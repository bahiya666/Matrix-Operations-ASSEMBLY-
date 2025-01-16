; ==========================
; Group member 01: u22598546
; ==========================

segment .text
        global multiplyScalarToMatrix
        
multiplyScalarToMatrix:
 ; Check if rows or columns are zero
    test    rsi, rsi          ; Check if rows (rsi) is zero
    jz      .done             ; If zero, jump to done
    test    rdx, rdx          ; Check if columns (rdx) is zero
    jz      .done             ; If zero, jump to done

    ; Check if scalar is 1.0
    movss   xmm1, xmm0        ; Move scalar value to xmm1
    movss   xmm2, [one]       ; Load 1.0 to xmm2
    ucomiss xmm1, xmm2        ; Compare scalar with 1.0
    jz      .done             ; If equal, jump to done

    ; Loop over each row
    mov     rcx, rsi          ; Set row counter
.loop_rows:
    ; Get pointer to the current row
    mov     r8, [rdi]         ; Load pointer to current row

    ; Loop over each column
    mov     r9, rdx           ; Set column counter
.loop_cols:
    ; Load element from matrix
    movss   xmm3, [r8]        ; Load matrix element to xmm3
    mulss   xmm3, xmm0        ; Multiply element by scalar
    movss   [r8], xmm3        ; Store result back to matrix

    ; Move to the next column element
    add     r8, 4             ; Move pointer to next element (assuming float size is 4 bytes)
    dec     r9                ; Decrement column counter
    jnz     .loop_cols        ; Loop until all columns are processed

    ; Move to the next row
    add     rdi, 8            ; Move matrix pointer to next row (assuming 2 columns * 4 bytes each)
    dec     rcx               ; Decrement row counter
    jnz     .loop_rows        ; Loop until all rows are processed

.done:
    ret                      ; Return from function

section .data
one:    dd 1.0              ; Define constant 1.0