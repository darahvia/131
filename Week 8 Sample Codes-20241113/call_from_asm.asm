

extern  scanf, printf, sum_in_c

segment .data
format  db "sum = %d ",10, 0  ; printf("x = %d ",x);


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        push    dword 12
        call    sum_in_c          ; no underscore, sum will be in eax
        pop     ecx

        push    eax               ; push sum’s value
        push    dword format      ; push address of format string      
        call    printf            ; no underscore
        add     esp, 8            ; remove parameters from stack


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

