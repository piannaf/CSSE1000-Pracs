/*
 * FILE: prac8-3.c
 *
 * Replace the "<-YOUR CODE HERE->" comment lines with your code.
 */

#include <avr/io.h>

/*
 * main -- Main program.
 */
int main(void)
{
	/* Set PORT D Pins 5 and 4 direction to output */
	/* NOTE that DDD5 is equal to the value 5 and
	** DDD4 is equal to the value 4. (These constants
	** are defined in a header file included by avr/io.h.)s
	** The names are the same as those given in the
	** datasheet for each bit position.
	*/
	DDRD = (1<<DDD5) | (1<<DDD4);

	/* Set PORT D Pin 4 output to zero */
	/*<-YOUR CODE HERE->*/

	/* Set OC1A pin to toggle */
	/*<-YOUR CODE HERE->*/

	/* Set Output Compare 1 value */
    OCR1A = 1999;
	/* An alternative would be to write:
	*  	OCR1AH = 1999/256;
	*  	OCR1AL = 1999 & 0xFF;
	*  but C allows us to treat OCR1A as a single 16 bit register
	*/

	/* Set Timer 1 to clear on compare match */
	/*<-YOUR CODE HERE->*/

	/* Start Timer 1 */
	/*<-YOUR CODE HERE->*/

	/* Sit back and let it happen - the hardware takes care of it all */
	for (;;) {
	}
}
