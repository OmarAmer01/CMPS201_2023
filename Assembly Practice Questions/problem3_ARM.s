/*
You will input 4 values in an array in the data section. And then you should reverse their order and load them into the first 4 registers to see them.
*/



.global _start
	
	_start:
	
	// Initializing the output register
	MOV r0, #0
	MOV r1, #0
	MOV r2, #0
	MOV r3, #0
	
	// we will make 2 indices, one will point at the first register and increment itself, the other points to the last register and decrement itself
	// for each iteration, we will just swap the 2 registers pointed at by the two indices
	// iterate until any index overlaps the other or they equate each other, then stop.
	LDR r7, =inputArray		// Index of the first register, carrying the address of the first element
	ADD r8, r7, #12			// Index of the last register, I just got its address after adding 3 to the address of the first element, but since each element is a word, and each word contains 4 bytes, so I added 3elements x 4 bytes which is 12
	
	MOV r9, #0		// Just a temporary register to swap any two registers
	MOV r10, #0		// another temp register to load the second register, since we cannot perform memory-to-memory operations, we should load them into registers first then store them into memory again
	
	mainloop:
		CMP r7, r8	//compare both indices
		BGE display_output	//end the program if both indices collide with each other or overlap with each other
		
		//swap both elements
		LDR r9, [r7]
		LDR r10, [r8]
		STR r9, [r8]
		STR r10, [r7]
		
		//increment first index
		ADD r7, r7, #4
		
		//decrement second index
		SUB r8, r8, #4
		
		B mainloop
		
		
		
		
		
		display_output: //here we just load memory contents into the first 4 registers, to be able to see them, nothing else.
		LDR r7, =inputArray //carrying the address of the first element
		LDR r0, [r7], #4
		LDR r1, [r7], #4
		LDR r2, [r7], #4
		LDR r3, [r7], #4
		
		
		stop: b stop


//Data section
.data
inputArray: .word 1, 2, 3, 4  // I just defined an array called "inputArray" with 4 words {1, 2, 3, 4}

