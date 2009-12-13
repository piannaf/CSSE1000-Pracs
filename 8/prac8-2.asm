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

	; Set PORT D Pin 4 output to zero

	;<-YOUR CODE HERE->

	; Set OC1A pin to toggle
	; (See description of TCCR1A register on page 36 of the 8515 
	; datasheet. In particular look at bits COM1A1 and COM1A0)

	;<-YOUR CODE HERE->

	; Set Output Compare 1 value (i.e. registers OCR1AH and OCR1AL)
	; to be 1999 (i.e. when the timer reaches this value, we want the 
	; output compare to trigger). This will mean the OC1A output will
	; toggle every 2000 clock cycles.
	; (Note (from page 39 of the datasheet) - the high byte of OCR1A must
	; be written before the low byte.)
	; Hint: use the low() and high() macros as in the stack pointer initialisation

	;<-YOUR CODE HERE->

	; Set Timer 1 to clear on compare match (i.e. when the timer reaches
	; 1999 we want it to start counting from 0 again)
	; HINT: Look at the CTC1 bit of the TCCR1B register - see page 37
	; of the datasheet.

	;<-YOUR CODE HERE->

	; Start Timer 1, so that it counts by 1 on every clock cycle. 
	; HINT: Look at the CS12:CS11:CS10 bits of the TCCR1B register - 
	; see page 37 of the datasheet
	; (Remember that this is the same register that holds the CTC1
	; bit - don't undo what you just did above - or maybe combine
	; the two lines of code that modify TCCR1B together.)

	;<-YOUR CODE HERE->

mainloop:
	; Sit back and let it happen - the hardware takes care of it all
	rjmp	mainloop
