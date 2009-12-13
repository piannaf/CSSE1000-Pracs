# Wedit Makefile for project p9Tutor
SRCDIR=f:\classes\csse1000\prac\9
CFLAGS=-I"C:\lcc\include"  -g2 
CC=$(LCCROOT)\bin\lcc.exe
LINKER=$(LCCROOT)\bin\lcclnk.exe
OBJS=\
	p9tutor.obj

LIBS=
EXE=p9Tutor.exe

$(EXE):	$(OBJS) Makefile
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\p9Tutor.exe $(OBJS) $(LIBS)

# Build p9Tutor.c
P9TUTOR_C=\

p9tutor.obj: $(P9TUTOR_C) $(SRCDIR)\p9tutor.c
	$(CC) -c $(CFLAGS) $(SRCDIR)\p9tutor.c

link:
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\p9Tutor.exe $(OBJS) $(LIBS)

clean:
	del $(OBJS) p9Tutor.exe
