; Prac 9: prep.asm
.include "8515def.inc"

; Interrupt vector table
rjmp	RESET		; IRQ0Reset handler
reti				; IRQ1 handler - not used
rjmp	EXT_INT1	; IRQ2 handler (external interrupt)
reti				; IRQ3 handler - not used
rjmp	TIMER1_OCA	; IRQ4 handler (Timer1 Compare Match A)


; Initialization
.def temp = r16
.def run = r17		; if run = 1, timer is running
.def time = r18		; current time

RESET:
	;initialize stack pointer
	ldi 	temp, low(RAMEND)
	out 	SPL, temp
	ldi		temp, high(RAMEND)
	out		SPH, temp

	; Timer is stopped initially
	clr		run
	; Timer starts at 0
	clr		time

	;set PORTC to be output
	ser		temp
	out DDRC, temp

	; Set up timer 1 so we get an interrupt approximately
	; every second. Set Output Compare value to 3906 (We
	; will divide clock by 1024 to count it so this gives
	; us about 1 sec delay for a 4MHz clock)
	.equ COUNT = 390

	ldi 	temp, high(COUNT)
	out 	OCR1AH, temp
	ldi 	temp, low(COUNT)
	out		OCR1AL, temp
	; Enable timer interrupt on output compare match
	ldi 	temp, (1<<OCIE1A)
	out		TIMSK, temp
	; Clear the counter on compare match
	ldi 	temp, (1<<CTC1)
	out		TCCR1B, temp

	; Setup External Interrupt 1
	; Set INT1 for falling edge

	ldi 	temp, (1<<ISC11)
	out		MCUCR, temp
	; Clear INT1 flag
	ldi		temp, (1<<INTF1)
	out		GIFR, temp
	; Enable INT1
	ldi		temp, (1<<INT1)
	out		GIMSK, temp

	; Enable CPU interrupts
	sei

mainloop:
	; The hardware initializes the counter as stopped at 00
	; The external interrupt will alter values to start
	; counting so there is nothing needed in the mainloop.
	rjmp	mainloop

EXT_INT1:
	; External interrupt handler (service routine)
	; - toggle whether we're running or not

	push	temp
	in		temp, SREG
	push	temp

	; Are we running?
	tst		run
	brne	stop

start:
	; Check whether we've reached 99. If we have, return.
	cpi		time, 0x99
	breq	end_ext_int1

	; Start Timer 1 and configure it so clock is divided by 1024 
	; (CS12=1,CS11=0,CS10=0) and so that we clear the counter when we reach the
	; OC value (CTC1=1)
	ldi 	temp, (1<<CTC1)|(1<<CS12)|(0<<CS11)|(1<<CS10)
	;ldi 	temp, (1<<CTC1)|(0<<CS12)|(0<<CS11)|(1<<CS10) ; For debugging
	out		TCCR1B, temp

	; Set run flag and return
	inc		run
	rjmp	end_ext_int1

stop:
	; Stop Timer 1
	clr		temp
	out		TCCR1B, temp
	
	; Clear run flag and return
	clr		run

end_ext_int1:
	pop 	temp
	out		SREG, temp
	pop		temp
	reti

TIMER1_OCA:
	; Timer interrupt service routine. If we're running, we increment the time.
	; If we reach 99, we stop running. All registers are preserved other than
	; time and run.

	push 	temp
	in 		temp, SREG
	push 	temp

	; If we're not running
	; Do nothing.
	cpi		run, 0
	breq	restore_sreg

	; We are running; 
	; Check whether we've reached 99. If not, keep counting.
	cpi		time, 0x99
	brne	increment

	; We reached 99
	; Stop running and stop Timer 1
	clr		run
	clr		temp
	out		TCCR1B, temp

	; restore registers
	rjmp restore_sreg
	
increment:
	; Increment the time
	inc		time

	; Check if right digit is 10, if not, display the time
	mov		temp, time
	andi	temp, 0x0F
	cpi		temp, 0x0A
	brne	display

	; The right digit is 10.
	; Clear the right digit and increment the left digit
	andi	time, 0xF0
	ldi 	temp, 0x10
	add		time, temp

display:
	out		PORTC, time

restore_sreg:
	pop		temp
	out		SREG, temp
	pop		temp

	reti
