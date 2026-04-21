# Logs directory - Test Execution Evidence

Thư mục này chứa minh chứng thực thi các test cases của bài lab DES.

## Minh chứng Test Runs

### 1. Sample DES Test (`test_des_sample.sh`)

```
Command: ./tests/test_des_sample.sh
Status: PASS
Output:
  Plaintext:   0001001000110100010101100111100010011010101111001101111011110001
  Key:         0001001100110100010101110111100110011011101111001101111111110001
  Ciphertext:  0111111010111111010001001001001100100011111110101111101011111000
```

### 2. Encrypt-Decrypt Roundtrip Test (`test_encrypt_decrypt_roundtrip.sh`)

```
Status: PASS (Encryption verified, awaiting decryption implementation)
Note: Full round-trip requires decrypt() implementation
      Current: Verifies encryption produces valid 64-bit ciphertext
```

### 3. Multi-block Padding Test (`test_multiblock_padding.sh`)

```
Status: INFO (Test framework ready, awaiting multi-block implementation)
Test Cases:
  - Two complete 64-bit blocks (128 bits total)
  - One block + partial block with zero padding (96 bits → 128 bits)
  - Proper block division and padding scheme
```

### 4. Tamper/Bit-flip Test (`test_tamper_negative.sh`)

```
Status: INFO (Test framework ready, awaiting decryption implementation)
Test Cases:
  - Flip first bit of ciphertext
  - Flip middle bit of ciphertext (position 32)
  - Flip last bit of ciphertext
Expected: decrypt(tampered_ct) ≠ original_plaintext
Demonstrates: DES avalanche effect
```

### 5. Wrong Key Test (`test_wrong_key_negative.sh`)

```
Status: INFO (Test framework ready, awaiting decryption implementation)
Test Cases:
  - Wrong key with first bit flipped
  - Wrong key with middle bit changed
  - Completely different wrong key
Expected: Using wrong key produces incorrect plaintext recovery
Demonstrates: Key dependency and security property
```

## Implementation Status

| Test             | Implemented | Status                         |
| ---------------- | ----------- | ------------------------------ |
| Sample DES       | ✓           | PASS                           |
| Roundtrip        | Partial     | Encryption OK, needs decrypt() |
| Multi-block      | Framework   | Needs multi-block handler      |
| Tamper Detection | Framework   | Needs decrypt()                |
| Wrong Key        | Framework   | Needs decrypt()                |

## Next Steps

1. ✓ Implement basic DES encryption
2. ⏳ Implement DES decryption function
3. ⏳ Implement multi-block support with zero padding
4. ⏳ Run full test suite and document results
5. ⏳ Push logs and evidence to git repository

## Test Running Instructions

```bash
# Run all tests
cd tests/
bash test_des_sample.sh
bash test_encrypt_decrypt_roundtrip.sh
bash test_multiblock_padding.sh
bash test_tamper_negative.sh
bash test_wrong_key_negative.sh

# Or use the sample test
bash test_sample.sh
```
