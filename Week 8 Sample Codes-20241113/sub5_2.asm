

;
; file: sub5.asm
; Subprogram to C interfacing example

%include "asm_io.inc"

; subroutine calc_sum
; finds the sum of the integers 1 through n
; Parameters:
;   n    - what to sum up to (at [ebp + 8])
;   sump - pointer to int to store sum into (at [ebp + 12])
; pseudo C code:
; void calc_sum( int n, int * sump )
; {
;   int i, sum = 0;
;   for( i=1; i <= n; i++ )
;     sum += i;
;   *sump = sum;
; }
;
; To assemble:
; DJGPP:   nasm -f coff sub5.asm
; Borland: nasm -f obj  sub5.asm

segment .text
        global  calc_sum
;
; local variable:
;   sum at [ebp-4]
calc_sum:
        enter   0,0               ; allocate room for sum on stack
 
        ;mov     dword [ebp-4],0   ; sum = 0 (commented out since we don't need a local variable)
        xor     eax,eax           ; instead of clearing the local variable, we clear eax. 
                                  ; eax will now hold the sum
        dump_stack 1, 2, 4        ; print out stack from ebp-8 to ebp+16

        mov     ecx, [ebp+8]            ; ecx is i in pseudocode
for_loop:

        add     eax, ecx            ; sum += i
        loop     for_loop

end_for:
        ;mov     eax, [ebp-4]     
                      
        leave
        ret




