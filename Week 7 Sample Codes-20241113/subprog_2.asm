
%include "asm_io.inc"

segment .data
sum_prompt      db  "The Sum is: ",0
enter_prompt    db  "Enter a number: ",0

segment .bss
sum resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        push    dword 10                ; 10 iterations 
        call    sum_function2
        add     esp,4                   ; remove the parameters from the stack

        mov     eax,sum_prompt
        call    print_string

        mov     eax,[sum]
        call    print_int
        call    print_nl

        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret


sum_function2:
        mov     ecx,[esp+4]

loop_start:
        mov     eax,enter_prompt
        call    print_string

        call    read_int
        add     [sum],eax
        loop    loop_start

        ret

