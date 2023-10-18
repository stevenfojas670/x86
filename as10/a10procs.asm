; *****************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 10
;  Description:  Working with floating point, sys calls, and openGL

; -----
;  Function: getRadii
;	Gets, checks, converts, and returns command line arguments.

;  Function: drawSpiro()
;	Plots spirograph formulas

; ---------------------------------------------------------

;	MACROS (if any) GO HERE

; ---------------------------------------------------------

section  .data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; successful operation
NOSUCCESS	equ	1

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; code for read
SYS_write	equ	1			; code for write
SYS_open	equ	2			; code for file open
SYS_close	equ	3			; code for file close
SYS_fork	equ	57			; code for fork
SYS_exit	equ	60			; code for terminate
SYS_creat	equ	85			; code for file open/create
SYS_time	equ	201			; code for get time

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

; -----
;  OpenGL constants

GL_COLOR_BUFFER_BIT	equ	16384
GL_POINTS		equ	0
GL_POLYGON		equ	9
GL_PROJECTION		equ	5889

GLUT_RGB		equ	0
GLUT_SINGLE		equ	0

; -----
;  Define program specific constants.

R1_MIN		equ	0
R1_MAX		equ	250			; 250(10) = 1054(6)

R2_MIN		equ	1			; 1(10) = 1(13)
R2_MAX		equ	250			; 250(10) = 1054(6)

OP_MIN		equ	1			; 1(10) = 1(13)
OP_MAX		equ	250			; 250(10) = 1054(6)

SP_MIN		equ	1			; 1(10) = 1(13)
SP_MAX		equ	100			; 100(10) = 244(6)

X_OFFSET	equ	320
Y_OFFSET	equ	240

; -----
;  Variables for getRadii procedure.

errUsage	db	"Usage:  ./spiro -r1 <senary number> "
		db	"-r2 <senary number> -op <senary number> "
		db	"-sp <senary number> -cl <b/g/r/y/p/w>"
		db	LF, NULL
errBadCL	db	"Error, invalid or incomplete command line arguments."
		db	LF, NULL

errR1sp		db	"Error, radius 1 specifier incorrect."
		db	LF, NULL
errR1value	db	"Error, radius 1 value must be between 0 and 1054(6)."
		db	LF, NULL

errR2sp		db	"Error, radius 2 specifier incorrect."
		db	LF, NULL
errR2value	db	"Error, radius 2 value must be between 1 and 1054(6)."
		db	LF, NULL

errOPsp		db	"Error, offset position specifier incorrect."
		db	LF, NULL
errOPvalue	db	"Error, offset position value must be between 1 and 1054(6)."
		db	LF, NULL

errSPsp		db	"Error, speed specifier incorrect."
		db	LF, NULL
errSPvalue	db	"Error, speed value must be between 1 and 244(6)."
		db	LF, NULL

errCLsp		db	"Error, color specifier incorrect."
		db	LF, NULL
errCLvalue	db	"Error, color value must be b, g, r, p, or w. "
		db	LF, NULL

; -----
;  Variables for spirograph routine.

fltOne		dd	1.0
fltZero		dd	0.0
fltTmp1		dd	0.0
fltTmp2		dd	0.0

t		dd	0.0			; loop variable
s		dd	1.0			; phase variable
tStep		dd	0.005			; t step
sStep		dd	0.0			; s step
x		dd	0			; current x
y		dd	0			; current y

r1		dd	0.0			; radius 1 (float)
r2		dd	0.0			; radius 2 (float)
ofp		dd	0.0			; offset position (float)
radii		dd	0.0			; tmp location for (radius1+radius2)

scale		dd	5000.0			; speed scale
limit		dd	360.0			; for loop limit
iterations	dd	0			; set to 360.0/tStep

red		db	0			; 0-255
green		db	0			; 0-255
blue		db	0			; 0-255

; ------------------------------------------------------------

section  .text

; -----
;  External references for openGL routines.

extern	glutInit, glutInitDisplayMode, glutInitWindowSize, glutInitWindowPosition
extern	glutCreateWindow, glutMainLoop
extern	glutDisplayFunc, glutIdleFunc, glutReshapeFunc, glutKeyboardFunc
extern	glutSwapBuffers, gluPerspective, glutPostRedisplay
extern	glClearColor, glClearDepth, glDepthFunc, glEnable, glShadeModel
extern	glClear, glLoadIdentity, glMatrixMode, glViewport
extern	glTranslatef, glRotatef, glBegin, glEnd, glVertex3f, glColor3f
extern	glVertex2f, glVertex2i, glColor3ub, glOrtho, glFlush, glVertex2d

extern	cosf, sinf

