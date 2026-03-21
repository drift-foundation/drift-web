#!/usr/bin/env python3
"""Minimal HTTPS test server for web.client e2e tests.

Usage:
    python3 https_test_server.py --cert CERT --key KEY [--wrong-host-cert CERT --wrong-host-key KEY]

Binds to ephemeral ports (no race). Prints machine-readable port lines:
    PORT <port>
    WRONG_HOST_PORT <port>
    READY

Serves JSON responses over HTTPS for deterministic local testing.
"""
import argparse
import json
import os
import ssl
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler


class TestHandler(BaseHTTPRequestHandler):
    protocol_version = "HTTP/1.1"

    def do_GET(self):
        if self.path == "/health":
            body = json.dumps({"ok": True}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        elif self.path == "/health-close":
            # Same response as /health but announces connection close.
            # Exercises clean pool eviction (client knows connection is done).
            body = json.dumps({"ok": True}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.send_header("Connection", "close")
            self.end_headers()
            self.wfile.write(body)
            self.close_connection = True
        elif self.path == "/health-drop":
            # Same response as /health but silently closes the socket after.
            # No Connection: close header — client pool thinks the connection
            # is still alive. Next reuse attempt hits a dead socket (EPIPE/EOF).
            # Exercises stale-connection detection and reconnect recovery.
            body = json.dumps({"ok": True}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            self.wfile.flush()
            self.close_connection = True
        else:
            self.send_error(404)

    def do_POST(self):
        if self.path == "/echo":
            length = int(self.headers.get("Content-Length", 0))
            data = self.rfile.read(length) if length > 0 else b""
            body = json.dumps({"echo": data.decode("utf-8", errors="replace")}).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        else:
            self.send_error(404)

    def log_message(self, format, *args):
        pass  # Silence request logs.


def start_server(certfile, keyfile):
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ctx.load_cert_chain(certfile, keyfile)
    server = HTTPServer(("127.0.0.1", 0), TestHandler)
    server.socket = ctx.wrap_socket(server.socket, server_side=True)
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()
    return server


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--cert", required=True)
    p.add_argument("--key", required=True)
    p.add_argument("--wrong-host-cert", default="")
    p.add_argument("--wrong-host-key", default="")
    p.add_argument("--port-file", default="",
                   help="Write JSON {port, wrong_host_port} to this file when ready")
    args = p.parse_args()

    srv = start_server(args.cert, args.key)
    port = srv.server_address[1]

    wrong_port = 0
    if args.wrong_host_cert and args.wrong_host_key:
        wrong_srv = start_server(args.wrong_host_cert, args.wrong_host_key)
        wrong_port = wrong_srv.server_address[1]

    # Signal readiness via port file (atomic rename) or stdout.
    if args.port_file:
        tmp = args.port_file + ".tmp"
        with open(tmp, "w") as f:
            json.dump({"port": port, "wrong_host_port": wrong_port}, f)
        os.rename(tmp, args.port_file)
    else:
        print(f"PORT {port}", flush=True)
        if wrong_port:
            print(f"WRONG_HOST_PORT {wrong_port}", flush=True)
        print("READY", flush=True)

    # Block until killed.
    try:
        threading.Event().wait()
    except KeyboardInterrupt:
        srv.shutdown()


if __name__ == "__main__":
    main()
