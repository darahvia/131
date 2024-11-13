%include "asm_io.inc"


; subprogram print_sum
; prints out the sum
; Parameter:
; sum to print out (at [ebp+8])
; Note: destroys value of eax
;
segment .data
result db "The sum is ", 0

segment .text

    global print_sum
print_sum:
    enter   0,0

    mov     eax, result
    call    print_string

    mov     eax, [ebp+8]
    call    print_int
    call    print_nl

    leave
    ret