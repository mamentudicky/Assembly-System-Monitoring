%include "headers.inc"

section .data
    proc_msg db 'Processes: ', 0
    proc_len equ $ - proc_msg
    proc_dir db '/proc', 0
    newline db 10, 0
    nl_len equ $ - newline

section .bss
    proc_count resd 1
    dirbuf resb 1024

section .text
global proc_count_func
extern print_decimal
proc_count_func:
    mov dword [proc_count], 0

    mov ebx, proc_dir
    mov ecx, O_RDONLY
    mov eax, SYS_OPEN
    int 0x80
    test eax, eax
    js .error

    mov ebx, eax

.read_loop:
    mov ecx, dirbuf
    mov edx, 1024
    mov eax, SYS_READ
    int 0x80
    test eax, eax
    jle .close

    mov esi, dirbuf
    mov ecx, eax
.parse_dirent:
    ; Skip if not digit start
    cmp byte [esi + 19], '0'  ; d_name offset in dirent = 19 (i386 linux)
    jb .next_entry
    cmp byte [esi + 19], '9'
    ja .next_entry
    
    ; Check all digits until non-digit (simple PID check)
    mov edi, esi
    add edi, 19
    mov ecx, 5  ; max PID digits
.is_pid:
    cmp byte [edi], '0'
    jb .is_pid_end
    cmp byte [edi], '9'
    ja .is_pid_end
    inc edi
    dec ecx
    jnz .is_pid
.is_pid_end:
    test ecx, ecx
    jz .next_entry  ; too many digits
    inc dword [proc_count]  ; valid PID dir
.next_entry:
    add esi, 24  ; sizeof dirent ~24 bytes, rough advance
    cmp esi, dirbuf + 1024
    jb .parse_dirent
    jmp .read_done
.read_done:
.close:
    mov eax, SYS_CLOSE
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, proc_msg
    mov edx, proc_len
    int 0x80

    mov eax, [proc_count]
call print_decimal

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, newline
    mov edx, nl_len
    int 0x80

    ret

.error:
    ret

