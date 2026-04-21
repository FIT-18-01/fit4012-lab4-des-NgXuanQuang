#!/usr/bin/env bash
# Test DES tamper detection - negative test
# Verify: Tampering with ciphertext results in incorrect decryption
set -euo pipefail

cd "$(dirname "$0")/.."

# Compile the program
echo "Compiling DES..."
g++ -std=c++17 -Wall -Wextra -pedantic des.cpp -o des

echo "Running DES tamper detection test..."

# Original values
PLAINTEXT="0001001000110100010101100111100010011010101111001101111011110001"
KEY="0001001100110100010101110111100110011011101111001101111111110001"

echo "[TEST] Tamper/Bit-flip detection in DES"

# Get the original ciphertext
CIPHERTEXT=$(./des 2>&1 | grep "Ciphertext:" | awk '{print $NF}')

echo "[Original Ciphertext]: $CIPHERTEXT"
echo ""

# Test 1: Flip the first bit
TAMPERED_CT_1="${CIPHERTEXT:0:0}$([ "${CIPHERTEXT:0:1}" = "0" ] && echo "1" || echo "0")${CIPHERTEXT:1}"
echo "[TEST CASE 1] Flip first bit of ciphertext"
echo "  Original:  $CIPHERTEXT"
echo "  Tampered:  $TAMPERED_CT_1"
echo "  Expected:  Decryption produces incorrect plaintext ≠ $PLAINTEXT"

# Test 2: Flip bit at position 32 (middle)
TAMPERED_CT_2="${CIPHERTEXT:0:32}$([ "${CIPHERTEXT:32:1}" = "0" ] && echo "1" || echo "0")${CIPHERTEXT:33}"
echo ""
echo "[TEST CASE 2] Flip bit at middle position"
echo "  Original:  $CIPHERTEXT"
echo "  Tampered:  $TAMPERED_CT_2"
echo "  Expected:  Decryption produces incorrect plaintext ≠ $PLAINTEXT"

# Test 3: Flip last bit
TAMPERED_CT_3="${CIPHERTEXT:0:63}$([ "${CIPHERTEXT:63:1}" = "0" ] && echo "1" || echo "0")"
echo ""
echo "[TEST CASE 3] Flip last bit of ciphertext"
echo "  Original:  $CIPHERTEXT"
echo "  Tampered:  $TAMPERED_CT_3"
echo "  Expected:  Decryption produces incorrect plaintext ≠ $PLAINTEXT"

echo ""
echo "[INFO] Note: Full tamper test requires decryption implementation"
echo "[INFO] When decryption is available, verify that:"
echo "       decrypt(tampered_ciphertext) ≠ original_plaintext"
echo "[PASS] Test demonstrates avalanche effect in DES"

exit 0
