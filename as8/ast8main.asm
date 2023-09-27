;  CS 218 - Assignment 8
;  Provided Main.

;  DO NOT EDIT/ALTER THIS FILE

; **********************************************************************************
;  Main routine to call assembly language functions:

;  * Function oddEvenSort() sorts the numbers into descending order
;	(large to small).

;  * Function listStats() finds the minimum, maximum, and median for a
;	list of numbers.

;  * Function listSum() to find and return the sum of a list of numbers.

;  * Function estimatedMedian() to find and return the estimated median
;	of a list of numbers.

;  * Function estimatedSkew() finds the estimated skew value based on the
;	provided formula.

; **********************************************************************************

section .data

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
;  Data Sets for Assignment #8.

array1		dd	 3321,     27,     10,     22,     61
		dd	   13,   1111,     22,    141,    216
		dd	    3,     12,    120,     19,     20
		dd	   20,   1427,     12,     30,     33
		dd	   30,     33,   2223,   1141,   1160
		dd	   90,     18,    150,    475,     23
		dd	 1110,   1137,   2346,   9999,   1212
len1		dd	35
min1		dd	0
max1		dd	0
med1		dd	0
sum1		dd	0
ave1		dd	0
estMed1		dd	0
skew1		dd	0

array2		dd	 5195,  10184,  12193,   1172,  12111
		dd	11090,    279,  10281,  10087,   2185
		dd	20135,    104,  10173,   1122,    160
		dd	 6129,   9113,   1155,   1135,   1437
		dd	 2119,   1141,   2143,   1145,   3149
		dd	 1175,  11214,    121,  18195,  12349
		dd	12327,  30255,  15417,  11115,  11361
		dd	21000,   1220,   1122,   3124,   9026
		dd	 1129,  12213,   3455,   1535,   5437
		dd	  739,    341,  11543,  10345,  10349
		dd	12153,   2319,  12123,  13217,  13459
len2		dd	55
min2		dd	0
max2		dd	0
med2		dd	0
sum2		dd	0
ave2		dd	0
estMed2		dd	0
skew2		dd	0

array3		dd	12153,  12319,  12123,  13217,  13459
		dd	32127,  26135,  42117,  91115,  71161
		dd	51110,  41120,  93122,  11124,  51226
		dd	26129,  79113,  61155,  31135,  31437
		dd	72119,  51141,  82143,  51145,  73149
		dd	99153,  89119,  31123,  12117,  51259
		dd	61116,  91115,  52151,  31167,  41169
		dd	71128,  19130,  73132,  61133,  41111
		dd	33138,  21140,  11142,  72144,  21146
		dd	22121,  31125,  25151,  82113,  51219
		dd	11257,  59199,  44153,  91165,  12179
		dd	61127,  11155,  84117,  15115,  31161
		dd	67183,  49114,  62121,  25128,  21212
		dd	51126,  51117,  21127,  31127,  83184
		dd	32174,  62912,  42115,  41616,  92229
		dd	94318,  71335,  31351,  31818,  72515
		dd	11126,  83317,  82315,  61000,  41414
		dd	21124,  93113,  71514,  91212,  31313
		dd	11129,  12213,  43455,  51535,  55437
		dd	25174,  69112,  11125,  45126,  91129
		dd	11188,  71115,  31111,  62118,  71215
		dd	33126,  39117,  42115,  71110,  41114
		dd	41124,  21143,  53134,  22112,  52113
		dd	72172,  79176,  81156,  11165,  31256
		dd	61153,  41140,  92191,  31168,  11162
		dd	51146,  32147,  13167,  53177,  21144
len3		dd	130
min3		dd	0
max3		dd	0
med3		dd	0
sum3		dd	0
ave3		dd	0
estMed3		dd	0
skew3		dd	0

array4	  	dd	22244,  31234,  71313,  61221,   3216
		dd	52130,  51233,  52223,  51141,  51160
		dd	11141,  24321,  82324,  32313,  25223
		dd	31318,  45197,  21112,  22410,  11110
		dd	22124,  43243,  13524,  11512,  32323
		dd	42153,  71440,  51111,  82618,  62212
		dd	64447,  83427,  84414,  73717,  82919
		dd	79999,  99999,  99999,  99999,  99999
		dd	85183,  21450,  25651,  24828,  51515
		dd	13183,  12414,  54311,  52918,  21212
		dd	21426,  21917,  73217,  62717,  41414
		dd	32174,  62912,  42115,  41616,  92229
		dd	94318,  71335,  31351,  31818,  72515
		dd	11126,  83317,  82315,  61000,  41414
		dd	21124,  93113,  71514,  91212,  31313
		dd	34272,  13326,  22416,  42515,  51616
		dd	45153,  52910,  73451,  81818,  44212
		dd	99999,  69999,  40099,  69999,  54399
		dd	22146,  32317,  41317,  42117,  51211
		dd	11255,  71452,  52615,  63219,  66111
		dd	41464,  81552,  61715,  74312,  61253
		dd	51483,  22515,  82911,  33418,  21137
		dd	62966,  53717,  71987,  62617,  52435
		dd	72610,  64320,  92332,  43524,  32659
		dd	29999,  19999,  99999,  52009,  99999
		dd	31319,  51232,  31195,  41335,  81373
		dd	23339,  92341,  12343,  81345,  41494
		dd	11353,  31439,  21313,  31000,  51953
		dd	12416,  51415,  51551,  61667,  32912
		dd	41628,  62430,  61132,  92133,  81000
		dd	62938,  43240,  32342,  42444,  61461
		dd	71121,  44425,  41251,  61313,  41191
		dd	31257,  95999,  31153,  12665,  41791
		dd	41118,  42455,  62417,  33515,  92111
		dd	21283,  33234,  42611,  41828,  62221
		dd	62826,  54317,  63827,  82127,  52400
		dd	11168,  63115,  83611,  71218,  31550
		dd	22436,  72317,  71515,  82411,  61448
		dd	73314,  31243,  41334,  32312,  42381
		dd	21432,  88276,  22156,  41665,  71647
		dd	33353,  41140,  32231,  61868,  82265
		dd	52896,  86547,  51367,  41777,  12446
		dd	63455,  23332,  71385,  72449,  31146
		dd	81264,  33472,  82175,  73162,  41721
		dd	99999,  53049,  99999,  99999
