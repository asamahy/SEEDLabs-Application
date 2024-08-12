# Project: Image encryption and Signature
These Tasks are an application on some lessons from [SEED Security Labs](https://seedsecuritylabs.org/Labs_20.04/Crypto/)

### Task 1:

1- Choose your image as the plaintext file.

2- Generate an 128-bit encryption key on your own.

3- Use ECB, CBC, CFB, and OFB modes to encrypt a file (using AES-128).

4- Display the encrypted picture using a picture viewing program (like what you did in Task 3-Lab1).

### Task 2:

1- Generate the private and the public key for using RSA as in (Lab2-RSA in OpenSSL) with 2048-bit length.

2- Create a hash (using SHA1 as shown in Lab2-RSA in OpenSSL) for the encrypted image (use the encrypted image with CBC mode).

3- Create an RSA signature (as shown in Lab2-RSA in OpenSSL) for the hash value obtained in the step 2 using the private key obtained in step 1.

4- Verify the signature (as shown in Lab2-RSA in OpenSSL) obtained in step 3 using the public key generated in step 1 and conclude the verification process (True or False).

## Observations:

Each mode results in different encrypted files. ECB mode encrypts blocks independently, which may result in patterns if the image has repetitive content and can allow to "figure out" what is in the image. CBC, CFB, and OFB modes use an initialization vector (IV) to provide better security (more entropy).

Original Image:
![Original Image](apple-logo.bmp)


Encrypted Image:
![ECB-Encrypted-Image](Task_1/encrypted_ecb.bmp)

# Usage
#### macOS:
Task 1:
```shell
./task1-1.sh <input image file>
```
Task 2: (keep in same directory as it's path dependent)
```shell
./task2.sh
```
