###########################################################################
#  Name: Steven Fojas
#  NSHE ID: 2001342715	
#  Section: 1003
#  Assignment: MIPS5
#  Description:  



#####################################################################
#  data segment

.data

# -----
#  Define basic parameters

TRUE = 1
FALSE = 0
NUMSIZE = 6		# parameter for maximum number size (digits)

# -----
#  Local variables for main.

hdr:	.ascii	"\nMIPS Assignment #5\n"
	.asciiz	"Pascal's Triangle Program\n\n"

rows:	.word	5

# -----
#  Local variables for displayPascalTriangle routine.

rmsg1:	.asciiz	"\nrow "
rmsg2:	.asciiz	":    "

# -----
#  Local variables for readRows routine.

entN:	.asciiz	"\nEnter number of rows in triangle (1-25): "
badRow:	.asciiz	"\nError, valid row amount, please re-enter."

# -----
#  Local variables for prtPnum routine.

spc:	.asciiz	"   "

# -----
#  Local variables for prtBlanks routine.

spc1:	.asciiz	" "
nline:	.asciiz	"\n"

# -----
#  Local variables for checkAgain routine.

uAns:	.byte	0, 0, 0

ask:	.asciiz	"\n\nAnother Game (y/Y/n/N)? "
dMsg:	.asciiz	"\nGame Over. \nThank you for playing.\n\n"
badAns:	.asciiz	"Error, invalid input, please try again."


#####################################################################
#  text/code segment

.text

.globl main
.ent main
main:

# -----
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  Read max rows (1-25).

doPascalAgain:
#	jal	readRows
#	sw	$v0, rows

# -----
#  Display the pascal triangle.

	lw	$a0, rows
	jal	displayPascalTriangle

# -----
#  Check for another triangle?

	jal	checkAgain
	beq	$v0, TRUE, doPascalAgain

# -----
#  Done, terminate program.

	la	$a0, nline
	li	$v0, 4
	syscall
	la	$a0, nline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall					# au revoir...

.end main


#####################################################################
#  Display the pascal triangle.
#	Routine must compute the Pascal number (via call),
#	display approriate row headers (see example), and
#	then print the pascal numbers.  Since the pascal()
#	function computes a single Pascal number, the pascal()
#	function will need to be called in a nested loop
#	(rows and columns).

# -----
#    Arguments:
#	$a0 - rows (value)

#    Returns:
#	nothing


#	YOUR CODE GOESH HERE

.globl displayPascalTriangle
.ent displayPascalTriangle
displayPascalTriangle:

