
%include "asm_io.inc"

segment .data

segment .bss
 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        push    dword 3
        call    fact

        call    print_int
        call    print_nl

        pop     ecx
        
        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

fact:

    enter   0,0

    mov     eax, [ebp+8]    ; eax = n
    cmp     eax, 1
    jle     term_cond       ; if n <= 1, terminate
    dec     eax
    push    eax

    call    fact            ; call fact(n-1) recursively
    pop     ecx             ; answer in eax
    mul     dword [ebp+8]   ; edx:eax = eax * [ebp+8]
    jmp     short end_fact

term_cond:
    mov     eax, 1
end_fact:
    
    leave
    ret