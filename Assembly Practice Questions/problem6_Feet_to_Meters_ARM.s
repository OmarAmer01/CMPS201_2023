//You are required to convert from Feet to meters using the formula below:
// Length_in_meters = Length_in_feet / 3.281
.global _start
	_start:
	MOV r0, #1000 //input value in feet
	MOV r3, #0    //our output
	
	
	//NOTE: 3.281 is not a perfect fraction. but we can represent it as 3281/1000
	//so we will just multiply the number by 3281 then divide by 1000
	MOV r5, #3281
	MUL r1, r0, r5
	
	subtractLoop:
	CMP r1, #0
	BGT ifgreater
	BLT ifless
	ifgreater:
	SUB r1, r1, 1000
	ADD r3, r3, #1
	b subtractLoop
	
	ifless:
	stop: b stop