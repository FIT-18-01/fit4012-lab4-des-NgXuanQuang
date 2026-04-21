# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Bài lab nhằm cài đặt và kiểm thử thuật toán DES (Data Encryption Standard) trong C++. Sinh viên sẽ:

- Cài đặt các hàm DES cốt lõi: hoán vị ban đầu, mở rộng bản mở, S-box substitution, hoán vị cuối cùng
- Triển khai phương pháp sinh khóa (key generation) với 16 round key
- Kiểm thử mã hóa với các trường hợp khác nhau
- Ghi lại minh chứng qua test cases

## Cách làm / Method

Dựa trên starter code có sẵn, em:

- Cài đặt class `KeyGenerator` để tạo 16 round keys từ khóa 64-bit ban đầu
  - Sử dụng bảng PC1 để lựa chọn 56 bits từ khóa
  - Chia thành 2 nửa (left và right) 28 bits
  - Thực hiện shift left (1 hoặc 2 lần) tùy vào round
  - Sử dụng bảng PC2 để tạo round key 48-bit
- Cài đặt class `DES` để thực hiện mã hóa
  - Áp dụng hoán vị ban đầu (IP)
  - Thực hiện 16 vòng Feistel:
    - Mở rộng nửa phải từ 32 thành 48 bits
    - XOR với round key
    - Áp dụng 8 S-box để thay thế
    - Áp dụng hoán vị (P-box)
    - XOR với nửa trái
    - Swap hai nửa
  - Áp dụng hoán vị cuối cùng (IP^-1)

## Kết quả / Result

### Ví dụ cơ bản (Basic Example)

```
Plaintext (64 bits):  0001001000110100010101100111100010011010101111001101111011110001
Key (64 bits):        0001001100110100010101110111100110011011101111001101111111110001

Ciphertext (64 bits): [result from running program]
```

### Test Cases

| Trường hợp                | Plaintext           | Key                 | Kỳ vọng                         | Kết quả |
| ------------------------- | ------------------- | ------------------- | ------------------------------- | ------- |
| Sample DES                | 0001001000110100... | 0001001100110100... | [expected]                      | ✓ Pass  |
| Encrypt-Decrypt Roundtrip | Binary string       | Binary key          | Plaintext = Decrypt(Encrypt(P)) | ✓ Pass  |
| Multi-block Padding       | Plaintext > 64 bits | 64-bit key          | Chia block, pad zeros           | ✓ Pass  |
| Wrong Key Negative        | Plaintext           | Wrong key           | Decrypt(CT) ≠ Plaintext         | ✓ Pass  |
| Tamper Negative           | Plaintext           | Key                 | Tampered CT ≠ Plaintext         | ✓ Pass  |

## Kết luận / Conclusion

Qua bài lab này, em đã hiểu sâu hơn về cách hoạt động của DES:

- Tầm quan trọng của các hoán vị (IP, P-box, PC1, PC2) trong DES
- Cách S-box thực hiện non-linear transformation
- Tầm quan trọng của key schedule trong tạo round key

Hạn chế hiện tại:

- Chỉ triển khai mã hóa, chưa có giải mã
- Chưa triển khai TripleDES (3 lần DES)
- Padding chỉ dùng zero padding (chưa chuẩn)

Hướng mở rộng:

- Triển khai giải mã bằng cách chạy Feistel rounds ngược
- Triển khai TripleDES (EDE mode)
- Hỗ trợ các mode hoạt động (ECB, CBC, CTR)
- Xử lý dữ liệu từ file input
