
%include "asm_io.inc"

segment .data

segment .bss
 
segment .text
    global  asm_main
    extern  f

asm_main:
    enter   0,0               ; setup routine
    pusha

    push    dword 3
    call    f
    pop     ecx
    
    popa
    mov     eax, 0            ; return back to C
    leave                     
    ret