; ******************************************************************
;  Function getRadii()
;	Gets radius 1, radius 2, offset positionm and rottaion
;	speedvalues and color code letter from the command line.

;	Performs error checking, converts ASCII/senary string
;	to integer.  Required ommand line format (fixed order):
;	  "-r1 <senary numberl> -r2 <senary number> -op <senary number> 
;			-sp <senary number> -cl <color>"

; HLL
;	stat = getRadii(argc, argv, &radius1, &radius2, &offPos,
;						&speed, &color);

; -----
;  Arguments:
;	- ARGC - rdi
;	- ARGV - rsi
;	- radius 1, double-word, address - rdx
;	- radius 2, double-word, address -rcx
;	- offset Position, double-word, address -r8
;	- speed, double-word, address - r9
;	- circle color, byte, address [rbp + 16]




;	YOUR CODE GOES HERE

global getRadii
getRadii:

push 	rbp
mov 	rbp, rsp
push 	rbx
push 	r10
push 	r11
push 	r12
push 	r13
push 	r14
push 	r15

cmp 	rdi, 11
jb 		invalidArgCount
mov 	r12, 1		;argv counter
mov 	r10, 0		;argv string counter

;Check first input
;argv[1] == "-r1"
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 45 						;vec[1] == "-"
jne 	r1InvalidSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 114						;vec[2] == "r"
jne 	r1InvalidSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 49
jne 	r1InvalidSpec

;0 <= argv[2] "-r1" <= 1054
mov 	r10, 0						;counter through string
inc 	r12							;argv[2]
push 	rdi
mov 	rdi, qword [rsi + r12 * 8]
call 	StringToNum
pop 	rdi

cmp 	eax, R1_MIN
jb 		r1InvalidValue

cmp 	eax, R1_MAX
ja 		r1InvalidValue

mov 	dword [rdx], eax

;argv[2] == "-r2"
mov 	r10, 0
inc 	r12
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 45
jne 	r2InvalidSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 114
jne 	r2InvalidSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 50
jne 	r2InvalidSpec

;1 <= argv[3] "-r2" <= 1054
mov 	r10, 0
inc 	r12
push 	rdi
mov 	rdi, qword [rsi + r12 * 8]
call 	StringToNum
pop 	rdi

cmp 	eax, R2_MIN
jb 		r2InvalidValue

cmp 	eax, R2_MAX
ja 		r2InvalidValue

mov 	dword [rcx], eax

;argv[4] == "-op"
mov 	r10, 0
inc 	r12
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 45
jne 	opIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 111
jne 	opIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 112
jne 	opIncorrectSpec

;1 <= argv[5] "op" <= 1054
mov 	r10, 0
inc 	r12
push 	rdi
mov 	rdi, qword [rsi + r12 * 8]
call 	StringToNum
pop 	rdi

cmp 	eax, OP_MIN
jb 		opInvalidValue

cmp 	eax, OP_MAX
ja 		opInvalidValue

mov 	dword [r8], eax

;argv[6] == "-sp"
mov 	r10, 0
inc 	r12 
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 45
jne 	spIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 115
jne 	spIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 112
jne 	spIncorrectSpec

;1 <= sp <= 244
mov 	r10, 0
inc 	r12
push 	rdi
mov 	rdi, qword [rsi + r12 * 8]
call 	StringToNum
pop 	rdi

cmp 	eax, SP_MIN
jb 		spIncorrectValue

cmp 	eax, SP_MAX
ja 		spIncorrectValue

mov 	dword [r9], eax

;argv[7] == "-cl"
mov 	r10, 0
inc 	r12
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 45
jne 	clIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 99
jne 	clIncorrectSpec
inc 	r10
mov 	al, byte [r15 + r10]
cmp 	al, 108
jne 	clIncorrectSpec

;Checking colors - r, g, b, p, y
mov 	r10, 0
inc 	r12
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r10]
cmp 	al, 114		;al == "r"
jne 	checkGreen

checkGreen:
cmp 	al, 103
jne 	checkBlue
jmp 	colorSuccess

checkBlue:
cmp 	al, 98
jne 	checkPurple
jmp 	colorSuccess

checkPurple:
cmp 	al, 121
jne 	checkWhite
jmp 	colorSuccess

checkWhite:
cmp 	al, 119
jne 	clIncorrectValue
jmp 	colorSuccess

colorSuccess:
lea 	r15, qword [rbp + 16]
mov 	dword [r15], eax

;Successful command line input
mov 	eax, TRUE
jmp 	done

clIncorrectValue:
mov 	rdi, errCLvalue
call 	printString
mov 	eax, FALSE
jmp 	done

