###########################################################################
#  Name: Steven Fojas
#  NSHE ID: 2001342715
#  Section: 1003
#  Assignment: MIPS #1
#  Description: Calculating the perimeter of an equilateral pentagon using MIPS

#  Example program to find the:
#	min, max, and average of a list of perimeters.
#	min, max, and average of the even perimeters values.
#	min, max, and average of the perimeters values eveny divisible by 9.

###########################################################
#  data segment

.data

sides:	.word	 252,  193,  982,  339,  564,  631,  421,  148,  936,  157
	.word	 117,  171,  697,  161,  147,  137,  327,  151,  147,  354
	.word	 432,  551,  176,  487,  490,  810,  111,  523,  532,  445
	.word	 163,  745,  571,  529,  218,  219,  122,  934,  370,  121
	.word	 315,  145,  313,  174,  118,  259,  672,  126,  230,  135
	.word	 199,  105,  106,  107,  124,  625,  126,  229,  248,  991
	.word	 132,  133,  936,  136,  338,  941,  843,  645,  447,  449
	.word	 171,  271,  477,  228,  178,  184,  586,  186,  388,  188
	.word	 950,  852,  754,  256,  658,  760,  161,  562,  263,  764
	.word	 199,  213,  124,  366,  740,  356,  375,  387,  115,  426
len:	.word	100

perims:	.space	400			# 100*4 bytes each

min:	.word	0
max:	.word	0
ave:	.word	0

eMin:	.word	0
eMax:	.word	0
eAve:	.word	0

d9Min:	.word	0
d9Max:	.word	0
d9Ave:	.word	0

hdr:	.ascii	"MIPS Assignment #1\n\n"
	.ascii	"Program to find: \n"
	.ascii	"   * min, max, and average for a list of perimeters.\n"
	.ascii	"   * min, max, and average of the even perimeter values.\n"
	.ascii	"   * min, max, and average of the perimeters values divisible by 9."
new_ln:	.asciiz	"\n"

a1_st:	.asciiz	"\n    List min = "
a2_st:	.asciiz	"\n    List max = "
a3_st:	.asciiz	"\n    List ave = "

a4_st:	.asciiz	"\n\n    Even min = "
a5_st:	.asciiz	"\n    Even max = "
a6_st:	.asciiz	"\n    Even ave = "

a7_st:	.asciiz	"\n\n    Divisible by 9 min = "
a8_st:	.asciiz	"\n    Divisible by 9 max = "
a9_st:	.asciiz	"\n    Divisible by 9 ave = "


###########################################################
#  text/code segment

.text
.globl	main
.ent	main
main:

# ********************
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall

# ********************



#	YOUR CODE GOES HERE

la 		$t0, sides				# sides array address
li 	 	$t1, 0 					# counter
lw 		$t2, len 				# length
la 		$t3, perims

perimeterLoop:

lw 		$t5, ($t0)

mul 	$t6, $t5, 5				# multiplying side by 5 to get the equilateral pentagon
sw 		$t6, ($t3)				# placing the equilateral into the perims array
add 	$t1, $t1, 1				# i++
add 	$t0, $t0, 4				# incrementing sides array
add 	$t3, $t3, 4				# incrementing perims array

blt 	$t1, $t2, perimeterLoop

la 		$t0, perims				# storing perims array address
li 		$t1, 0					# perims counter
lw 		$t2, len				# storing perims length
li 		$t3, 0 					# stores sum of perimeters
lw 		$t6, ($t0)				# min
lw 		$t7, ($t0)				# max

normalLoop:
lw 		$t5, ($t0)				# getting perims[i]

add 	$t3, $t3, $t5				# sum = sum + perims[i]

bgt 	$t6, $t5, swapMin				# if min > perims[i]
j 		checkMax

swapMin:
move 	$t6, $t5					# min = perims[i]
sw 		$t6, min
j 		skip	

checkMax:
blt 	$t7, $t5, swapMax			# max < perims[i]
j 		skip

swapMax:
move 	$t7, $t5					# max = perims[i]
sw 		$t7, max

skip:
add 	$t1, $t1, 1					# i++
add 	$t0, $t0, 4					# incrementing perims array
blt		$t1, $t2, normalLoop

div 	$t8, $t3, $t1
sw 		$t8, ave					# saving average


