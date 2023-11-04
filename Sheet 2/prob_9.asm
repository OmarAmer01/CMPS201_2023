;====================================
; Sheet 2, Exercise 9
; Name  : Omar Tarek Amer
; Convert input_msg to lower case.
;====================================
.model small

.data
input_msg db "tHiS iS aN iNpUt MsG", "$"

.code

main proc far
    mov ax, @data
    mov ds, ax
    lea di, input_msg ; di now has the address of the input msg

cmp_loop:
    ; If the letter is uppercase (greater than 64 and less than 91)
    ;add 32 decimal to turn it into lower case.
    cmp byte ptr [di], 64
    jg greater_than_64
    jmp is_this_the_end
greater_than_64: cmp byte ptr [di], 91
    jl turn_into_lowercase

is_this_the_end: cmp byte ptr [di], "$" ; Is this the end? (of the string?)
    jz end_prog
    inc di
    jmp cmp_loop

turn_into_lowercase:
    add byte ptr [di], 32 ; ASCII MAGIC
                 ; The ASCII of a capital letter is
                 ; smaller than its small counterpart
                 ; by 32 decimal. Consult your ASCII sheet.
    jmp is_this_the_end





end_prog: HLT
main endp
end main