clIncorrectSpec:
mov 	rdi, errCLsp
call 	printString
mov 	eax, FALSE
jmp 	done

spIncorrectValue:
mov 	rdi, errSPvalue
call 	printString
mov 	eax, FALSE
jmp 	done

spIncorrectSpec:
mov 	rdi, errSPsp
call 	printString
mov 	eax, FALSE
jmp 	done

opInvalidValue:
mov 	rdi, errOPvalue
call 	printString
mov 	eax, FALSE
jmp 	done

opIncorrectSpec:
mov 	rdi, errOPsp
call 	printString
mov 	eax, FALSE
jmp 	done

r2InvalidValue:
mov 	rdi, errR2value
call 	printString
mov 	eax, FALSE
jmp 	done

r2InvalidSpec:
mov		rdi, errR2sp
call 	printString
mov 	eax, FALSE
jmp 	done

r1InvalidValue:
mov 	rdi, errR1value
call 	printString
mov 	eax, FALSE
jmp 	done

r1InvalidSpec:
mov 	rdi, errR1sp
call 	printString
mov 	eax, FALSE
jmp 	done

incorrectUsage:
mov 	rdi, errUsage
call 	printString
mov 	eax, FALSE
jmp 	done

invalidArgCount:
mov 	rdi, errBadCL
call 	printString
mov 	eax, FALSE
jmp 	done

done:

pop 	r15
pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	rbx
pop 	rbp

ret

; ******************************************************************
;  Spirograph Plotting Function.

; -----
;  Color Code Conversion:
;	'r' -> red=255, green=0, blue=0
;	'g' -> red=0, green=255, blue=0
;	'b' -> red=0, green=0, blue=255
;	'p' -> red=255, green=0, blue=255
;	'y' -> red=255 green=255, blue=0
;	'w' -> red=255, green=255, blue=255
;  Note, set color before plot loop.

; -----
;  The loop is from 0.0 to 360.0 by tStep, can calculate
;  the number if iterations via:  iterations = 360.0 / tStep
;  This eliminates needing a float compare (a hassle).

; -----
;  Basic flow:
;	Set openGL drawing initializations
;	Loop initializations
;		Set draw color (i.e., glColor3ub)
;		Convert integer values to float for calculations
;		set 'sStep' variable
;		set 'iterations' variable
;	Plot the following spirograph equations:
;	     for (t=0.0; t<360.0; t+=step) {
;	         radii = (r1+r2)
;	         x = (radii * cos(t)) + (offPos * cos(radii * ((t+s)/r2)))
;	         y = (radii * sin(t)) + (offPos * sin(radii * ((t+s)/r2)))
;	         t += tStep
;	         plot point (x, y)
;	     }
;	Close openGL plotting (i.e., glEnd and glFlush)
;	Update s for next call (s += sStep)
;	Ensure openGL knows to call again (i.e., glutPostRedisplay)

; -----
;  The animation is accomplished by plotting a static
;	image, exiting the routine, and replotting a new
;	slightly different image.  The 's' variable controls
;	the phase or animation.

; -----
;  Global variables accessed
;	There are defined and set in the main, accessed herein by
;	name as per the below declarations.

common	radius1		1:4		; radius 1, dword, integer value
common	radius2		1:4		; radius 2, dword, integer value
common	offPos		1:4		; offset position, dword, integer value
common	speed		1:4		; rortation speed, dword, integer value
common	color		1:1		; color code letter, byte, ASCII value

global drawSpiro
drawSpiro:
	push	r12

; -----
;  Prepare for drawing
	; glClear(GL_COLOR_BUFFER_BIT);
	mov	rdi, GL_COLOR_BUFFER_BIT
	call	glClear

	; glBegin();
	mov	rdi, GL_POINTS
	call	glBegin

; -----
;  Set draw color(r,g,b)
;	Convert color letter to color values
;	Note, only legal color letters should be
;		passed to this procedure
;	Note, color values should be store in local
;		variables red, green, and blue

;	YOUR CODE GOES HERE

mov 	al, byte [color]
cmp 	al, 114				;red
jne 	setGreen
mov 	byte [red], 255
mov 	byte [green], 0
mov 	byte [blue], 0
jmp 	colorSet

setGreen:
cmp 	al, 103				;green
jne 	setBlue
mov 	byte [red], 0
mov 	byte [green], 255
mov 	byte [blue], 0
jmp 	colorSet

setBlue:
cmp 	al, 98				;blue
jne 	setPurple
mov 	byte [red], 0
mov 	byte [green], 0
mov 	byte [blue], 255
jmp 	colorSet

