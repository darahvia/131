%include "asm_io.inc"

segment .data
tab_char db 9, 0               ; ASCII character for tab

segment .text
        global mult

mult:
        enter   0, 4                ; Setup routine
        push ebx                     ; Preserve ebx

        mov eax, [ebp + 8]           ; Retrieve parameter n
        mov dword [ebp - 4], 1       ; Initialize local variable row_index to 1

row_loop:
        ; Create rows
        mov eax, [ebp - 4]
        cmp eax, [ebp + 8]           ; Compare row_index with n
        jg end_loop

        mov dword [ebp - 8], 1       ; Initialize local variable col_index to 1

col_loop:
        ; Create columns
        mov eax, [ebp - 8]
        cmp eax, [ebp + 8]           ; Compare col_index with n
        jg end_col_loop

        ; Calculate row_index * col_index
        mov eax, [ebp - 4]
        imul dword [ebp - 8]
        call print_int                ; Print the product

        ; Print a tab character
        mov eax, tab_char
        call print_string

        ; Increment col_index
        mov eax, [ebp - 8]
        add eax, 1
        mov [ebp - 8], eax
        jmp col_loop                  ; Repeat for the next column

end_col_loop:
        call print_nl                 ; Print a newline after each row

        ; Increment row_index
        mov eax, [ebp - 4]
        add eax, 1
        mov [ebp - 4], eax
        jmp row_loop                  ; Repeat for the next row

end_loop:
        ; Restore ebx and return
        pop ebx
        leave
        ret
