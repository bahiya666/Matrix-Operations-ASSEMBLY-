; ==========================
; Group member 01: u22598546
; ==========================

segment .text
        global calculateMatrixDotProduct

calculateMatrixDotProduct:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; Check if the number of rows or columns is zero
    test edx, edx
    jz .return_zero
    test ecx, ecx
    jz .return_zero

    mov r12, rdi    ; Matrix 1
    mov r13, rsi    ; Matrix 2
    mov r14d, edx   ; Number of rows
    mov r15d, ecx   ; Number of columns

    xorps xmm0, xmm0  ; Initialize accumulator for dot product

    xor ebx, ebx    ; Initialize row counter
.row_loop:
    mov rax, [r12 + rbx * 8]  ; Get row pointer from matrix 1
    mov rdx, [r13 + rbx * 8]  ; Get row pointer from matrix 2
    
    xor ecx, ecx    ; Initialize column counter
.col_loop:
    movss xmm1, [rax + rcx * 4]  ; Load element from matrix 1 row
    mulss xmm1, [rdx + rcx * 4]  ; Multiply with corresponding element from matrix 2 row
    addss xmm0, xmm1             ; Accumulate the result in xmm0

    inc ecx         ; Increment column counter
    cmp ecx, r15d   ; Check if all columns are processed
    jl .col_loop    ; Repeat for remaining columns

    inc ebx         ; Increment row counter
    cmp ebx, r14d   ; Check if all rows are processed
    jl .row_loop    ; Repeat for remaining rows

    jmp .done       ; Jump to completion

.return_zero:
    xorps xmm0, xmm0  ; Return 0 if matrix dimensions are invalid

.done:
    ; Restore registers and return
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
