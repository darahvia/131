%include "asm_io.inc"

segment .data
msg_size_prompt db "Enter array size: ", 0
msg_value_prompt db "Enter value @ index [%d]: ", 0
fmt_input db "%d ", 0
msg_array_content db "Array contains:", 10, 0
msg_search_prompt db "Enter number to be searched: ", 0
msg_found db "%d is @ array[%d]", 0
msg_not_found db "Value not found", 0

segment .bss
array_size resd 1
dynamic_array resd 1
search_target resd 1 

segment .text
    extern puts, printf, scanf, dump_line, malloc
    global asm_main

asm_main:
    enter   0,0               
    pusha

    ; Prompt and read array size
    mov eax, msg_size_prompt
    call print_string
    call read_int
    mov [array_size], eax        ; Store array size

    ; Allocate memory for array
    mov ecx, [array_size]
    shl ecx, 2                    ; Convert to bytes (4 bytes per int)
    push ecx
    call malloc                   ; Allocate memory dynamically
    add esp, 4
    mov [dynamic_array], eax      ; Store pointer to allocated memory

    ; Call function to read values into array
    mov ebx, [dynamic_array]
    push ebx
    call fill_array
    pop ecx
    pop ecx

exit_main:
    popa
    mov eax, 0                    ; Return to C
    leave                     
    ret

; Function to read array values
fill_array:
    enter 4,0
    mov ecx, 0

array_input_loop:
    push dword ecx                ; Parameter for printf
    push msg_value_prompt
    call printf
    pop ecx
    pop ecx

    call read_int                 ; Read user input
    mov ebx, [ebp+8]              ; Array pointer parameter
    lea ebx, [ebx + 4*ecx]        ; Calculate address for current index
    mov [ebx], eax                ; Store value in array

    mov edx, [array_size]
    sub edx, 1
    cmp ecx, edx                  ; Compare counter with array size
    je display_array              ; Exit loop if array is full

    inc ecx
    jmp array_input_loop          ; Continue loop

display_array:
    mov eax, msg_array_content
    call print_string
    call print_nl
    mov ecx, 0

array_output_loop:
    mov ebx, [ebp+8]              ; Array pointer

    push ecx                      ; Preserve counter
    push dword [ebx + 4*ecx]      ; Push array element value
    push fmt_input
    call printf
    pop ecx
    pop ecx
    pop ecx

    mov edx, [array_size]
    inc ecx                       ; Increment counter
    cmp ecx, edx
    jne array_output_loop         ; Loop until end of array
    call print_nl

    ; Search functionality
    mov ebx, [ebp+8]              ; Load array pointer
    mov eax, msg_search_prompt
    call print_string
    call read_int
    mov [search_target], eax      ; Store target value to search

    cld
    mov edi, ebx                  ; Set EDI to point to array start
    mov ecx, [array_size]
    xor ebx, ebx                  ; Clear index counter

search_loop:
    scasd                         ; Compare array value with target
    je found_case                 ; Jump if value found
    inc ebx                       ; Increment index
    loop search_loop              ; Continue loop if not found

    ; Case for value not found
not_found_case:
    mov eax, msg_not_found
    call print_string
    call print_nl
    leave
    ret

found_case:
    mov eax, [search_target]
    push ebx
    push eax
    push msg_found
    call printf
    pop ecx
    pop ecx
    pop ecx
    call print_nl
    
    leave
    ret
