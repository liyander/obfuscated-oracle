FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y gcc libc6-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY oracle.c .

RUN gcc -o oracle oracle.c

RUN pip install --no-cache-dir flask gunicorn

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
    return send_file('/app/oracle', as_attachment=True, download_name='oracle')

@app.route('/health')
def health():
    return jsonify({"status": "ok"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

ENV PORT=5000
EXPOSE $PORT

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT", "--workers", "1"]
