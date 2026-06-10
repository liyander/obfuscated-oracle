# Obfuscated Oracle

## Challenge Info

| Field | Details |
|-------|---------|
| **Name** | Obfuscated Oracle |
| **Category** | Reverse Engineering |
| **Difficulty** | Easy |
| **Points** | 150 |
| **Flag Format** | `blackperl{...}` |
| **Access** | Web browser (ttyd terminal) |
| **Technologies** | C, Base64, ttyd |

## Description

A binary contains a Base64-encoded flag. Use `strings` to extract it, then decode it.

## Objective

Extract a Base64-encoded string from the binary using `strings`, then decode it to get the flag.

## What You Will Learn

- How to use the `strings` command to extract text from binaries
- How to decode Base64-encoded data
- Basic binary analysis

## Skills Required

- Basic Linux command line
- `strings` command
- Base64 decoding

## Hints

1. Run `./oracle` to see what it says.
2. Use `strings oracle` to extract all text from the binary.
3. Look for a string containing `FLAG_ENCODED_BASE64_`.
4. Extract the Base64 part and decode it with `base64 -d`.

## Tools Included in Terminal

- `strings` - Extract readable strings from binaries
- `base64` - Decode Base64 data
- `gcc` - C compiler (already used to build the binary)

## Access Method

This challenge uses **ttyd** (web-based terminal) so players can access it through a browser:

1. Open the challenge URL in a web browser
2. A terminal interface appears
3. Login with credentials: `ctfuser` / `ctfuser`
4. Solve the challenge using included tools

## Setup

### Local (Docker)
```bash
docker build -t obfuscated-oracle .
docker run -d -p 10000:10000 --name obfuscated-oracle obfuscated-oracle
```

Visit http://localhost:10000

### Render Deployment
1. Push to GitHub
2. Create Web Service on Render
3. Set Root Directory: `challenges/obfuscated-oracle`
4. Set Runtime: `Docker`
5. Add env var: `PORT=10000`
6. Deploy

Players access via the Render URL in their browser.

## Files Provided

- Web-based terminal access
- Credentials: `ctfuser` / `ctfuser`
- `oracle` binary in home directory
- Hint file at `/home/ctfuser/hint.txt`
