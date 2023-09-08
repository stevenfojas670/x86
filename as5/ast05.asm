;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 5
;  Description: Finding the min, max, estimated median value, sum, and
;	average for the areas and perimeters

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

; ----------------------------------------------------------
sideLens dd 1145, 1135, 1123, 1123, 1123
dd 1254, 1454, 1152, 1164, 1542
dd 1353, 1457, 1182, 1142, 1354
dd 1364, 1134, 1154, 1344, 1142
dd 1173, 1543, 1151, 1352, 1434
dd 1355, 1037, 1123, 1024, 1453
dd 1134, 2134, 1156, 1134, 1142
dd 1267, 1104, 1134, 1246, 1123
dd 1134, 1161, 1176, 1157, 1142
dd 1153, 1193, 1184, 1142, 2034
apothemLens dw 133, 114, 173, 131, 115
dw 164, 173, 174, 123, 156
dw 144, 152, 131, 142, 156
dw 115, 124, 136, 175, 146
dw 113, 123, 153, 167, 135
dw 114, 129, 164, 167, 134
dw 116, 113, 164, 153, 165
dw 126, 112, 157, 167, 134
dw 117, 114, 117, 125, 153
dw 123, 173, 115, 106, 113
length dd 50
perimMin dd 0
perimEstMed dd 0
perimMax dd 0
perimSum dd 0
perimAve dd 0
areaMin dd 0
areaEstMed dd 0
areaMax dd 0
areaSum dd 0
areaAve dd 0
; --------------------------------------------------------------
; Uninitialized data
section .bss
hexPerims resd 50
hexAreas resd 50


; *****************************************************************

section	.text
global _start
_start:

; ----------------------------------------------

;hexPerims [i] = 6 * sideLens[i]
;hexAreas[i] = (hexPerims[i] * apothemLens[i])/2

mov 	r12, 0		;counter

mainLoop:
mov 	eax, dword [sideLens + (r12 * 4)]
mov 	ecx, 6
mul 	ecx
mov 	dword [hexPerims], eax ;Placing the calculated perimeter into first hexPerim

;Calculate the area
movsx 	eax, word [apothemLens + (r12 * 2)]
mov 	ecx, 2
mul 	dword [hexPerims + (r12 * 4)]
cdq
div 	ecx
mov 	dword [hexAreas], eax

inc 	r12
cmp 	r12d, dword [length]
jne 	mainLoop

;min, max, estMed, sum, average for AREA and PERIM

mov 	r12, 0		;counter for the area and perim
mov 	eax, dword [hexPerims]
mov 	dword [perimMax], eax	;setting the min and max to the first val
mov 	dword [perimMin], eax

perimeterLoop:
mov 	eax, dword [hexPerims + (r12 * 4)]
add 	dword [perimSum], eax

cmp 	dword [perimMax], eax
jb 		swapMax
jmp 	checkMin

swapMax:
mov 	dword [perimMax], eax

checkMin:
cmp 	dword [perimMin], eax
ja 		swapMin
jmp 	continue

swapMin:
mov 	dword [perimMin], eax

continue:

inc 	r12
cmp 	r12d, dword [length]
jne 	perimeterLoop

;Average and EstMed
mov 	eax, dword [perimSum]
cdq
div 	dword [length]
mov 	dword [perimAve], eax

mov 	eax, dword [length]
cdq 	
mov 	ecx, 2
div 	ecx
mov 	r12d, eax

mov 	eax, dword [hexPerims + (r12d * 4)]
add 	eax, dword [hexPerims + (r12d * 4) - 4]
mov 	ecx, 2
cdq
div 	ecx
mov 	dword [perimEstMed], eax

;--------------------------------------------------------------------------------------------

mov 	r12, 0		;counter for the area and perim
mov 	eax, dword [hexAreas]
mov 	dword [areaMax], eax	;setting the min and max to the first val
mov 	dword [areaMin], eax

areaLoop:
mov 	eax, dword [hexAreas + (r12 * 4)]
add 	dword [areaSum], eax

cmp 	dword [areaMax], eax
jb 		swapMaxArea
jmp 	checkMinArea

swapMaxArea:
mov 	dword [areaMax], eax

checkMinArea:
cmp 	dword [areaMin], eax
ja 		swapMinArea
jmp 	continueArea

swapMinArea:
mov 	dword [areaMin], eax

continueArea:

inc 	r12
cmp 	r12d, dword [length]
jne 	areaLoop

;Average and EstMed
mov 	eax, dword [areaSum]
cdq
div 	dword [length]
mov 	dword [areaAve], eax

mov 	eax, dword [length]
cdq 	
mov 	ecx, 2
div 	ecx
mov 	r12d, eax

mov 	eax, dword [hexAreas + (r12d * 4)]
add 	eax, dword [hexAreas + (r12d * 4) - 4]
mov 	ecx, 2
cdq
div 	ecx
mov 	dword [areaEstMed], eax

; *****************************************************************
;	Done, terminate program.

last:
	mov	rax, SYS_exit			; system call for exit (SYS_exit)
	mov	rdi, EXIT_SUCCESS		; return C/C++ style code (0)
	syscall

