FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY oracle.c .

RUN gcc -o oracle oracle.c

FROM python:3.11-slim

WORKDIR /app

COPY --from=builder /build/oracle ./files/oracle

RUN echo '{"service": "obfuscated-oracle", "status": "binary_ready"}' > health.json

RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir flask gunicorn

COPY <<'EOF' app.py
from flask import Flask, send_file, jsonify
import os

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify({
        "challenge": "Obfuscated Oracle",
        "category": "Reverse Engineering",
        "difficulty": "Easy",
        "points": 150,
        "download": "/download/oracle",
        "instructions": [
            "Download the oracle binary",
            "Make it executable: chmod +x oracle",
            "Run it: ./oracle",
            "Use 'strings oracle' to find the encoded flag",
            "Decode the Base64 string to get the flag"
        ]
    })

@app.route('/download/oracle')
def download():
    return send_file('files/oracle', as_attachment=True, download_name='oracle')

@app.route('/health')
def health():
    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

ENV PORT=5000
EXPOSE $PORT

CMD gunicorn app:app --bind 0.0.0.0:$PORT --workers 1
