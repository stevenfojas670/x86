###########################################################################
#  Name: Steven Fojas
#  NSHE ID: 2001342715
#  Section: 1003
#  Assignment: MIPS3
#  Description:  


#####################################################################
#  data segment

.data

# -----
#  Data declarations for main.

aSides1:	.word	119, 117, 115, 113, 111, 119, 117, 115, 113, 111
		.word	112, 114, 116, 118, 110
cSides1:	.word	 34,  32,  31,  35,  34,  33,  32,  37,  38,  39
		.word	 32,  30,  36,  38,  30
heights1:	.word	 51,  52,  51,  55,  54,  53,  52,  57,  58,  59
		.word	 52,  50,  56,  58,  52
tAreas1:	.space	60
len1:		.word	15
estMed1:	.word	0
min1:		.word	0
med1:		.word	0
max1:		.word	0
fSum1:		.float	0.0
fAve1:		.float	0.0

aSides2:	.word	145, 155, 143, 154, 168, 159, 142, 156, 149, 141
		.word	147, 141, 157, 141, 157, 147, 147, 151, 151, 149
		.word	142, 149, 145, 149, 143, 145, 141, 142, 144, 149
		.word	146, 142, 142, 141, 146, 150, 154, 148, 158, 152
		.word	157, 147, 159, 144, 143, 144, 145, 146, 145, 144
		.word	151, 153, 146, 159, 151, 142, 150, 158, 141, 149
		.word	159, 144, 147, 149, 152, 154, 146, 148, 152, 153
		.word	142, 151, 156, 157, 146
cSides2:	.word	 42,  71,  76,  57,  45,  50,  41,  53,  42,  45
		.word	 44,  52,  44,  76,  57,  44,  46,  40,  46,  53
		.word	 52,  53,  42,  69,  44,  51,  61,  78,  46,  47
		.word	 53,  45,  51,  69,  48,  59,  62,  74,  50,  51
		.word	 40,  44,  46,  57,  54,  55,  46,  49,  48,  52
		.word	 41,  43,  44,  56,  50,  56,  75,  57,  50,  56
		.word	 42,  55,  57,  42,  47,  47,  67,  79,  48,  44
		.word	 50,  41,  43,  42,  45
heights2:	.word	 42,  51,  76,  47,  50,  50,  41,  53,  42,  45
		.word	 44,  52,  74,  46,  57,  44,  46,  40,  46,  53
		.word	 42,  43,  42,  49,  44,  51,  61,  78,  46,  57
		.word	 43,  45,  41,  49,  48,  49,  62,  74,  40,  41
		.word	 46,  44,  46,  47,  44,  45,  46,  59,  48,  62
		.word	 41,  43,  44,  46,  40,  56,  75,  47,  50,  46
		.word	 52,  45,  47,  42,  47,  47,  67,  49,  58,  44
		.word	 60,  41,  43,  42,  45
tAreas2:	.space	300
len2:		.word	75
estMed2:	.word	0
min2:		.word	0
med2:		.word	0
max2:		.word	0
fSum2:		.float	0.0
fAve2:		.float	0.0

aSides3:	.word	143, 142, 141, 141, 141, 144, 142, 146, 158, 143
		.word	142, 149, 145, 149, 141, 155, 149, 142, 144, 149
		.word	140, 144, 146, 157, 144, 135, 146, 129, 148, 142
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	169, 174, 127, 179, 152, 141, 144, 156, 142, 133
		.word	141, 153, 154, 146, 140, 156, 175, 167, 150, 146
		.word	154, 155, 145, 162, 152, 141, 142, 156, 156, 143
		.word	168, 159, 151, 142, 153, 141, 176, 151, 149, 156
		.word	146, 179, 149, 137, 146, 154, 154, 156, 164, 142
