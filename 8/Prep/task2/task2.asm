;
; FILE: prac8-2.asm
;
; Replace the lines ";<-YOUR CODE HERE->" with your code.
;
;******************************************************
.include "8515def.inc"
	rjmp	RESET		; Reset Handler
;******************************************************

.def	temp	= r16

RESET:
	; Initialise Stack Pointer
	ldi	temp,low(RAMEND)
	out	SPL,temp
	ldi	temp,high(RAMEND)
	out	SPH,temp

	; Set PORT D Pins 5 and 4 direction to output

	;<-YOUR CODE HERE->
	ldi temp, 0x30
	out DDRD, temp	

	; Set PORT D Pin 4 output to zero

	;<-YOUR CODE HERE->
	clr temp
	out PORTD, temp		; this will actually set both pin 4 and 5 outputs to 0


	; Set OC1A pin to toggle
	; (See description of TCCR1A register on page 36 of the 8515 
	; datasheet. In particular look at bits COM1A1 and COM1A0)

	;<-YOUR CODE HERE->
	ldi temp, 0x40		; we need COM1A1 = 0, COM1A0 = 1
	out TCCR1A, temp	; set TCCR1A to toggle OC1A 

	; Set Output Compare 1 value (i.e. registers OCR1AH and OCR1AL)
	; to be 1999 (i.e. when the timer reaches this value, we want the 
	; output compare to trigger). This will mean the OC1A output will
	; toggle every 2000 clock cycles.
	; (Note (from page 39 of the datasheet) - the high byte of OCR1A must
	; be written before the low byte.)
	; Hint: use the low() and high() macros as in the stack pointer initialisation

	;<-YOUR CODE HERE->
	.equ	CYCLES = 1999
	ldi temp, high(CYCLES)
	out OCR1AH, temp
	ldi temp, low(CYCLES)
	out OCR1AL, temp

	; Set Timer 1 to clear on compare match (i.e. when the timer reaches
	; 1999 we want it to start counting from 0 again)
	; HINT: Look at the CTC1 bit of the TCCR1B register - see page 37
	; of the datasheet.

	;<-YOUR CODE HERE->
	ldi temp, 0x08		; we need CTC1 = 1
	out TCCR1B, temp	; set TCCR1B to clear on compare match

	; Start Timer 1, so that it counts by 1 on every clock cycle. 
	; HINT: Look at the CS12:CS11:CS10 bits of the TCCR1B register - 
	; see page 37 of the datasheet
	; (Remember that this is the same register that holds the CTC1
	; bit - don't undo what you just did above - or maybe combine
	; the two lines of code that modify TCCR1B together.)

	;<-YOUR CODE HERE->
	in temp, TCCR1B		; load current status into temp
	ori temp, 0x01		; modify only the bit 0 to 1
	out TCCR1B, temp	; set TCCR1B to count every clock cycle
	

mainloop:
	; Sit back and let it happen - the hardware takes care of it all
	rjmp	mainloop