subu 	$sp, $sp, 28
sw 		$s0, ($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$s4, 16($sp)
sw 		$ra, 20($sp)
sw 		$fp, 24($sp)
addu 	$fp, $sp, 28

move 	$s4, $a0
li 		$s0, 0
printLine:
	li 		$s1, 0
	printRow:

	li 		$v0, 4
	la 		$a0, rmsg1
	syscall

	li 		$v0, 1
	move 	$a0, $s0
	syscall

	li 		$v0, 4
	la 		$a0, rmsg2
	syscall

	# call pascal($s0, $s1) - $s0 is n, $s1 is k
	move 	$a0, $s0	
	move 	$a1, $s1
	jal 	pascal

	# call prtPnum(n, $v0) - $v0 is the number returned from pascal(n, k)
	move 	$a0, $s0
	move 	$a1, $v0
	jal 	prtPnum

	add 	$s1, $s1, 1
	ble 	$s1, $s0, printRow

	li 		$v0, 4
	la 		$a0, nline
	syscall

add 	$s0, $s0, 1
blt 	$s0, $s4, printLine

lw 		$s0, ($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$s4, 16($sp)
lw 		$ra, 20($sp)
lw 		$fp, 24($sp)
addu 	$sp, $sp, 28

jr 		$ra
.end displayPascalTriangle

#####################################################################
#  MIPS assembly language function, readRows()
#	Reads a number from the user and ensure that the number
#	is between 1 and 25 (inclusive).
#	Includes prompting and error checking.
#	Re-prompts for incorrect input.

# -----
#    Arguments:
#	none

#    Returns:
#	$v0 - n (between 1-25)

.globl readRows
.ent readRows
readRows:

subu 	$sp, $sp, 8
sw 		$s0, ($sp)
sw 		$fp, 4($sp)
addu 	$fp, $sp, 8

entryPrompt:
li 		$v0, 4						# prints "Enter number of rows in triangle (1-25):"
la 		$a0, entN
syscall

li 		$v0, 5						# syscall to get row input
syscall

blt 	$v0, 1, outOfBounds
bgt 	$v0, 25, outOfBounds
j 		inBounds

outOfBounds:
li 		$v0, 4
la 		$a0, badRow
syscall
j 		entryPrompt

inBounds:
lw 		$s0, ($sp)
lw 		$fp, 4($sp)
addu 	$sp, $sp, 8

jr 	$ra
.end readRows

#####################################################################
#  Pascal's triangle.
#  Compute the kth element of the nth row.
#  Note, k and n are 0-based

#	Pascal(n,k)
#	   if k = 0 or k = n then
#	      return 1
#	   else
#	      return Pascal(n-1,k-1) + Pascal(n-1, k)

# -----
#    Arguments:
#	$a0 - n
#	$a1 - k

#    Returns:
#	$v0 - pascal(n,k)

.globl pascal
.ent pascal
pascal:

subu 	$sp, $sp, 16
sw 		$s0, ($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$ra, 16($sp)
		
# base case
beq 	$a1, 0, pascalDone				# if k = 0
beq 	$a1, $a0, pascalDone			# if k = n

sub 	$s0, $a0, 1 					# n - 1
sub 	$s1, $a1, 1						# k - 1
move 	$s3, $s1 						# saving k

move 	$a0, $s0						# passing n - 1
move 	$a1, $s1						# passing k - 1
jal 	pascal							# calling pascal(n-1,k-1)
move 	$s2, $v0						# saving pascal(n-1,k-1)

move 	$a0, $s0						# passing n - 1
move 	$a1, $s3						# passing k
jal 	pascal							# calling pascal(n-1, k)
add 	$v0, $s2, $v0 					# pascal(n-1, k-1) + pascal(n-1, k)

j 		done

pascalDone:
li 		$v0, 1							# then return 1

done:
lw 		$s0, ($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$ra, 16($sp)
addu 	$sp, $sp, 16

jr 		$ra
.end pascal

#####################################################################
#  Print pascal number as per asst #5 specificiations.
#	In order to provide the correct triangle output the
#	number will need to be printed in a formatted manner.

#	This funtion uses a function to
#	    1) print the leading blanks (spc * row
#	    2) print the pascal number.

# -----
#  Arguments:
#	$a0 - n (value)
#	$a1 - pascal number (value)

#  Returns
#	nothing

.globl prtPnum
.ent prtPnum
prtPnum:

subu 	$sp, $sp, 12
sw 		$s0, ($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)

lw 		$s0, rows
li 		$s1, 0					# counter for printing leading spaces
subu 	$s0, $s0, $a0			# rows - n
beq 	$a1, 1, printLdSpc
j 		printNum
printLdSpc:

li 		$v0, 4
la 		$a0, spc
syscall

add 	$s1, $s1, 1				# i++
blt 	$s1, $s0, printLdSpc	# while(i < rows - n)

printNum:

li 		$v0, 1					# print pascal number
move 	$a0, $a1
syscall

li 		$v0, 4					# print spc1
la 		$a0, spc1
syscall

lw 		$s0, ($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
addu 	$sp, $sp, 12

jr 		$ra
.end prtPnum

#####################################################################
#  Utility function to prompt user if they
#	want to display another pascal's
#	triangle.  Expected response is Y/y/N/n.


#	YOUR CODE GOESH HERE



#####################################################################