cSides3:	.word	 71,  48,  55,  43,  52,  40,  58,  71,  54,  52
		.word	 35,  62,  76,  52,  53,  59,  56,  42,  58,  41
		.word	 72,  45,  46,  47,  45,  34,  46,  30,  56,  53
		.word	 53,  42,  31,  31,  51,  34,  42,  46,  58,  53
		.word	 52,  59,  45,  39,  51,  45,  39,  42,  44,  49
		.word	 50,  44,  46,  77,  54,  25,  26,  29,  48,  62
		.word	 41,  43,  46,  49,  51,  52,  54,  58,  41,  65
		.word	 69,  74,  39,  52,  77,  44,  46,  51,  52,  53
		.word	 41,  53,  34,  36,  40,  56,  75,  47,  40,  46
heights3:	.word	 71,  73,  34,  56,  50,  56,  75,  57,  60,  26
		.word	 54,  65,  65,  62,  72,  81,  62,  76,  76,  73
		.word	 32,  79,  61,  42,  73,  41,  76,  41,  69,  56
		.word	 56,  39,  39,  57,  76,  34,  74,  56,  64,  62
		.word	 71,  78,  45,  63,  42,  70,  58,  71,  54,  42
		.word	 65,  62,  56,  32,  73,  29,  36,  32,  58,  41
		.word	 42,  55,  56,  57,  75,  54,  86,  39,  66,  53
		.word	 73,  52,  41,  31,  71,  74,  62,  76,  58,  43
		.word	 52,  70,  65,  69,  61,  65,  59,  62,  64,  59
tAreas3:	.space	360
len3:		.word	90
estMed3:	.word	0
min3:		.word	0
med3:		.word	0
max3:		.word	0
fSum3:		.float	0.0
fAve3:		.float	0.0

aSides4:	.word	145, 144, 143, 157, 153, 154, 154, 156, 164, 142
		.word	166, 152, 152, 151, 146, 150, 154, 178, 188, 192
		.word	182, 195, 157, 152, 157, 147, 167, 179, 188, 194
		.word	154, 152, 174, 186, 197, 154, 156, 150, 156, 153
		.word	152, 151, 156, 187, 190, 150, 151, 153, 152, 145
		.word	157, 187, 199, 151, 153, 154, 155, 156, 175, 194
		.word	149, 156, 162, 151, 157, 177, 199, 197, 175, 154
		.word	164, 141, 142, 153, 166, 154, 146, 153, 156, 163
		.word	151, 158, 177, 143, 178, 152, 151, 150, 155, 150
		.word	157, 144, 150, 172, 154, 155, 156, 162, 158, 192
		.word	153, 152, 146, 176, 151, 156, 164, 165, 195, 156
		.word	157, 153, 153, 140, 155, 151, 154, 158, 153, 152
		.word	169, 156, 162, 127, 157, 157, 159, 177, 175, 154
		.word	181, 155, 155, 152, 157, 155, 150, 159, 152, 154
		.word	161, 152, 151, 152, 171, 159, 154, 152, 155, 151
