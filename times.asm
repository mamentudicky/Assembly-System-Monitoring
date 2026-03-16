%include "headers.inc"

section .bss
    tms_data resb 16

section .data
    uptime_msg db 'Uptime (ticks): ', 0
    uptime_len equ $ - uptime_msg
    newline db 10, 0
    nl_len equ $ - newline

section .text
global uptime_info
extern print_decimal
uptime_info:
    mov ebx, tms_data
    mov eax, SYS_TIMES
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, uptime_msg
    mov edx, uptime_len
    int 0x80

    mov eax, [tms_data + TMS_UTIME]
call print_decimal

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, nl_len
    int 0x80
    ret

