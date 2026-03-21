#!/usr/bin/env python3
"""Minimal HTTPS test server for web.client e2e tests.

Usage:
    python3 https_test_server.py --port PORT --cert CERT --key KEY [--wrong-host-port PORT --wrong-host-cert CERT --wrong-host-key KEY]

Serves JSON responses over HTTPS for deterministic local testing.
"""
import argparse
import json
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


def start_server(port, certfile, keyfile):
    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ctx.load_cert_chain(certfile, keyfile)
    server = HTTPServer(("127.0.0.1", port), TestHandler)
    server.socket = ctx.wrap_socket(server.socket, server_side=True)
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()
    return server


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--port", type=int, required=True)
    p.add_argument("--cert", required=True)
    p.add_argument("--key", required=True)
    p.add_argument("--wrong-host-port", type=int, default=0)
    p.add_argument("--wrong-host-cert", default="")
    p.add_argument("--wrong-host-key", default="")
    args = p.parse_args()

    srv = start_server(args.port, args.cert, args.key)
    print(f"HTTPS server on port {args.port}", flush=True)

    wrong_srv = None
    if args.wrong_host_port > 0 and args.wrong_host_cert:
        wrong_srv = start_server(args.wrong_host_port, args.wrong_host_cert, args.wrong_host_key)
        print(f"Wrong-host HTTPS server on port {args.wrong_host_port}", flush=True)

    print("READY", flush=True)

    # Block until killed.
    try:
        threading.Event().wait()
    except KeyboardInterrupt:
        srv.shutdown()
        if wrong_srv:
            wrong_srv.shutdown()


if __name__ == "__main__":
    main()
