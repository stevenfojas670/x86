;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 4
;  Description: Finding the sum, average, count, min, max, and estimated median for a list

; *****************************************************************
;  Data Declarations (provided).

section	.data
; -----
;  Define constants.

NULL		equ	0			; end of string

TRUE		equ	1
FALSE		equ	0

EXIT_SUCCESS	equ	0			; Successful operation
SYS_exit	equ	60			; call code for terminate

; -----
;  Practice declarations

rand 	dd 		10000

; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------

mov 	ebx, 14
mov 	ecx, dword [rbx]
mov 	byte [rbx + 4], 10
;mov 	10, rcx illegal operation
;Destination cannot be an immediate
mov 	dl, ah
mov 	ax, word [rsi + 4]
mov 	cx, word [rbx + rsi]
;mov 	ax, byte [rbx] illegal operation
;Cannot move byte into word

; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

