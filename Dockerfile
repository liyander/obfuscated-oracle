FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    ttyd \
    gcc \
    libc6-dev \
    binutils \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ctfuser && \
    echo "ctfuser:ctfuser" | chpasswd

WORKDIR /home/ctfuser

COPY oracle.c .

RUN gcc -o oracle oracle.c && \
    chmod +x oracle && \
    chown ctfuser:ctfuser oracle && \
    rm oracle.c

RUN echo '#!/bin/bash' > /home/ctfuser/hint.txt && \
    echo 'Welcome to the Obfuscated Oracle challenge!' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'The oracle binary contains a hidden flag.' >> /home/ctfuser/hint.txt && \
    echo '' >> /home/ctfuser/hint.txt && \
    echo 'Try these commands:' >> /home/ctfuser/hint.txt && \
    echo '  ./oracle              - Run the binary' >> /home/ctfuser/hint.txt && \
    echo '  strings oracle        - Extract readable strings' >> /home/ctfuser/hint.txt && \
    echo '  strings oracle | grep -E "^[A-Za-z0-9+/=]{20,}$"  - Find Base64' >> /home/ctfuser/hint.txt && \
    echo '  echo "<base64>" | base64 -d  - Decode Base64' >> /home/ctfuser/hint.txt && \
    chmod 444 /home/ctfuser/hint.txt && \
    chown ctfuser:ctfuser /home/ctfuser/hint.txt

RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'exec ttyd -p 10000 -W login -f ctfuser' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 10000

CMD ["/entrypoint.sh"]
