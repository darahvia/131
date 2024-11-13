extern  printf, sum_in_c2

segment .data
format          db      "sum = %d ",10, 0                       ; printf("sum = %d ",sum);
reject_prompt   db      "Function returned an error!",10,0

segment .text
        global  call_c_function
call_c_function:
        enter   4,0                     ; setup routine, reserving 4 local bytes for sum
        push    ebx                     ; push EBX since we are using it here

        lea     ebx, [ebp - 4]          ; Load effective address of [EBP - 4] local variable to EBX    
        
        push    ebx                     ; push address of local variable
        push    dword -100                ; push n
        call    sum_in_c2               ; sum is in [ebp -4], eax contains return value if error
        add     esp, 8

        cmp     eax, 0 
        jl      reject
        
        push    dword [ebp -4]          ; push sum’s value
        push    dword format            ; push address of format string      
        call    printf                  ; no underscore
        add     esp, 8                  ; remove parameters from stack
        jmp     end_if

reject:
        push    dword reject_prompt     ; push address of format string      
        call    printf                  ; no underscore
        pop     ecx                     ; remove parameters from stack
end_if:

        pop     ebx                     
        leave                     
        ret

