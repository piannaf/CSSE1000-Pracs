/*
 * FILE: prepC.c
 *
 */

#include <avr/io.h>
#include <avr/interrupt.h>

volatile unsigned char run;	/* If run = 1, timer is running */
int	time;	/* the current time */

int main(void)
{
	/* Initialize variables */
	run = 0;
	time = 0;

	/* Initalize AVR8515 */
	/* PORTC will be output for hex display */
	DDRC = 0xFF;
	
	/* Set up timer 1 so we get an interrupt approximately
	   every second. Set Output Compare value to 3906 (We
	   will divide clock by 1024 to count it so this gives
	   us about 1 sec delay for a 4MHz clock)
	*/

	//OCR1A = 1			//used for debugging
	OCR1A = 390;  		//tenth of a second delay

	TIMSK = (1<<OCIE1A);	//interrupt on output compare match
	TCCR1B = (1<<CTC1);	//clear the counter on output compare match

	MCUCR = (1<<ISC11);	//INT1 triggered on falling edge
	GIFR = (1<<INTF1);	//Clear the INT1 flag
	GIMSK = (1<<INT1);	//Enable INT1

	/* Enable interrupts */
	sei();
	
	/* Sit back and let it happen - this will loop forever */
	for (;;) {
	}

	return 0;
}

/* Save SREG Not necessary */

void stopTimer(void){
	TCCR1B = 0;
	run = 0;
}

ISR(INT1_vect){
	if(run == 0 && time != 0x99){	//not running and have more numbers to go
			TCCR1B = (1<<CTC1)|(1<<CS12)|(0<<CS11)|(1<<CS10);
			run = 1;
	}
	else
		stopTimer();
}

ISR(TIMER1_COMPA_vect){
	if(run == 1 && time != 0x99){	//running and have more numbers to go
		if( (time & 0x0F) >= 0x09)
			time = (time & 0xF0) + 0x10; //clear right digit, carry to left
		else
			time++;	//add one to units
	}
	else	//either we're not supposed to be running or we've reached the end
		stopTimer();

	PORTC = time; //display the new time
}
