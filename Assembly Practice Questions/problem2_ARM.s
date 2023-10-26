
// You will enter an input immediate value into a register of your choice (the input register), then store 1 in another register of your choice (the output register) if the input number was divisible by 2.
// Or store 2 in the output register if the input number was divisible by 3.
// Or store 3 in the output register if the input number was divisible by both 2 and 3.
// Or store 0 if it neither divisible by 2 nor 3

.global _start
	/*
	input in r0
	output in r4
	*/
	_start:
	
	
	MOV r0, #35   //enter your input here
	MOV r4, #0	   //initialize the output to 0
	
	check_if_divisible_by_2_lbl:
		AND r3, r0, #0b000000000000000000000001      //put the LSB in r3 to check it
		cmp r3, #0						// check if r3 is 0
		BNE check_if_divisible_by_3_lbl   //if not divisible by 2, ie, the LSB was not 0
		MOV r4, #1 							//put 1 in output if the number was divisible by 2
	
	check_if_divisible_by_3_lbl:
		MOV r5, r0 //we will subtract 3 from r5 until it reaches zero or a negative number
		MOV r6, #0//our quotient
	subtractLoop:
		cmp r5, #0
		bGT subtract
		bLE dontsubtract
		subtract:
			SUB r5, r5, #3
			ADD r6, r6, #1
			b subtractLoop
	dontsubtract:
		CMP r5, #0
		BNE not_divisible_by_3 //if the number is not divisible by 3 ie r5 was a negative number after subtracting 3 from it multiple times
		CMP r4, #1  //check if the number was previously divisible by 2 by checking if the output was 1
		BEQ put_3_in_output //if it was previously divisible by 2, put 3 in output
	
	MOV r4, #2 //if the number is divisible by 3 only
	
	B not_divisible_by_3 //ie skip the following label
	put_3_in_output:
		MOV r4, #3
	not_divisible_by_3:
	
	stop: b stop //end here
	
	
	