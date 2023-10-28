# CS 218 Assignment #11
# Simple make file for asst #11B

OBJS_SM	= imageCvt.o a11procsSM.o
OBJS_LG	= imageCvt.o a11procsLG.o
ASM	= yasm -g dwarf2 -f elf64
CC	= g++ -g -std=c++11

all:	sed imageCvtLG imageCvtSM

sed:
	@sed -e "s/BUFF_SIZE\tequ\t1000000/BUFF_SIZE\tequ\t2/" \
					a11procs.asm > a11procsSM.asm

imageCvt.o: imageCvt.cpp
	$(CC) -c imageCvt.cpp

a11procsSM.o: a11procsSM.asm
	$(ASM) a11procsSM.asm -l a11procsSM.lst -o a11procsSM.o

a11procsLG.o: a11procs.asm
	$(ASM) a11procs.asm -l a11procs.lst -o a11procsLG.o

imageCvtSM: $(OBJS_SM)
	$(CC) -no-pie -o imageCvtSM $(OBJS_SM)

imageCvtLG: $(OBJS_LG)
	$(CC) -no-pie -o imageCvtLG $(OBJS_LG)

# -----
# clean by removing object files and list files.

clean:
	@rm  -f $(OBJS_LG)
	@rm  -f $(OBJS_SM)
	@rm  -f a11procs.lst
	@rm  -f a11procsSM.lst
