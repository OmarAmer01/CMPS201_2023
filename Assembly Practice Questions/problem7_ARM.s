.global _start
	_start:
	mov r0, #0xFFFFFFFF
	mov r1, #0xFFFFFFFF
	mov r2, #0xFFFFFFFF
	mov r3, #00
	
	mov r7, #0 //output will be in r7
	
	AND r4, r3, #0xFFFFFFFF
	CMP r4, #0x00
	BEQ secondBinarySlotlbl
	ADD r7, r7, #1
	
	secondBinarySlotlbl:
	AND r4, r2, #0xFFFFFFFF
	CMP r4, #0x00
	BEQ thirdBinarySlotlbl
	ADD r7, r7, #2
	
	thirdBinarySlotlbl:
	AND r4, r1, #0xFFFFFFFF
	CMP r4, #0x00
	BEQ fourthBinarySlotlbl
	ADD r7, r7, #4
	
	fourthBinarySlotlbl:
	AND r4, r0, #0xFFFFFFFF
	CMP r4, #0x00
	BEQ stop
	ADD r7, r7, #8
	
	stop: b stop