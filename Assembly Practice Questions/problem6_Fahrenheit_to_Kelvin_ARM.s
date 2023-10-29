/*
You are required to convert from Fahrenheit to celsius then to kelvin.
You convert from F to C using the formula below:

Degrees in C = ( Degrees in F - 32 ) x 5/9
//and Degrees in K = Degrees in C + 273

*/

.global _start
	_start:
	MOV r0, #1000 //input value in Fahrenheit
	MOV r3, #0    //our output
	
	SUB r1, r0, #32
	MOV r5, #5
	MUL r1, r1, r5

	
	subtractLoop:
	CMP r1, #0
	BGT ifgreater
	BLT ifless
	ifgreater:
	SUB r1, r1, 9
	ADD r3, r3, #1
	b subtractLoop
	
	ifless:
	ADD r3, r3, #273
	stop: b stop