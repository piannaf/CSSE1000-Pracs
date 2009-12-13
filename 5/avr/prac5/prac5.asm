;
; FILE: prac5.asm
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

	; Set port B direction (all 8 bits) to output. 
	; Each port has a data direction I/O register. 
	; For an I/O port bit to be an output there 
	; must be a 1 in the corresponding bit of
	; the data direction I/O register. To make port B
	; an output, you must write 1's to all bits of I/O 
	; register DDRB. To do this, you must load a general
	; purpose register (e.g. temp) with 0xFF (= 255 = all ones) 
	; and then use the "out" instruction to write this value
	; out to the DDRB I/O register.
	
	;<-YOUR CODE HERE->
	ldi temp, 0xFF
	out DDRB, temp

	; Set port C direction to input. (Write 0x00 OUT to 
	; the I/O register DDRC - the data direction register
	; for port C.)
	
	;<-YOUR CODE HERE->
	ldi temp, 0x00
	out DDRC, temp

mainloop:
	; Input 8-bits of data from the port C pins into 'temp'
	
	;<-YOUR CODE HERE->
	in temp, PINC

	; Task 2 of the prac - determine the 2's complement of 'temp'
	
	;<-YOUR CODE HERE FOR TASK 2 - LEAVE COMMENTED OUT FOR TASK 1->
	neg temp

	; Output the result to port B
	
	;<-YOUR CODE HERE->
	out PORTB, temp

	; Run forever - the following instruction causes execution to 
	; jump back to the instruction immediately after the label
	; "mainloop"
	rjmp mainloop
