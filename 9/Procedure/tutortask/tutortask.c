/*
 * FILE: prac9-1.c
 *
 * Replace the "<-YOUR CODE HERE->" comments with your code.
 */

#include <avr/io.h>
#include <avr/interrupt.h>

volatile unsigned char h = 1;
volatile unsigned char l = 1;

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
	PORTD = 0; /* both 4 and 5 will go to 0 but OK */

	/* Set OC1A pin to toggle */
	TCCR1A = 0x40;

	/* Set Output Compare 1 value */
    OCR1A = 0x1000;

	/* Set up timer 1 so that it will clear on compare match */
	TCCR1B = (1<<CTC1)|(0<<CS12)|(0<<CS11)|(1<<CS10);

	/* Set prescaler to CK*/
	//TCCR1B |= (0<<CS12)|(0<<CS11)|(1<<CS10);

	/* Start the timer */
	TCCR1B |= 0x01;
	
	/* Set the baud rate to 19200 - see page 58 of the datasheet
	** to see what value to write to the UBRR register when we 
	** have a 4MHz clock
	*/
	UBRR = 12;
	
	/*
	** Enable receiving via UART and also 
	** enable the Receive Complete Interrupt and the Data Register
	** Empty interrupt. This ensures that we get an interrupt
	** when the UART receives a character and when it is ready
	** to accept a new character for transmission.
	** HINT: Look at the RXEN, TXEN, RXCIE, UDRIE bits of UCR
	** (see page 56 of the datasheet)
	*/

	/* UCR = UART Controll Register
	   RXEN = Reciever Enable, TXEN, Transmitter Enable
	   UDRIE = Data Register Empty Interrupt Enable
	   RXCIE = Receive Complete Interrupt Enable
	*/
	UCR = (1<<RXEN)|(1<<RXCIE);

	/* Enable interrupts */
	sei();
	
	/* Sit back and let it happen - this will loop forever */
	for (;;) {
	}
}

void update_OCR1A(char h, char l) {
	OCR1AH = h;
	OCR1AL = l;
}

		
/*
 * Define the interrupt handler for UART Receive Complete - i.e. a new
 * character has arrived in the UART Data Register (UDR).
 */
ISR(UART_RX_vect) {
	/* A character has been received - if it is not a number, then
	** put it into the transmit buffer to echo it back. If it is
	** a number than put the text equivalent into the transmit
	** buffer
	*/
	char input;

	/* Extract character from UART Data register and place in input
	** variable
	*/

	/*When writing to the register, the UART Transmit Data register is written.
	  When reading from UDR, the UART Receive Data register is read.*/
	input = UDR;

	/* check if high and low are already set.
	   if they are, clear them both and put the new input
	   into the high and clear low */
	if( h && l){
		h = input;
		l = 0;
	} else {
		/* put the input into low and update OCR1A */
	    l = input;
		update_OCR1A(h, l);
	}
}


