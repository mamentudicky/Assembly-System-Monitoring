%include "headers.inc"

section .bss
    loadavg resq 3

section .data
    load_msg db 'CPU Load: ', 0
    load_len equ $ - load_msg
    newline db 10, 0
    nl_len equ $ - newline

section .text
global cpu_load
extern print_decimal    ; <--- TAMBAHKAN INI agar assembler tahu fungsi ini ada di luar

cpu_load:
    push ebx
    push ecx
    push edx

    mov ebx, loadavg
    mov ecx, 3
    mov eax, SYS_GETLOADAVG
    int 0x80
    test eax, eax
    js .print_done

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, load_msg
    mov edx, load_len
    int 0x80

    mov eax, dword [loadavg]
    shr eax, 10         ; Scale down loadavg (loadavg is fixed-point *100)
    call print_decimal

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, nl_len
    int 0x80

.print_done:
    pop edx
    pop ecx
    pop ebx
    ret