;
; FILE: prac8-1.asm
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

	; Set PORT B direction to output
	;<-YOUR CODE HERE->

	; Set PORT B output to zero
	;<-YOUR CODE HERE->

mainloop:
	; Call procedure which delays for 500uS
	rcall	delay

	; Toggle (i.e. flip) bit 0 of PORT B
	; HINT: Consider using the eor (Exclusive OR) instruction, 
	; but remember that it doesn't operate on I/O registers,
	; only on general purpose registers;
	;<-YOUR CODE HERE->

	; Run forever
	rjmp	mainloop

;******************************************************

; define a symbolic constant that holds how many times we'll iterate through 
; the loop
; <- CHANGE THIS NUMBER ->
.equ	CYCLES = 1

delay:
	; Procedure to generate 500uS (i.e. 2000 clock cycle) delay
	; We'll use the 16-bit X register (i.e. r27:r26) to count the
	; number of times we'll iterate through the loop
	
	; load XH with the high byte of our loop counter
	ldi XH, high(CYCLES)

	; load XL with the low byte of our loop counter
	;<-YOUR CODE HERE->

loop:
	; decrement X by 1 (i.e. subtract 1 from X)
	; (Remember, X is a 16-bit quantity)
	;<-YOUR CODE HERE->
	
	; if we haven't reached 0, return to loop
	;<-YOUR CODE HERE->

	; We have reached 0 (i.e. have completed our loop)
	; Return from procedure
	ret
