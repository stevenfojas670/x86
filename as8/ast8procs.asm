; *****************************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 8
;  Description: Learning to write functions


; --------------------------------------------------------------------
;  Write assembly language functions.

;  * Function oddEvenSort() sorts the numbers into descending order
;	(large to small).

;  * Function listStats() finds the minimum, maximum, and median for a
;	list of numbers.

;  * Function listSum() to find and return the sum of a list of numbers.

;  * Function estimatedMedian() to find and return the estimated median
;	of a list of numbers.

;  * Function estimatedSkew() finds the estimated skew value based on the 
;	formula:
;			  sum (lst[i] - average)^2
;		 skew  =  --------------------------
;				  len * 3
;	The summation must be performed as a quad-word.


; ============================================================================

section	.data

; -----
;  Define constants.

TRUE		equ	1
FALSE		equ	0

; -----
;  Local variables for oddEvenSort() function.

weight		dd	12
dtwo		dd	2
ddTen		dd	10
ddTwelve	dd	12
dNine		dd	9
isSorted 	db 	0

; -----
;  Local variables for lstStats() function (if any).



section	.bss

; -----
;  Unitialized variables.

qSum		resq	1
qTmp		resq	1


; ============================================================================

section	.text

; *****************************************************************************
;  Sort data using odd/even sort.
;	Note, must update the odd/even sort algorithm to sort
;	in desending order

; -----
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

; -----
;  HLL Call:
;	oddEvenSort(list, len)

;  Arguments Passed:
;	- list, addr
;	- length, value

;  Returns:
;	sorted list (list passed by reference)

global	oddEvenSort
oddEvenSort:


;	YOUR CODE GOES HERE
;rdi: list address
;rsi: length value 
push 	r12
push 	r13
push 	rbx
push 	rcx

while:
mov 	byte [isSorted], 1	;isSorted = true
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
jae 		continue1

mov 	dword [rdi + r12 * 4], ecx	;list[i] = list[i+1]
mov 	dword [rdi + ((r12 * 4) + 4)], ebx ;list[i+1] = list[i]
mov 	byte [isSorted], 0	;sorted = false

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
jae 		continue2

mov 	dword [rdi + r12 * 4], ecx	;list[i] = list[i+1]
mov 	dword [rdi + ((r12 * 4) + 4)], ebx ;list[i+1] = list[i]
mov 	byte [isSorted], 0	;sorted = false

continue2:
add 	r12, 2
jmp 	forLoop2
whileCondition:
cmp 	byte [isSorted], 0
je 		while

pop 	rcx
pop 	rdx
pop 	r13
pop 	r12

ret

; *****************************************************************************
;  Find the minimum, maximum, median, sum and average for a list of integers

;  Note, for an odd number of items, the median value is defined as
;  the middle value.  For an even number of values, it is the integer
;  average of the two middle values.

;  Note, assumes the list is already sorted in desending order.

; -----
;  HLL Call:
;	listStats(list, len, &min, &max, &med)

;  Arguments Passed:
;	- list, addr - rdi
;	- length, value - esi
;	- minimum, addr - rdx
;	- maximum, addr - rcx
;	- median, addr - r8
;	- sum, addr - r9
;	- ave, addr - stack
;  Returns:
;	minimum, maximum, median, sum, and average (via reference)

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
	mov 	r13d, dword [rbp + 16]
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

; *****************************************************************************
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


; *****************************************************************************
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

global estimatedSkew
estimatedSkew:


;	YOUR CODE GOES HERE
;Summation is just a loop, so keep going for x long iterations

	push 	r12 	;this will be the counter
	push 	r13 	;will be len - 1
	push 	r14

	mov 	r12, 0
	dec 	esi		;len - 1

	skewLoop:
	;(list[i] - average)^2
	mov 	r13d, dword [rdi + r12 * 4]	;list[i]
	sub 	r13d, edx		;list[i] - average
	shl 	r13d, 1			;performs a square on r13
	add 	r14, r13		;summation
	inc 	r12
	cmp 	r12d, esi
	jb 		skewLoop
	;Divide the summation by len * 3
	

	pop 	r14
	pop 	r13
	pop		r12

	ret

; *****************************************************************************

