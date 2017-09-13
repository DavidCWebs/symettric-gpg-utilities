#!/bin/bash
# Select a file to encrypt using symmetric GnuPG.
# Convert to a QR code for printing and cold storage.

function set_target() {
  TARGET=$(zenity --file-selection --title="Select a file to be encrypted." --filename=${HOME}/)
  case $? in
    0)
    echo "\"$TARGET\" selected.";;
    1)
    echo "No file selected.";;
    -1)
    echo "An unexpected error has occurred when setting the target.";;
  esac
  OUTPUT=$(basename ${TARGET}).gpg
  TARGET_DIR=$(dirname ${TARGET})
}

function set_output_directory() {
  OUTPUT_DIR=$(zenity --file-selection --title="Select a directory for the encrypted file." --filename=${TARGET_DIR}/ --directory)
  case $? in
    0)
    echo "\"$OUTPUT_DIR\" selected.";;
    1)
    echo "No file selected.";;
    -1)
    echo "An unexpected error has occurred when setting the output.";;
  esac
}

function create_encrypted_file() {
  gpg --armor --output ${OUTPUT_DIR}/${OUTPUT} --symmetric ${TARGET}
}

function create_qrcode() {
  if [[ -x "$(command -v qrencode)" ]]; then
    cat ${OUTPUT_DIR}/${OUTPUT} | qrencode -s 10 -o ${OUTPUT_DIR}/${OUTPUT}.png
  else
    echo "The qrencode package is not installed. See https://fukuchi.org/works/qrencode/index.html.en"
    echo "Or in Ubuntu run: sudo apt-get install qrencode."
  fi
}

set_target
set_output_directory
create_encrypted_file
create_qrcode

echo "-------------------------------------------------------------------------"
echo "Encrypted file: ${OUTPUT_DIR}/${OUTPUT}"
if [[ -f ${OUTPUT_DIR}/${OUTPUT}.png ]]; then
  echo "QR encoded encrypted file: ${OUTPUT_DIR}/${OUTPUT}.png"
fi
echo "-------------------------------------------------------------------------"
