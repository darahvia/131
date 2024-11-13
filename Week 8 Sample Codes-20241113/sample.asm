

extern  scanf, printf

segment .data
x       dd 50
format  db "x = %d ",10, 0  ; printf("x = %d ",x);


segment .bss
input1 resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        push    dword [x]         ; push x’s value
        push    dword format      ; push address of format string      
        call    printf            ; no underscore
        add     esp, 8            ; remove parameters from stack


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

