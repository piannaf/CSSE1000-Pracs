;******************************************************
.include "8515def.inc"
	rjmp RESET ;Reset Handle
;******************************************************

RESET:
.def temp =r16

	ldi temp,low(RAMEND)
	out SPL,temp
	ldi temp,high(RAMEND)
	out SPH,temp	;init Stack Pointer
	ser temp        ;set temp to all 1's
	out DDRB,temp	;Set direction out
loop: 
	out PORTB,temp
	dec temp
	rjmp loop
