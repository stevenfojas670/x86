; *****************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 
;  Assignment: 12
;  Description: 

; -----
;  Example Smith Number Count for 1 to 200: 8
;	4	22	27	58
;	85	94	121	166

; ***************************************************************

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
ESC		equ	27			; escape key

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

STDIN		equ	0			; standard input
STDOUT		equ	1			; standard output
STDERR		equ	2			; standard error

SYS_read	equ	0			; call code for read
SYS_write	equ	1			; call code for write
SYS_open	equ	2			; call code for file open
SYS_close	equ	3			; call code for file close
SYS_fork	equ	57			; call code for fork
SYS_exit	equ	60			; call code for terminate
SYS_creat	equ	85			; call code for file open/create
SYS_time	equ	201			; call code for get time

; -----
;  Globals (used by threads)

currentIndex	dq	1
myLock		dq	0

; -----
;  Local variables for thread function(s).

msgThread1	db	" ...Thread starting...", LF, NULL

; -----
;  Local variables for getArgs function

THREAD_MIN	equ	1
THREAD_MAX	equ	8
LIMIT_MIN	equ	10
LIMIT_MAX	equ	4000000000

errUsage	db	"Usage: ./smithNums -t <senaryNumber> ",
		db	"-l <senaryNumber>", LF, NULL
errOptions	db	"Error, invalid command line options."
		db	LF, NULL
errLSpec	db	"Error, invalid limit specifier."
		db	LF, NULL
errLValue	db	"Error, invalid limit value."
		db	LF, NULL
errLRange	db	"Error, limit out of range."
		db	LF, NULL
errTSpec	db	"Error, invalid thread count specifier."
		db	LF, NULL
errTValue	db	"Error, invalid thread count value."
		db	LF, NULL
errTRange	db	"Error, thread count out of range."
		db	LF, NULL

; -----
;  Local variables for aSenary2int function

qSix		dq	6
qTen		dq	10
tmpNum		dq	0


; ***************************************************************

section	.text

; ******************************************************************
;  Function getArgs()
;	Get, check, convert, verify range, and return the
;	sequential/parallel option and the limit.

;  Example HLL call:
;	stat = getArgs(argc, argv, &thdCount, &userLimit)

;  This routine performs all error checking, conversion of ASCII/senary
;  to integer, verifies legal range.
;  For errors, applicable message is displayed and FALSE is returned.
;  For good data, all values are returned via addresses with TRUE returned.

;  Command line format (fixed order):
;	-t <senaryNumber> -l <senaryNumber>

; -----
; *WARNING:*	The aSenary2int funciton returns a quad.
;		When returning the userLimit, return the full quad value.
;		When returning the thread count, return only the dword
;		portion of the quad result.

; -----
;  Arguments:
;	1) ARGC, value rdi
;	2) ARGV, address rsi
;	3) thread count (dword), address rdx
;	4) user limit (qword), address rcx

global getArgs
getArgs:

push 	rbx
push 	r12
push 	r13
push 	r14
push 	r15

cmp 	rdi, 1
je 		usageErr

cmp 	rdi, 5
jb 		clERR
	
mov 	r12, 1			;argv index
mov 	r13, 0			;argv string counter
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r13]
cmp 	al, "-"
jne 	threadSpecErr
inc 	r13
mov 	al, byte [r15 + r13]
cmp 	al, "t"
jne 	threadSpecErr
inc 	r13
mov 	al, byte [r15 + r13]
cmp 	al, NULL
jne 	threadSpecErr

inc 	r12
push 	rdi
push 	rsi
mov 	rdi, qword [rsi + r12 * 8]
mov 	rsi, rdx
call 	aSenary2int
pop 	rsi
pop 	rdi

cmp 	rax, FALSE						;checking if thread input is valid
je 		threadValueErr
mov 	eax, dword [rdx]				;checking if thread is in range
cmp 	eax, THREAD_MIN
jb 		threadRangeErr
cmp 	eax, THREAD_MAX
ja 		threadRangeErr

mov 	r13, 0
inc 	r12
mov 	r15, qword [rsi + r12 * 8]
mov 	al, byte [r15 + r13]
cmp 	al, "-"
jne 	limitSpecErr
inc 	r13
mov 	al, byte [r15 + r13]
cmp 	al, "l"
jne 	limitSpecErr
inc 	r13
mov 	al, byte [r15 + r13]
cmp 	al, NULL
jne 	limitSpecErr

inc 	r12
push 	rdi
push 	rsi
mov 	rdi, qword [rsi + r12 * 8]
mov 	rsi, rcx
call 	aSenary2int
pop 	rsi
pop 	rdi
cmp 	rax, FALSE
je 		limitValueErr

mov 	rax, qword [rcx]				;checking if limit is within range
cmp 	rax, LIMIT_MIN
jb	 	limitRangeErr

