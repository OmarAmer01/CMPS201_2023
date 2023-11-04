;====================================
; Sheet 2, Exercise 2
; Name  : Omar Tarek Amer
;====================================
.model small

.data

num1 dq 5463f8a8d37eh
     dq 87de340892c2h ; Contiguous

res  dq ?

.code
main proc far
    mov ax, @data
    mov ds, ax

    mov cx, 6 ; Loop 6 times

    lea si, num1 ; we know num2 is after num1 by 8 bytes
    lea di, res
    mov ax, 0
    counting_loop:
        adc al, byte ptr [si] ; Add num 1
        adc al, byte ptr [si+8]

        mov [di], al
        pushf
        inc di
        inc si
        popf

        dec cx
        mov al, 0
        jnz counting_loop


main endp
end main


