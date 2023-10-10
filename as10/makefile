# CS 218 Assignment #10
# Simple make file for asst #10

OBJS	= spirograph.o a10procs.o
ASM	= yasm -g dwarf2 -f elf64
CC	= g++ -g -std=c++11 

all: spirograph

spirograph.o: spirograph.cpp
	$(CC) -c spirograph.cpp

a10procs.o: a10procs.asm 
	$(ASM) a10procs.asm -l a10procs.lst

spirograph: $(OBJS)
	$(CC) -no-pie -o spirograph $(OBJS) -lglut -lGLU -lGL -lm

# -----
# clean by removing object files.

clean:
	rm  $(OBJS)
	rm  a10procs.lst