# ********************************************************************************

la 		$t0, perims
li 		$t1, 0						# counter
lw 		$t2, len					# length of perims array
li 		$t3, 0 						# sum of perimeters
lw 		$t6, ($t0)					# eMin
lw 		$t7, ($t0)					# eMax
li 		$s0, 0						# counter for even numbers

evenLoop:

lw 		$t5, ($t0)

rem 	$t8, $t5, 2
beq 	$t8, 0, isEven
j 		isOdd

isEven:

add 	$s0, $s0, 1					# increment even counter
add 	$t3, $t3, $t5				# sum = sum + perims[i]

bgt 	$t6, $t5, swapEMin			# if min > perims[i] then swap min
j 		checkEMax

swapEMin:
move 	$t6, $t5					# min = perims[i]
sw 		$t6, eMin
j 		isOdd

checkEMax:
blt 	$t7, $t5, swapEMax			# if max < perims[i] then swap max
j 		isOdd

swapEMax:
move 	$t7, $t5					# max = perims[i]
sw 		$t7, eMax

isOdd:
add 	$t0, $t0, 4					# incrementing perims array
add 	$t1, $t1, 1					# counter++
blt 	$t1, $t2, evenLoop					# if counter < len then reloop

div 	$t8, $t3, $s0 				# eAve = sum / even counter
sw 		$t8, eAve

# ********************************************************************************

la 		$t0, perims
li 		$t1, 0 						# counter
lw 		$t2, len 					# length of perims array
li 		$t3, 0 						# sum of perimeters 
lw 		$t6, ($t0)					# min
lw 		$t7, ($t0)					# max
li 		$s0, 0 						# div by 9 counter

div9Loop:

lw 		$t5, ($t0)					# getting perims[i]

rem 	$t8, $t5, 9					# perims[i] % 9
beq 	$t8, 0, divBy9				# if perims[i] % 9 == 0 then perform calculations
j 		notDiv

divBy9:

add 	$s0, $s0, 1					# increment div by 9 coutner
add 	$t3, $t3, $t5				# d9sum = sum + perims[i]

bgt 	$t6, $t5, swap9Min			# if d9min > perims[i] then swap 
j 		check9Max

swap9Min:
move 	$t6, $t5					# d9min = perims[i]
sw 		$t6, d9Min
j 		notDiv

check9Max:
blt 	$t7, $t5, swap9Max			# if d9Max < perims[i] then swap
j 		notDiv

swap9Max:
move 	$t7, $t5					# d9Max = perims[i]
sw 		$t7, d9Max

notDiv:
add 	$t0, $t0, 4					# incrementing perims array
add 	$t1, $t1, 1					# incrementing perims array counter
blt 	$t1, $t2, div9Loop			# if counter < len

div 	$t8, $t3, $s0				# d9Ave = sum / d9counter
sw 		$t8, d9Ave
	

# ********************
#  Display results.

#  Print list min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall						# print "List min = "

	lw	$a0, min
	li	$v0, 1
	syscall						# print list min

#  Print max message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall						# print "List max = "

	lw	$a0, max
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall						# print "List ave = "

	lw	$a0, ave
	li	$v0, 1
	syscall						# print average

# -----
#  Display results - even numbers.

#  Print min message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall						# print "Even min = "

	lw	$a0, eMin
	li	$v0, 1
	syscall						# print min

#  Print max message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall						# print "Even max = "

	lw	$a0, eMax
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a6_st
	li	$v0, 4
	syscall						# print "Even ave = "

	lw	$a0, eAve
	li	$v0, 1
	syscall						# print average

# -----
#  Display results - divisible by 9 numbers.

#  Print min message followed by result.

	la	$a0, a7_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Min
	li	$v0, 1
	syscall						# print min

#  Print max message followed by result.

	la	$a0, a8_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Max
	li	$v0, 1
	syscall						# print max

#  Print average message followed by result.

	la	$a0, a9_st
	li	$v0, 4
	syscall						# print message

	lw	$a0, d9Ave
	li	$v0, 1
	syscall						# print average

	la	$a0, new_ln				# print a newline
	li	$v0, 4
	syscall


# -----
#  Done, terminate program.

	li	$v0, 10
	syscall						# all done!

.end main

