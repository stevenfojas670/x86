###########################################################################
#  Name: Steven Fojas	
#  NSHE ID: 2001342715	
#  Section: 1003
#  Assignment: MIPS4
#  Description:  Performing matrix multiplication


###########################################################
#  data segment

.data

hdr:	.asciiz	"\nMIPS Assignment #4\nProgram to perform matrix multiplication. \n\n"


# -----
#  Matrix Set #1 - MA(i,k), MB(k,j), MC(i,j)

idim1:		.word	1
jdim1:		.word	1
kdim1:		.word	4

matrix_a1:	.word	 10,  20,  30,  40	# MA(1,4)

matrix_b1:	.word	 50			# MB(4,1)
		.word	 60
		.word	 70
		.word	 80

matrix_c1:	.word	 0			# MC(1,1)

# -----
#  Matrix Set #2 - MA(i,k), MB(k,j), MC(i,j)

idim2:		.word	3
jdim2:		.word	3
kdim2:		.word	2

matrix_a2:	.word	 10,  20		# MA(3,2)
		.word	 30,  30
		.word	 50,  60

matrix_b2:	.word	 15,  25,  35		# MB(2,3)
		.word	 45,  55,  60

matrix_c2:	.word	 0,  0,  0		# MC(3,3)
		.word	 0,  0,  0
		.word	 0,  0,  0

# -----
#  Matrix Set #3 - MA(i,k), MB(k,j), MC(i,j)

idim3:		.word	2
jdim3:		.word	2
kdim3:		.word	3

matrix_a3:	.word	 2,  3,  4		# MA(2,3)
		.word	 3,  4,  5

matrix_b3:	.word	 2,  3			# MB(3,2)
		.word	 3,  4
		.word	 5,  6

matrix_c3:	.word	 0,  0			# MC(2,2)
		.word	 0,  0

# -----
#  Matrix Set #4 - MA(i,k), MB(k,j), MC(i,j)

idim4:		.word	2
jdim4:		.word	3
kdim4:		.word	4

matrix_a4:	.word	 1,  2,  3,  4		# MA(2,4)
		.word	 5,  6,  7,  8

matrix_b4:	.word	 1,  2,  3		# MB(4,3)
		.word	 4,  5,  6
		.word	 7,  8,  9
		.word	10, 11, 12

matrix_c4:	.word	 0,  0,  0		# MC(2,3)
		.word	 0,  0,  0

# -----
#  Matrix Set #5 - MA(i,k), MB(k,j), MC(i,j)

idim5:		.word	4
jdim5:		.word	4
kdim5:		.word	4

matrix_a5:	.word	110, 120, 130, 140	# MA(4,4)
		.word	150, 160, 170, 180
 		.word	190, 200, 210, 220
		.word	230, 240, 250, 260

matrix_b5:	.word	300, 310, 320, 330	# MB(4,4)
		.word	340, 350, 360, 370
		.word	380, 390, 400, 410
		.word	420, 430, 440, 450

matrix_c5:	.word	  0,   0,   0,   0	# MC(4,4)
		.word	  0,   0,   0,   0
		.word	  0,   0,   0,   0
		.word	  0,   0,   0,   0
		.word	  0,   0,   0,   0

# -----
#  Matrix Set #6 - MA(i,k), MB(k,j), MC(i,j)

idim6:		.word	5
jdim6:		.word	5
kdim6:		.word	5

matrix_a6:	.word	12, 23, 45, 32, 20	# MA(5,5)
		.word	24, 31, 51, 54, 41
		.word	32, 48, 67, 76, 60
		.word	48, 59, 75, 98, 88
		.word	50, 63, 82, 16, 91

matrix_b6:	.word	10, 23, 45, 52, 60	# MB(5,5)
		.word	53, 12, 13, 37, 21
		.word	27, 72, 31, 41, 82
		.word	14, 58, 28, 54, 77
		.word	49, 36, 53, 63, 46

matrix_c6:	.word	 0,  0,  0,  0,  0	# MC(5,5)
		.word	 0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0

# -----
#  Matrix Set #7 - MA(i,k), MB(k,j), MC(i,j)

idim7:		.word	3
jdim7:		.word	5
kdim7:		.word	7

matrix_a7:	.word	 72,  9, 92,  6, 68,  4, 81	# MC(3,7)
		.word	  7, 91,  9, 86,  5, 62, 91
		.word	 89,  4, 65,  7, 77, 82,  6

