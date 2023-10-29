;=======================================================
; Question 9 Point C Solution, Sheet 1 (Lab 3).
; Author: Omar Amer
; Date  : 10/24/2023
; This program should teach you that sometimes you will
; need to do things differently. Either for optimization
; or to work around limitations.
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

    ldr r0, =0x28 ; Load the number


    ; Multiplication is a very clunky operation,
    ; consumes power, and could be a performance
    ; bottleneck on some devices. Whenever we can
    ; find ways to avoid multiplication we should
    ; take them.

    ; Method 1 : The Multiply Command
    ; We can't multiply by an immediate! We need to use a register.
    ldr r1, =2      ; Load 2 into r2 so that we can use it in the MUL command.
    mul r1, r0, r1  ; Multiply r0 by r1 and place the lower 32 bits in r1.

    ; Method 2 : We can add the number to itself.
    ; Sometimes, the solutions to the problems we face
    ; are easier than we think. In assembly too.

    add r2, r0, r0 ; Add r0 to r0 and place the result at r2

    ; Method 3 : Bit manipulation. This is the best technique ever.
    ; Multiplication by 2 is equivalent to shifting to the left by 1.
    ; Multiplication by 8 is equivalent to shifting to the left by 3.
    ; Multiplication by N is equivalent to shifting to the left by Log2(N).
    ; WHERE N IS A POWER OF 2

    mov r3, r0 ,LSL#1


    ; Division by N can be done by shifting to the right by Log2(N)
    ; WHERE N IS A POWER OF 2

    mov r4, r0, LSR#2


    mov r0, r0 ; Something to place a breakpoint at.
    END        ; We need to end the program when we are done, don't we?
