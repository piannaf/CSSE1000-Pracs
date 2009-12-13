/*
** FILE: prac7-1.c
**
** Replace the lines <-YOUR CODE HERE-> with your code.
*/

#include <avr/io.h>

int main(void)
{
	unsigned char temp;

	/* Set PORT B direction to output */
	DDRB = 0xFF;

	/* Set PORT C direction to input */
	DDRC = 0x00;

	while(1) {
		/* Input 8 bits of data from the PORT C pins into temp */
		/* temp = PINC */

		/* Invert temp */
		/* temp = temp * -1 */

		/* Output the result to PORT B */
		/* PORTB = temp */

		/* As an alternative, the above three lines can be
		** replaced by a single line of code.
		*/

		PORTB = PINC ^ 0xFF;
	}
}

