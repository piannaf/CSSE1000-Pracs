/*
** FILE: prac7-2.c
**
** Replace the lines <-YOUR CODE HERE-> with your code.
*/

#include <avr/io.h>

int main(void)
{
	unsigned char total = 0;

	/* Set PORT B direction to output */
	DDRB = 0xFF;

	/* Set PORT A and C direction to input */
	DDRA = 0x00;
	DDRC = 0x00;

	while(1) {
		/* output total */
		PORTB = total;

		/* Wait for button to be pushed */
		while( (PINA & 0x01) ){
		}

		/* Wait for button to be released */
		while( !(PINA & 0x01) ){
		}

		/* do the accumulation */
		total += PINC;
	}
}

