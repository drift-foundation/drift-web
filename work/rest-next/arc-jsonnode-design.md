# Design Review: Arc-Backed `std.json.JsonNode`

Status: feasibility review — revised after compiler team feedback
Audience: compiler/stdlib team
Date: 2026-03-09

## Motivation

REST frameworks (and other multi-layer consumers) often parse a JSON body once
and access it multiple times across guards, filters, and handlers. Today,
`JsonNode` is move-only with no clone mechanism. This forces a choice between
re-parsing on each access or exposing `&mut` to cache and return `&JsonNode`.
Neither is acceptable in a clean public API.

If parsed JSON were cheap to share, a framework could cache the parsed tree and
return owned values to each consumer — no `&mut`, no re-parse, no
reference-lifetime leakage.

## Current Representation

```drift
pub variant JsonNode {
    Null,
    Bool(value: Bool),
    Number(raw: String),
    String(value: String),
    Array(values: Array<JsonNode>),
    Object(fields: HashMap<String, JsonNode>),
    @tombstone Tombstone
}
```

- Move-only. No `Copy`, no `clone()`.
- Recursive ownership: each node owns its children as values.
- Drop cascades through the tree (compiler-generated glue).
- Construction by the parser is bottom-up: leaf nodes moved into arrays/hashmaps,
  then wrapped in variant constructors.

## Evaluated Approach: Per-Node Arc (Replace JsonNode)

Rename the current variant to `JsonNodeData` (internal). Expose `JsonNode` as a
thin struct wrapping `Arc<JsonNodeData>`:

```drift
// Internal
variant JsonNodeData {
    Null,
    Bool(value: Bool),
    Number(raw: String),
    String(value: String),
    Array(values: Array<JsonNode>),
    Object(fields: HashMap<String, JsonNode>),
    @tombstone Tombstone
}

// Public type
pub struct JsonNode {
    data: Arc<JsonNodeData>
}
```

`clone()` is O(1): one atomic increment, one pointer copy.

### Why Per-Node, Not Whole-Tree

A whole-tree Arc (`Arc<JsonNodeData>` wrapping only the root) would make the root
cheap to clone, but cannot return owned values for subtree or field lookup
results. Subtree extraction would still require either deep-copy or returning
references with lifetime constraints.

