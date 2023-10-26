/*
You are prompted to find the Manhattan Distance between 2 points.
The first x and y coordinates of the first point are inside the first and second registers respectively.
The x and y coordinates of the second point are inside the third and fourth registers respectively.

The output distance should be stored inside a register of your choice, as the output register.
*/


.global _start

_start:
	//inputs
	MOV r0, #3	// X coordinate of the first point
	MOV r1, #7	// Y coordinate of the first point
	
	MOV r2, #6	//X coordinate of the second point
	MOV r3, #3	//Y coordinate of the second point
	
	//output will be r5
	MOV r5, #0
	
	//Manhattan distance = |x1-x2| + |y1-y2|
	
	SUB r4, r0, r2		//x1-x2, notice this value might be negative
	CMP r4, #0
	BGE IfPositivelbl
	MVN r4, r4			//if the output of subtraction was a negative value, just negate it
	ADD r4, r4, #1		//notice that when we negate a value in binary, we get its 1's complement, so to get the 2's complement, we just add 1, don't forget this!
	
	IfPositivelbl:
	SUB r5, r1, r3
	CMP r5, #0
	BGE IfPositivelbl_2
	MVN r5, r5
	ADD r5, r5, 1
	
	IfPositivelbl_2:
	ADD r5, r5, r4
	
	stop: b stop
	