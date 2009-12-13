# Wedit Makefile for project task2
SRCDIR=e:\classes\csse1000\prac\7\prep\task2
CFLAGS=-I"C:\lcc\include"  -g2  -ansic
CC=$(LCCROOT)\bin\lcc.exe
LINKER=$(LCCROOT)\bin\lcclnk.exe
OBJS=\
	prac7-2.obj

LIBS=
EXE=task2.exe

$(EXE):	$(OBJS) Makefile
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\task2.exe $(OBJS) $(LIBS)

# Build prac7-2.c
PRAC7-2_C=\

prac7-2.obj: $(PRAC7-2_C) $(SRCDIR)\prac7-2.c
	$(CC) -c $(CFLAGS) $(SRCDIR)\prac7-2.c

link:
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\task2.exe $(OBJS) $(LIBS)

clean:
	del $(OBJS) task2.exe
