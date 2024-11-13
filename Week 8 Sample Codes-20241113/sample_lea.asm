
%include "asm_io.inc"

extern  scanf, printf

segment .data
x       dd 25
format  db "x = %d ",10, 0 


segment .bss
input1 resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        call    foo


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

foo:
        enter   4,0

        ;mov     eax, ebp-4         
        dump_regs 1               ; check register values

        lea     eax, [ebp-4]    
        push    eax             
        
        dump_regs 2               ; check register values

        leave
        ret


