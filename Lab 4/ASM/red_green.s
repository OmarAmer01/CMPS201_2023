@ TODO: Fill the header comment data.
@ ===========================================
@ Author: Your NAMES
@ ID:     XXXXXXX
@
@ This program implements the Red Light/
@ Green Light Lab 4 on the CC1350 Launchpad
@ ===========================================

.syntax unified
.global t_light

@ ===================== Constants

@ TODO: Find the base address of the GPIO registers (from the datasheet)
@ .equ GPIO_base_addr, FIND_THIS

@ TODO: Find the offset of these registers (from the datasheet)
@.equ dout4_7_reg, GPIO_base_addr + FIND_THIS
@.equ DOUTTGL31_0, GPIO_base_addr + FIND_THIS
@.equ doe31_0_reg, GPIO_base_addr + FIND_THIS
@.equ din31_0_reg, GPIO_base_addr + FIND_THIS

@ TODO:
@ This is a two step process:
@	1. Find which pin is connected to the button.
@	2. Find the address of its IOCFG register.

@.equ iocfg_btn, FIND_THIS


@.equ green_led, 7
@.equ red_led, 6
@.equ btn_r, 13
@.equ btn_g, 14



t_light:

	@ TODO: Set the LED pins as outputs
	ldr r0, =doe31_0_reg

	/* YOUR CODE HERE*/

	str r2, [r0] @ Store the value in r2 in the physical address r0

	@ ===== Continue the above code
	@ [HINT] ==== Modify any general purpose register
	@ such that the bit that represents the Red LED is
	@ equal to one.


	@ TODO: Set the buttons as inputs
	ldr r0, =iocfg_btn

	/* YOUR CODE HERE*/

	str r2, [r0]

	@ ===== Continue the above code




	@ TODO: Turn On RED by default
	ldr r0, =dout4_7_reg

	/* YOUR CODE HERE*/

	str r2, [r0]

	@ ===== Continue the above code


main_loop:
	@ TODO:Read button state
	ldr r1, =din31_0_reg
	ldr r0, [r1]

	/* YOUR CODE HERE*/

	@ [HINT] ==== If the bit is zero,
	@ then the button is pressed.

	@ Do something that changes the flags.
	beq btn_g_pressed

	@ ==== Continue the above code.
	B main_loop

btn_g_pressed:
	@ TODO: Toggle both the red
	@ and green LEDs

	ldr r0, =DOUTTGL31_0
	@ YOUR CODE HERE. DO THIS IN A SINGLE INSTRUCTION.
	@ Modify r2.

	str r2, [r0]


	@ Wait untill the button is not pressed anymore

recheck_btn:
	@ TODO: Exit the loop if the button
	@ is not pressed anymore.

	ldr r1, =din31_0_reg
	ldr r0, [r1]

	/* YOUR CODE HERE*/

	@ ==== Continue the above code.
	beq recheck_btn

	@ TODO: Debounce the button
	@ using a delay loop.


debouncer_delay_loop:

	/* YOUR CODE HERE*/

	@ ==== Continue the above code.

	B main_loop
