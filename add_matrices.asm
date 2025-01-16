; ==========================
; Group member 01: u22598546
; ==========================

section .text
    global addMatrices
    extern malloc
    extern free

addMatrices:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi    ; Matrix 1
    mov r13, rsi    ; Matrix 2
    mov r14d, edx   ; Number of rows
    mov r15d, ecx   ; Number of columns

    test r14d, r14d ; Check if rows are 0
    jz .return_null
    test r15d, r15d ; Check if columns are 0
    jz .return_null

    mov rdi, r14    ; Number of rows
    imul rdi, 8     ; Calculate space for row pointers
    call malloc     ; Allocate memory for row pointers
    test rax, rax   ; Check if allocation failed
    jz .return_null
    mov rbx, rax    ; Save allocated memory address

    xor r8d, r8d    ; Initialize row counter
.alloc_rows:
    mov rdi, r15    ; Number of columns
    shl rdi, 2      ; Multiply by 4 (float size)
    push rbx        ; Save the current matrix base address
    push r8         ; Save row counter
    call malloc     ; Allocate memory for each row
    pop r8          ; Restore row counter
    pop rbx         ; Restore matrix base address
    test rax, rax   ; Check if allocation failed
    jz .cleanup

    mov [rbx + r8 * 8], rax ; Store row pointer in matrix
    inc r8d                 ; Increment row counter
    cmp r8d, r14d           ; Check if all rows are allocated
    jl .alloc_rows          ; Repeat if more rows to allocate

    xor r8d, r8d    ; Reset row counter
.row_loop:
    mov r9, [r12 + r8 * 8]  ; Get pointer to row in matrix 1
    mov r10, [r13 + r8 * 8] ; Get pointer to row in matrix 2
    mov r11, [rbx + r8 * 8] ; Get pointer to row in result matrix
    
    xor edx, edx    ; Initialize column counter
.col_loop:
    movss xmm0, [r9 + rdx * 4] ; Load float from matrix 1
    addss xmm0, [r10 + rdx * 4] ; Add corresponding float from matrix 2
    movss [r11 + rdx * 4], xmm0 ; Store result in result matrix

    inc edx         ; Increment column counter
    cmp edx, r15d   ; Check if all columns are processed
    jl .col_loop    ; Repeat for next column

    inc r8d         ; Increment row counter
    cmp r8d, r14d   ; Check if all rows are processed
    jl .row_loop    ; Repeat for next row

    mov rax, rbx    ; Return result matrix
    jmp .exit

.cleanup:
    dec r8d         ; Decrement row counter
.free_loop:
    mov rdi, [rbx + r8 * 8] ; Get pointer to row
    call free       ; Free allocated row memory
    dec r8d         ; Decrement row counter
    jns .free_loop  ; Repeat until all rows are freed
    mov rdi, rbx    ; Free the main matrix
    call free

.return_null:
    xor eax, eax    ; Return null on error

.exit:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
