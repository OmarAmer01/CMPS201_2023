/*
You are prompted to find the Manhattan Distance between 2 points.
The first x and y coordinates of the first point are inside the first and second registers respectively.
The x and y coordinates of the second point are inside the third and fourth registers respectively.

The output distance should be stored inside a register of your choice, as the output register.
*/


.global _start

_start:
	//inputs
	MOV r0, #6	// X coordinate of the first point
	MOV r1, #14	// Y coordinate of the first point
	
	MOV r2, #12	//X coordinate of the second point
	MOV r3, #6	//Y coordinate of the second point
	
	//output will be r6
	MOV r5, #0
	MOV r6, #0
	
	//Euclidean distance = root( (x1-x2)^2 + (y1-y2)^2 )
	
	SUB r4, r0, r2		//x1-x2, notice this value might be negative
	CMP r4, #0
	BGE IfPositivelbl
	MVN r4, r4			//if the output of subtraction was a negative value, just negate it
	ADD r4, r4, #1		//notice that when we negate a value in binary, we get its 1's complement, so to get the 2's complement, we just add 1, don't forget this!
	
	IfPositivelbl:
	MUL r4, r4, r4		//multiply r4 by itself to perform squaring
	
	
	SUB r5, r1, r3
	CMP r5, #0
	BGE IfPositivelbl_2
	MVN r5, r5
	ADD r5, r5, 1
	
	IfPositivelbl_2:
	MUL r5, r5, r5		//multiply r4 by itself to perform squaring
	
	ADD r5, r5, r4
	
	
	// I assume that (x1-x2)^2 + (y1-y2)^2 is a perfect square, ie its square root is an integer
	mov r7, #1	//just a counter
	//here we will multiply the counter with itself until it equates our number
	squarerootlbl:
	MUL r8, r7, r7
	CMP r8, r5
	BEQ foundrootlbl		//if we found the root, just pass it to the output register, r6 in this very code
	ADD r7, r7, #1			//just increment the counter and try again
	b squarerootlbl
	
	
	
	foundrootlbl:
	MOV r6, r7
	
	
	stop: b stop