; *****************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 7
;  Description: Translating a sorting algorithm from a high level language into x86.
; 	Using a sorting algo, finding the min, max, sum, average, and median of a list

; Sort a list of number using the odd/even sort algorithm.
; Also finds the minimum, median, maximum, and average of the list.

; =====================================================================
;  Macro to convert integer to senary value in ASCII format.
;  Reads <integer>, converts to ASCII/senary string including
;	NULL into <string>


;	YOUR CODE GOES HERE

%macro int2aSenary 2

;	YOUR CODE GOES HERE
mov 	r12, 0	;count of chars
mov 	r13, 10
mov 	eax, %1
%%toString:
cdq
div 	r13d
add 	edx, 48
mov 	byte [tmpString + r12], dl
inc 	r12
cmp 	eax, 0
jne 	%%toString

dec 	r12
mov 	r13, 0
mov 	r14, STR_LENGTH
dec 	r14b	;ignores the NULL terminator
sub 	r14b, r12b	;gets the amount of whitespace 

%%insertWS:
mov 	byte [%2 + r13], 32
inc 	r13b
cmp 	r13b, r14b
jne 	%%insertWS

%%moveChars:	;Placing the chars from tmpString into perimSumString
mov 	al, byte [tmpString + r12]
mov 	byte [%2 + r13], al
dec 	r12
inc 	r13
cmp 	r12, STR_LENGTH
jne 	%%moveChars

mov 	byte[%2 + r13], NULL ;placing the NULL at the end of the string

%endmacro




; --------------------------------------------------------------
;  Simple macro to display a string to the console.
;	Call:	printString  <stringAddr>

;	Arguments:
;		%1 -> <stringAddr>, string address

;  Count characters (excluding NULL).
;  Display string starting at address <stringAddr>

%macro	printString	1
	push	rax			; save altered registers
	push	rdi
	push	rsi
	push	rdx
	push	rcx

	mov	rdx, 0
	mov	rdi, %1
%%countLoop:
	cmp	byte [rdi], NULL
	je	%%countLoopDone
	inc	rdi
	inc	rdx
	jmp	%%countLoop
%%countLoopDone:

	mov	rax, SYS_write		; system call for write (SYS_write)
	mov	rdi, STDOUT		; standard output
	mov	rsi, %1			; address of the string
	syscall				; call the kernel

	pop	rcx			; restore registers to original values
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rax
%endmacro

; ---------------------------------------------

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation

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

; -----
;  Program specfic constants

STR_LENGTH	equ	15

; -----
;  Provided data

lst	dd	  147,  1123,  2245,  4440,   165
	dd	   69,   126,   571,   147,   228
	dd	   27,    90,   177,    75,    14
	dd	  181,    25,    15,    22,  1217
	dd	  127,    64,   140,   172,    24
	dd	 2161,   134,   151,    32,    12
	dd	 1113,  1232,  2146,  3376,  5120
	dd	 2356,  3164, 34565,  3155, 23157
	dd	 1001,   128,    33,   105,  8327
	dd	  101,   115,   108, 12233,  2115
	dd	 1227,  1226,  5129,   117,   107
	dd	  105,   109,   730,   150,  3414
	dd	 1107,  6103,  1245,  6440,   465
	dd	 2311,   254,  4528,   913,  6722
	dd	 1149,  2126,  5671,  4647,  4628
	dd	  327,  2390,   177,  8275,  5614
	dd	 3121,   415,   615,    22,  7217
	dd	 1221,    34,  6151,   432,   114
	dd	  629,   114,   522,  2413,   131
	dd	 5639,   126,    62,    41,   127
	dd	 2101,   133,   133,    50,  4532
	dd	 1219,  3116,    62,    17,   127
	dd	 6787,  4569,    79, 15675,    14
	dd	 7881,  8320,  3467,  4559,  1190
	dd	  186,   134,  1125,  5675,  3476
	dd	 2137,  2113,  1647,   114,    15
	dd	 6571,  7624,   128,   113,  3112
	dd	 1121,   320,  4540,  5679,  1190
	dd	 9125,   116,   122,   117,   127
	dd	 5677,   101,  3727,   125,  3184
	dd	 1104,   124,   112,   143,   176
	dd	 7534,  2126,  6112,   156,  1103
	dd	 6759,  6326,  2171,   147,  5628
	dd	 7527,  7569,  3177,  6785,  3514
	dd	 1156,   164,  4165,   155,  5156
	dd	 5634,  7526,  3413,  7686,  7563
	dd	 2147,   113,   143,   140,   165
	dd	 5721,  5615,  4568,  7813,  1231
	dd	 5527,  6364,   330,   172,    24
	dd	 7525,  5616,  5662,  6328,  2342

