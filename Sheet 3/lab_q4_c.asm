;==================================
; Author: Omar Amer
; Lab 4 Sheet 3
; Question 4 Point C
;==================================

.model small



.data

in_data db 4, ?, 4 dup('$')

.code
main proc far
; Fill the buffer from keyboard
; We know these are decimal numbers,
; no need to handle hex digits (yay)
mov ax, @data
mov ds, ax


mov ah, 0ah
lea dx, in_data
int 21h ; This reads from the keyboard into the buffer.

mov si, 0; we use SI to index the input.


; Gameplan:
;   1. Multiply the first number by  100 (hex 64)
;   2. Multiply the second number by 10  (hex A )
;   3. Multiply the third number by  1   (hex 1 )

; Accumulate all in AX


; Do not forget: the first digit is the hundereds place,
; the second is the tens, the third is the ones.

sub [in_data+2], '0' ; To the actual number
sub [in_data+3], '0' ; To the actual number
sub [in_data+4], '0' ; To the actual number

mov al, 064h
mul [in_data+2]
mov bx, ax ; Hundereds

mov al, 0ah
mul [in_data+3]
mov cx, ax ; Tens

mov dx, 0
mov dl, [in_data+4] ; Ones
                    ; No need to multiply here.

mov ax, 0
add ax, bx ; Hundereds
add ax, cx ; Tens
add ax, dx ; Ones

; Now, we need to print the number in binary.
; Watch this:

; When shifting the number, the discarded bit is stored
; in the carry flag. This way we can shift right and read
; the number serially.

; The maximum number we can represent is 03E7H.
; Three hex digits.
mov bx, ax
shl bx, 4 ; Discard the last digit which is always zero.

; We want to print tweleve bits now.
; Thats one word (16 bits) - a hex digit (4 bits)
mov cx, 12


bit_printer:
    mov dl, 0 ; The char we want to print has to be in the dl register.
    shl bx, 1 ; The bit we want to print is now in the carry flag.

    adc dl, '0' ; Hacker move. If the carry is set, then the bit
                ; we want to print is a one. If the carry is not
                ; set, then it was a zero. We want to add '0' anyway
                ; to convert it into an ascii character that represents
                ; a number.

    mov ah ,2
    int 21h
loop bit_printer





mov ah, 04ch
int 21h

main endp
end main
