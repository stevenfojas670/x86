;  Name:
;  NSHE_ID: 
;  Section:
;  Assignment:
;  Description:


;  Focus on learning basic arithmetic operations
;  (add, subtract, multiply, and divide).
;  Ensure understanding of sign and unsigned operations.

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
;  Assignment #3 data declarations

; byte data
bNum1		db	7
bNum2		db	17
bNum3		db	28
bNum4		db	39
bNum5		db	-7
bNum6		db	-17
bNum7		db	-24
bNum8		db	-34
bAns1		db	0
bAns2		db	0
bAns3		db	0
bAns4		db	0
bAns5		db	0
bAns6		db	0
bAns7		db	0
bAns8		db	0
bAns9		db	0
bAns10		db	0
wAns11		dw	0
wAns12		dw	0
wAns13		dw	0
wAns14		dw	0
wAns15		dw	0
bAns16		db	0
bAns17		db	0
bAns18		db	0
bRem18		db	0
bAns19		db	0
bAns20		db	0
bAns21		db	0
bRem21		db	0

; word data
wNum1		dw	127
wNum2		dw	255
wNum3		dw	327
wNum4		dw	421
wNum5		dw	149
wNum6		dw	-247
wNum7		dw	-325
wNum8		dw	-469
wAns1		dw	0
wAns2		dw	0
wAns3		dw	0
wAns4		dw	0
wAns5		dw	0
wAns6		dw	0
wAns7		dw	0
wAns8		dw	0
wAns9		dw	0
wAns10		dw	0
dAns11		dd	0
dAns12		dd	0
dAns13		dd	0
dAns14		dd	0
dAns15		dd	0
wAns16		dw	0
wAns17		dw	0
wAns18		dw	0
wRem18		dw	0
wAns19		dw	0
wAns20		dw	0
wAns21		dw	0
wRem21		dw	0

; double-word data
dNum1		dd	118236
dNum2		dd	258397
dNum3		dd	426726
dNum4		dd	614372
dNum5		dd	7871
dNum6		dd	-3296
dNum7		dd	-4357
dNum8		dd	-5277
dAns1		dd	0
dAns2		dd	0
dAns3		dd	0
dAns4		dd	0
dAns5		dd	0
dAns6		dd	0
dAns7		dd	0
dAns8		dd	0
dAns9		dd	0
dAns10		dd	0
qAns11		dq	0
qAns12		dq	0
qAns13		dq	0
qAns14		dq	0
qAns15		dq	0
dAns16		dd	0
dAns17		dd	0
dAns18		dd	0
dRem18		dd	0
dAns19		dd	0
dAns20		dd	0
dAns21		dd	0
dRem21		dd	0

; quadword data
qNum1		dq	1456789
qNum2		dq	2915775
qNum3		dq	3912602
qNum4		dq	5654879
qNum5		dq	14291
qNum6		dq	-145741
qNum7		dq	-244849
qNum8		dq	-461041
qAns1		dq	0
qAns2		dq	0
qAns3		dq	0
qAns4		dq	0
qAns5		dq	0
qAns6		dq	0
qAns7		dq	0
qAns8		dq	0
qAns9		dq	0
qAns10		dq	0
dqAns11		ddq	0
dqAns12		ddq	0
dqAns13		ddq	0
dqAns14		ddq	0
dqAns15		ddq	0
qAns16		dq	0
qAns17		dq	0
qAns18		dq	0
qRem18		dq	0
qAns19		dq	0
qAns20		dq	0
qAns21		dq	0
qRem21		dq	0

; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------
; Byte Operations

; unsigned byte additions
;	bAns1  = bNum1 + bNum2

mov 	al, byte [bNum1]
add 	al, byte [bNum2]
mov 	byte [bAns1], al

;	bAns2  = bNum2 + bNum3

mov 	al, byte [bNum2]
add 	al, byte [bNum3]
mov 	byte [bAns2], al

;	bAns3  = bNum3 + bNum4

mov 	al, byte [bNum3]
add 	al, byte [bNum4]
mov 	byte [bAns3], al

; -----
; signed byte additions
;	bAns4  = bNum5 + bNum6

mov 	al, byte [bNum5]
add 	al, byte [bNum6]
mov 	byte [bAns4], al

;	bAns5  = bNum7 + bNum8

