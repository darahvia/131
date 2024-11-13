
%include "asm_io.inc"

segment .data
prompt db ") Enter an integer number (0 to quit): ", 0

segment .text
    
    global  get_int
get_int:
    enter   0,0

    mov     eax, [ebp + 12]
    call    print_int

    mov     eax, prompt
    call    print_string

    call    read_int
    mov     ebx, [ebp + 8]
    mov     [ebx], eax              ; store input into memory

    leave
    ret                             ; jump back to caller

