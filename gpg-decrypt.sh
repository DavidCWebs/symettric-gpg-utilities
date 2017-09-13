#!/bin/bash
# Decrypt files that have been symmetrically encrypted by GnuPG

function set_target() {
  TARGET=$(zenity --file-selection --title="Select a file to be decrypted." --filename=${PWD}/)
  case $? in
    0)
    echo "\"$TARGET\" selected.";;
    1)
    echo "No file selected.";;
    -1)
    echo "An unexpected error has occurred.";;
  esac
  TARGET_DIR=$(dirname ${TARGET})
}

function set_output_directory() {
  OUTPUT_DIR=$(zenity --file-selection --title="Select a directory for the decrypted file." --filename=${TARGET_DIR}/ --directory)
  case $? in
    0)
    echo "\"$OUTPUT_DIR\" selected.";;
    1)
    echo "No file selected.";;
    -1)
    echo "An unexpected error has occurred.";;
  esac
}

function set_output_filename() {
  OUTPUT_FILENAME=$(zenity --entry --title="Enter a filename.")
  case $? in
    0)
    echo "\"$OUTPUT_FILENAME\" selected.";;
    1)
    echo "No file selected.";;
    -1)
    echo "An unexpected error has occurred.";;
  esac
}

set_target
set_output_directory
set_output_filename

gpg -o ${OUTPUT_DIR}/${OUTPUT_FILENAME} -d ${TARGET}
