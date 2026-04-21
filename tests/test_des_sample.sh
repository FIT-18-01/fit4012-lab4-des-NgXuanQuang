#!/usr/bin/env bash
# Test DES sample - đối chiếu với ví dụ mẫu trong code gốc
set -euo pipefail

cd "$(dirname "$0")/.."

# Compile the program
echo "Compiling DES..."
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

echo "Running DES sample test..."

# Expected output for sample plaintext and key
PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

# Run the program
OUTPUT=$(./des 2>&1 | grep "Ciphertext:" | awk '{print $NF}')

# Verify output contains 64 bits
if [[ "$OUTPUT" =~ ^[01]{64}$ ]]; then
    echo "[PASS] Sample DES test: Ciphertext is 64-bit binary"
    echo "  Plaintext:   $PLAINTEXT"
    echo "  Key:         $KEY"
    echo "  Ciphertext:  $OUTPUT"
    exit 0
else
    echo "[FAIL] Sample DES test: Invalid ciphertext format"
    echo "  Expected: 64-bit binary string"
    echo "  Got: $OUTPUT"
    exit 1
fi
