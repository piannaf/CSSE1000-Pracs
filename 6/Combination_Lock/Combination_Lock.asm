;
; FILE: Combination_Lock.asm
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

; Further definitions
.def	tens = r17
.def	units = r18
.def	input = r19
.def	status = r20
.equ	bmask = 0x10	; mask for Push Button
.equ	nmask = 0x0F	; mask for low nibble

; Main Program
rjmp Initialize

ButtonWaitPress:
	in		input, PINC
	andi 	input, bmask
	cpi 	input, 0x00
	breq	ButtonWaitRel
	rjmp	ButtonWaitPress

ButtonWaitRel:
	in		input, PINC
	andi	input, bmask
	cpi		input, 0x10
	breq	SetHex
	rjmp	ButtonWaitRel

Initialize:
	clr 	temp
	out 	DDRC, temp
	ser		temp
	out		DDRA, temp
	out		DDRB, temp
	out		DDRD, temp
	
	clr		tens
	clr 	units
	clr		status
	rjmp	DisplayHex

DisplayHex:
	out 	PORTA, tens
	out		PORTB, units
	rjmp	SetStatus

SetStatus:
	cpi		tens, 0x08		; given tens digit 8
	brne	Close
	cpi		units, 0x03		; given units digit 3
	breq	Open
	rjmp 	Close

Close:
	ldi 	status, 0x02	; pin 1 for closed
	out 	PORTD, status
	rjmp 	ButtonWaitPress

Open:
	ldi 	status, 0x01	; pin 0 for closed
	out 	PORTD, status
	rjmp 	ButtonWaitPress

SetHex:
	mov		units, tens
	in		tens, PINC
	andi	tens, nmask		; switches are on the low nibble
	rjmp DisplayHex
