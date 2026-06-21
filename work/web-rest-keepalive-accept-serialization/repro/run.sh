#!/usr/bin/env bash
# Turnkey repro: build wcserver (web.rest) + wcbench (web.client), then compare web.rest vs python
# HTTP/1.1 under the identical web.client load. See 2026-06-20-microflows-web-rest-keepalive-latency.md.
set -euo pipefail
cd "$(dirname "$0")"
DRIFTC="${DRIFT_TOOLCHAIN_ROOT:-$HOME/opt/drift/certified/current/toolchain}/bin/driftc"
PKG="${DRIFT_PKG_ROOT:-$HOME/opt/drift/certified/current/libs}"

echo "[build] wcserver (web.rest) + wcbench (web.client)"
"$DRIFTC" --target-word-bits 64 --trust-store drift/trust.json --package-root "$PKG" \
  --dep web-rest@0.5.4 --dep web-jwt@0.4.2 --dep net-tls@0.5.2 --entry wcserver::main src/server.drift -o wcserver
"$DRIFTC" --target-word-bits 64 --trust-store drift/trust.json --package-root "$PKG" \
  --dep web-client@0.4.2 --dep net-tls@0.5.2 --entry wcbench::main src/bench.drift -o wcbench

python3 - <<'PY'
import subprocess,time,socket,threading,http.server,socketserver,urllib.request
def fp():
    s=socket.socket(); s.bind(("127.0.0.1",0)); p=s.getsockname()[1]; s.close(); return p
wport=fp()
srv=subprocess.Popen(["./wcserver","--port",str(wport)],stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
for _ in range(80):
    try: urllib.request.urlopen(f"http://127.0.0.1:{wport}/ping",timeout=1); break
    except: time.sleep(0.2)
t=time.time(); r=subprocess.run(["./wcbench",f"http://127.0.0.1:{wport}/ping","10","3000"],capture_output=True,text=True,timeout=60); dt=time.time()-t
print(f"web.rest  (wcserver): {dt:5.1f}s  ok={r.stdout.count('ok ')} send-errors={r.stdout.count('send-error')}")
srv.terminate()
class H(http.server.BaseHTTPRequestHandler):
    protocol_version='HTTP/1.1'
    def do_GET(self):
        b=b'{\"ok\":1}'; self.send_response(200); self.send_header('Content-Length',str(len(b))); self.end_headers(); self.wfile.write(b)
    def log_message(self,*a): pass
ps=socketserver.ThreadingTCPServer(("127.0.0.1",0),H); pp=ps.server_address[1]
threading.Thread(target=ps.serve_forever,daemon=True).start()
t=time.time(); r=subprocess.run(["./wcbench",f"http://127.0.0.1:{pp}/ping","10","3000"],capture_output=True,text=True,timeout=60); dt=time.time()-t
print(f"python HTTP/1.1     : {dt:5.1f}s  ok={r.stdout.count('ok ')} send-errors={r.stdout.count('send-error')}")
ps.shutdown()
PY