cSides4:	.word	 53,  52,  46,  76,  50,  56,  64,  65,  55,  56
		.word	 71,  47,  50,  27,  74,  65,  51,  67,  81,  59
		.word	 53,  52,  46,  56,  50,  56,  64,  56,  55,  52
		.word	 51,  83,  53,  50,  55,  89,  55,  58,  53,  55
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 27,  64,  50,  72,  54,  55,  56,  62,  58,  92
		.word	 51,  83,  53,  50,  57,  51,  55,  58,  53,  55
		.word	 57,  26,  62,  57,  57,  77,  99,  77,  75,  54
		.word	 94,  54,  52,  43,  76,  54,  56,  52,  56,  63
		.word	 54,  59,  52,  83,  50,  61,  92,  59,  59,  52
		.word	 55,  56,  62,  57,  57,  57,  59,  77,  75,  44
		.word	 79,  53,  56,  40,  55,  52,  54,  58,  53,  52
		.word	 61,  72,  51,  53,  56,  69,  54,  52,  55,  51
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 49,  44,  54,  54,  67,  43,  59,  61,  65,  56
heights4:	.word	 53,  53,  53,  50,  55,  59,  43,  48,  53,  55
		.word	 51,  55,  57,  23,  66,  68,  71,  77,  94,  96
		.word	 52,  59,  55,  59,  51,  55,  59,  42,  44,  49
		.word	 41,  43,  46,  59,  51,  52,  54,  58,  61,  65
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  92,  93
		.word	 52,  59,  55,  59,  51,  55,  59,  52,  34,  39
		.word	 52,  54,  58,  61,  65,  51,  52,  52,  71,  59
		.word	 69,  24,  77,  79,  82,  84,  86,  88,  92,  93
		.word	 50,  54,  56,  57,  54,  55,  56,  59,  48,  92
		.word	 45,  75,  55,  52,  57,  55,  50,  59,  52,  34
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  92,  43
		.word	 50,  51,  54,  59,  50,  55,  61,  74,  88,  93
		.word	 51,  53,  54,  56,  50,  56,  75,  87,  90,  96
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 55,  52,  56,  55,  40,  57,  63,  79,  82,  54
len4:		.word	150
tAreas4:	.space	600
estMed4:	.word	0
min4:		.word	0
med4:		.word	0
max4:		.word	0
fSum4:		.float	0.0
fAve4:		.float	0.0

aSides5:	.word	152, 159, 155, 159, 151, 155, 159, 152, 144, 149
		.word	162, 165, 157, 152, 157, 147, 167, 159, 168, 174
		.word	159, 154, 156, 157, 154, 155, 156, 159, 148, 172
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	159, 153, 154, 156, 140, 156, 175, 187, 155, 156
		.word	152, 151, 176, 187, 170, 150, 151, 153, 152, 145
		.word	147, 153, 153, 140, 165, 151, 154, 158, 153, 152
		.word	151, 153, 154, 156, 140, 156, 175, 187, 160, 196
		.word	134, 152, 174, 186, 167, 154, 156, 150, 156, 153
		.word	182, 165, 157, 152, 157, 147, 167, 179, 168, 194
		.word	159, 151, 159, 151, 149, 151, 169, 171, 169, 191
		.word	153, 153, 153, 150, 155, 159, 143, 148, 153, 155
		.word	151, 155, 157, 163, 166, 168, 171, 177, 164, 176
		.word	152, 159, 155, 159, 151, 155, 159, 142, 144, 149
		.word	141, 143, 146, 149, 151, 152, 154, 158, 161, 165
		.word	152, 159, 155, 159, 151, 155, 159, 152, 154, 159
		.word	152, 154, 158, 161, 165
cSides5:	.word	 69,  74,  77,  79,  72,  84,  86,  88,  62,  73
		.word	 50,  54,  56,  57,  54,  55,  56,  59,  48,  72
		.word	 45,  75,  55,  52,  57,  55,  50,  59,  52,  54
		.word	 50,  51,  54,  59,  40,  55,  61,  74,  88,  73
		.word	 51,  53,  54,  56,  40,  56,  75,  87,  70,  76
		.word	 94,  54,  54,  43,  76,  54,  56,  52,  56,  63
		.word	 54,  52,  57,  86,  77,  54,  56,  50,  36,  53
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  72,  73
		.word	 55,  52,  56,  55,  40,  57,  63,  79,  82,  74
		.word	 56,  52,  52,  51,  46,  50,  54,  78,  88,  72
		.word	 57,  57,  57,  57,  47,  57,  67,  77,  87,  77
		.word	 57,  87,  99,  51,  53,  54,  55,  56,  75,  74
		.word	 54,  52,  74   86,  97,  54,  56,  50,  36,  53
		.word	 82,  65,  57,  52,  57,  47,  67,  79,  88,  74
		.word	 69,  74,  77,  79,  82,  84,  86,  88,  62,  73
		.word	 59,  51,  59,  31,  49,  51,  69,  71,  79,  71
		.word	 41,  43,  46,  49,  51
