/*
** FILE: prac7-3.c
**
** Replace the lines <-YOUR CODE HERE-> with your code.
*/

#include <avr/io.h>

int main(void)
{
	unsigned char input = 0x00;

	/* Set PORT A, B, D direction to output */
	DDRA = 0xFF; 				// Left Digit
	DDRB = 0xFF; 				// Right Digit
	DDRD = 0xFF; 				// Status LEDs

	/* Set PORT C direction to input */
	DDRC = 0x00;

	while(1) {
		/* output the inputed combination */
		PORTA = input >> 4;		// shift the nibble
		PORTB = input & 0x0F;   // mask the nibble

		/* set status */
		if( input == 0x83 )
			PORTD = 0x01;		// Open
		else
			PORTD = 0x02;		// Closed

		/* Wait for button to be pushed */
		while( (PINC & 0x10) ){
		}

		/* Wait for button to be released */
		while( !(PINC & 0x10) ){
		}

		/* set input */
		input = input >> 4; 	// shift left digit to right digit
								// note, the left digit will be 0 after this operation
		
		input |= PINC << 4;		// shift the input to be in the left digit
								// note, the right digit will be 0 after this operation
								// so we can OR them together to merge the results
	}
}

