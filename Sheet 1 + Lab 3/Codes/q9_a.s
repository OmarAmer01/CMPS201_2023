;=======================================================
; Question 9 Point A Solution, Sheet 1 (Lab 3).
; Author: Omar Amer
; Date  : 10/24/2023
; This program returns the sum of the first 10 fibonacci
; numbers in the r0 register.
;=======================================================
;;; Directives
          PRESERVE8
          THUMB

; Vector Table Mapped to Address 0 at Reset
; Linker requires __Vectors to be exported

          AREA    RESET, DATA, READONLY


          EXPORT  __Vectors


__Vectors
	  DCD  0x20001000     ; stack pointer value when stack is empty
			;The processor uses a full descending stack.
			;This means the stack pointer holds the address of the last
			;stacked item in memory. When the processor pushes a new item
			;onto the stack, it decrements the stack pointer and then
			;writes the item to the new memory location.

          DCD  Reset_Handler  ; reset vector

          ALIGN

; The program
; Linker requires Reset_Handler

          AREA    MYCODE, CODE

   	  ENTRY
   	  EXPORT Reset_Handler


Reset_Handler
;;;;;;;;;;User Code Starts from the next line;;;;;;;;;;;;

; We need to find the fibonacci numbers and accumulate them.

 mov r1, #1 ; This will store the previous fibbonaci number.
    mov r2, #1 ; This will store the current fibbonaci number.
    mov r0, #2 ; This will be the fibbonaci number accumulator.
			   ; The current number is one and the previous number is one, the sum is two.

	;add r0, #1, #2
	add r0, r0, r0
	;add r0, #1, r0
	add r0, r0, #1
    mov r3, #7 ; This will be the loop counter register.
               ; Note that 1+1 is the sum of the first three fibonacci numbers.
			   ; The Fibbonaci is zero-indexed.
               ; We still have seven numbers left. (we did F0, F1, and F2. We now need to calculate F3 to F9)

fibbonacci_loop
    mov r4, r2          ; Temporary register to store the current fibonacci number.
    add r2, r1, r2      ; Update the current fibonacci number.
    mov r1, r4          ; The previous fibonacci number is the one before adding r1 to it.
    add r0, r0, r2      ; Accumulate fibonacci numbers.

    subs r3, #1         ; Subtract while affecting flags
    bne fibbonacci_loop ; jmp if the zero flag is not set.

	mov r0, r0
    END