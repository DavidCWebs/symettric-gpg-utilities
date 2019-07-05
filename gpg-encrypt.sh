#!/bin/bash
# Select a file to encrypt using symmetric GnuPG.
# Convert to a QR code for printing and cold storage.
# ------------------------------------------------------------------------------

set -o nounset
set -o errexit

function create_encrypted_file {
	gpg --armor --output ${OUTPUT_DIR}/${OUTPUT} --symmetric ${TARGET}
}

function create_qrcode {
	if [[ -x "$(command -v qrencode)" ]]; then
		cat ${OUTPUT_DIR}/${OUTPUT} | qrencode -s 10 -o ${OUTPUT_DIR}/${OUTPUT}.png
	else
		echo "The qrencode package is not installed. See https://fukuchi.org/works/qrencode/index.html.en"
		echo "Or in Ubuntu run: sudo apt-get install qrencode."
	fi
}

function run {
	echo "running..."
	#set_target
	TARGET=$1
	OUTPUT=$(basename ${TARGET}).gpg
	OUTPUT_DIR=$(dirname ${TARGET})
	set_output_directory
	create_encrypted_file
	create_qrcode
	echo "-------------------------------------------------------------------------"
	echo "Encrypted file: ${OUTPUT_DIR}/${OUTPUT}"
	if [[ -f ${OUTPUT_DIR}/${OUTPUT}.png ]]; then
		echo "QR encoded encrypted file: ${OUTPUT_DIR}/${OUTPUT}.png"
	fi
	echo "-------------------------------------------------------------------------"
}

cat << EOF
---
This script helps you to symmetrically encrypt a file.

Note that the QR encoding is not optimised for large files.
---
EOF

while true; do
	read -p "Do you want to proceed[y/N]?" -n 1 -r
	echo $REPLY
	[[ $REPLY =~ ^[yY]$ ]] && { run; break; }
	[[ $REPLY =~ ^[nN]$ ]] && exit
	echo "Please enter y or n."
done

