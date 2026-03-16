%include "headers.inc"

section .bss
dec_buffer resb 32
temp_char resb 1

section .text
global print_decimal

print_decimal:
    push ebx
    push ecx
    push edx
    push esi

    mov esi, 10
    mov edi, dec_buffer + 31
    mov byte [edi], 0
    dec edi

    test eax, eax
    jnz .div_loop

    mov byte [edi], '0'
    jmp .print_loop

.div_loop:
    xor edx, edx
    div esi
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz .div_loop

.print_loop:
    inc edi
    mov al, [edi]
    cmp al, 0
    je .exit

    mov [temp_char], al
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, temp_char
    mov edx, 1
    int 0x80
    jmp .print_loop

.exit:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
