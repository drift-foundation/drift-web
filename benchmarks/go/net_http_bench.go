// Go net/http baseline: same workload as Drift rest-perf baseline-health.
//
// - One listener on localhost, ephemeral port
// - One keep-alive TCP connection, sequential ping-pong
// - GET /health -> {"ok":true} (11 bytes, application/json)
// - Warmup 10000 (covers CPU freq-scaling ramp), measure 5000
//
// Run: go run benchmarks/go/net_http_bench.go

package main

import (
	"bufio"
	"fmt"
	"net"
	"net/http"
	"time"
)

const (
	warmupN  = 10000
	measureN = 5000
)

func main() {
	// --- Server ---
	mux := http.NewServeMux()
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(200)
		w.Write([]byte(`{"ok":true}`))
	})

	ln, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		fmt.Printf("listen error: %v\n", err)
		return
	}
	port := ln.Addr().(*net.TCPAddr).Port

	srv := &http.Server{Handler: mux}
	go srv.Serve(ln)

	// --- Client: raw TCP keep-alive, same shape as Drift benchmark ---
	req := "GET /health HTTP/1.1\r\nHost: localhost\r\n\r\n"
	reqBytes := []byte(req)

	conn, err := net.Dial("tcp", fmt.Sprintf("127.0.0.1:%d", port))
	if err != nil {
		fmt.Printf("connect error: %v\n", err)
		return
	}
	defer conn.Close()

	reader := bufio.NewReader(conn)

	// readOneResponse: read status line + headers + body (Content-Length based).
	readOneResponse := func() error {
		// Read HTTP response using the same approach as Drift:
		// parse headers to find Content-Length, then read body.
		resp, err := http.ReadResponse(reader, nil)
		if err != nil {
			return err
		}
		// Drain body to complete the response.
		buf := make([]byte, 256)
		for {
			n, _ := resp.Body.Read(buf)
			if n == 0 {
				break
			}
		}
		resp.Body.Close()
		return nil
	}

	// Warmup
	for i := 0; i < warmupN; i++ {
		if _, err := conn.Write(reqBytes); err != nil {
			fmt.Printf("warmup write error: %v\n", err)
			return
		}
		if err := readOneResponse(); err != nil {
			fmt.Printf("warmup read error: %v\n", err)
			return
		}
	}

	// Measured run
	start := time.Now()
	for i := 0; i < measureN; i++ {
		if _, err := conn.Write(reqBytes); err != nil {
			fmt.Printf("measure write error at %d: %v\n", i, err)
			return
		}
		if err := readOneResponse(); err != nil {
			fmt.Printf("measure read error at %d: %v\n", i, err)
			return
		}
	}
	elapsed := time.Since(start)

	elapsedMs := elapsed.Milliseconds()
	avgUs := int64(0)
	reqPerSec := int64(0)
	if measureN > 0 {
		avgUs = (elapsedMs * 1000) / int64(measureN)
	}
	if elapsedMs > 0 {
		reqPerSec = (int64(measureN) * 1000) / elapsedMs
	}

	fmt.Printf("[bench] go-net-http  iters=%d  total_ms=%d  avg_us=%d  req_per_sec=%d\n",
		measureN, elapsedMs, avgUs, reqPerSec)

	srv.Close()
}
