;====================================
; Sheet 2, Exercise 1
; Name  : Omar Tarek Amer
;====================================
.model small

.data
; Data Segment: Two 3-word numbers.
num1 dw 0d37eh, 0f8a8h, 05463h
num2 dw 092c2h, 03408h, 087deh ; Contiguous

res  dw ?, ?, ? ; Result of the addition.

.code
main proc far
mov ax, @data
mov ds, ax

; If we will be doing it word by word, we need three loop iterations.

    mov cx, 3 ; CX, the counter register is conventionally used for loop iterations.


    ; Use the source index (SI) register to point to the first word of both numbers.
    ; Use the destination index (DI) register to point to the first word of the result.
    lea si, num1 ; LEA => Load effective address.
    lea di, res
    mov ax, 0 ; Accumulate here.

loop_start:
    adc ax, [si]
    adc ax, [si+6]
    mov [di], ax
    pushf
    add di, 2
    add si, 2
    popf
    dec cx
    mov ax, 0
    jnz loop_start
main endp
end main
