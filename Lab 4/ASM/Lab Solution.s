@ ===========================================
@ Author: Omar Amer
@ ID:     XXXXXXX
@
@ This program implements the Red Light/
@ Green Light Lab 4 on the CC1350 Launchpad
@ ===========================================

.syntax unified

.global t_light

.equ GPIO_base_addr, 0x40022000
.equ dout4_7_reg, GPIO_base_addr + 4
.equ DOUTTGL31_0, GPIO_base_addr + 0xb0


.equ doe31_0_reg, 0x400220d0
.equ din31_0_reg, 0x400220c0

.equ iocfg_btn, 0x40022038

.equ green_led, 7
.equ red_led, 6
.equ btn_r, 13
.equ btn_g, 14

.equ debounce_factor, 500


t_light:
	@ Set the LED pins as outputs
	ldr r0, =doe31_0_reg
	mov r1, #1
	mov r2, #0
	orr r2, r2, r1, LSL #green_led
	orr r2, r2, r1, LSL #red_led
	str r2, [r0]

	@ Set the buttons as inputs
	ldr r0, =iocfg_btn
	mov r1, #1
	mov r2, #0
	orr r2, r2, r1, LSL 29
	str r2, [r0]

	@ Turn On RED by default
	mov r2, #0
	eor r2, r2, r1, LSL #16
	ldr r0, =dout4_7_reg
	str r2, [r0]


main_loop:
	@ Read button state
	ldr r1, =din31_0_reg
	ldr r0, [r1]
	mov r1, #1
	mov r1, r1, LSL #btn_g

	ands r0, r0, r1
	beq btn_g_pressed

	B main_loop

btn_g_pressed:
	@ Toggle
	ldr r0, =DOUTTGL31_0
	orr r2, #0b11000000 @ Toggle Pins
	str r2, [r0]


	@ Wait untill the button is not pressed
recheck_btn:
	ldr r1, =din31_0_reg
	ldr r0, [r1]
	mov r1, #1
	mov r1, r1, LSL #btn_g

	ands r0, r0, r1
	beq recheck_btn

	@ Debounce
	mov r0, #debounce_factor

debouncer_delay_loop:
	subs r0, #1
	bne debouncer_delay_loop

	B main_loop