len4		dd	224
min4		dd	0
max4		dd	0
med4		dd	0
sum4		dd	0
ave4		dd	0
estMed4		dd	0
skew4		dd	0


; **********************************************************************************

extern  oddEvenSort
extern	listStats
extern	estimatedMedian
extern	estimatedSkew

section	.text

section	.text
global	_start
_start:

; **************************************************
;  Main routine calls functions for each data set.

;  Notes:
;	The high level language call is shown (in comments) followed
;	by the implementing assembly code for each.

;	Assembly functions return results in eax (for double word values).

; **************************************************
;  Call functions for data set 1.

;  estMed = estimatedMedian(array, length);
	mov	rdi, array1
	mov	esi, dword [len1]
	call	estimatedMedian
	mov	dword [estMed1], eax			; save average result

;  oddEvenSort(array, len)
	mov	rdi, array1
	mov	esi, dword [len1]
	call    oddEvenSort

;  listStats(array, len, min, max, med, sum, ave)
	mov	rdi, array1
	mov	esi, dword [len1]
	mov	rdx, min1
	mov	rcx, max1
	mov	r8, med1
	mov	r9, sum1
	push	ave1
	call    listStats
	add	rsp, 8

;  skew = estimatedSkew(array, len, ave)
	mov	rdi, array1
	mov	esi, dword [len1]
	mov	edx, dword [ave1]
	call	estimatedSkew
	mov	dword [skew1], eax			; save skew result

; **************************************************
;  Call procedures for data set 2.

;  estMed = estimatedMedian(array, length);
	mov	rdi, array2
	mov	esi, dword [len2]
	call	estimatedMedian
	mov	dword [estMed2], eax			; save average result

;  oddEvenSort(array, len)
	mov	rdi, array2
	mov	esi, dword [len2]
	call    oddEvenSort

;  listStats(array, len, min, max, med, sum, ave)
	mov	rdi, array2
	mov	esi, dword [len2]
	mov	rdx, min2
	mov	rcx, max2
	mov	r8, med2
	mov	r9, sum2
	push	ave2
	call    listStats
	add	rsp, 8

;  skew = estimatedSkew(array, len, ave)
	mov	rdi, array2
	mov	esi, dword [len2]
	mov	edx, dword [ave2]
	call	estimatedSkew
	mov	dword [skew2], eax			; save skew result

; **************************************************
;  Call procedures for data set 3.

;  estMed = estimatedMedian(array, length);
	mov	rdi, array3
	mov	esi, dword [len3]
	call	estimatedMedian
	mov	dword [estMed3], eax			; save average result

;  oddEvenSort(array, len)
	mov	rdi, array3
	mov	esi, dword [len3]
	call    oddEvenSort

;  listStats(array, len, min, max, med, sum, ave)
	mov	rdi, array3
	mov	esi, dword [len3]
	mov	rdx, min3
	mov	rcx, max3
	mov	r8, med3
	mov	r9, sum3
	push	ave3
	call    listStats
	add	rsp, 8

;  skew = estimatedSkew(array, len, ave)
	mov	rdi, array3
	mov	esi, dword [len3]
	mov	edx, dword [ave3]
	call	estimatedSkew
	mov	dword [skew3], eax			; save skew result

; **************************************************
;  Call procedures for data set 4.

;  estMed = estimatedMedian(array, length);
	mov	rdi, array4
	mov	esi, dword [len4]
	call	estimatedMedian
	mov	dword [estMed4], eax			; save average result

;  oddEvenSort(array, len)
	mov	rdi, array4
	mov	esi, dword [len4]
	call    oddEvenSort

;  listStats(array, len, min, max, med, sum, ave)
	mov	rdi, array4
	mov	esi, dword [len4]
	mov	rdx, min4
	mov	rcx, max4
	mov	r8, med4
	mov	r9, sum4
	push	ave4
	call    listStats
	add	rsp, 8

;  skew = estimatedSkew(array, len, ave)
	mov	rdi, array4
	mov	esi, dword [len4]
	mov	edx, dword [ave4]
	call	estimatedSkew
	mov	dword [skew4], eax			; save skew result

; **************************************************
;  Done, terminate program.

last:
	mov	rax, SYS_exit
	mov	rdi, EXIT_SUCCESS
	syscall

; **********************************************************************************

