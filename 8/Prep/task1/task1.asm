;
; FILE: task1.asm
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
	clr temp
	out DDRB, temp

	; Set PORT B output to zero
	;<-YOUR CODE HERE->
	out PORTB, temp

mainloop:
	; Call procedure which delays for 500uS
	rcall	delay

	; Toggle (i.e. flip) bit 0 of PORT B
	; HINT: Consider using the eor (Exclusive OR) instruction, 
	; but remember that it doesn't operate on I/O registers,
	; only on general purpose registers;
	;<-YOUR CODE HERE->
	in temp, PORTB
	ldi r17, 0x01
	eor temp, r17
	nop
	nop
	out PORTB, temp

	; Run forever
	rjmp	mainloop

;******************************************************

; define a symbolic constant that holds how many times we'll iterate through 
; the loop
; <- CHANGE THIS NUMBER ->
.equ	CYCLES = 330

delay:
	; Procedure to generate 500uS (i.e. 2000 clock cycle) delay
	; We'll use the 16-bit X register (i.e. r27:r26) to count the
	; number of times we'll iterate through the loop
	
	; load XH with the high byte of our loop counter
	ldi XH, high(CYCLES)

	; load XL with the low byte of our loop counter
	;<-YOUR CODE HERE->
	ldi XL, low(CYCLES)

loop:
	; decrement X by 1 (i.e. subtract 1 from X)
	; (Remember, X is a 16-bit quantity)
	;<-YOUR CODE HERE->
	ldi temp, 0xFF	
	add XL, temp	; add -1 to the low byte
	adc XH, temp	; add -1 to the high byte including the carry from the low byte
	
	; if we haven't reached 0, return to loop
	;<-YOUR CODE HERE->
	cpi XL, 0x00	; is the low byte 0?
	brne loop		; no? loop again
	cpi XH,	0x00	; is the high byte 0?
	brne loop		; no? loop again

	; We have reached 0 (i.e. have completed our loop)
	; Return from procedure
	ret
