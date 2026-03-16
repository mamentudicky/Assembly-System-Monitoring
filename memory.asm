%include "headers.inc"

section .bss
    buffer resb 100

section .data
    mem_msg db 'Memory Total: ', 0
    mem_len equ $ - mem_msg
    mb_msg db ' MB Free: ', 0
    mb_len equ $ - mb_msg
    newline db 10, 0
    nl_len equ $ - newline

section .text
global memory_info
extern print_decimal    ; Deklarasikan fungsi eksternal

memory_info:
    ; Simpan register agar tidak berantakan
    push ebx
    push ecx
    push edx

    mov ebx, buffer
    mov eax, SYS_SYSINFO
    int 0x80

    ; Print "Memory Total: "
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, mem_msg
    mov edx, mem_len
    int 0x80

    ; Ambil Total RAM dan Print
    mov eax, [buffer + 16] ; SYSINFO_TOTALRAM offset 16
    shr eax, 20         ; Convert ke MB
    call print_decimal  ; UBAH: dari print_num eax menjadi call print_decimal

    ; Print " MB Free: "
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, mb_msg
    mov edx, mb_len
    int 0x80

    ; Ambil Free RAM dan Print
    mov eax, [buffer + 20] ; SYSINFO_FREERAM offset 20
    shr eax, 20         ; Convert ke MB
    call print_decimal  ; UBAH: dari print_num eax menjadi call print_decimal

    ; Print Newline
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, nl_len
    int 0x80

    pop edx
    pop ecx
    pop ebx
    ret