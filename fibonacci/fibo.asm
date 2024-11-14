%include "asm_io.inc"

segment .text
global fibo

fibo:
    enter   0,0                     ;setup routine
    pusha

    mov     edx, eax                ;edx contains the original n parameter
    dec     edx                     ;prepare for the loop (n - 1)
    mov     ecx, -1                 ;ecx is the counter initialized to -1

looper:
    inc     ecx                     ;increment the counter
    cmp     ecx, edx                ;compare counter with edx
    jg      end                     ;if counter > edx, exit loop

    push    ecx                     ;push fib parameter (i)
    call    fib                     ;call Fibonacci function
    add     esp, 4                  ;clean up the stack
    call    print_int               ;print the Fibonacci result
    call    print_nl                ;print a new line
    jmp     looper                  ;repeat the loop

end:
    popa
    mov     eax, 0                  ;return back to C
    leave
    ret

; Fibonacci function
fib:
    enter   4,0                     ;push EBP and allocate 4 bytes
    mov     ebx,[ebp+8]             ;store fib parameter to ebx
    mov     dword [ebp-4],0         ;clear allocated bytes

    cmp     ebx,1                    ;if ebx <= 1, end recursion
    jle     termination_condition

    ; Return fib(n-1) + fib(n-2)
    dec     ebx
    push    ebx
    call    fib                     ;fib(n-1)

    add     [ebp-4], eax            ;add local var with return value
    pop     ebx                     ;restore value of ebx

    dec     ebx
    push    ebx
    call    fib                     ;fib(n-2)

    add     [ebp-4], eax            ;add local var with return value
    pop     ebx                     ;restore value of ebx
    jmp     return_fib

termination_condition:
    mov     [ebp-4], ebx

return_fib:
    mov     eax,[ebp-4]
    leave
    ret