mov 	al, byte [bNum7]
add 	al, byte [bNum8]
mov 	byte [bAns5], al

; -----
; unsigned byte subtractions
;	bAns6  = bNum2 - bNum1

mov 	al, byte [bNum2]
sub 	al, byte [bNum1]
mov 	byte [bAns6], al

;	bAns7  = bNum3 - bNum2

mov 	al, byte [bNum3]
sub 	al, byte [bNum2]
mov 	byte [bAns7], al

;	bAns8  = bNum4 - bNum3

mov 	al, byte [bNum4]
sub 	al, byte [bNum3]
mov 	byte [bAns8], al

; -----
; signed byte subtraction
;	bAns9  = bNum7 - bNum5

mov 	al, byte [bNum7]
sub 	al, byte [bNum5]
mov 	byte [bAns9], al

;	bAns10 = bNum8 - bNum6

mov 	al, byte [bNum8]
sub 	al, byte [bNum5]
mov 	byte [bAns10], al

; -----
; unsigned byte multiplication
;	wAns11  = bNum2 * bNum3

mov 	al, byte [bNum2]
mul 	byte [bNum3]
mov 	word [wAns11], ax

;	wAns12  = bNum3 * bNum4

mov 	al, byte [bNum3]
mul 	byte [bNum4]
mov 	word [wAns12], ax

;	wAns13  = bNum1 * bNum4

mov 	al, byte [bNum1]
mul 	byte [bNum4]
mov 	word [wAns13], ax

; -----
; signed byte multiplication
;	wAns14  = bNum5 * bNum7

mov 	al, byte [bNum5]
imul	byte [bNum7]
mov 	word [wAns14], ax

;	wAns15  = bNum6 * bNum8

mov 	al, byte [bNum6]
imul	byte [bNum8]
mov 	word [wAns15], ax

; -----
; unsigned byte division
;	bAns16 = bNum4 / bNum3

movzx 	ax, byte [bNum4]
div 	byte [bNum3]
mov 	byte [bAns16], al

;	bAns17 = bNum3 / bNum2

movzx 	ax, byte [bNum3]
div 	byte [bNum2]
mov 	byte [bAns17], al

;	bAns18 = wNum2 / bNum1

mov 	ax, word [wNum2]
div 	byte [bNum1]
mov 	byte [bAns18], al

;	bRem18 = wNum2 % bNum1

mov 	ax, word [wNum2]
div 	byte [bNum1]
mov 	byte [bRem18], ah

; -----
; signed byte division
;	bAns19 = bNum8 / bNum5

mov 	al, byte [bNum8]
cbw
idiv 	byte [bNum5]
mov 	byte [bAns19], al

;	bAns20 = bNum7 / bNum6

mov 	al, byte [bNum7]
cbw
idiv 	byte [bNum6]
mov 	byte [bAns20], al

;	bAns21 = wNum6 / bNum4

mov 	ax, word [wNum6]
cwd
idiv 	byte [bNum4]
mov 	byte [bAns21], al

;	bRem21 = wNum6 % bNum4

mov 	ax, word [wNum6]
cwd
idiv 	byte [bNum4]
mov 	byte [bRem21], ah

; *****************************************
; Word Operations

; -----
; unsigned word additions
;	wAns1  = wNum1 + wNum3
mov 	ax, word [wNum1]
add 	ax, word [wNum3]
mov 	word [wAns1], ax
;	wAns2  = wNum2 + wNum4
mov 	ax, word [wNum2]
add 	ax, word [wNum4]
mov 	word [wAns2], ax 
;	wAns3  = wNum3 + wNum2
mov 	ax, word [wNum3]
add 	ax, word [wNum2]
mov 	word [wAns3], ax



; -----
; signed word additions
;	wAns4  = wNum7 + wNum6

mov 	ax, word [wNum7]
add 	ax, word [wNum6]
mov 	word [wAns4], ax

;	wAns5  = wNum8 + wNum5

mov 	ax, word [wNum8]
add 	ax, word [wNum5]
mov 	word [wAns5], ax
; -----
; unsigned word subtractions
;	wAns6  = wNum3 - wNum1

mov 	ax, word [wNum3]
sub 	ax, word [wNum1]
mov 	word [wAns6], ax

;	wAns7  = wNum4 - wNum2

