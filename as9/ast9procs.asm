; *****************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 9
;  Description: Using system services and working with high level languages

; --------------------------------------------------------------------
;  Write some assembly language functions.

;  The value returning function estimatedMedian() returns the
;  median for a list of unsorted numbers.

;  The void function, oddEvenSort(), sorts the numbers into
;  ascending order (small to large).  Uses the odd/even sort
;  algorithm from assignment #7 (with sort order modified).

;  The void function, lstStats(), finds the sum, average, minimum,
;  maximum, and median for a list of numbers.  Results returned
;  via reference.

;  The value returning function, estimatedSkew(), computes the
;  skew statictic for the data set.  Summation for the
;  dividend must be performed as a quad.

; ******************************************************************************

section	.data

; -----
;  Define standard constants.

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
;  Define program specific constants.

SUCCESS 	equ	0
NOSUCCESS	equ	1
OUTOFRANGEMIN	equ	2
OUTOFRANGEMAX	equ	3
INPUTOVERFLOW	equ	4
ENDOFINPUT	equ	5

MIN_NUM		equ	1
MAX_NUM		equ	50000

BUFFSIZE	equ	50			; 50 chars including NULL

; -----
;  NO static local variables allowed...

; ****************************************************************************

section	.text

; -----------------------------------------------------------------------------
;  Read an ASCII senary number from the user.
;  Performs all error checking.

; -----
;  Call:
;	status = readSenaryNum(&numberRead);

;  Arguments Passed:
;	1) numberRead, addr

;  Returns:
;	number read (via reference)
;	return code

;  Return codes:
;	SUCCESS		Successful conversion and number within required range
;	NOSUCCESS	Invalid input entered (i.e., not a valid senaray number)
;	OUTOFRANGEMIN	Valid tetradecimal number, but below minimum value
;	OUTOFRANGEMAX	Valid tetradecimal number, but above maximum value
;	INPUTOVERFLOW	User entry character count exceeds maximum length
;	ENDOFINPUT	Return entered, no characters (for end of the input)



;	YOUR CODE GOES HERE

global readSenaryNum
readSenaryNum:

;&numberRead is actually just the return address of the converted value
;we are reading into numberRead
;rdi input location
;rsi address where to store characters read
;rdx number of chars to read
;Convert each char into a senary number
;ignore whitespace
;MIN_NUM <= number <= MIN_MAX (Converted number)
;Input must be < BUFFSIZE 
;if (input.size() == BUFFSIZE)
;   if(input[BUFFSIZE] != NULL)
;       ignore line
;If any errors return codes in eax

push 	rdi
push 	rsi
push 	rdx
push 	rbx			;stores newNumber
push 	r12			;stores size of input
push 	r11			;counter
push 	r14
push 	rcx			;stores 10

mov 	r12, 0 		;counter for chars
mov 	rbx, rdi
readChars:
mov 	rax, SYS_read
mov 	rdi, STDIN
lea 	rsi, byte [rbx]
mov 	rdx, 1
syscall

mov 	al, byte [rbx]

cmp 	al, LF
je 		readDone

cmp 	al, SPACE
je 		readChars

inc 	r12
cmp 	r12, BUFFSIZE
jae 	readChars

mov 	byte [rbx], al
inc 	rbx

jmp 	readChars
readDone:

cmp 	r12, BUFFSIZE - 1
ja 		overFlow

cmp 	r12, 0
je 		empty

mov 	r11, 0	
returnNewNumber:	;Reverting rbx back to rbx[0]
dec 	rbx
inc 	r11
cmp 	r11, r12
jb 		returnNewNumber

;Debugging to see if the values were properly placed into rbx

mov 	rax, 0
mov 	r11, 0
stringLoop:
mov 	al, byte [rbx + r11]
inc 	r11
cmp 	r11, r12
jb 		stringLoop

;Debugging done

mov 	r11, 0
mov 	rdx, r12
dec 	rdx 		;n-1
mov 	rcx, 10		;base 10
mov 	r14, 0

toDigit:
movzx 	eax, byte [rbx + r11]

cmp 	al, 48
jb		invalidNumber

cmp 	al, 54
jae		invalidNumber
sub 	eax, 48

cmp 	rdx, 0
jne 	exp
jmp 	continue3

exp:
mul 	cl
dec 	rdx
cmp 	rdx, 0
jne 	exp

continue3:
add 	r14d, eax