heights5:	.word	 52,  51,  56,  87,  60,  50,  51,  53,  52,  45
		.word	 57,  87,  69,  51,  53,  54,  55,  56,  75,  64
		.word	 49,  56,  62,  51,  57,  77,  69,  67,  75,  54
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 51,  58,  77,  43,  78,  52,  51,  50,  55,  50
		.word	 57,  44,  50,  72,  54,  55,  56,  62,  58,  62
		.word	 53,  52,  46,  76,  51,  56,  64,  65,  35,  56
		.word	 57,  53,  53,  50,  55,  51,  54,  58,  53,  52
		.word	 69,  56,  62,  57,  57,  57,  59,  77,  75,  54
		.word	 81,  55,  55,  52,  57,  55,  50,  59,  52,  54
		.word	 61,  52,  51,  52,  71,  59,  54,  52,  55,  51
		.word	 53,  52,  46,  76,  50,  56,  64,  65,  55,  56
		.word	 71,  47,  50,  57,  74,  65,  51,  67,  31,  59
		.word	 53,  52,  46,  56,  50,  56,  64,  56,  55,  52
		.word	 51,  83,  53,  50,  55,  89,  55,  58,  53,  55
		.word	 64,  41,  42,  53,  66,  54,  46,  53,  56,  63
		.word	 57,  64,  50,  72,  54
tAreas5:	.space	660
len5:		.word	165
estMed5:	.word	0
min5:		.word	0
med5:		.word	0
max5:		.word	0
fSum5:		.float	0.0
fAve5:		.float	0.0


# -----
#  Variables for main.

asstHeader:	.ascii	"\nMIPS Assignment #3\n"
		.asciiz	"Trapezoid Areas Program\n\n"

# -----
#  Local variables/constants for prtHeaders() function.

hdr_nm:		.ascii	"\n*******************************************************************"
		.asciiz	"\nData Set #"
hdr_ln:		.asciiz	"\nLength: "
hdr_sr:		.asciiz	"\n\nTrapezoid Areas: \n"


# -----
#  Variables/constants for trapAreas() function.


# -----
#  Variables/constants for combSort() function.

TRUE = 1	
FALSE = 0

# -----
#  Variables/constants for trapStats() function.


# -----
#  Variables/constants for showTrapStats() function.

spc:		.asciiz	"     "
new_ln:		.asciiz	"\n"

str1:		.asciiz "\n sum = "
str2:		.asciiz	"\n ave = "
str3:		.asciiz	"\n min = "
str4:		.asciiz	"\n med = "
str5:		.asciiz	"\n max = "
str6:		.asciiz	"\n est med = "
str7:		.asciiz	"\n pct diff = "


#####################################################################
#  text/code segment

# -----
#  Basic flow:
#	for each data set:
#	  * display headers
#	  * find trapezoid areas
#	  * find estimated median
#	  * sort trapezoid areas
#	  * find trapezoid stats (sum, average, min, med, max, est med)
#	  * display trapezoid areas and stats

.text
.globl	main
.ent main
main:

# ----------------------------
#  Display Program Header.

	la	$a0, asstHeader
	li	$v0, 4
	syscall					# print header
	li	$s0, 1				# counter, data set number

