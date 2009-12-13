/* FILE: prac7-2.c */

#include <stdio.h>

int main(void)
{
	int digit1, digit2;

	/* print preamble to the screen */
	printf("CSSE1000 PRAC 7 PREP TASK 1 - COMBINATION LOCK\n");
	printf("Justin Mancinelli - 42094353\n");

	/* start an infinite loop */
	while(1) {
		/* check whether the combination is correct */
		if(digit1 == 8 && digit2 == 3)
			printf("\nthe lock is currently open\n\n");
		else
			printf("\nthe lock is currently closed\n\n");

		/* allow user to enter digts */
		printf("enter the first digit: ");
		scanf("%d", &digit1);
		printf("enter the second digit: ");
		scanf("%d", &digit2);

		/* show the user their code */
		printf("\nthe code you entered is %d%d\n", digit1, digit2);

		/* check if the user wants to exit */
		if(digit1 == 0 && digit2 == 0)
			/* break out of infinite loop */
			break;
	}

	/* return success to the OS */
	return 0;
}
