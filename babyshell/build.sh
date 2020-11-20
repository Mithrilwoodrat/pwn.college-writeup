#!/bin/bash

if [ "$#" -eq 3 ]; then
    echo "Using $0, input.s <shellcode-raw>"
    exit 0
fi

source=$1
target=$2

echo "source: $source"
echo "output: $target"

# exit 0

gcc -nostdlib -static $source -o tmp.elf
objcopy --dump-section .text=$target tmp.elf
cat shellcode-raw|disasm -c 'amd64' > shellcode.disasm
