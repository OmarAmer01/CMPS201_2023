;==================================
; Author: Omar Amer
; Lab 4 Sheet 3
; Question 4 Point H
;==================================

.model small



.data

.code
main proc far
    mov ax, @data
    mov ds, ax
    ; Graphics Mode
    mov al, 13h
    mov ah, 0
    int 10h

    ; White background
    mov ax, 0600h
    mov bh, 00fh
    mov cx, 0
    mov dl, 40
    mov dh, 25
    int 10h


    mov cx, 20
    mov dx, 15

    mov al, 5

    mov si, 40
    mov di, 40

    call draw_rect

    mov cx, 40
    mov dx, 40

    mov al, 4
    mov bx, 40

    call draw_square

    mov cx, 80
    mov dx, 80
    mov al, 8
    mov bx, 80
    call draw_triangle

    BNCH : JMP BNCH

main endp

draw_rect proc near
    ; Starting Point (top left)
    ; Row = DX
    ; Col = CX

    ; Colour = AL

    ; Ending point
    ; Row SI
    ; Col DI
    next_row:
            mov ah, 0ch
            push cx ; Starting point
            draw_row:
                int 10h
                inc cx
                cmp cx, si
                jne draw_row

            pop cx
            inc dx
            cmp dx, di
            jne next_row

    ret
draw_rect endp

draw_square proc near
    ; Starting Point (top left)
    ; Row = DX
    ; Col = CX
    ; Side Length = BX
    ; Colour = AL

    mov si,cx
    mov di, dx

    add si, bx
    add di, bx
    next_row_square:
            mov ah, 0ch
            push cx ; Starting point
            draw_row_square:
                int 10h
                inc cx
                cmp cx, si
                jne draw_row_square

            pop cx
            inc dx
            cmp dx, di
            jne next_row_square

    ret
draw_square endp


draw_triangle proc near
    ; Starting Point (Top left corner)
    ; Row = DX
    ; Col = CX
    ; Side Length = BX
    ; Colour = AL

    ; Right angle triangle
    mov si ,cx
    mov di, dx

    add si, bx
    add di, bx
    next_row_tri:
            mov ah, 0ch
            push cx ; Starting point
            draw_row_tri:
                int 10h
                inc cx
                cmp cx, si
                jne draw_row_tri

            pop cx
            inc dx
            dec si
            cmp dx, di
            jne next_row_tri

    ret


draw_triangle endp

end main