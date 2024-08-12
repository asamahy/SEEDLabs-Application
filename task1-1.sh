#!/bin/bash
# sips -s format bmp input.jpg --out output.bmp

if [ -z $1 ] ; then
    echo "Choose BMP image file to encrypt:"
    read image_path
else
    image_path="$1"
fi


# echo "Choose BMP image file to encrypt:"
# read image_path

if [ ! -f "$image_path" ]; then
    echo "File not found!"
    exit 1
fi

out_folder="Task_1";

if [ ! -d "${out_folder}" ]; then
    mkdir "${out_folder}"
fi

#if input isnt bmp convert to bmp using sips
if [[ ! "$image_path" =~ \.bmp$ ]]; then
    sips -s format bmp "$image_path" --out "${out_folder}"/"${image_path//.jpg/.bmp}" > /dev/null 2>&1
    image_path="${out_folder}/${image_path//.jpg/.bmp}"
fi

# read ok
# openssl rand 128
key=$(openssl rand -hex 16)
echo "Generated AES-128 key."

header_size=54
header_file="${out_folder}/header.bin"
body_file="${out_folder}/body.bin"

tail -c +55 "$image_path" > "$body_file"
head -c $header_size "$image_path" > "$header_file"

ecb_encryption="${out_folder}/encrypted_ecb.bin"
cbc_encryption="${out_folder}/encrypted_cbc.bin"
cfb_encryption="${out_folder}/encrypted_cfb.bin"
ofb_encryption="${out_folder}/encrypted_ofb.bin"

# ECB, CBC, CFB, and OFB modes to encrypt the image
iv=$(openssl rand -hex 16)
openssl enc -aes-128-cbc -in "$body_file" -out "$cbc_encryption" -K "$key" -iv "$iv"
openssl enc -aes-128-cfb -in "$body_file" -out "$cfb_encryption" -K "$key" -iv "$iv"
openssl enc -aes-128-ofb -in "$body_file" -out "$ofb_encryption" -K "$key" -iv "$iv"
openssl enc -aes-128-ecb -in "$body_file" -out "$ecb_encryption" -K "$key"

echo "Encrypted image using AES-128 in ECB, CBC, CFB, and OFB modes."

ecb_encrypted_image="${out_folder}/encrypted_ecb.bmp"
cbc_encrypted_image="${out_folder}/encrypted_cbc.bmp"
cfb_encrypted_image="${out_folder}/encrypted_cfb.bmp"
ofb_encrypted_image="${out_folder}/encrypted_ofb.bmp"

cat "$header_file" "$ecb_encryption" > "$ecb_encrypted_image"
cat "$header_file" "$cbc_encryption" > "$cbc_encrypted_image"
cat "$header_file" "$cfb_encryption" > "$cfb_encrypted_image"
cat "$header_file" "$ofb_encryption" > "$ofb_encrypted_image"

echo "Done. Encrypted BMP files created:"
