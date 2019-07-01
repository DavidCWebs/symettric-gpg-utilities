Symmetric File Encryption with GnuPG
====================================
This utility is a wrapper for GnuPG that focuses on backing up files to be stored in paper format.

Use case: sensitive config data that needs to be backed up both securely and with a high degree of reliability.

This package adds a bit of convenience when encrypting & decrypting files from the command line.

## Dependencies
Written for Ubuntu 16.04. Requires:
* [Gnu Privacy Guard - GnuPG](https://www.gnupg.org/)
* [Qrencode](https://fukuchi.org/works/qrencode/index.html.en)

## Usage
Prompts (using Zenity) for the file to encrypt and the storage directory.

Encryption will require you to enter a passphrase twice. The strength of your passphrase is likely to be the main determinant of how secure your encrypted file is.

This [tool](https://www.rempe.us/diceware/#eff) is a good way to generate strong passphrases. For maximum security, download the tool and run in an offline Tails session. Or just [roll some dice](http://world.std.com/~reinhold/diceware.html) to determine a properly randomised passphrase.

A ten-word passphrase, (pseudo)randomly selected from a keyspace of 7776 possible words will give you ~ 129 bits of entropy - which will take longer to brute force than the probable age of the universe. Probably secure enough for most purposes.
