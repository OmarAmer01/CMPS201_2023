;=======================================================
; Question 9 Point B Solution, Sheet 1 (Lab 3).
; Author: Omar Amer
; Date  : 10/24/2023
; This program returns the sum of the numbers from 1:N,
; Where N is stored in r1.
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
    ldr r1, =10  ; Lets keep this number small for now.
                 ; This register holds the N value.
                 ; We will use it as our loop counter as well,
    ldr r0, =0   ; Init r0.

accumulation_loop   ; This loop accumulates its counter.

    add r0, r0, r1  ; Add the counter register r1 to the accumulator register r0

    subs r1, #1     ; Decrement the counter by on.
                    ; The "s" suffix means [update flags after instruction]

    bne accumulation_loop ; If the result of the decrement r1 does not set the zero flag,
                          ; jump to the start of the accumulation loop.

    mov r0, r0 ; Something to place a breakpoint at.
    END        ; We need to end the program when we are done, don't we?
