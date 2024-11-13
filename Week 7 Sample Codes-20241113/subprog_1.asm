
%include "asm_io.inc"

segment .data
sum_prompt   db  "The Sum is: ",0

segment .bss
sum resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, 5
        mov     ebx, 7
        mov     ecx, 2
        mov     edx, 9

        call    sum_function

        mov     eax,sum_prompt
        call    print_string

        mov     eax,[sum]
        call    print_int
        call    print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


sum_function:
        add     eax,ebx
        add     eax,ecx
        add     eax,edx
        mov     [sum],eax
        ret

