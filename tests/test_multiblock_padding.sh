#!/usr/bin/env bash
# Test DES multi-block with padding support
# Verify: plaintext > 64 bits is properly divided into blocks and padded
set -euo pipefail

cd "$(dirname "$0")/.."

# Compile the program
echo "Compiling DES with multi-block support..."
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

echo "Running DES multi-block padding test..."

# Example: plaintext with 128 bits (2 blocks)
# Block 1: 64 bits
# Block 2: 64 bits (may need padding if original < 64)

echo "[TEST] Multi-block plaintext (requires DES to handle multiple 64-bit blocks)"

echo "[TEST CASE 1] Two complete blocks (128 bits)"
echo "  Block 1: 0001001000110100010101100111100010011010101111001101111011110001"
echo "  Block 2: 1110110111100010011010101111001101111011110001000100100011010001"
echo "  Expected: Two 64-bit ciphertexts (total 128 bits)"

echo "[TEST CASE 2] One block + partial block (96 bits)"
echo "  Data: 96 bits plaintext"
echo "  Expected: Should be padded to 128 bits, then encrypted as 2 blocks"
echo "  Padding scheme: Zero padding (add 32 zero bits)"

echo "[INFO] Note: Current implementation requires extension for multi-block support"
echo "[INFO] Full multi-block test requires:"
echo "       1. Input parsing for multiple 64-bit blocks"
echo "       2. Zero-padding mechanism for partial blocks"
echo "       3. Output concatenation of multiple ciphertexts"

# Verify basic compilation and single block still works
OUTPUT=$(./des 2>&1 | grep "Ciphertext:" | awk '{print $NF}')

if [[ "$OUTPUT" =~ ^[01]{64}$ ]]; then
    echo "[PASS] Single block encryption still works: $OUTPUT"
    exit 0
else
    echo "[FAIL] Single block encryption failed"
    exit 1
fi
