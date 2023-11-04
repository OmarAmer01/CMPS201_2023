;====================================
; Sheet 2, Exercise 10
; Name  : Omar Tarek Amer
;====================================

.model small

.data
grades db 81, 65, 77, 82, 73,55, 88, 78, 51, 91, 86, 76
; No radix means the grades are in decimal.

curved_grades db 12 dup(?)

max db ? ; Maximum grade


.code
main proc far
    mov ax, @data
    mov ds, ax

    lea si, grades
    lea di, curved_grades

    ; First, we need to find the maximum grade.
    ; Keep the maximum nubmer in MAX
    ; The index of the maximum is stored in DX

    ; We have 12 grades, loop 12 times.


    ; Assume the maximum of the grades
    ; is the first grade
    mov ah, [si]
    mov [max], ah
    mov bx, 0
find_max:

    cmp ah, [si+bx]
    jng found_new_max

resume_loop:
    inc bx
    cmp bx, 12
    jnz find_max
    jz final_max_found

found_new_max:
    mov ah, [si+bx]
    mov [max], ah ; Update max.
    mov dx, bx ; Update max index.
    jmp resume_loop

final_max_found: ; We can now start curving the grades
; We need to find the curve amount (we place it in DH)
    mov dh, 99
    sub dh, [max] ; => Curve amount.


; => Loop 12 times
mov bx, 0 ; We use this because of the addressing mode limitations
          ; We cant use CX in this addressing mode.
curver_loop:
    mov ah, byte ptr [si + bx]
    add ah,  dh
    mov byte ptr [di + bx], ah


    inc bx
    cmp bx, 12
    jnz curver_loop


end_prog: jmp end_prog

HLT
main endp
end main
