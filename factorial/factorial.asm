
%include "asm_io.inc"

segment .text
global get_int, factorial

get_int:
    call    read_int
    ret

factorial:
    cmp     eax, 1
    jle     base_case
    dec     eax
    push    eax
    call    factorial

    pop     ebx
    inc     ebx
    mul     ebx
    ret

base_case:
    mov eax, 1
    ret
