%include "print_num.inc"

section .text
global _start
_start:
    mov eax, 123
    print_num eax
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
