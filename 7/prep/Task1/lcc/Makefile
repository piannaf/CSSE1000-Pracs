# Wedit Makefile for project task1
SRCDIR=e:\classes\csse1000\prac\7\task1
CFLAGS=-I"C:\lcc\include"  -g2  -ansic
CC=$(LCCROOT)\bin\lcc.exe
LINKER=$(LCCROOT)\bin\lcclnk.exe
OBJS=\
	prac7-1.obj

LIBS=
EXE=task1.exe

$(EXE):	$(OBJS) Makefile
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\task1.exe $(OBJS) $(LIBS)

# Build prac7-1.c
PRAC7-1_C=\

prac7-1.obj: $(PRAC7-1_C) $(SRCDIR)\prac7-1.c
	$(CC) -c $(CFLAGS) $(SRCDIR)\prac7-1.c

link:
	$(LINKER)  -subsystem console -o $(SRCDIR)\lcc\task1.exe $(OBJS) $(LIBS)

clean:
	del $(OBJS) task1.exe
