
%include "asm_io.inc"

segment .data
enter_prompt    db  "Enter a number: ",0
sum_prompt      db  "The sum of the number you entered and the parameter is: ",0

segment .bss
input1 resd 1
 
segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        push    dword 10 
        call    num_function1
        add     esp,4                  ; remove the parameters from the stack

        mov     eax, sum_prompt
        call    print_string

        mov     eax, [input1]
        call    print_int
        call    print_nl

        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret


num_function1:
        ;dword 10 is at ESP + 4
        mov     eax,enter_prompt
        call    print_string

        push    input1
        call    get_int

        mov     eax, [ESP + 8] ; dword 10 to EAX
        add     [input1], eax

        add     esp, 4

        ret



get_int:
        mov     ebx, [ESP + 4]

        call    read_int
        mov     [ebx],eax

        ret