# ----------------------------
#  Data Set #1

	move	$a0, $s0
	lw	$a1, len1
	jal	prtHeaders

	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides1
	la	$a1, cSides1
	la	$a2, heights1
	lw	$a3, len1
	la	$t0, tAreas1
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas1
	lw	$a1, len1
	jal	estMedian

	sw	$v0, estMed1

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas1
	lw	$a1, len1
	jal	oddEvenSort

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas1			# arg 1
	lw	$a1, len1			# arg 2
	la	$a2, fSum1			# arg 3
	la	$a3, fAve1			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min1
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med1
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max1
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas1			# arg 1
	lw	$a1, len1			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum1			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve1
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min1
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med1
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max1
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed1
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #2

	move	$a0, $s0
	lw	$a1, len2
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides2
	la	$a1, cSides2
	la	$a2, heights2
	lw	$a3, len2
	la	$t0, tAreas2
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas2
	lw	$a1, len2
	jal	estMedian

	sw	$v0, estMed2

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas2
	lw	$a1, len2
	jal	oddEvenSort

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas2			# arg 1
	lw	$a1, len2			# arg 2
	la	$a2, fSum2			# arg 3
	la	$a3, fAve2			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min2
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med2
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max2
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas2			# arg 1
	lw	$a1, len2			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum2			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve2
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min2
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med2
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max2
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed2
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #3

	move	$a0, $s0
	lw	$a1, len3
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides3
	la	$a1, cSides3
	la	$a2, heights3
	lw	$a3, len3
	la	$t0, tAreas3
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas3
	lw	$a1, len3
	jal	estMedian

	sw	$v0, estMed3

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas3
	lw	$a1, len3
	jal	oddEvenSort

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas3			# arg 1
	lw	$a1, len3			# arg 2
	la	$a2, fSum3			# arg 3
	la	$a3, fAve3			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min3
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med3
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max3
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas3			# arg 1
	lw	$a1, len3			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum3			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve3
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min3
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med3
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max3
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed3
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #4

	move	$a0, $s0
	lw	$a1, len4
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides4
	la	$a1, cSides4
	la	$a2, heights4
	lw	$a3, len4
	la	$t0, tAreas4
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas4
	lw	$a1, len4
	jal	estMedian

	sw	$v0, estMed4

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas4
	lw	$a1, len4
	jal	oddEvenSort

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas4			# arg 1
	lw	$a1, len4			# arg 2
	la	$a2, fSum4			# arg 3
	la	$a3, fAve4			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min4
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med4
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max4
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas4			# arg 1
	lw	$a1, len4			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum4			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve4
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min4
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med4
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max4
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed4
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# ----------------------------
#  Data Set #5

	move	$a0, $s0
	lw	$a1, len5
	jal	prtHeaders
	add	$s0, $s0, 1

#  Find trapezoid areas
#	trapAreas(aSides, cSides, heights, len, tAreas)

	la	$a0, aSides5
	la	$a1, cSides5
	la	$a2, heights5
	lw	$a3, len5
	la	$t0, tAreas5
	sub	$sp, $sp, 4
	sw	$t0, ($sp)
	jal	trapAreas
	add	$sp, $sp, 4

#  Get estimated median (before sort).
#	ans = estMedian(tAreas, len)

	la	$a0, tAreas5
	lw	$a1, len5
	jal	estMedian

	sw	$v0, estMed5

#  Sort tAreas[] array
#	combSort(tAreas, len)

	la	$a0, tAreas5
	lw	$a1, len5
	jal	oddEvenSort

#  Generate trapezoid areas stats
#	trapStats(tAreas, len, fSum, fAve, min, med, max)

	la	$a0, tAreas5			# arg 1
	lw	$a1, len5			# arg 2
	la	$a2, fSum5			# arg 3
	la	$a3, fAve5			# arg 4
	subu	$sp, $sp, 12
	la	$t0, min5
	sw	$t0, ($sp)			# arg 5, on stack
	la	$t0, med5
	sw	$t0, 4($sp)			# arg 6, on stack
	la	$t0, max5
	sw	$t0, 8($sp)			# arg 7, on stack
	jal	trapStats

	addu	$sp, $sp, 12			# clear stack

#  show final results
#	showTrapStats(tAreas, len, fSum, fAve, min, med, max, estMed)

	la	$a0, tAreas5			# arg 1
	lw	$a1, len5			# arg 2
	subu	$sp, $sp, 24
	l.s	$f6, fSum5			# arg 3, on stack
	s.s	$f6, ($sp)
	l.s	$f6, fAve5
	s.s	$f6, 4($sp)			# arg 4, on stack
	lw	$t0, min5
	sw	$t0, 8($sp)			# arg 5, on stack
	lw	$t0, med5
	sw	$t0, 12($sp)			# arg 6, on stack
	lw	$t0, max5
	sw	$t0, 16($sp)			# arg 7, on stack
	lw	$t0, estMed5
	sw	$t0, 20($sp)			# arg 8, on stack
	jal	showTrapStats

	addu	$sp, $sp, 24			# clear stack

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...
.end

