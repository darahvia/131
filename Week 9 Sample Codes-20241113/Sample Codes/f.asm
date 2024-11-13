%define i ebp-4
%define x ebp+8 ; useful macros

segment .data
format db "%d", 10, 0 ; 10 = ’\n’

segment .text
    global f
    extern printf
f:

    enter   4,0 ; allocate room on stack for i

    mov     dword [i], 0 ; i = 0
lp:
    mov     eax, [i] ; is i < x?
    cmp     eax, [x]
    jnl     quit

    push    eax ; call printf
    push    format
    call    printf
    add     esp, 8

    push    dword [i] ; call f
    call    f
    pop     eax

    inc     dword [i] ; i++
    jmp     short lp

quit:
    leave
    ret