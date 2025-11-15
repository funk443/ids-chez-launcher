#!/bin/sh

set -xe

LIB_AND_INCLUDE_PATH="chez"

gcc -O2 -Wall -Wextra -oapp \
    -I"$LIB_AND_INCLUDE_PATH" \
    c/launcher.c \
    -L"$LIB_AND_INCLUDE_PATH" \
    -lkernel -llz4 -lz -lcurses -lm
