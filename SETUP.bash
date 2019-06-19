#!/bin/bash
#

BIN_SETUP_FOLDER=$(dirname "${BASH_SOURCE[0]}")
BIN_SETUP_SCRIPT=$(dirname "${BASH_SOURCE[0]}")/bin/bin_setup.bash

if [[ $(uname) == "Darwin" ]]; then
    source "$BIN_SETUP_SCRIPT" -var PATH -prepend -path "$BIN_SETUP_FOLDER/bin/ds9_mac"
else
    SYS_GLIBC_VERSION=$(ldd --version | head -n 1 | perl -p -e 's/.*[ ]+([0-9.]+)$/\1/g')
    SYS_GLIBC_VER_MAJ=$(echo $SYS_GLIBC_VERSION | perl -p -e 's/([0-9]+)[.]([0-9]+)/\1/g')
    SYS_GLIBC_VER_MIN=$(echo $SYS_GLIBC_VERSION | perl -p -e 's/([0-9]+)[.]([0-9]+)/\2/g')
    if [[ $SYS_GLIBC_VER_MAJ -lt 2 ]]; then
        source "$BIN_SETUP_SCRIPT" -var PATH -prepend -path "$BIN_SETUP_FOLDER/bin/ds9_linux_Glibc_2.12"
    elif [[ $SYS_GLIBC_VER_MAJ -eq 2 ]] && [[ $SYS_GLIBC_VER_MIN -le 12 ]]; then
        source "$BIN_SETUP_SCRIPT" -var PATH -prepend -path "$BIN_SETUP_FOLDER/bin/ds9_linux_Glibc_2.12"
    else
        source "$BIN_SETUP_SCRIPT" -var PATH -prepend -path "$BIN_SETUP_FOLDER/bin/ds9_linux_Glibc_2.14"
    fi
fi

source "$BIN_SETUP_SCRIPT" # -check ds9 ds9galfit ds9longurl


