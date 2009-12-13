/* FILE: prac7-1.c */

#include <stdio.h>

int main(void)
{
	int input = 0;
	int total = 0;

	/* print preamble to the screen */
	printf("CSSE1000 PRAC 7 PREP TASK 1 - ACCUMULATOR\n");
	printf("Justin Mancinelli - 42094353\n");

	/* start an infinite loop */
	while(1){
		/* add the input to the total */
		total += input;
		/* show the user the total */
		printf("the accumulated total is %d\n", total);

		/* as the user for a new number */
		printf("enter a number: ");
		scanf("%d", &input);

		/* check if user wants to exit */
		if(input == 0)
			/* break out of infinite loop */
			break;
	}

	/* return success to the OS */
	return 0;
}
