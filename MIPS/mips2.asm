###########################################################################
#  Name: Steven Fojas
#  NSHE ID: 2001342715
#  Section: 1003
#  Assignment: MIPS #2
#  Description: calculating volumes from 3 different arrays and placing the value into a volume
# array. Finding min, max, estmed, sum and average



###########################################################
#  data segment

.data

lengths:
	.word	  327,   344,   310,   372,   324 
	.word	  325,   316,   362,   328,   392 
	.word	  317,   314,   315,   372,   324 
	.word	  325,   316,   362,   338,   392 
	.word	  321,   383,   333,   330,   337 
	.word	  342,   335,   358,   323,   335 
	.word	  327,   326,   326,   327,   227 
	.word	  357,   387,   399,   311,   323 
	.word	  324,   325,   326,   375,   394 
	.word	  349,   326,   362,   331,   327 
	.word	  377,   399,   397,   375,   314 
	.word	  364,   341,   342,   373,   366 
	.word	  304,   346,   323,   356,   363 
	.word	  321,   318,   377,   343,   378 
	.word	  312,   311,   310,   335,   310 
	.word	  377,   399,   377,   375,   314 
	.word	  394,   324,   312,   343,   376 
	.word	  334,   326,   332,   356,   363 
	.word	  324,   319,   322,   383,   310 
	.word	  391,   392,   329,   329,   322 

widths:
	.word	  226,   252,   257,   267,   234 
	.word	  217,   254,   217,   225,   253 
	.word	  223,   273,   235,   261,   259 
	.word	  225,   224,   263,   247,   223 
	.word	  234,   234,   256,   264,   242 
	.word	  233,   214,   273,   231,   255 
	.word	  264,   273,   274,   223,   256 
	.word	  244,   252,   231,   242,   256 
	.word	  255,   224,   236,   275,   246 
	.word	  253,   223,   253,   267,   235 
	.word	  254,   229,   264,   267,   234 
	.word	  256,   253,   264,   253,   265 
	.word	  236,   252,   232,   231,   246 
	.word	  250,   254,   278,   288,   292 
	.word	  282,   295,   247,   252,   257 
	.word	  257,   267,   279,   288,   294 
	.word	  234,   252,   274,   286,   297 
	.word	  244,   276,   242,   236,   253 
	.word	  232,   251,   236,   287,   290 
	.word	  220,   241,   223,   232,   245 

heights:
	.word	  124,   119,   122,   183,   110
	.word	  191,   192,   129,   129,   122
	.word	  135,   226,   162,   137,   127
	.word	  127,   159,   177,   175,   144
	.word	  179,   153,   136,   140,   235
	.word	  117,   114,   115,   172,   124
	.word	  125,   116,   162,   138,   192
	.word	  111,   183,   133,   130,   127
	.word	  111,   115,   158,   113,   115
	.word	  117,   126,   116,   117,   227
	.word	  177,   199,   177,   175,   114
	.word	  194,   124,   112,   143,   176
	.word	  134,   126,   132,   156,   163
	.word	  112,   154,   128,   113,   132
	.word	  161,   192,   151,   213,   126
	.word	  269,   114,   122,   115,   131
	.word	  194,   124,   114,   143,   176
	.word	  134,   126,   122,   156,   163
	.word	  149,   144,   114,   134,   167
	.word	  143,   129,   161,   165,   136

len:	.word	100 

volumes:
	.space	400 

vMin:	.word	0 
vMid:	.word	0 
vMax:	.word	0 
vSum:	.word	0 
vAve:	.word	0 

# -----

hdr:	.ascii	"MIPS Assignment #2 \n"
	.ascii	"  Rectangular Prism Volumes Program:\n"
	.ascii	"  Also finds minimum, middle value, maximum, sum,"
	.asciiz	" and average for the volumes.\n\n"

a1_st:	.asciiz	"\nVolumes Minimum      = "
a2_st:	.asciiz	"\nVolumes Est. Median  = "
a3_st:	.asciiz	"\nVolumes Maximum      = "
a4_st:	.asciiz	"\nVolumes Sum          = "
a5_st:	.asciiz	"\nVolumes Average      = "

newLn:	.asciiz	"\n"
blnks:	.asciiz	"  "


###########################################################
#  text/code segment

# --------------------
#  Compute volumes.
#  Then find middle, max, sum, and average for the volumes.

.text
.globl main
.ent main
main:

# ******************************
#  Display header.

	la	$a0, hdr
	li	$v0, 4
	syscall				# print header

# ******************************




#	YOUR CODE GOES HERE
la 		$t0, lengths			# lengths array address
la 		$t1, widths				# widths array address
la 		$t2, heights			# heights array address
lw 		$t3, len				# length
li 		$t4, 0					# counter
la 		$s1, volumes			# volumes array address