inc 	r11
dec 	r12			
mov 	rdx, r12	;Getting the proper size of the string
dec 	rdx			;decreasing n to do x^n-1
cmp 	r12, 0
jne 	toDigit

;ERROR CHECKING

cmp 	r14d, MAX_NUM
ja 		aboveMax

cmp 	r14d, MIN_NUM
jb		belowMin
jmp 	success

belowMin:
mov 	eax, 2
jmp 	done

aboveMax:
mov 	eax, 3
jmp 	done

empty:
mov 	eax, 5
jmp 	done

invalidNumber:
mov 	eax, 1
jmp 	done

overFlow:
mov 	eax, 4
jmp 	done

success:
mov 	eax, 0
mov 	qword [rbx], r14

done:
pop 	rcx
pop 	r14
pop 	r11
pop 	r12
pop 	rbx
pop 	rdx
pop 	rsi
pop 	rdi


ret


; ****************************************************************************
;  Sort data using odd/even sort.
;	Note, must update the odd/even sort algorithm to sort
;	in asending order

; -----
;  function oddEvenSort(list) {
;	bool sorted = false;

;	while (!sorted) {
;		sorted = true;
;		for (var i=1; i < len-1; i+=2) {
;			if (list[i] > list[i+1]) {
;			swap(list, i, i+1);
;			sorted = false;
;			}
;		}
;		for (var i=0; i < len-1; i+=2) {
;			if (list[i] > list[i+1]) {
;				swap(list, i, i+1);
;				sorted = false;
;			}
;		}
;	}
;  }

; -----
;  HLL Call:
;	oddEvenSort(list, len)

;  Arguments Passed:
;	- list, addr
;	- length, value

;  Returns:
;	sorted list (list passed by reference)


;	YOUR CODE GOES HERE

global oddEvenSort
oddEvenSort:

push 	r12
push 	r13
push 	rbx
push 	rcx
push    r15

while:
mov 	r15b, 1	;isSorted = true
mov 	r12, 1	;i = 1 for first loop
mov 	r13d, esi
sub 	r13d, 1	;len-2

forLoop1:
cmp 	r12d, r13d
jae 	nextLoop

;if statement
mov 	ebx, dword [rdi + r12 * 4]	;list[i]
mov 	ecx, dword [rdi + ((r12 * 4) + 4)] ;list[i + 1]

cmp 	ebx, ecx	;if(list[i] < list[i+1])
jbe 		continue1

mov 	dword [rdi + r12 * 4], ecx	;list[i] = list[i+1]
mov 	dword [rdi + ((r12 * 4) + 4)], ebx ;list[i+1] = list[i]
mov 	r15b, 0	;sorted = false

continue1:
add 	r12, 2	;i+=2
jmp 	forLoop1
nextLoop:
mov 	r12, 0

forLoop2:
cmp 	r12d, r13d
jae 	whileCondition

;if statement
mov 	ebx, dword [rdi + r12 * 4]	;list[i]
mov 	ecx, dword [rdi + ((r12 * 4) + 4)] ;list[i + 1]

cmp 	ebx, ecx	;if(list[i] < list[i+1])
jbe 		continue2

mov 	dword [rdi + r12 * 4], ecx	;list[i] = list[i+1]
mov 	dword [rdi + ((r12 * 4) + 4)], ebx ;list[i+1] = list[i]
mov 	r15b, 0	;sorted = false

continue2:
add 	r12, 2
jmp 	forLoop2
whileCondition:
cmp 	r15b, 0
je 		while

pop     r15
pop 	rcx
pop 	rdx
pop 	r13
pop 	r12

ret


; *******************************************************************************
;  Find the minimum, maximum, median, sum and average for a list of integers

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  Note, assumes the list is already sorted in desending order.

; -----
;  HLL Call:
;	listStats(list, len, &min, &max, &med)

;  Arguments Passed:
;	- list, addr
;	- length, value
;	- minimum, addr
;	- maximum, addr
;	- median, addr
;	- sum, addr
;	- ave, addr (stack)
;  Returns:
;	minimum, maximum, median, sum, and average (via reference)


;	YOUR CODE GOES HERE

global listStats
listStats:


;	YOUR CODE GOES HERE
	push 	rbp
	mov 	rbp, rsp
	push 	r12
	push 	r13

	mov 	r12d, dword [rdi]			;placing max into max var
	mov 	dword [rcx], r12d
	mov 	r12d, dword [rdi + ((rsi * 4) - 4)]	;placing min into min var
	mov 	dword [rdx], r12d

	mov 	r12, 0
	mov 	r13, 0
	sumLoop:
	add 	r13d, dword [rdi + r12 * 4]
	inc 	r12
	cmp 	r12, rsi
	jb		sumLoop
	mov 	dword [r9], r13d
	;Calculate the average
	lea 	r13, dword [rbp + 16]
	mov 	eax, dword [r9]
	cdq
	div 	esi
	mov 	dword [r13], eax	;placing the average into the ave var

	;Checking if the list is even or odd
	push 	rdx			;preserving the minimum to use rdx for division
	mov 	eax, esi
	cdq 	
	mov 	r12, 2
	div 	r12
	cmp 	rdx, 1
	jne 	evenLength1

	mov 	r13, r8
	mov 	r12d, dword [rdi + rax * 4]
	mov 	dword [r13], r12d	;getting median for odd length array
	jmp 	statsDone

	evenLength1:
	mov 	r12, 0
	mov 	r12d, dword [rdi + rax * 4]
	add 	r12d, dword [rdi + ((rax * 4) - 4)]
	shr 	r12d, 1
	mov 	r13, r8
	mov 	dword [r13], r12d	;getting median for even length array

	statsDone:
	pop 	rdx
	pop 	r13
	pop 	r12
	pop 	rbp

	ret

; *******************************************************************************
;  Find the estimated median (before sort)

;  Even formula
;	est median = (arr[len/2] + arr[len/2-1]) / 2
;  Odd formula
;	est median = arr[len/2]

; -----
;  HLL Call:
;	estMed = estimatedMedian(list, len)

;  Arguments Passed:
;	- list, addr
;	- length, value

;  Returns:
;	estimated median (in eax)


;	YOUR CODE GOES HERE

global estimatedMedian
estimatedMedian:


;	YOUR CODE GOES HERE
	push 	rdx
	push 	r12
	mov 	eax, esi	;placing length
	cdq
	mov 	r12, 2
	div 	r12d
	cmp 	rdx, 1		;Checking of the remainder is 0 to determine if it is even
	jne 	evenLength2
	
	;Calculating odd
	mov 	r12, rsi	;placing length
	shr 	r12, 1		;dividing by 2
	mov 	eax, dword [rdi + r12 * 4]
	jmp 	medianDone

	evenLength2:
	mov 	r12, rsi	;placing length
	shr 	r12, 1		;dividing by 2
	mov 	eax, dword [rdi + r12 * 4]
	add 	eax, dword [rdi + ((r12 * 4) - 4)]
	shr 	eax, 1		;dividing by 2

	medianDone:
	pop 	r12
	pop 	rdx

	ret

; ****************************************************************************
;  Function to calculate the estimated skew value based on the 
;  formula:
;			  sum (lst[i] - average)^2
;		 skew  =  ------------------------
;				  len * 3

;   The subtraction (lst[i]-average may result in a negative value
;   and an IMIL must be used for perform the squaring which will
;   result in a positive value.
;   The summation must be performed as a quad-word.

; -----
;  HLL Call:
;	skew = estimatedSkew(list, len, ave)

;  Arguments Passed:
;	- list, addr
;	- length, value
;	- average, value

;  Returns:
;	skew value (in eax)


;	YOUR CODE GOES HERE

global estimatedSkew
estimatedSkew:


;	YOUR CODE GOES HERE
;Summation is just a loop, so keep going for x long iterations

	push 	r12 	;this will be the counter
	push 	r13 	;will be len - 1
	push 	r14
    push    r15     ;qTmp
    push    r10     ;qSum

	mov 	r12, 0
	mov  	r14, rsi		;len - 1
	dec 	r14
	mov 	r15, 0
	mov 	r10, 0

	skewLoop:
	;(list[i] - average)^2
	mov 	eax, dword [rdi + r12 * 4]
	sub 	eax, edx				;edx is the average
	push 	rdx
	cdq
	mul 	eax						;Squaring parenthesis
	mov 	r15d, eax
	mov 	r13, r15
	add 	r10, r13		;adding to the summation
	pop 	rdx
	inc 	r12
	cmp 	r12, r14
	jbe	 	skewLoop
	;Divide the summation by len * 3
	nop		;debugging point
	mov 	r12, 3
	mov 	eax, esi
	mul 	r12d
	mov 	r12, rax	;holds len * 3
	mov 	rax, r10
	cqo
	div 	r12
	nop
    pop     r10
    pop     r15
	pop 	r14
	pop 	r13
	pop		r12

	ret

; ****************************************************************************

