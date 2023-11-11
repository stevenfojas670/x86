#  CS 218, MIPS Assignment #0

#  Example program to display a list of
#  numbers and find the mimimum and maximum.

###########################################################
#  data segment

.data

array:		.word	113, 234, 116, 261, 228
		.word	224, 158, 211, 126, 241
		.word	119, 417, 138, 112, 213
len:		.word	15

hdr:		.ascii	"\nExample program to find the min"
		.asciiz	" and max of an array.\n\n"
newLine:	.asciiz	"\n"

minMsg:		.asciiz	"min = "
maxMsg:		.asciiz	"max = "


###########################################################
#  text/code segment

#  Uses the following registers:
#	t0 - array address
#	t1 - count of elements
#	s2 - min
#	s3 - max
#	t4 - each word from array

#  Note, SPIM requires the main procedure to be named "main".

.text

.globl main
.ent main
main:

# -----
#  Display header
#  Uses print string system call

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# -----
#  Find max and min of the array.

#   Set min and max to first item in list and then
#   loop through the array and check min and max against
#   each item in the list, updating the min and max values
#   as needed.

	la	$t0, array		# set $t0 addr of array
	lw	$t1, len		# set $t1 to length

	lw	$s2, ($t0)		# set min, $t2 to array[0]
	lw	$s3, ($t0)		# set max, $t3 to array[0]

loop:	lw	$t4, ($t0)		# get array[n]

	bge	$t4, $s2, NotMin	# is new min?
	move	$s2, $t4		# set new min

NotMin:	ble	$t4, $s3, NotMax	# is new max?
	move	$s3, $t4		# set new max

NotMax:
	sub	$t1, $t1, 1		# decrement counter
	addu	$t0, $t0, 4		# increment addr by word
	bnez	$t1, loop

# -----
#  Display results for min and max.
#   First display string, then value, then a print a
#   new line (for formatting).  Do for each max and min.

	la	$a0, minMsg
	li	$v0, 4
	syscall				# print "min = "

	move	$a0, $s2
	li	$v0, 1
	syscall				# print min

	la	$a0, newLine		# print a newline
	li	$v0, 4
	syscall

	la	$a0, maxMsg
	li	$v0, 4
	syscall				# print "max = "

	move	$a0, $s3
	li	$v0, 1
	syscall				# print max

	la	$a0, newLine		# print a newline
	li	$v0, 4
	syscall

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall				# all done!

.end main

