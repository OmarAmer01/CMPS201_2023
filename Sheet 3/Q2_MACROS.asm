;=====================================================
; Question 2 sheet 3.
; Author: Omar Amer
;=====================================================

; Constants
THREE_HEX_DIGITS_IN_BITS EQU 12

; MACROS

DisplayString MACRO string_offset
    mov ah, 9               ; Select option for int 21; ah = 9 means display string.
    lea dx, string_offset   ; String offset needs to be in dx.
    int 21h                 ; Call the interrupt.
ENDM

ReadString MACRO prompt_offset, string_offset
    DisplayString prompt_offset ; Display the prompt.
    mov ah, 0ah                 ; Select Option for interrupt 21; ah = 0a means read from keyboard.
    lea dx, string_offset       ; Result offset must be in dx.
    int 21h                     ; Call the interrupt
ENDM

DisplayNumber MACRO
              LOCAL digit_select
              LOCAL dont_shift
              LOCAL convert_hex
              LOCAL convert_decimal
    ; We know 16 bits are 4 hex digits.
    ; we loop on the contents of ax and display each digit on its own.

    pusha ; We will change all registers.
          ; Save them to retrieve them later.
          ; Good etiquette. Not available in
          ; the 8086. use the 80286 instead.

    mov cx, 0 ; Loop counter

    mov bx, ax ; We use ax for interrupts.
               ; Keep our number in bx for now.

    digit_select:
    ; Select a digit write it on the screen.

        cmp cl, 0
        je dont_shift
        shl bx, 4

    dont_shift:
        mov dx, bx
        and dx, 0f000h ; Bit mask to select the last digit only
                       ; Now, our character is the in the MSB of
                       ; DX.

        shr dx, THREE_HEX_DIGITS_IN_BITS     ; This puts the number in the LSB of dl.

        cmp dl, 10          ; Is the digit 10 or greater  (hex A)?
        jge convert_hex     ; If yes, convert into the corresponding letter.

        ; If no, convert into the corresponding decimal number.
        convert_decimal: add dl, '0'  ; This is the character we want to print.
        jmp print

        convert_hex: add dl, 55 ; Difference between ASCII character 'A' and ASCII number 10.
        ; ASCII (Letter A) = 65
        ; ASCII 10, well, is 10.
        ; 65 - 10 = 55. Math.

        print:
        mov ah, 2
        int 21h

        inc cx
        cmp cl, 4
        jne digit_select

    popa
ENDM

ConvertAsciiToHex MACRO reg8
                  LOCAL done
    ; This converts the byte in reg8
    ; into its hex equivalent.

    sub reg8, '0'

    ; if its decimal then we are done
    cmp reg8, 0ah
    jl done

    ; If not, then it is in hex
    sub reg8, 7
    done:
ENDM

ReadNumber MACRO

ReadString prompt, user_input_num

    mov bx, word ptr [user_input_num+2]   ; Lower  part of the number
    mov ax, word ptr [user_input_num+4]   ; Higher part of the number

    ; Convert all ascii to numbers
    ConvertAsciiToHex ah
    ConvertAsciiToHex al

    ConvertAsciiToHex bh
    ConvertAsciiToHex bl

    shl al, 4
    or al, ah

    shl bl, 4
    or bl, bh

    mov ah, bl
ENDM

.model small
.286 ; pusha and popa are not available
     ; in the 8086. Use the 80286 instead.

.data
my_string       db  "The lazy brown fox jumps over the quick dog. haha.", 0ah, '$'
user_input_num  db  5, ?, '0000$'


prompt          db  "Enter any text: ", 0ah, '$'
user_input      db  15, ? , 15 dup('$')
u_typed         db  "You Typed: ", 0ah, '$'

.code
main proc far
    mov ax, @data
    mov ds, ax

    ; ReadString prompt, user_input
    ; DisplayString u_typed
    ; DisplayString user_input+2
    ReadNumber

    push ax
    DisplayString u_typed
    pop ax

    DisplayNumber


    mov ah, 4ch
    int 21h
main endp
end main


