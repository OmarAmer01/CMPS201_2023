;========================================================
; This is called a header comment.
; Program Name here.
; Program Description Here.
; Program Authors Here.
; Date Here.
;
; Grades will be deducted if a header comment is not
; included in your code.
; Grades will be also deducted if your code has poor
; comments.

; Effort is heavily rewarded in CMPS201. Do your best
; and dont forget to learn and enjoy. That's what matters.
;=========================================================
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
