#!/usr/bin/env python3
"""Minimal HTTP/1.0 HTTPS server for SIGPIPE repro.

Speaks HTTP/1.0 (Connection: close after each response), which causes
the Drift connection pool to write to a stale socket on the second request.
"""
import argparse
import json
import ssl
import threading
from http.server import HTTPServer, BaseHTTPRequestHandler


class Http10Handler(BaseHTTPRequestHandler):
    # Deliberately HTTP/1.0 to force connection close after each response.

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

    def log_message(self, format, *args):
        pass


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--port", type=int, required=True)
    p.add_argument("--cert", required=True)
    p.add_argument("--key", required=True)
    args = p.parse_args()

    ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    ctx.load_cert_chain(args.cert, args.key)
    server = HTTPServer(("127.0.0.1", args.port), Http10Handler)
    server.socket = ctx.wrap_socket(server.socket, server_side=True)
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()
    print(f"HTTP/1.0 HTTPS server on port {args.port}", flush=True)
    print("READY", flush=True)

    try:
        threading.Event().wait()
    except KeyboardInterrupt:
        server.shutdown()


if __name__ == "__main__":
    main()