cmp 	rax, LIMIT_MAX
ja 		limitRangeErr

mov 	rax, TRUE
jmp 	done

clERR:
mov 	rdi, errOptions
call 	printString
mov 	rax, FALSE
jmp 	done

usageErr:
mov 	rdi, errUsage
call 	printString
mov 	rax, FALSE
jmp 	done

threadRangeErr:
mov 	rdi, errTRange
call 	printString
mov 	rax, FALSE
jmp 	done

limitRangeErr:
mov 	rdi, errLRange
call 	printString
mov 	rax, FALSE
jmp 	done

limitValueErr:
mov 	rdi, errLValue
call 	printString
mov 	rax, FALSE
jmp 	done

limitSpecErr:
mov 	rdi, errLSpec
call 	printString
mov 	rax, FALSE
jmp 	done

threadValueErr:
mov 	rdi, errTValue
call 	printString
mov 	rax, FALSE
jmp 	done

threadSpecErr:
mov 	rdi, errTSpec
call 	printString
mov 	rax, FALSE
jmp 	done

done:
pop 	r15
pop 	r14
pop 	r13
pop 	r12
pop 	rbx

ret





; ******************************************************************
;  Function: Check and convert ASCII/senary to integer.

;  Example HLL Call:
;	bool = aSenary2int(senaryStr, &num);

global aSenary2int
aSenary2int:

push 	rbx
push 	r11
push 	r12
push 	r13
push 	r14

mov 	r11, 0
countPos:
mov 	al, byte [rdi + r11]
inc 	r11
cmp 	al, NULL
jne 	countPos
dec 	r11

mov 	r12, 0					;counter for string
mov 	r13, r11
dec 	r13						;n-1
mov 	rbx, 6					;base
mov 	r14, 0					;store

toDigit:
movzx 	rax, byte [rdi + r12]

cmp 	al, "0"
jb 		valueErr

cmp 	al, "9"
ja		valueErr

sub 	al, 48

cmp 	r13, 0
jne 	exp
jmp 	continue

exp:
mul 	ebx
dec 	r13
cmp 	r13, 0
jne 	exp

continue:
add 	r14, rax

inc 	r12
dec 	r11
mov 	r13, r11
dec 	r13
cmp 	r11, 0
jne 	toDigit

cmp 	r14, 0
jbe 	valueErr

cmp 	r14, 10
jb 		returnDword
jmp 	returnQword

returnDword:
mov 	dword [rsi], r14d
mov 	rax, TRUE
jmp 	done2

returnQword:
mov 	qword [rsi], r14
mov 	rax, TRUE
jmp 	done2

valueErr:
mov 	rax, FALSE
jmp 	done2

done2:
pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	rbx

ret




; ******************************************************************
;  Thread function, findSmithNumberCount()
;	Determine count of smith numbers for all values between
;	1 and userLimit (globally available)

; -----
;  Arguments:
;	N/A (global variable accessed)
;  Returns:
;	N/A (global variable accessed)

common	userLimit		1:8
common	smithNumberCount	1:8

global 	findSmithNumberCount
findSmithNumberCount:

;Display one time starting thread message
; Obtain the next number to check (via global variable, currentIndex)
; 	increment counter
; while the next number is <= userLimit
; 	Check if the number is a smith number
; 	If the number is a smith number, increment the smith number count
; currentIndex	dq	1
; myLock		dq	0
push 	rbx
push 	r12
push 	r13

mov 	r13, qword [userLimit]

mov 	rdi, msgThread1
call 	printString

SNLOOP:
call 	spinLock
mov 	rbx, qword [currentIndex]
inc 	qword [currentIndex]
call 	spinUnlock

cmp 	qword [currentIndex], r13
jbe 	SNLOOPBODY
jmp 	SNLOOPEND

SNLOOPBODY:
mov 	rdi, rbx
call 	isPrime
cmp 	rax, TRUE					;if prime then not a Smith Number
je		notSN

mov 	rdi, rbx
call 	findSumPrimeFactors
mov 	r12, rax					;prime sum

mov 	rdi, rbx
call 	findSumOfDigits
cmp 	rax, r12					;comparing prime factor sum and sum of the digits
jne 	notSN

lock inc 	qword [smithNumberCount]

notSN:
jmp 	SNLOOP

SNLOOPEND:
pop 	r13
pop 	r12
pop 	rbx

ret



; ******************************************************************
;  Check if prime function -> isPrime()

;	if (n <= 1)
;		return false;
;	for (int i = 2; i <= n/2; i++)
;		if (n % i == 0)
;			return false;
;	return true;

; -----
; Arguments
;	number

; Returns
;	TRUE / FALSE

global isPrime
isPrime:

push 	rbx
push 	r12
push 	r13

cmp 	rdi, 1
jbe 	returnFalse