#####################################################################
#  Display headers.

.globl	prtHeaders
.ent	prtHeaders
prtHeaders:
	sub	$sp, $sp, 8
	sw	$s0, ($sp)
	sw	$s1, 4($sp)

	move	$s0, $a0
	move	$s1, $a1

	la	$a0, hdr_nm
	li	$v0, 4
	syscall

	move	$a0, $s0
	li	$v0, 1
	syscall

	la	$a0, hdr_ln
	li	$v0, 4
	syscall

	move	$a0, $s1
	li	$v0, 1
	syscall

	lw	$s0, ($sp)
	lw	$s1, 4($sp)
	add	$sp, $sp, 4

	jr	$ra
.end	prtHeaders

#####################################################################
#  Find estimated median (first, last, and middle two).

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	$v0, estimated median

.globl estMedian
.ent estMedian
estMedian:



#	YOUR CODE GOES HERE



.end estMedian

#####################################################################
#  Find trapezoid araes, tAreas[]

#    Arguments:
#	$a0   - starting address of the aSides array
#	$a1   - starting address of the cSides array
#	$a2   - starting address of the heights array
#	$a3   - length
#	($fp) - starting address of the tAreas array

#    Returns:
#	tAreas areas array via passed address

.globl	trapAreas
trapAreas:



#	YOUR CODE GOES HERE



.end trapAreas

#####################################################################
#  Sort a list of numbers using even/odd sort.
#  MUST use even/odd sort.

# ******************************
#  function oddEvenSort(list) {
#	bool sorted = false#

#	while (!sorted) {
#		sorted = true;
#		for (var i=1; i < len-1; i+=2) {
#			if (list[i] > list[i+1]) {
#			swap(list, i, i+1);
#			sorted = false;
#			}
#		}
#		for (var i=0; i < len-1; i+=2) {
#			if (list[i] > list[i+1]) {
#				swap(list, i, i+1);
#				sorted = false;
#			}
#		}
#	}
#  }

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length

#    Returns:
#	sorted list (via passed address)

.globl oddEvenSort
.ent oddEvenSort
oddEvenSort:



#	YOUR CODE GOES HERE



.end oddEvenSort

#####################################################################
#  MIPS assembly language function, trapStats(), that will
#    find the sum, average, minimum, maximum, and median of the list.
#    The average is returned as floating point value.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length
#	$a2 - addr of fSum
#	$a3 - addr of fAve
#	($fp) - addr of min
#	4($fp) - addr of med
#	8($fp) - addr of max

#    Returns (via addresses):
#	fSum
#	fAve
#	min
#	max
#	med

.globl trapStats
.ent trapStats
trapStats:



#	YOUR CODE GOES HERE



.end trapStats

#####################################################################
#  MIPS assembly language function, showTrapStats(), to display
#    the tAreas and the statistical information:
#	sum (float), average (float), minimum, median, maximum,
#	estimated median in the presribed format.
#    The numbers should be printed seven (7) per line (see example).

#  Note, due to the system calls, the saved registers must
#        be used.  As such, push/pop saved registers altered.

# -----
#    Arguments:
#	$a0 - starting address of the list
#	$a1 - list length
#	($fp) - sum (float)
#	4($fp) - average (float)
#	8($fp) - min
#	12($fp) - med
#	16($fp) - max
#	20($fp) - est median

#    Returns:
#	N/A

.globl	showTrapStats
.ent	showTrapStats
showTrapStats:



#	YOUR CODE GOES HERE



.end showTrapStats

#####################################################################

