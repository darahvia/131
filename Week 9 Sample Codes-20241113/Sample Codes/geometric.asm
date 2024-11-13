
%include "asm_io.inc"

segment .data
prompt  db  "Enter a number: ",0

;
; Geometric Sequences follow the following psuedo code
; int geo_sequence(a,r,n):
;   if (n <= 0):
;       return a
;   return r * geo_sequence(a,r,n-1)
;
;
 
segment .text
        global  asm_main
asm_main:
        enter   0,0                 ; setup routine
        pusha

        mov     eax, prompt
        call    print_string
        call    read_int

        push    eax                 ;n
        push    dword 5             ;r
        push    dword 3             ;a
        call    geo_sequence

        call    print_int
        call    print_nl

        add     esp, 12
        
        popa
        mov     eax, 0              ; return back to C
        leave                     
        ret

geo_sequence:

    enter   0,0                     ; local variable to hold return value

    mov     eax, [ebp + 16]         ; eax = n
    cmp     eax, 0                  
    jle     term_cond               ; if n <= 0, terminate

    dec     eax
    push    eax
    push    dword [ebp + 12]
    push    dword [ebp + 8]
    call    geo_sequence            ; call fact(a,r,n-1) recursively
    add     esp, 12

    imul    eax, [ebp + 12]        ; eax = eax * [ebp+8]
    jmp     end_seq

term_cond:
    mov     eax, [ebp + 8]
end_seq:
    
    leave
    ret