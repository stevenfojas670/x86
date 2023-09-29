; *****************************************************************
;  Name: 
;  NSHE_ID: 
;  Section:
;  Assignment: 9
;  Description: 

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



; ****************************************************************************

