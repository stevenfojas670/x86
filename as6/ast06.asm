; *****************************************************************
;  Name: <your name>
;  NSHE_ID: 
;  Section: 
;  Assignment: 6
;  Description:	

; =====================================================================
;  STEP #2
;  Macro to convert ASCII/senary value into an integer.
;  Reads <string>, convert to integer and place in <integer>
;  Assumes valid data, no error checking is performed.

;  Arguments:
;	%1 -> <string>, register -> string address
;	%2 -> <integer>, register -> result

;  Macro usgae
;	aSenary2int  <string-address>, <integer-variable>

;  Example usage:
;	aSenary2int	rbx, tmpInteger

;  For example, to get address into a local register:
;		mov	rsi, %1

;  To return a value, it might be:
;		mov	dword [%2], eax

;  Note, the register used for the macro call (rbx in this example)
;  must not be altered BEFORE the address is copied into
;  another register (if desired).

%macro	aSenary2int	2


;	YOUR CODE GOES HERE


%endmacro

; =====================================================================
;  Macro to convert integer to senary value in ASCII format.
;  Reads <integer>, converts to ASCII/senary string including
;	NULL into <string>

;  Note, the macro is calling using RSI, so the macro itself should
;	 NOT use the RSI register until is saved elsewhere.

;  Arguments:
;	%1 -> <integer>, value
;	%2 -> <string>, string address

;  Macro usgae
;	int2aSenary	<integer-variable>, <string-address>

;  Example usage:
;	int2aSenary	dword [perimsArrays rsi*4], tempString

;  For example, to get the passed value into a local register:
;		mov	eax, %1

%macro	int2aSenary	2


;	YOUR CODE GOES HERE


%endmacro

; =====================================================================
;  Simple macro to display a string to the console.
;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

;  Macro usage:
;	printString  <stringAddr>

;  Arguments:
;	%1 -> <stringAddr>, string address

%macro	printString	1
	push	rax			; save altered registers (cautionary)
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	lea	rdi, [%1]		; get address
	mov	rdx, 0			; character count
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	lea	rsi, [%1]		; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; =====================================================================
;  Initialized variables.

section	.data

; -----
;  Define standard constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; successful operation
NOSUCCESS	equ	1			; unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; system call code for read
SYS_write	equ	1			; system call code for write
SYS_open	equ	2			; system call code for file open
SYS_close	equ	3			; system call code for file close
SYS_fork	equ	57			; system call code for fork
SYS_exit	equ	60			; system call code for terminate
SYS_creat	equ	85			; system call code for file open/create
SYS_time	equ	201			; system call code for get time

LF		equ	10
SPACE		equ	" "
NULL		equ	0
ESC		equ	27

NUMS_PER_LINE	equ	4

; -----
;  Assignment #6 Provided Data

STR_LENGTH	equ	12			; chars in string, with NULL

aSideLengths
		db	"         23", NULL, "         43", NULL, "        150", NULL
		db	"        215", NULL, "        234", NULL, "        251", NULL
		db	"        302", NULL, "        322", NULL, "        342", NULL
		db	"        411", NULL, "        432", NULL, "        450", NULL
		db	"        512", NULL, "        532", NULL, "        555", NULL
		db	"       1021", NULL, "       1034", NULL, "       1052", NULL
		db	"       2002", NULL, "       2213", NULL, "       2325", NULL
		db	"       3131", NULL, "       3204", NULL, "       3520", NULL
		db	"       4112", NULL, "       4200", NULL, "       4430", NULL
		db	"       5230", NULL, "       5321", NULL, "       5513", NULL
		db	"      10234", NULL, "      11203", NULL, "      12345", NULL
		db	"      20245", NULL, "      23450", NULL, "      24513", NULL     
		db	"      31243", NULL, "      33525", NULL, "      41230", NULL    
		db	"      54321", NULL

aSenaryLength	db	"        104", NULL
length		dd	0

perimSum	dd	0
perimAve	dd	0
perimMin	dd	0
perimMax	dd	0

; -----
;  Misc. variables for main.

hdr		db	"-----------------------------------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #6", ESC, "[0m", LF
		db	"Perimeter Calculations", LF, LF
		db	"Perimeters:", LF, NULL
