%include "asm_io.inc"

segment .data
prompt1 db  "Enter a number to calculate its factorial: ", 0
exclam  db  "!", 0
eq      db  " = ",0

segment .bss
input1  resd 1
result  resd 1

segment .text
global asm_main
extern get_int, factorial

asm_main:
    enter 0,0
    pusha

    mov     eax, prompt1
    call    print_string
    call    get_int
    mov     [input1], eax
    call    factorial
    mov     [result], eax

    mov     eax, [input1]
    call    print_int

    mov     eax, exclam
    call    print_string

    mov     eax, eq
    call    print_string

    mov     eax, [result]
    call    print_int

    popa
    leave
    ret