mov 	ax, word [wNum4]
sub 	ax, word [wNum2]
mov 	word [wAns7], ax

;	wAns8  = wNum2 - wNum1

mov 	ax, word [wNum2]
sub 	ax, word [wNum1]
mov 	word [wAns8], ax

; -----
; signed word subtraction
;	wAns9  = wNum8 - wNum6

mov 	ax, word [wNum8]
sub 	ax, word [wNum6]
mov 	word [wAns9], ax

;	wAns10  = wNum7 - wNum5

mov 	ax, word [wNum7]
sub 	ax, word [wNum5]
mov 	word [wAns10], ax

; -----
; unsigned word multiplication
;	dAns11 = wNum2 * wNum2

mov 	ax, word [wNum2]
mul 	word [wNum2]
mov 	word [dAns11], ax
mov 	word [dAns11 + 2], dx

;	dAns12  = wNum3 * wNum2

mov 	ax, word [wNum3]
mul 	word [wNum2]
mov 	word [dAns12], ax
mov 	word [dAns12 + 2], dx

;	dAns13  = wNum4 * wNum1

mov 	ax, word [wNum4]
mul 	word [wNum1]
mov 	word [dAns13], ax
mov 	word [dAns13 + 2], dx


; -----
; signed word multiplication
;	dAns14  = wNum7 * wNum5

mov 	ax, word [wNum7]
imul 	word [wNum5]
mov 	word [dAns14], ax
mov 	word [dAns14 + 2], dx

;	dAns15  = wNum8 * wNum6

mov 	ax, word [wNum8]
imul 	word [wNum6]
mov 	word [dAns15], ax
mov 	word [dAns15 + 2], dx

; -----
; unsigned word division
;	wAns16 = wNum4 / wNum2

mov 	ax, word [wNum4]
mov 	dx, 0
div 	word [wNum2]
mov 	word [wAns16], ax
mov 	word [wAns16 + 2], dx

;	wAns17 = wNum3 / wNum2

mov 	ax, word [wNum3]
mov 	dx, 0
div 	word [wNum2]
mov 	word [wAns17], ax
mov 	word [wAns17 + 2], dx

;	wAns18 = dNum2 / wNum1

mov 	eax, dword [dNum2]
div 	word [wNum1]
mov 	word [wAns18], ax
mov 	word [wAns18 + 2], dx

;	wRem18 = dNum2 % wNum1

mov 	eax, dword [dNum2]
div 	word [wNum1]
mov 	word [wRem18], ax
mov 	word [wRem18 + 2], dx

; -----
; signed word division
;	wAns19 = wNum6 / wNum5

mov 	ax, word [wNum6]
cwd
idiv 	word [wNum5]
mov 	word [wAns19], ax
mov 	word[wAns19 + 2], dx

;	wAns20 = wNum8 / wNum7

mov 	ax, word [wNum8]
cwd 	
idiv 	word [wNum7]
mov  	word [wAns20], ax
mov 	word [wAns20 + 2], dx

;	wAns21 = dNum7 / wNum5

mov 	eax, dword [dNum7]
cdq
idiv 	word [wNum5]
mov 	dword [wAns21], eax
mov 	dword [wAns21 + 4], edx

;	wRem21 = dNum7 % wNum5

mov 	eax, dword [dNum7]
cdq 	
idiv 	word [wNum5]
mov 	dword [wRem21 + 4], edx

; *****************************************
; Double-Word Operations

; -----
; unsigned double-word additions
;	dAns1  = dNum4 + dNum1

mov 	eax, dword [dNum4]
add 	eax, dword [dNum1]
mov 	dword [dAns1], eax

;	dAns2  = dNum3 + dNum2

mov 	eax, dword [dNum3]
add 	eax, dword [dNum2]
mov 	dword [dAns2], eax

;	dAns3  = dNum2 + dNum4

mov 	eax, dword [dNum2]
add 	eax, dword [dNum4]
mov 	dword [dAns3], eax

; -----
; signed double-word additions
;	dAns4  = dNum7 + dNum6

mov 	eax, dword [dNum7]
add 	eax, dword [dNum6]
mov 	dword [dAns4], eax

;	dAns5  = dNum7 + dNum5

mov 	eax, dword [dNum7]
add 	eax, dword [dNum6]
mov 	dword [dAns5], eax

