#!/bin/bash

out_folder="Task_2";
if [ ! -d "${out_folder}" ]; then
    mkdir "${out_folder}"
fi

private_key="${out_folder}/private_key.pem"
public_key="${out_folder}/public_key.pem"

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_keygen_pubexp:3 -out "$private_key" > /dev/null 2>&1

openssl pkey -in "$private_key" -out "$public_key" -pubout && echo "RSA private and public keys generated." || echo "RSA key generation failed."

# echo "RSA private and public keys generated."
# read ok

cbc_encrypted_image="Task_1/encrypted_cbc.bmp"
file_hash="${out_folder}/hash.txt"

openssl dgst -sha1 "$cbc_encrypted_image" | awk '{print $2}' > "$file_hash"
# file_hash=$(openssl dgst -sha1 "$cbc_encrypted_image" | awk '{print $2}')
# echo $file_hash

echo "SHA1 hash created for the CBC encrypted image."
# read ok

signature_file="${out_folder}/signature.bin"

# openssl dgst -sha1 -sign privkey-alice.pem -out sign-alice.bin message-alice.txt
openssl dgst -sha1 -sign "$private_key" -out "$signature_file" "$file_hash" > /dev/null 2>&1 && echo "RSA signature created for the hash value." || echo "RSA signature creation failed."

# echo "RSA signature created for the hash value."
# read ok
# openssl dgst -sha1 -verify pubkey-alice.pem -signature sign-alice.bin received-alice.txt

openssl dgst -sha1 -verify "$public_key" -signature "$signature_file" "$file_hash" > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Signature verification: Successful"
else
    echo "Signature verification: Failed"
fi

echo ""
echo "Process completed."

