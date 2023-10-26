/*
Problem 1: Hailstone sequence
input is in r0
output is in r4, r0 also can carry the output as I am modifying it directly
*/

.global _start
	_start:
	
	MOV r0, #43      //put input number here
	
	comparewith_1:             //here I am comparing r0 with 1, if r0 is 1 just end the program, else just do another iteration of hailstone label
		CMP r0, #1
		BNE dohailtstonelbl
		BEQ endprogramlbl
	dohailtstonelbl:
		bl hailstone       //call label hailstone and store PC into LR to return to the next line
		b comparewith_1	   //here we will jump to the comparison above to do another iteration of the hailstone, or to end the program
	endprogramlbl:
		stop: b stop
	
	
	
	hailstone:
		/*
		int hstone(N)
		{
			if (N%2 == 0)                   //N is even
				return N/2;
			else              	              //N is odd
				return 3*N + 1;
		}
		
		We can know whether a register is divisible by 2 or not by checking the LSB
		If the LSB is 0, then the register is divisible by 2 (or even), if the LSB is 1, then the register is not divisible by 2
		*/
		
		AND r3, r0, #0b00000000000000000000000000000001 //I just ANDed reg0 with 31 zeros and 1 in the LSB, just to store only the LSB of r0 into r3
		CMP r3, #0 //check if r3 (which was the LSB of r0) is 0 or 1
		BEQ evenlbl //goto label evenlbl if r3 == 0
		BNE oddlbl //goto label oddlbl if r3 == 1
		evenlbl:
			LSR r0, #1 //divide r3 by 2
			MOV r4, r0 //then store the result in r4
			b endifeven //jump to the end if the if statement to avoid entering the below label
		oddlbl:
			MOV r5, #3
			MUL r4, r0, r5 //for some reason, I must MUL with registers only, we cannot use immediate values
			ADD r4, r4, #1
								//notice no jumping here, code flow will eventually enter the next label keda keda
		endifeven:
			MOV r0, r4			//put the result back into r3 to prepare for another iteration
			bx lr				//return to LR