setPurple:
cmp 	al, 112				;purple
jne 	setYellow
mov 	byte [red], 255
mov 	byte [green], 0
mov 	byte [blue], 255
jmp 	colorSet

setYellow:
cmp 	al, 121				;yellow
jne 	setWhite
mov 	byte [red], 255
mov 	byte [green], 255
mov 	byte [blue], 0
jmp 	colorSet


setWhite:
mov 	byte [red], 255
mov 	byte [green], 255
mov 	byte [blue], 255
jmp 	colorSet

colorSet:

; -----
;  Loop initializations and main plotting loop

;	YOUR CODE GOES HERE

;iterations = 360.0 / tStep
;floating point 32 bit to integer 32 bit register
movss 	xmm0, dword [limit]
cvtss2si 	eax, xmm0
div 	dword [tStep]
mov 	dword [iterations], eax

mov 	r12d, dword [t]
graphLoop:

;radii
cvtsi2ss	xmm3, dword [radius1]
addss 		xmm3, dword [radius2]

;(t+s)/2
movss 	xmm4, dword [t]
addss 	xmm4, dword [s]
divss 	xmm4, dword [radius2]

;radii * ((t+s)/2)
movss 	xmm5, xmm4
mulss 	xmm5, xmm3

;radii * cos(t)
mov 	rdi, r12
call 	cosf
movss 	xmm6, xmm3
mulss 	xmm6, xmm0

;offPos * cos(radii * (t+s)/r2)
cvtsi2ss	xmm1, dword [offPos]
cvtss2si 	rdi, xmm5
call 	cosf
mulss 	xmm1, xmm0

;(radii * cos(t)) + (offPos * cos(radii * (t+s)/2))
movss 	xmm2, xmm6
addss 	xmm2, xmm1
movss 	dword [x], xmm2

;radii * sin(t)
mov 	rdi, r12
call 	sinf
mulss 	xmm0, xmm3
movss 	xmm6, xmm0

;offPos * sin(radii * (t+s)/2)
cvtsi2ss 	xmm1, dword [offPos]
cvtss2si 	rdi, xmm5
call 	sinf
mulss 	xmm0, xmm1

;(radii * sin(t)) + (offPos * sin(radii * (t+s)/2))
addss	xmm6, xmm0

inc 	r12d
cmp 	r12d, dword [iterations]
jb 		graphLoop

; -----
;  Plotting done.

	call	glEnd
	call	glFlush

; -----
;  Update s for next call.

;	YOUR CODE GOES HERE
;sStep = speed / scale
movss 	xmm0, dword [speed]
divss 	xmm0, dword [scale]
addss 	xmm0, dword [s]
movss 	dword [s], xmm0

; -----
;  Ensure openGL knows to call again

	call	glutPostRedisplay

	pop		r12
	ret

; ******************************************************************
;  Generic function to display a string to the screen.
;  String must be NULL terminated.

;  Algorithm:
;	Count characters in string (excluding NULL)
;	Use syscall to output characters

;  Arguments:
;	- address, string
;  Returns:
;	nothing

global	printString
printString:

; -----
;  Count characters in string.

	mov	rbx, rdi			; str addr
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL
	je	strCountDone
	inc	rbx
	inc	rdx
	jmp	strCountLoop
strCountDone:

	cmp	rdx, 0
	je	prtDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; EDX=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

prtDone:
	ret

; ******************************************************************

global StringToNum
StringToNum:

push 	rcx
push 	rbx
push 	rdx
push 	r13
push 	r11
push 	r14

mov 	rcx, 0
mov 	rax, 0

stringSize:						;Gets the size of the current string
mov 	al, byte [rdi + rcx]
inc 	rcx
cmp 	al, NULL
jne 	stringSize

dec 	rcx							;size ignores NULL
mov 	rbx, 0						;used to increment through string
mov 	r13, 6						;base for conversion to digit
mov 	r11, rcx
dec 	r11							;n - 1
mov 	r14, 0						;will store the converted value for comp

toDigit:
movzx 	eax, byte [rdi + rbx]
sub 	eax, 48

cmp 	r11, 0						;if exp is 0 then skip and add
jne 	exp 	
jmp 	continue

exp:
mul 	r13d
dec 	r11
cmp 	r11, 0
jne 	exp

continue:
add 	r14d, eax

inc 	rbx							;increment string counter
dec 	rcx							;moving down in size of string
mov 	r11, rcx					;getting original size back
dec 	r11 						;getting n - 1
cmp 	rcx, 0						;if string is out of chars
jne 	toDigit

mov 	eax, r14d

pop 	r14
pop 	r11
pop 	r13
pop 	rdx
pop 	rbx
pop 	rcx

ret