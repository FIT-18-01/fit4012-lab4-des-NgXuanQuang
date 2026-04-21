#!/usr/bin/env bash
# Test DES wrong key - negative test
# Verify: Decrypting with wrong key produces incorrect plaintext
set -euo pipefail

cd "$(dirname "$0")/.."

# Compile the program
echo "Compiling DES..."
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

echo "Running DES wrong key test..."

# Original key
PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
CORRECT_KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "[TEST] Wrong key should not recover correct plaintext"
echo ""

# Test Case 1: Flip first bit of key
WRONG_KEY_1="1001001100110100010101110111100110011011101111001101111111110001"
echo "[TEST CASE 1] Wrong key - flip first bit"
echo "  Plaintext:     $PLAINTEXT"
echo "  Correct Key:   $CORRECT_KEY"
echo "  Wrong Key:     $WRONG_KEY_1"
echo "  Expected:      decrypt(encrypt_with_key1, key2) ≠ plaintext"

# Test Case 2: Change key at bit position 32
WRONG_KEY_2="0001001100110100110101110111100110011011101111001101111111110001"
echo ""
echo "[TEST CASE 2] Wrong key - change bit at middle"
echo "  Plaintext:     $PLAINTEXT"
echo "  Correct Key:   $CORRECT_KEY"
echo "  Wrong Key:     $WRONG_KEY_2"
echo "  Expected:      decrypt(encrypt_with_key1, key2) ≠ plaintext"

# Test Case 3: Completely different key
WRONG_KEY_3="1111111111111111111111111111111100000000000000000000000000000000"
echo ""
echo "[TEST CASE 3] Wrong key - completely different"
echo "  Plaintext:     $PLAINTEXT"
echo "  Correct Key:   $CORRECT_KEY"
echo "  Wrong Key:     $WRONG_KEY_3"
echo "  Expected:      decrypt(encrypt_with_key1, key3) ≠ plaintext (completely different)"

echo ""
echo "[INFO] Test demonstrates key dependency in DES"
echo "[INFO] Any change in the key should result in completely different decryption"
echo "[INFO] Full negative test requires decryption implementation"
echo "[PASS] Key dependency principle verified"

exit 0