; -----
; unsigned double-word subtractions
;	dAns6  = dNum4 - dNum2

mov 	eax, dword [dNum4]
sub 	eax, dword [dNum2]
mov 	dword [dAns6], eax

;	dAns7  = dNum3 - dNum1

mov 	eax, dword [dNum3]
sub 	eax, dword [dNum2]
mov 	dword [dAns7], eax

;	dAns8  = dNum2 - dNum1

mov 	eax, dword [dNum2]
sub 	eax, dword [dNum1]
mov 	dword [dAns8], eax

; -----
; signed double-word subtraction
;	dAns9  = dNum7 - dNum6

mov 	eax, dword [dNum7]
sub 	eax, dword [dNum6]
mov 	dword [dAns9], eax

;	dAns10 = dNum7 – dNum5

mov 	eax, dword [dNum7]
sub 	eax, dword [dNum5]
mov 	dword [dAns10], eax

; -----
; unsigned double-word multiplication
;	qAns11  = dNum3 * dNum3

mov 	eax, dword [dNum3]
mul 	dword [dNum3]
mov 	dword [qAns11], eax
mov 	dword [qAns11 + 4], edx

;	qAns12  = dNum2 * dNum3

mov 	eax, dword [dNum2]
mul 	dword [dNum3]
mov 	dword [qAns12], eax
mov 	dword [qAns12 + 4], edx

;	qAns13  = dNum1 * dNum4

mov 	eax, dword [dNum1]
mul 	dword [dNum4]
mov 	dword [qAns13], eax
mov 	dword [qAns13 + 4], edx

; -----
; signed double-word multiplication
;	qAns14  = dNum8 * dNum5

mov 	eax, dword [dNum8]
imul 	dword [dNum5]
mov 	dword [qAns14], eax
mov 	dword [qAns14 + 4], edx

;	qAns15  = dNum7 * dNum6

mov 	eax, dword [dNum7]
imul 	dword [dNum6]
mov 	dword [qAns15], eax
mov 	dword [qAns15 + 4], edx

; -----
; unsigned double-word division
;	dAns16 = dNum3 / dNum2

mov 	eax, dword [dNum3]
div 	dword [dNum2]
mov 	dword [dAns16], eax

;	dAns17 = dNum4 / dNum1

mov 	eax, dword [dNum4]
div 	dword [dNum1]
mov 	dword [dAns17], eax

;	dAns18 = qNum4 / dNum2

mov 	rax, qword [qNum4]
div 	dword [dNum2]
mov 	qword [dAns18], rax

;	dRem18 = qNum4 % dNum2


; -----
; signed double-word division
; signed double-word division
;	dAns19 = dNum8 / dNum6
;	dAns20 = dNum7 / dNum6
;	dAns21 = qNum8 / dNum5
;	dRem21 = qNum8 % dNum5


; *****************************************
; QuadWord Operations

; -----
; unsigned quadword additions
;	qAns1  = qNum4 + qNum2
;	qAns2  = qNum3 + qNum1
;	qAns3  = qNum1 + qNum4


; -----
; signed quadword additions
;	qAns4  = qNum7 + qNum6
;	qAns5  = qNum8 + qNum5


; -----
; unsigned quadword subtractions
;	qAns6  = qNum4 - qNum3
;	qAns7  = qNum2 - qNum1
;	qAns8  = qNum3 - qNum2


; -----
; signed quadword subtraction
;	qAns9  = qNum7 - qNum5
;	qAns10 = qNum8 - qNum6


; -----
; unsigned quadword multiplication
;	dqAns11  = qNum4 * qNum3
;	dqAns12  = qNum3 * qNum2
;	dqAns13  = qNum1 * qNum1


; -----
; signed quadword multiplication
;	dqAns14  = qNum7 * qNum5
;	dqAns15  = qNum8 * qNum6


; -----
; unsigned quadword division
;	qAns16 = qNum4 / qNum2
;	qAns17 = qNum3 / qNum1
;	qAns18 = dqAns13 / qNum3
;	qRem18 = dqAns13 % qNum3


; -----
; signed quadword division
;	qAns19 = qNum7 / qNum5
;	qAns20 = qNum8 / qNum6
;	qAns21 = dqAns15 / qNum5
;	qRem21 = dqAns15 % qNum5


; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

