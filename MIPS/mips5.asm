###########################################################################
#  Name: Steven Fojas
#  NSHE ID: 2001342715	
#  Section: 1003
#  Assignment: MIPS5
#  Description:  Understanding recursion through the implementation of Pascal's triangle



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

rows:	.word	0

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
	jal	readRows
	sw	$v0, rows

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

subu 	$sp, $sp, 32
sw 		$s0, 0($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$s4, 16($sp)
sw 		$s5, 20($sp)
sw 		$ra, 24($sp)
sw 		$fp, 28($sp)
addu 	$fp, $sp, 32

move 	$s4, $a0
li 		$s0, 0							# i
printLine:								# for(int i = 0; i < rows; i++)

	li 		$v0, 4						# printing row labels
	la 		$a0, rmsg1
	syscall

	li 		$v0, 1
	move 	$a0, $s0
	syscall

	li 		$v0, 4	
	la 		$a0, rmsg2
	syscall

	li 		$s1, 0						# j

	printRow:							# for(int j = 0; j <= i; j++)				
	move 	$a0, $s0					# call pascal($s0, $s1) - $s0 is n which is current row, $s1 is k
	move 	$a1, $s1
	jal 	pascal
	move 	$s5, $v0					# saving the pascal number

	# print leading blanks
	move 	$s2, $s4					# getting rows
	sub 	$s2, $s2, $s0				# rows - currentRow
	li 		$s3, 0						# counter for printing leading spaces
	beq 	$s1, 0, printLeadingSpaces	# if (j == 0) then print leading spaces
	j 		callprtPnum

	printLeadingSpaces:					# for(int i = 0; i <= rows - currentRow; i++)

		li 		$v0, 4
		la 		$a0, spc
		syscall

		add 	$s3, $s3, 1
		blt 	$s3, $s2, printLeadingSpaces

	callprtPnum:				
	move 	$a0, $s0					# call prtPnum(n, $v0) - $v0 is the number returned from pascal(n, k)
	move 	$a1, $s5
	jal 	prtPnum		

	add 	$s1, $s1, 1
	ble 	$s1, $s0, printRow			# if(j <= i)

	li 		$v0, 4
	la 		$a0, nline
	syscall

add 	$s0, $s0, 1
blt 	$s0, $s4, printLine				# if(i < rows)

lw 		$s0, 0($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$s4, 16($sp)
lw 		$s5, 20($sp)
lw 		$ra, 24($sp)
lw 		$fp, 28($sp)
addu 	$sp, $sp, 32

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
sw 		$s0, 0($sp)
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
lw 		$s0, 0($sp)
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

subu 	$sp, $sp, 24
sw 		$s0, 0($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$ra, 16($sp)
sw		$fp, 20($sp)
addu 	$fp, $sp, 24

move 	$s0, $a0						# saving n
move 	$s1, $a1 						# saving k

# base case
beq 	$s1, 0, pascalDone				# if k = 0
beq 	$s1, $a0, pascalDone			# if k = n

# Pascal(n - 1, k - 1)
sub 	$s2, $s0, 1						# n - 1
move 	$a0, $s2
sub 	$s2, $s1, 1 					# k - 1
move 	$a1, $s2
jal 	pascal
move 	$s3, $v0						# saving Pascal(n - 1, k - 1)

# Pascal (n - 1, k)
sub 	$s2, $s0, 1						# n - 1
move 	$a0, $s2
move 	$a1, $s1						# k
jal 	pascal

add 	$v0, $v0, $s3					# Pascal(n - 1, k - 1) + Pascal(n - 1, k)

j 		done

pascalDone:
li 		$v0, 1							# then return 1

done:
lw 		$s0, 0($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$ra, 16($sp)
lw 		$fp, 20($sp)
addu 	$sp, $sp, 24

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

subu 	$sp, $sp, 32
sw 		$s0, 0($sp)
sw 		$s1, 4($sp)
sw 		$s2, 8($sp)
sw 		$s3, 12($sp)
sw 		$s4, 16($sp)
sw 		$s5, 20($sp)
sw		$ra, 24($sp)
sw 		$fp, 28($sp)
addu 	$fp, $sp, 32

move 	$s0, $a0				# saving n
move 	$s1, $a1 				# saving pascal number

# leading blanks will be printed in the display function

li 		$v0, 1				# printing the number
move 	$a0, $s1
syscall

li 		$s4, 0
li 		$s5, 6				# max space
move 	$s2, $s1			# getting pascal number
li 		$s3, 0 				# digit counter

getDigits:
div 	$s2, $s2, 10		# dividing the pascal number by 10 to get the amount of digits
add 	$s3, $s3, 1			# counts the digits
bnez 	$s2, getDigits		# if (pascalNum / 10 != 0) then keep looping

sub 	$s5, $s5, $s3		# max spaces = max spaces - digit count

displaySpaces:
li 		$v0, 4
la 		$a0, spc1
syscall

add 	$s4, $s4, 1
blt 	$s4, $s5, displaySpaces
skipSpaces:
lw 		$s0, 0($sp)
lw 		$s1, 4($sp)
lw 		$s2, 8($sp)
lw 		$s3, 12($sp)
lw 		$s4, 16($sp)
lw 		$s5, 20($sp)
lw		$ra, 24($sp)
lw 		$fp, 28($sp)
addu 	$sp, $sp, 32

jr 		$ra
.end prtPnum

#####################################################################
#  Utility function to prompt user if they
#	want to display another pascal's
#	triangle.  Expected response is Y/y/N/n.


#	YOUR CODE GOESH HERE
.globl checkAgain
.ent checkAgain
checkAgain:

subu 	$sp, $sp, 8
sw 		$s0, 0($sp)
sw 		$s1, 4($sp)

retryPrompt:
li 		$v0, 4
la 		$a0, ask
syscall

li 		$v0, 8						# syscall to get yes or no for another game
la 		$a0, uAns
li 		$a1, 3
syscall

la 		$s0, uAns
lb 		$s1, ($s0)

bne 	$s1, 89, checky				# if(input != "Y")
j 		tryAgain
checky:
bne 	$s1, 121, checkN			# if(input != "y")
j 		tryAgain
checkN:
bne 	$s1, 78, checkn				# if(input != "N")
j 		gameOver
checkn:
bne 	$s1, 110, error				# if(input != "n")
j 		gameOver

error:
li 		$v0, 4
la 		$a0, badAns
syscall
j 		retryPrompt

tryAgain:
li 		$v0, TRUE					# retry the game
j 		checkComplete

gameOver:
li 		$v0, 4						# end game
la 		$a0, dMsg
syscall 	

li 		$v0, FALSE
j 		checkComplete

checkComplete:

lw 		$s0, 0($sp)
lw 		$s1, 4($sp)
addu 	$sp, $sp, 8

jr 		$ra
.end checkAgain

#####################################################################

