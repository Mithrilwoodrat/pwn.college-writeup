#!/bin/sh

gcc -nostdlib -static readflag.s -o readflag.elf
objcopy --dump-section .text=shellcode-raw readflag.elf
cat shellcode-raw|disasm -c 'amd64' > shellcode.disasm
