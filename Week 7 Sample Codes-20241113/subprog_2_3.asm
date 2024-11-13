
%include "asm_io.inc"

segment .data
sum_prompt      db  "The Sum is: ",0
enter_prompt    db  "Enter a number: ",0

segment .bss
 
segment .text
        global  asm_main
asm_main:
        enter   0,0                     ; setup routine
        pusha

        push    dword 10                ; 10 iterations 
        call    sum_function2
        add     esp,4                   ; remove the parameters from the stack       
        mov     ebx,eax                 ; temporarily store eax to ebx

        mov     eax,sum_prompt
        call    print_string

        mov     eax,ebx 
        call    print_int
        call    print_nl

        popa
        mov     eax, 0                  ; return back to C
        leave                     
        ret


sum_function2:
        push    ebp
        mov     ebp,esp
        sub     esp,4                   ;allocate 4 bytes of memory for a local variable

        mov     ecx,[ebp+8]
        mov     dword [ebp-4],0         ;clear allocated memory

loop_start:
        mov     eax,enter_prompt
        call    print_string

        call    read_int
        add     [ebp-4],eax
        loop    loop_start

        mov     eax,[ebp-4]

        mov     esp,ebp                  ; remove the 4 bytes from the stack before returning
        pop     ebp
        ret

