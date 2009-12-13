loop:
	ldi r29, 0x41
	ldi r24, 0x54
	and r24, r29
	andi r24, 0xFC
	
	ldi r29, 0x41
	ldi r24, 0x54
	andi r29, 0xFC
	andi r24, 0xFC
	rjmp loop
