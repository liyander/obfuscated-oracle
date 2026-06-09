# Challenge 2: Obfuscated Oracle (Easy)

**Category:** Reverse Engineering  
**Difficulty:** Easy  
**Points:** 150  
**Flag:** `blackperl{str1ngs_b64_d3c0d3d}`

## Description

The binary contains a Base64-encoded flag. Use strings to find it, then decode it.

## Walkthrough

### Step 1: Extract the Binary

```bash
docker create --name oracle-tmp obfuscated-oracle
docker cp oracle-tmp:/challenge/oracle ./oracle
docker rm oracle-tmp
```

### Step 2: Use strings Command

```bash
strings oracle | grep -E '^[A-Za-z0-9+/=]{20,}$'
```

Output:
```
YmxhY2twZXJse3N0cjFuZ3NfYjY0X2QzYzBkM2R9
```

### Step 3: Decode Base64

```bash
echo "YmxhY2twZXJse3N0cjFuZ3NfYjY0X2QzYzBkM2R9" | base64 -d
```

Output:
```
blackperl{str1ngs_b64_d3c0d3d}
```

## Running

```bash
docker build -t obfuscated-oracle .
docker run -it --rm obfuscated-oracle
```
