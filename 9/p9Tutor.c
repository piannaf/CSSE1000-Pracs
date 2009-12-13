#include <stdio.h>
#include <windows.h>

/*---------------------------------------------------------------------------------------*/

/* A440 is note 49 */

#define A 49

/* All other notes defined realtive to A (in semitones). +1 or -1 can be used for sharps and flats */

#define B A+2
#define C B+1
#define D C+2
#define E D+2
#define F E+1
#define G F+2

/* use +/- O * N to jump octives */

#define O 12

/* default time duration (in milliseconds) */

#define T 250

/*---------------------------------------------------------------------------------------*/

/* each note is a pitch and a duration (in milliseconds) */

typedef struct {
	int pitch;
	int duration;
} Note;

/* A very basic tune. (Notes of the A-minor scale) */

Note notes [] = {
	{C, T},
	{D, T},
	{E-1, T},
	{F, T},
	{G, T},
	{A-1+O, T},
	{B+O, T},
	{C+O, T},
	{C-O*2, T/2},
	{E-1-O*2, T/2},
	{G-O*2, T/2},
	{C-O, T/2},
	{E-1-O, T/2},
	{G-O, T/2},
	{C, T/2},
	{E-1, T/2},
	{G, T/2},
	{C+O, T/2},
	{E-1+O, T/2},
	{G+O, T/2},
	{C+O*2, T/2},
	{E-1+O*2, T/2},
	{G+O*2, T/2},
	{C+O*3, T*6},
};

/* the length of the above array */

#define NUM_NOTES 8

/*---------------------------------------------------------------------------------------*/

/* the ratio of frequencies between two consecutive notes is the 12th root of 2 */

#define RT12_2 1.0594630943592952645618252949463

double scale [100];

/*create a musical scale centered on A440*/

void populateScale () {
	int i;
	scale[49] = 440.0;
	for (i = 48; i > 0; --i)
		scale[i] = scale[i+1] / RT12_2;
	for (i = 50; i < 100; ++i)
		scale[i] = scale[i-1] * RT12_2;
}

/*--------------------------------------------------------------------------------------*/
/* change these macros to match the AVR's configuration. Timer counter prescaler and system
clock speed are used to compute the frequency of the timer for calucations in delays
*/

#define TC_PRESCALER 1.0
#define F_CLK 4000000.0
#define F_TIMER (F_CLK/TC_PRESCALER)

int main() {

	populateScale();

	HANDLE hSerial;

	/* request the serial port from the operating system (Windows) */

	hSerial = CreateFile("COM1",
		GENERIC_READ | GENERIC_WRITE,
		0,
		0,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		0);
	if(hSerial==INVALID_HANDLE_VALUE) {
		printf("Error, serial port not available, close hypterterminal or active sync if either are running\n");
		return 1;
	} else
		printf("Serial port opened sucessfully\n");

	/* configure the serial port */

	DCB dcbSerialParams = {0};
	dcbSerialParams.DCBlength=sizeof(dcbSerialParams);
	if (!GetCommState(hSerial, &dcbSerialParams)) {
		printf("error (0) configuring serial port\n");
		return 1;
	}
	dcbSerialParams.BaudRate=CBR_19200;
	dcbSerialParams.ByteSize=8;
	dcbSerialParams.StopBits=ONESTOPBIT;
	dcbSerialParams.Parity=NOPARITY;
	if(!SetCommState(hSerial, &dcbSerialParams)) {
		printf("error (1) configuring serial port\n");
		return 1;
	} else
		printf("serial port configured successfully\n");

	/* play the tune on the piezo */

	int i;
	for (i = 0; i < NUM_NOTES; ++i) {
		unsigned char szBuff [2];
		DWORD bytesWritten;
		int p = (int)(F_TIMER / scale[notes[i].pitch]);
		szBuff[1] = (unsigned char)(p & 0x00FF);
		p >>= 8;
		szBuff[0] = (unsigned char)(p & 0x00FF);
		if (!WriteFile(hSerial, szBuff, 2, &bytesWritten, NULL)) {
			printf("error writing to serial port\n");
		}
		printf("%d bytes written: 0x%.2x 0x%.2x \n", bytesWritten, szBuff[0], szBuff[1]);
		Sleep(notes[i].duration);
	}

	/* clean up and exit */
	CloseHandle(hSerial);
	return 0;
}