# retrieving the volume and placing it into the volumes array

volumeLoop:

li 		$s0, 0					# resetting volume each iteration
lw 		$t5, ($t0)
lw 		$t6, ($t1)
lw 		$t7, ($t2)

mul 	$s0, $t5, $t6			# length * width
mul 	$s0, $s0, $t7			# volume = length * width * heights

sw 		$s0, ($s1)				# saving volume into volumes[i]

add 	$t4, $t4, 1				# i++
add 	$t0, $t0, 4				# increasing lengths index
add 	$t1, $t1, 4				# increasing widths index
add 	$t2, $t2, 4				# increasing heights index
add 	$s1, $s1, 4				# increasing volumes index

blt 	$t4, $t3, volumeLoop

# find min, estMed, max, sum, and avg
# (ODD) Est Med will be first, last and middle value / 3
# (EVEN) Est Med will be the first, last and two middle values / 4

la 		$t0, volumes		# volumes
li 		$t1, 0				# counter
lw 		$t2, len 			# length
lw 		$t3, ($t0)			# min
lw 		$t4, ($t0)			# max
li	 	$t6, 0				# sum

calcLoop:

lw 		$t5, ($t0)
add 	$t6, $t6, $t5		# sum = sum + volumes[i]
sw 		$t6, vSum

bgt 	$t3, $t5, swapMin	# if min > volumes[i] then swap
j 		checkMax

swapMin:
move 	$t3, $t5			# min = volumes[i]
sw 		$t3, vMin
j 		skip

checkMax:
blt 	$t4, $t5, swapMax	# if max < volumes[i] then swap
j 		skip

swapMax:
move 	$t4, $t5			# max = volumes[i]
sw 		$t4, vMax

skip:
add 	$t1, $t1, 1			# counter++
add 	$t0, $t0, 4			# increasing volumes array

blt 	$t1, $t2, calcLoop	# if counter < len then reloop

# calc average

div 	$t6, $t6, $t1		# ave = sum / len
sw 		$t6, vAve

la 		$t0, volumes		# reloading volumes address into $t0
rem 	$t6, $t1, 2			# counter % 2 == 0 ? isEven : isOdd
beq 	$t6, 0, isEven
j 		isOdd
isEven:

# get first
# get middle 
# middle 2
# get last

la 		$t0, volumes
lw 		$t1, len

lw 		$t2, ($t0)
mul 	$t1, $t1, 4
sub 	$t1, $t1, 4
add 	$t0, $t0, $t1
lw 		$t3, ($t0)
add 	$t2, $t2, $t3			# first + last

la 		$t0, volumes
lw 		$t1, len

div 	$t1, $t1, 2				# len / 2
mul 	$t1, $t1, 4
sub 	$t1, $t1, 4				# gets actual middle
add 	$t0, $t0, $t1
lw 		$t4, ($t0)				# middle1

add 	$t0, $t0, 4
lw 		$t5, ($t0)				# middle2

add 	$t4, $t4, $t5			# mid1 + mid2

add 	$t2, $t2, $t4
div 	$t2, $t2, 4
sw 		$t2, vMid

j		done

isOdd:



done:

la 		$s0, volumes
li 		$s1, 0
lw 		$s2, len

printLoop:

li 		$v0, 4
la 		$a0, blnks
syscall

li 		$v0, 1
lw 		$a0, ($s0)
syscall

addu 	$s0, $s0, 4
add 	$s1, $s1, 1

rem 	$t0, $s1, 8
bnez 	$t0, skipNewLine

li 		$v0, 4
la 		$a0, newLn
syscall

skipNewLine:
bne 	$s1, $s2, printLoop

# ******************************
#  Display results.

	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

#  Print min message followed by result.

	la	$a0, a1_st
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, vMin
	li	$v0, 1
	syscall				# print min

# -----
#  Print middle message followed by result.

	la	$a0, a2_st
	li	$v0, 4
	syscall				# print "est med = "

	lw	$a0, vMid
	li	$v0, 1
	syscall				# print mid

# -----
#  Print max message followed by result.

	la	$a0, a3_st
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, vMax
	li	$v0, 1
	syscall				# print max

# -----
#  Print sum message followed by result.

	la	$a0, a4_st
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, vSum
	li	$v0, 1
	syscall				# print sum

# -----
#  Print average message followed by result.

	la	$a0, a5_st
	li	$v0, 4
	syscall				# print "ave = "

	lw	$a0, vAve
	li	$v0, 1
	syscall				# print average

# -----
#  Done, terminate program.

endit:
	la	$a0, newLn		# print a newline
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall				# all done!

.end main

