# Challenge 2: Obfuscated Oracle (Easy)

**Category:** Reverse Engineering  
**Difficulty:** Easy  
**Points:** 150  
**Flag:** `blackperl{str1ngs_b64_d3c0d3d}`

## Description

The oracle binary contains a Base64-encoded flag. Use `strings` to find it, then decode it.

## Access

**Web Terminal:** Open the deployed URL in your browser (e.g., `https://obfuscated-oracle.onrender.com`)

A web-based terminal will appear. Login with:
- **Username:** `ctfuser`
- **Password:** `ctfuser`

## Walkthrough

### Step 1: Login

Open the web terminal URL in your browser and login as `ctfuser`.

### Step 2: Read the Hint

```bash
cat hint.txt
```

### Step 3: Run the Binary

```bash
./oracle
```

It prints a message about the flag being hidden.

### Step 4: Extract the Flag String

```bash
strings oracle | grep FLAG_ENCODED
```

Output:
```
FLAG_ENCODED_BASE64_YmxhY2twZXJse3N0cjFuZ3NfYjY0X2QzYzBkM2R9_END_FLAG
```

### Step 5: Extract and Decode Base64

Extract the Base64 part (between `BASE64_` and `_END_FLAG`):

```bash
echo "YmxhY2twZXJse3N0cjFuZ3NfYjY0X2QzYzBkM2R9" | base64 -d
```

Output:
```
blackperl{str1ngs_b64_d3c0d3d}
```

### One-liner

```bash
strings oracle | grep FLAG_ENCODED | sed 's/.*BASE64_\(.*\)_END_FLAG.*/\1/' | base64 -d
```

## Running Locally

```bash
docker build -t obfuscated-oracle .
docker run -d -p 10000:10000 --name obfuscated-oracle obfuscated-oracle
```

Visit http://localhost:10000 in your browser.

## Deploying to Render

1. Push to GitHub
2. Create new Web Service on Render
3. Configure:
   - **Root Directory:** `challenges/obfuscated-oracle`
   - **Runtime:** `Docker`
   - **Environment Variable:** `PORT=10000`
4. Deploy

Players access the challenge via the Render URL in their browser.
