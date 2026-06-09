# Obfuscated Oracle

## Challenge Info

| Field | Details |
|-------|---------|
| **Name** | Obfuscated Oracle |
| **Category** | Reverse Engineering |
| **Difficulty** | Easy |
| **Points** | 150 |
| **Flag Format** | `blackperl{...}` |
| **Access** | Compiled binary (`oracle`) |
| **Technologies** | C, Base64 |

## Description

A binary contains a Base64-encoded flag. Use strings to extract it, then decode it.

## Objective

Extract a Base64-encoded string from the binary using strings, then decode it to get the flag.

## What You Will Learn

- How to use the strings command to extract text from binaries
- How to decode Base64-encoded data
- Basic binary analysis

## Skills Required

- Basic Linux command line
- strings command
- Base64 decoding

## Hints

1. Run the binary to see what it says.
2. Use `strings oracle` to extract all text from the binary.
3. Look for a long string that looks like Base64 (letters, numbers, +, /, =).
4. Decode it with `base64 -d` or an online decoder.

## Tools Required

- `strings` command
- `base64` command or online Base64 decoder

## Setup

```bash
docker build -t obfuscated-oracle .
docker run -it --rm obfuscated-oracle
```

To extract the binary:
```bash
docker create --name oracle-tmp obfuscated-oracle
docker cp oracle-tmp:/challenge/oracle ./oracle
docker rm oracle-tmp
```

## Files Provided

- `oracle` — the compiled binary