;for(int i = 2; i <= n/2; i++)
mov 	r12, 2
mov 	r13, rdi
shr 	r13, 1				;n/2

isPrimeLoop:
cmp 	r12, r13			;if (i <= n/2)
ja 		returnTrue
mov 	rax, rdi			;rax = n
cqo
div 	r12d				;n % i
inc 	r12
cmp 	rdx, 0				;if(n % i == 0) then return false
je 		returnFalse
jmp 	isPrimeLoop

returnTrue:
mov 	rax, TRUE
jmp 	isPrimeComplete

returnFalse:
mov 	rax, FALSE

isPrimeComplete:
pop 	r13
pop 	r12
pop 	rbx

ret


; ******************************************************************
;  Find sum of digits for given number -> findSumOfDigits()
;  Sum digits for number.
;	set sumDigits = 0
;	set tmp = n
;	while tmp > 0 repeat
;		set sumDigits = sumDigits + (tmp mod 10)
;		set tmp = tmp / 10

; -----
;  Arguments:
;	number rdi

;  Returns
;	sum (in rax)

global findSumOfDigits
findSumOfDigits:

push 	rbx
push 	r12

mov 	r12, 0			;int sum = 0

sumWhileLoop:
cmp 	rdi, 0			;while (n > 0)
ja		calculateSum
jmp 	sumCalculated
calculateSum:
mov 	rax, rdi
cqo
div 	dword [qTen]	;n % 10
add 	r12, rdx		;sumDigits = sumDigits + (n % 10)
mov 	rdi, rax		;n = n / 10
jmp 	sumWhileLoop
sumCalculated:
mov 	rax, r12

pop 	r12
pop 	rbx

ret


; ******************************************************************
;  Find sum of prime factors -> findSumPrimeFactors()

;	int i = 2, sum = 0;
;	while (n > 1) {
;		if (n % i == 0) {
;			sum = sum + findSumOfDigit(i);
;			n = n / i;
;		} else {
;			do {
;				i++;
;			} while (!isPrime(i));
;		}
;	}
;	return sum;

; -----
;  Arguments:
;	number

;  Returns
;	sum (in rax)

global findSumPrimeFactors
findSumPrimeFactors:
	push	rbx
	push	r12
	push	r13

	mov	rbx, rdi			; save n
	mov	r12, 2				; i=2
	mov	r13, 0				; sum=0

;	while (n > 1) {
primeFactorsLoop:
	cmp	rbx, 1
	jle	primeFactorsDone

;	if ((n % i) == 0) {
	mov	rax, rbx
	mov	rdx, 0
	div	r12
	cmp	rdx, 0
	jne	notDivisible

primeDigitsLoop:
	mov	rdi, r12
	call	findSumOfDigits
	add	r13, rax			; sum += findSumOfDigit(i);

;	n = n / i;
	mov	rax, rbx
	mov	rdx, 0
	div	r12
	mov	rbx, rax
	jmp	primeIfDone

notDivisible:					; } else {
;	do { i++; } while (!isPrime(i));
	inc	r12
	mov	rdi, r12
	call	isPrime
	cmp	rax, TRUE
	jne	notDivisible

primeIfDone:
	jmp	primeFactorsLoop		;; // end while

primeFactorsDone:
	mov	rax, r13			; return sum;

	pop	r13
	pop	r12
	pop	rbx
	ret

; ******************************************************************
;  Mutex lock
;	checks lock (shared global variable)
;		if unlocked, sets lock
;		if locked, lops to recheck until lock is free

global	spinLock1
spinLock:
	mov	rax, 1			; Set the REAX register to 1.

lock	xchg	rax, qword [myLock]	; Atomically swap the RAX register with
					;  the lock variable.
					; This will always store 1 to the lock, leaving
					;  the previous value in the RAX register.

	test	rax, rax	        ; Test RAX with itself. Among other things, this will
					;  set the processor's Zero Flag if RAX is 0.
					; If RAX is 0, then the lock was unlocked and
					;  we just locked it.
					; Otherwise, RAX is 1 and we didn't acquire the lock.

	jnz	spinLock		; Jump back to the MOV instruction if the Zero Flag is
					;  not set; the lock was previously locked, and so
					; we need to spin until it becomes unlocked.
	ret

; ******************************************************************
;  Mutex unlock
;	unlock the lock (shared global variable)

global	spinUnlock
spinUnlock:
	mov	rax, 0			; Set the RAX register to 0.

	xchg	rax, qword [myLock]	; Atomically swap the RAX register with
					;  the lock variable.
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
; Count characters to write.

	mov	rdx, 0
strCountLoop:
	cmp	byte [rdi+rdx], NULL
	je	strCountLoopDone
	inc	rdx
	jmp	strCountLoop
strCountLoopDone:
	cmp	rdx, 0
	je	printStringDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; rdx=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

printStringDone:
	ret

; ******************************************************************

