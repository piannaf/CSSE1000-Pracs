/*
** FILE: prac7-3.c
**
** Replace the lines <-YOUR CODE HERE-> with your code.
*/

#include <avr/io.h>

int main(void)
{
	unsigned char input = 0x00;

	/* Set PORT A direction to output */
	DDRA = 0xFF; 				// Left and Right Digits

	/* Set PORTC pins 6-3, 0 to input with others output*/
	DDRC = 0x06;

	while(1) {
		/* output the inputed combination */
		PORTA = input;

		/* set status */
		if( input == 0x38 )
			PORTC = 0x02;		// Open
		else
			PORTC = 0x04;		// Closed

		/* Wait for button to be pushed */
		while( (PINC & 0x01) ){
		}

		/* Wait for button to be released */
		while( !(PINC & 0x01) ){
		}

		/* set input */
		input = input << 4; 	// shift left digit to right digit
								// note, the left digit will be 0 after this operation

		input |= (PINC >> 3) & 0x0F;
								// shift the input to be in the left digit
								// note, the right digit will be 0 after this operation
								// so we can OR them together to merge the results
	}
}

