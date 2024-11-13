

extern  call_c_function 

segment .text

        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        call    call_c_function

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret

