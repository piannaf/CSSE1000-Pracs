;
; FILE: Accumulator.asm
;
; Replace the lines ";<-YOUR CODE HERE->" with your code.
; See the hints in the prac description about the I/O
; registers and instructions you may need to use.

; Note that semicolons indicate the start of comments; 
; Comments below describe the code that follows.
;******************************************************

	; Include the file that contains the definitions of I/O
	; register names and other things for the AT90S8515. We'll
	; talk more about the contents of this file in a future lecture.
.include "8515def.inc"

	; Define another name for register r16. Doing this helps make
	; code easier to read - we don't have to remember which register
	; holds what, we can use the name to indicate what the register 
	; holds - in this, just temporary values
.def	temp	= r16

	; The first instruction in an AVR program should be a jump 
	; instruction. This is where execution will start when the
	; micrcontroller is powered on or reset. Here we jump to 
	; the instruction immediately after the label "RESET". 
	rjmp	RESET		

RESET:
	; Initialise Stack Pointer - we'll talk more about this
	; in a future lecture
	ldi	temp,low(RAMEND)
	out	SPL,temp
	ldi	temp,high(RAMEND)
	out	SPH,temp


;further definitions
.def	button = r17
.def	switch = r18
.def	leds = r19

;initialization
clr		temp
out 	DDRA, temp	; Toggle Switches are input
out		DDRC, temp	; Push Button is input
ser		temp
out		DDRB, temp	; LEDs are output
clr		leds

ButtonWaitPress:
	in		button,	PINC
	andi	button, 0x01	; Only look at LSB
	cpi		button, 0x00	; Is the button down?
	breq 	ButtonWaitRel
	rjmp	ButtonWaitPress


Accumulate:
	in 		switch, PINA
	add		leds, switch
	out		PORTB, leds
	rjmp ButtonWaitPress

ButtonWaitRel:
	in		button, PINC
	andi	button, 0x01
	cpi		button, 0x01	; Is the button released?
	breq	Accumulate
	rjmp	ButtonWaitRel