Per-node Arc means every node in the tree is independently shareable. A `.get()`
call returns `&JsonNode` (reference into the parent's HashMap), and the caller
can `.clone()` it to get an independent owned handle to that subtree.

An arena/slab approach (one allocation backing all nodes, with indices) would
require either a custom allocator not in stdlib or self-referential structs that
Drift's current type system cannot express cleanly.

### Cost Profile

| Dimension | Current (owned tree) | Per-node Arc |
|-----------|---------------------|----------------------|
| Parse cost | N variant constructions | N variant constructions + N heap allocs |
| Clone cost | Not possible (move-only) | O(1) per node cloned |
| Memory per node | Variant tag + payload | +~24 bytes (Arc overhead) |
| Traversal | 0 extra indirections | +1 indirection per node |
| Drop (sole owner) | Cascade drop | Cascade drop + N atomic ops |
| Drop (shared, one handle) | N/A | N atomic decrements, 0 deallocs |
| Single parse + extract | Optimal | ~1.5–2x slower (alloc overhead) |
| Cached multi-read | Must re-parse or use `&mut` | O(1) clone from cache |

## Compiler Team Findings

The per-node Arc approach was reviewed by the compiler/stdlib team. Key findings:

### 1. `into_*` semantic break is not minor

`into_array(self: JsonNode)` and `into_object(self: JsonNode)` today mean
unconditional ownership transfer. With per-node Arc, the node may be shared
(refcount > 1). This forces one of three bad outcomes:

- Introduce failure where none existed (breaking change)
- Deep-copy unpredictably (hidden cost, violates user expectations)
- Weaken the semantic meaning of "into" (API contract erosion)

This is a real semantic change, not an implementation detail.

### 2. Pattern-match breakage is underweighted

Turning `JsonNode` from a public variant into a struct wrapper is a
source-breaking change for any code matching on variants directly. The original
proposal asserted this was "uncommon" without demonstrating it.

If `JsonNodeData` stays internal, user expressiveness drops. If `JsonNodeData`
becomes public to preserve matching, the abstraction boundary becomes messy —
users see both the struct wrapper and the inner variant, with unclear guidance
on which to use.

### 3. Per-node Arc is highest-overhead sharing

It solves subtree sharing cleanly, but pays the maximum tax:

- One heap allocation per node at parse time
- One refcount domain per node
- Additional pointer chasing on every traversal
- More complex drop cascades

For JSON trees, this is a large cost on the common single-use case
(parse → extract a few fields → discard).

### 4. "Implementable as library" is not decisive

The design uses only existing Drift primitives (Arc, AtomicInt, RawBuffer). No
compiler magic needed. But "can be implemented" is not the hard question. The
hard question is whether JsonNode should change semantics and performance
profile globally for all users.

## Revised Recommendation: Separate Shared Type

Based on compiler team feedback, the recommended direction is:

**Keep current `JsonNode` as the zero-overhead default. Introduce a separate
shared form alongside it.**

### Proposed: `std.json.SharedJsonNode`

```drift
pub struct SharedJsonNode {
    data: Arc<SharedJsonNodeData>
}

// Internal
variant SharedJsonNodeData {
    Null,
    Bool(value: Bool),
    Number(raw: String),
    String(value: String),
    Array(values: Array<SharedJsonNode>),
    Object(fields: HashMap<String, SharedJsonNode>),
    @tombstone Tombstone
}
```

### Conversion API

```drift
// Owned → shared (consumes the owned tree, wraps each node in Arc)
pub fn share(node: JsonNode) nothrow -> SharedJsonNode

// SharedJsonNode methods — same accessor surface as JsonNode
implement SharedJsonNode {
    pub fn clone(self: &SharedJsonNode) nothrow -> SharedJsonNode
    pub fn get(self: &SharedJsonNode, key: &String) nothrow -> Optional<&SharedJsonNode>
    pub fn as_string(self: &SharedJsonNode) nothrow -> Optional<String>
    pub fn as_int(self: &SharedJsonNode) nothrow -> Optional<Int>
    pub fn as_bool(self: &SharedJsonNode) nothrow -> Optional<Bool>
    pub fn as_array(self: &SharedJsonNode) nothrow -> Optional<&Array<SharedJsonNode>>
    pub fn as_object(self: &SharedJsonNode) nothrow -> Optional<&HashMap<String, SharedJsonNode>>
    // ... remaining accessors mirror JsonNode
}
```

### Why this is better

| Concern | Replace JsonNode | Separate SharedJsonNode |
|---------|-----------------|------------------------|
| Default-path performance | Regresses (N extra allocs) | Unchanged |
| `into_*` semantics | Broken or weakened | Preserved on JsonNode |
| Pattern matching | Broken (variant → struct) | Preserved on JsonNode |
| ABI break | Yes (all users) | No (additive API) |
| Source break | Yes (variant matchers) | No |
| Sharing capability | Yes | Yes (after explicit `share()`) |
| API surface | One type, changed semantics | Two types, clear boundary |

### Conversion cost

`share(node: JsonNode) -> SharedJsonNode` walks the owned tree once, wrapping
each node in an Arc. This is O(N) with N heap allocations — the same cost as
parsing an Arc-backed tree from scratch. The difference is that this cost is
paid only when a framework actually needs fan-out reuse, not on every parse.

### No `into_*` on SharedJsonNode

`SharedJsonNode` does not provide `into_array()` or `into_object()`. Shared
nodes are read-only by design. Ownership transfer is only meaningful for the
owned `JsonNode` type, where it continues to work exactly as today.

### Pattern matching

`JsonNode` remains a public variant. All existing pattern matching works.
`SharedJsonNode` is a struct — access is method-only. Users who need to match
on shared data use the accessor methods, which is the natural API for shared
immutable data.

## Web.rest Integration

With `SharedJsonNode`, the request-body caching path becomes:

1. At dispatch time (`&mut Request` available): parse body to `JsonNode`, call
   `json.share(move node)` to get `SharedJsonNode`, store in Request cache.
2. `body_json(req: &Request)` returns `cached.clone()` — O(1).
3. Return type changes: `Result<SharedJsonNode, RestError>` instead of
   `Result<JsonNode, RestError>`.

This does change the `body_json` return type — but to a type with the same
accessor surface, not to a reference type or `&mut` requirement. Callers
migrate from `node.get()` / `node.as_string()` to `shared.get()` /
`shared.as_string()` — identical method names and signatures.

**Alternative: web.rest wraps internally.** If the stdlib ships
`SharedJsonNode`, web.rest could define its own thin handle type that hides
the shared/owned distinction. This is a framework-level decision independent
of the stdlib proposal.

## Open Questions for Stdlib Team

1. **Naming**: `SharedJsonNode` vs `JsonHandle` vs `JsonRef` vs `JsonArc`.
   `SharedJsonNode` is descriptive but verbose.

2. **Module placement**: same `std.json` module, or a sub-module
   (`std.json.shared`)?

3. **Trait/interface unification**: Should `JsonNode` and `SharedJsonNode`
   share a common interface/trait for accessor methods, allowing generic code
   to work with either? Drift's trait system would need to support this.

4. **Future convergence**: If real-world usage shows that most consumers end
   up calling `share()` anyway, that would be evidence for revisiting the
   "make Arc the default" direction — with the `into_*` and pattern-match
   questions resolved by then through ecosystem experience.

## Recommendation

**Viable and worth proposing as an additive stdlib extension.**

- Preserves current `JsonNode` semantics and performance for the default path.
- Avoids immediate source/ABI break.
- Gives frameworks the sharing capability they need now.
- Provides real usage data before deciding whether shared should become the
  default representation.

The per-node Arc design itself is technically sound — the compiler team's
objection is not to the mechanism but to replacing the default type wholesale
as the first move. `SharedJsonNode` as an opt-in companion type addresses
that concern directly.