len	dd	10


min	dd	0
med	dd	0
max	dd	0
sum	dd	0
avg	dd	0

; -----
;  Misc. data definitions (if any).
isSorted 	db 	FALSE


; -----
;  Provided string definitions.

newLine		db	LF, NULL

hdr		db	LF, "---------------------------"
		db	"---------------------------"
		db	LF, ESC, "[1m", "CS 218 - Assignment #7", ESC, "[0m"
		db	LF, "Odd/Even Sort", LF, LF, NULL

hdrMin		db	"Minimum:  ", NULL
hdrMax		db	"Maximum:  ", NULL
hdrMed		db	"Median:   ", NULL
hdrSum		db	"Sum:      ", NULL
hdrAve		db	"Average:  ", NULL

; ---------------------------------------------

section .bss

tmpString	resb	STR_LENGTH

; ---------------------------------------------

section	.text
global	_start
_start:

; ******************************
;  function oddEvenSort(list) {
;	bool sorted = false;

;	while (!sorted) {
;		sorted = true;
;		for (var i=1; i < len-2; i+=2) {
;			if (list[i] > list[i+1]) {
;			swap(list, i, i+1);
;			sorted = false;
;			}
;		}
;		for (var i=0; i < len-2; i+=2) {
;			if (list[i] > list[i+1]) {
;				swap(list, i, i+1);
;				sorted = false;
;			}
;		}
;	}
;  }


;	YOUR CODE GOES HERE

while:
mov 	byte [isSorted], 1	;isSorted = true
mov 	r12, 1	;i = 1 for first loop
mov 	r13d, dword [len]
sub 	r13d, 2	;len-2
forLoop1:

;if statement

mov 	ebx, dword [lst + r12 * 4] ;list[i]
mov 	ecx, dword [lst + ((r12 * 4) + 4)] ;list[i + 1]

cmp 	ebx, ecx		;if list[i] <= list[i + 1], then increment, else do swappy stuff
jbe 	loopCondition1

;Swap
mov 	dword [lst + r12 * 4], ecx
mov 	dword [lst + ((r12 * 4) + 4)], ebx

mov 	byte [isSorted], 0

loopCondition1:
cmp 	r12d, r13d ;i < len-2
jb 		incLoop1
jmp 	continue
incLoop1:
add 	r12d, 2 ;i+=2
jmp 	forLoop1

continue:

;If isSorted is true then code proceeds

; ******************************
;  Find stats
;	minimum, maximum, median, sum, and average


;	YOUR CODE GOES HERE

mov 	r12, 0 ;counter for perimsArray
mov 	eax, dword [lst + r12 * 4]
mov 	dword [min], eax
mov 	dword [max], eax
perimsLoop:
mov 	eax, dword [lst + r12 * 4]
add 	dword [sum], eax

cmp 	dword [min], eax
ja 		swapMin
jmp 	checkMax

swapMin:
mov 	dword [min], eax

checkMax:
cmp 	dword [max], eax
jb 		swapMax
jmp 	skipMax

swapMax:
mov 	dword [max], eax

skipMax:
inc 	r12
cmp 	r12d, dword [len]
jne 	perimsLoop

;Calculate average
mov 	eax, dword [sum]
mov		ecx, dword [len]
cdq
div 	ecx
mov 	dword [avg], eax

;Calculate median
mov 	r12, 0
mov 	r12d, dword [len]
shr 	r12d, 1	;Divides by 2

mov 	ecx, dword [lst + ((r12 * 4) - 4)]
mov 	ebx, dword [lst + r12 * 4]

add 	ecx, ebx
shr 	ecx, 1
mov 	dword [med], ecx


; ******************************
;  Display results to screen in senary.

	printString	hdr

	printString	hdrMin
	int2aSenary	dword [min], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrMax
	int2aSenary	dword [max], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrMed
	int2aSenary	dword [med], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrSum
	int2aSenary	dword [sum], tmpString
	printString	tmpString
	printString	newLine

	printString	hdrAve
	int2aSenary	dword [avg], tmpString
	printString	tmpString
	printString	newLine
	printString	newLine

; ******************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