shdr		db	LF, "Perimeters Sum:  ", NULL
avhdr		db	LF, "Perimeters Ave:  ", NULL
minhdr		db	LF, "Perimeters Min:  ", NULL
maxhdr		db	LF, "Perimeters Max:  ", NULL

newLine		db	LF, NULL
spaces		db	"   ", NULL

; =====================================================================
;  Uninitialized variables

section	.bss

tmpInteger	resd	1				; temporaty value

perimsArray	resd	40

lenString	resb	STR_LENGTH
tempString	resb	STR_LENGTH			; bytes

perimSumString	resb	STR_LENGTH
perimAveString	resb	STR_LENGTH
perimMinString	resb	STR_LENGTH
perimMaxString	resb	STR_LENGTH

; **************************************************************

section	.text
global	_start
_start:

; -----
;  Display assignment initial headers.

	printString	hdr

; -----
;  STEP #1
;	Convert integer length, in ASCII senary format to integer.
;	Do not use macro here...
;	Read string aSenaryLength, convert to integer, and store in length


;	YOUR CODE GOES HERE


mov 	r12, 0 ;Counter for aSernaryLength string
mov 	r13, 0 ;Count for non-whitespace

whitespace:

mov 	al, byte [aSenaryLength + r12]	;Placing first char of the string in al

inc 	r12
cmp 	r12, 0
je 		whitespace
;Take the char and convert it to ascii digit
sub 	al, 48
mov 	byte [tempString + r13]
inc 	r13

cmp 	r12, NULL
jne 	whitespace

;concatentate tempString
concatentate:

mov 	al, byte 


; -----
;  Convert radii from ASCII/senary format to integer.
;  STEP #2 must complete before this code.

	mov	ecx, dword [length]
	mov	rdi, 0					; index for array
	mov	rbx, aSideLengths
cvtLoop:
	push	rbx					; safety push's
	push	rcx
	push	rdi
	aSenary2int	rbx, tmpInteger
	pop	rdi
	pop	rcx
	pop	rbx

	mov	eax, dword [tmpInteger]
	mov	r8d, 6
	mul	r8d					; perim = length * 6
	mov	dword [perimsArray+rdi*4], eax
	add	rbx, STR_LENGTH

	inc	rdi
	dec	ecx
	cmp	ecx, 0
	jne	cvtLoop

; -----
;  Display each the perimsArray (three per line).

	mov	ecx, dword [length]
	mov	rsi, 0
	mov	r12, 0
printLoop:
	push	rcx					; safety push's
	push	rsi
	push	r12

	int2aSenary	eax, tempString

	printString	tempString
	printString	spaces

	pop	r12
	pop	rsi
	pop	rcx

	inc	r12
	cmp	r12, 3
	jne	skipNewline
	mov	r12, 0
	printString	newLine
skipNewline:
	inc	rsi

	dec	ecx
	cmp	ecx, 0
	jne	printLoop
	printString	newLine

; -----
;  STEP #3
;	Find perims array stats (sum, min, max, and average).
;	Reads data from perimsArray (set above).


;	YOUR CODE GOES HERE


; -----
;  STEP #4
;	Convert sum to ASCII/senary for printing.
;	Do not use macro here...

	printString	shdr				; display header

;	Read perimsArray sum inetger (set above), convert to
;		ASCII/senary and store in perimSumString.
;	The ASCII version of the number should be STR_LENGTH
;		(globally available constant) characters (including the NULL),
;		right justified with the appropriate number of leading blanks.


;	YOUR CODE GOES HERE


;	print the perimSumString (set above).
	printString	perimSumString

; -----
;  Convert average, min, and max integers to ASCII/senary for printing.
;  STEP #5 must complete before this code.

	printString	avhdr
	int2aSenary	dword [perimAve], perimAveString
	printString	perimAveString

	printString	minhdr
	int2aSenary	dword [perimMin], perimMinString
	printString	perimMinString

	printString	maxhdr
	int2aSenary	dword [perimMax], perimMaxString
	printString	perimMaxString

	printString	newLine
	printString	newLine

; *****************************************************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