matrix_b7:	.word	820, 221,   9,  34, 123		# MA(7,5)
		.word	  1, 183, 833,  52, 687
		.word	 62, 723,   4, 922,   5
		.word	  3, 824,  25, 212, 312
		.word	114, 425,  66,  43,  54
		.word	  5,  26, 637,  71, 291
		.word	916, 527, 738, 792,  32

matrix_c7:	.word	 0,  0,  0,  0,  0		# MB(3,5)
		.word	 0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0

# -----
#  Matrix Set #8 - MA(i,k), MB(k,j), MC(i,j)

idim8:		.word	5
jdim8:		.word	6
kdim8:		.word	10

matrix_a8:	.word	 21, 11, 72,  1, 76, 12, 26,  7, 12, 67	 # MA(5,10)
		.word	 54, 65, 54,  4, 31, 54, 56,  3, 34, 23
		.word	  3, 65,  6, 16, 68, 34, 75,  2, 10, 80
		.word	 11,  5, 45, 87, 30,  2, 13, 31, 56,  3
		.word	  9, 43, 60,  5, 45, 12, 90, 12,  1, 20

matrix_b8:	.word	 12,  3, 70, 32, 13, 51		# MB(10,6)
		.word	  2, 12, 34,  2, 65,  6
		.word	 57, 34,  6, 13,  5,  3
		.word	 64,  4, 34, 98, 67,  1
		.word	  5, 23,  9, 34,  8, 45
		.word	 36,  5, 58,  2, 89,  8
		.word	  8, 65,  5, 49,  9, 56
		.word	 95,  8, 45, 12, 52,  4
		.word	  3, 30,  6, 67,  5, 34
		.word	 36,  2, 81,  4, 56,  7

matrix_c8:	.word	 0,  0,  0,  0,  0,  0		# MC(5,6)
		.word	 0,  0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0,  0
		.word	 0,  0,  0,  0,  0,  0

# -----

mhdr:	.ascii	"\n----------------------------------------"
	.asciiz	"\nMatrix Set #"

msg_c:	.asciiz	"\nMatrix MC = (Matrix MA * Matrix MB) \n\n"


# -----
#  Local variables for multMatrix function.

msg_a:	.asciiz	"\n\nMatrix MA \n\n"
msg_b:	.asciiz	"Matrix MB \n\n"


# -----
#  Local variables for matrixPrint function.

new_ln:	.asciiz	"\n"

blnks1:	.asciiz	" "
blnks2:	.asciiz	"  "
blnks3:	.asciiz	"   "
blnks4:	.asciiz	"    "
blnks5:	.asciiz	"     "
blnks6:	.asciiz	"      "


###########################################################
#  text/code segment

.text

.globl main
.ent main
main:

# -----
#  Display main program header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Set data set counter.

	li	$s0, 1

# -----
#  Matrix Set #1
#  Multiply Matrix MA and MB, save in Matrix MC, and print.

	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a1
	la	$a1, matrix_b1
	la	$a2, matrix_c1
	lw	$a3, idim1
	lw	$t0, jdim1
	lw	$t1, kdim1
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c1			# matrix C
	lw	$a1, idim1			# i dimension
	lw	$a2, jdim1			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #2
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a2
	la	$a1, matrix_b2
	la	$a2, matrix_c2
	lw	$a3, idim2
	lw	$t0, jdim2
	lw	$t1, kdim2
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c2			# matrix C
	lw	$a1, idim2			# i dimension
	lw	$a2, jdim2			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #3
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a3
	la	$a1, matrix_b3
	la	$a2, matrix_c3
	lw	$a3, idim3
	lw	$t0, jdim3
	lw	$t1, kdim3
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c3			# matrix C
	lw	$a1, idim3			# i dimension
	lw	$a2, jdim3			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #4
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a4
	la	$a1, matrix_b4
	la	$a2, matrix_c4
	lw	$a3, idim4
	lw	$t0, jdim4
	lw	$t1, kdim4
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c4			# matrix C
	lw	$a1, idim4			# i dimension
	lw	$a2, jdim4			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #5
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a5
	la	$a1, matrix_b5
	la	$a2, matrix_c5
	lw	$a3, idim5
	lw	$t0, jdim5
	lw	$t1, kdim5
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c5			# matrix C
	lw	$a1, idim5			# i dimension
	lw	$a2, jdim5			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #6
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a6
	la	$a1, matrix_b6
	la	$a2, matrix_c6
	lw	$a3, idim6
	lw	$t0, jdim6
	lw	$t1, kdim6
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c6			# matrix C
	lw	$a1, idim6			# i dimension
	lw	$a2, jdim6			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #7
