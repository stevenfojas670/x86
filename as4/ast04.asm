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
;  Assignment #4 declarations

list dd 2140, 1116, 1540, 1240, 1677, 1635, 2426, 1820
 dd 1614, 2418, 2513, 1420, 2119, 1215, 1525, 1712
 dd 1441, 3622, 1731, 1729, 1615, 1724, 1217, 1224
 dd 1580, 1147, 2324, 1425, 1816, 1262, 2718, 2192
 dd 1432, 1235, 2764, 1615, 1310, 1765, 1954, 1967
 dd 1515, 3556, 1342, 7321, 1556, 2727, 1227, 1927
 dd 1382, 1465, 3955, 1435, 1225, 2419, 2534, 1345
 dd 2467, 1315, 1961, 1335, 2856, 2553, 1032, 1835
 dd 1246, 2330, 2317, 1115, 2726, 2140, 2565, 2871
 dd 1464, 1915, 1810, 1465, 1554, 1267, 1615, 1656
 dd 2192, 1825, 1925, 2312, 1725, 2517, 1498, 1677
 dd 1475, 2034, 1223, 1883, 1173, 1350, 1415, 1335
 dd 1125, 1118, 1713, 3025
length dd 100
listMin dd 0
listEstMed dd 0
listMax dd 0
listSum dd 0
listAve dd 0
evenCnt dd 0
evenSum dd 0
evenAve dd 0
tenCnt dd 0
tenSum dd 0
tenAve dd 0

; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------

;Using length to loop through 

mov 	r12, 0					;Counter for the list
mov 	ebx, 2					;Used to divide by two and also find even numbers
mov 	ecx, 10					;Used to find numbers divisible by 10
mov 	eax, dword [list]
mov 	dword [listMin], eax	;Placing the first value of list into both min and max
mov 	dword [listMax], eax
mov 	r11, 0
mov 	r10, 0

loopStart:

;Set first value to min
;Set first value to max
mov 	eax, dword [list + r12 * 4]
add 	dword [listSum], eax			;Finding the sum

cmp 	eax, dword [listMin]
jb 		swapMin
jmp		checkMax

swapMin:
mov 	dword [listMin], eax

checkMax:
cmp 	eax, dword [listMax]
ja		swapMax
jmp 	checkEven

swapMax:
mov 	dword [listMax], eax

checkEven:
cdq
div 	ebx
cmp 	edx, 0
je		isEven
jmp 	divBy10

isEven:
inc 	r11
mov 	eax, dword [list + r12 * 4] 	;Getting the position in the list back
mov 	dword [evenCnt], r11d			;Getting the count
add 	dword [evenSum], eax

divBy10: ;Divides eax by 10 from ecx, if edx is 0 then eax is divisible by 10
mov 	eax, dword [list + r12 * 4]
cdq
div 	ecx
cmp		edx, 0
je		isDivBy10
jmp 	continue

isDivBy10:
inc 	r10
mov 	eax, dword [list + r12 * 4] 	;Getting the position in the list back
mov 	dword [tenCnt], r10d			;Getting the count
add 	dword [tenSum], eax

continue:

inc 	r12
cmp 	r12d, dword [length]
jne	 	loopStart

;Find the integer average for list
;Average = Sum / Length

mov 	rax, 0 	;clearing rax just incase
mov 	eax, dword [listSum]
cdq
div 	dword [length]
mov 	dword [listAve], eax

;Finding the integer average for evens

mov 	rax, 0
mov 	eax, dword [evenSum]
cdq
div 	dword [evenCnt]
mov 	dword [evenAve], eax

;Finding the integer average for values divisible by 10

mov 	rax, 0
mov 	eax, dword [tenSum]
cdq
div 	dword [tenCnt]
mov 	dword [tenAve], eax

;Finding the estimated median 
;EstMed = [(length / 2) + ((length / 2) + 1)] / 2

;EstMed for list

mov 	eax, dword [length]
cdq
div 	ebx
mov 	r12, 0	;clearing r12 just in case
mov 	r12d, eax

mov 	eax, dword [list + r12 * 4] ;First middle value
add 	eax, dword [list + ((r12 * 4) - 4)] ;Second middle value
cdq		;not necessary but good practice I guess lol
div 	ebx
mov 	dword [listEstMed], eax

mov 	ax, byte [rbx]

; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

