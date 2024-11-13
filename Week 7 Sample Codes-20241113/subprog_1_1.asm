
%include "asm_io.inc"

segment .data
sum_prompt   db  "The Sum is: ",0

segment .bss
sum resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        push    dword 5
        push    dword 7
        push    dword 2
        push    dword 9

        call    sum_function
        add     esp, 16                 ;remove the parameters from the stack 

        mov     eax,sum_prompt
        call    print_string

        mov     eax,[sum]
        call    print_int
        call    print_nl

        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret


sum_function:
        xor     eax,eax
        add     eax,[esp+16]    ;first parameter 5
        add     eax,[esp+12]    ;first parameter 7
        add     eax,[esp+8]     ;first parameter 2
        add     eax,[esp+4]     ;first parameter 9 
        mov     [sum],eax
        ret