#  Multiply Matrix A and B, save in Matrix C, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a7
	la	$a1, matrix_b7
	la	$a2, matrix_c7
	lw	$a3, idim7
	lw	$t0, jdim7
	lw	$t1, kdim7
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c7			# matrix C
	lw	$a1, idim7			# i dimension
	lw	$a2, jdim7			# j dimension
	jal	matrixPrint

# -----
#  Matrix Set #8
#  Multiply Matrix MA and MB, save in Matrix MC, and print.

	add	$s0, $s0, 1
	la	$a0, mhdr
	li	$v0, 4
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, matrix_a8
	la	$a1, matrix_b8
	la	$a2, matrix_c8
	lw	$a3, idim8
	lw	$t0, jdim8
	lw	$t1, kdim8
	subu	$sp, $sp, 8
	sw	$t0, ($sp)
	sw	$t1, 4($sp)

	jal	multMatrix

	addu	$sp, $sp, 8

	la	$a0, msg_c
	li	$v0, 4
	syscall

	la	$a0, matrix_c8			# matrix C
	lw	$a1, idim8			# i dimension
	lw	$a2, jdim8			# j dimension
	jal	matrixPrint

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall

.end main

# -------------------------------------------------------
#  function to multiply two matrix's.

# -----
#  Matrix multiplication formula:

#	for (i=0; i<DIM; i++)
#		for j=0; j<DIM; j++)
#			for (k=0; k<DIM<; k++)
#				MC(i,j) = MC(i,j) + MA(i,k) * MB(k,j)
#			end_for
#		end_for
#	end_for

# -----
#  Formula for multiple dimension array indexing:
#	addr of ARRY(x,y) = [ (x * y_dimension) + y ] * data_size

# -----
#  Arguments
#	$a0 - address matrix a
#	$a1 - address matrix b
#	$a2 - address matrix c
#	$a3 - value, i dimension
#	stack, ($fp) - value, j dimension 
#	stack, 4($fp) - value, k dimension

.globl	multMatrix
.ent	multMatrix
multMatrix:

subu 	$sp, $sp, 40
sw  	$s0, ($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$s4, 16($sp)
sw 		$s5, 20($sp)
sw 		$s6, 24($sp)
sw 		$s7, 28($sp)
sw 		$fp, 32($sp)
sw 		$ra, 36($sp)
addu 	$fp, $sp, 40

move 	$t0, $a0		# matrix a
move 	$t1, $a1		# matrix b
move 	$t2, $a2		# matrix c
move 	$t3, $a3		# i dimension
lw 		$t4, ($fp)		# j dimension
lw 		$t5, 4($fp)		# k dimension
li 		$t6, 0 			# i counter
li 		$t7, 0 			# j counter
li 		$t8, 0 			# k counter

# board(row, col) = baseAddress + (rowIndex * colSize + colIndex) * dataSize

forLoopI:
	forLoopJ:
		forLoopK:
			# accessing MC(i,j)
			mul 	$s0, $t6, $t4	# 				(i * jDim
			add 	$s0, $s0, $t7	# 						  + j)
			mul 	$s0, $s0, 4		#							   * dataSize
			add 	$s1, $t2, $s0	# matrixC + 

			# s1 stores the address for MC(i,j)
			
			# accessing MA(i,k)
			mul 	$s0, $t6, $t5	#			(i * kDim
			add 	$s0, $s0, $t8 	#					  + k)
			mul 	$s0, $s0, 4 	#							* dataSize
			add 	$s2, $t0, $s0 	# matrixA + 

			# s2 stores the address for MA(i,k)

			# accessing MB(k,j)
			mul 	$s0, $t8, $t4	#			(k * jDim
			add 	$s0, $s0, $t7 	#					  + j)
			mul 	$s0, $s0, 4 	#							* dataSize
			add 	$s3, $t1, $s0 	# matrixB + 

			# s3 stores the address for MB(k,j)

			

lw  	$s0, ($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$s4, 16($sp)
lw 		$s5, 20($sp)
lw 		$s6, 24($sp)
lw 		$s7, 28($sp)
lw 		$fp, 32($sp)
lw 		$ra, 36($sp)
addu 	$fp, $sp, 40

jr 		$ra
.end 	multMatrix

# ---------------------------------------------------------
#  Print matrix - M(i,j)

#  Arguments:
#	$a0 - starting address of matrix to ptint
#	$a1 - i dimension of matrix
#	$a2 - j dimension of matrix

.globl 	matrixPrint
.ent 	matrixPrint
matrixPrint:

#	YOUR CODE GOES HERE

jr 		$ra
.end 	matrixPrint
