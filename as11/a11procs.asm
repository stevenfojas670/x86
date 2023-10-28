; *****************************************************************
;  Name: Steven Fojas
;  NSHE_ID: 2001342715
;  Section: 1003
;  Assignment: 11
;  Description: Using Syscalls and buffer I/O to change modify bmp files


; ***********************************************************************
;  Data declarations
;	Note, the error message strings should NOT be changed.
;	All other variables may changed or ignored...

; ***********************************************************************
;  Data declarations
;	Note, the error message strings should NOT be changed.
;	All other variables may changed or ignored...

section	.data

; -----
;  Define standard constants.

LF		equ	10			; line feed
NULL		equ	0			; end of string
SPACE		equ	0x20			; space

TRUE		equ	1
FALSE		equ	0

SUCCESS		equ	0			; Successful operation
NOSUCCESS	equ	1			; Unsuccessful operation

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

O_CREAT		equ	0x40
O_TRUNC		equ	0x200
O_APPEND	equ	0x400

O_RDONLY	equ	000000q			; file permission - read only
O_WRONLY	equ	000001q			; file permission - write only
O_RDWR		equ	000002q			; file permission - read and write

S_IRUSR		equ	00400q
S_IWUSR		equ	00200q
S_IXUSR		equ	00100q

; -----
;  Define program specific constants.

GRAYSCALE	equ	0
BRIGHTEN	equ	1
DARKEN		equ	2

MIN_FILE_LEN	equ	5
BUFF_SIZE	equ	1000000			; buffer size

; -----
;  Local variables for getArguments() function.

eof		db	FALSE

usageMsg	db	"Usage: ./imageCvt <-gr|-br|-dk> <inputFile.bmp> "
		db	"<outputFile.bmp>", LF, NULL
errIncomplete	db	"Error, incomplete command line arguments.", LF, NULL
errExtra	db	"Error, too many command line arguments.", LF, NULL
errOption	db	"Error, invalid image processing option.", LF, NULL
errReadName	db	"Error, invalid source file name.  Must be '.bmp' file.", LF, NULL
errWriteName	db	"Error, invalid output file name.  Must be '.bmp' file.", LF, NULL
errReadFile	db	"Error, unable to open input file.", LF, NULL
errWriteFile	db	"Error, unable to open output file.", LF, NULL

; -----
;  Local variables for processHeaders() function.

HEADER_SIZE	equ	54

errReadHdr	db	"Error, unable to read header from source image file."
		db	LF, NULL
errFileType	db	"Error, invalid file signature.", LF, NULL
errDepth	db	"Error, unsupported color depth.  Must be 24-bit color."
		db	LF, NULL
errCompType	db	"Error, only non-compressed images are supported."
		db	LF, NULL
errSize		db	"Error, bitmap block size inconsistent.", LF, NULL
errWriteHdr	db	"Error, unable to write header to output image file.", LF,
		db	"Program terminated.", LF, NULL

; -----
;  Local variables for getRow() function.

buffMax		dq	BUFF_SIZE
curr		dq	BUFF_SIZE
wasEOF		db	FALSE
pixelCount	dq	0

errRead		db	"Error, reading from source image file.", LF,
		db	"Program terminated.", LF, NULL

; -----
;  Local variables for writeRow() function.

errWrite	db	"Error, writting to output image file.", LF,
		db	"Program terminated.", LF, NULL


; ------------------------------------------------------------------------
;  Unitialized data

section	.bss

localBuffer	resb	BUFF_SIZE
header		resb	HEADER_SIZE


; ############################################################################

section	.text

; ***************************************************************
;  Routine to get arguments.
;	Check image conversion options
;	Verify files by atemptting to open the files (to make
;	sure they are valid and available).

;  NOTE:
;	ENUM vaiables are 32-bits.

;  Command Line format:
;	./imageCvt <-gr|-br|-dk> <inputFileName> <outputFileName>

; -----
;  Arguments:
;	argc (value) rdi
;	argv table (address) rsi
;	image option variable, ENUM type, (address) rdx
;	read file descriptor (address) rcx
;	write file descriptor (address) r8
;  Returns:
;	TRUE or FALSE


;	YOUR CODE GOES HERE
global getArguments
getArguments:

push 	rbp
mov 	rbp, rsp
push 	r10
push 	r11
push 	r12
push 	r13
push 	r15

cmp 	rdi, 1
jbe 	incorrectUsage

cmp 	rdi, 4
jb 		tooFewArgs

cmp 	rdi, 4
ja 		tooManyArgs

mov 	r10, 1			;argv counter
mov  	r11, 0 			;argv string counter
mov 	r12, rcx		;read file descriptor
mov 	r13, r8			;write file descriptor

;Check first input
mov 	r15, qword [rsi + r10 * 8]
mov 	al, byte [r15 + r11]
cmp 	al, 45
jne 	imInvalid
inc 	r11
mov 	al, byte [r15 + r11]
cmp 	al, 103					;check "-gr"
jne 	checkB
inc 	r11
mov 	al, byte [r15 + r11]
cmp 	al, 114
jne 	imInvalid
mov 	dword [rdx], GRAYSCALE
jmp 	checkSecondInput
checkB:
cmp 	al, 98					;check "-br"
jne 	checkD
inc 	r11
mov 	al, byte [r15 + r11]
cmp 	al, 114
jne 	imInvalid
mov 	dword [rdx], BRIGHTEN
jmp 	checkSecondInput
checkD:
cmp 	al, 100					;check "-dk"
jne 	imInvalid
inc 	r11
mov 	al, byte [r15 + r11]
cmp 	al, 107
jne 	imInvalid
mov 	dword [rdx], DARKEN

checkSecondInput:
inc 	r10
mov 	r11, 0
push 	rdi
mov 	rdi, qword [rsi + r10 * 8]
call 	checkFileExtension
pop 	rdi
cmp 	rax, TRUE
jne 	invalidReadFileName
push 	rdi
push 	rsi
mov 	rdi, qword [rsi + r10 * 8]			;opening argv[2] "image0.bmp" etc
call 	openFile
pop 	rsi
pop 	rdi
cmp 	rax, 0
jl 		openFileError
mov 	qword [r12], rax					;read file descriptor
inc 	r10
push 	rdi
push 	rsi
mov 	rdi, qword [rsi + r10 * 8]			;checking file argv[3] "newFile.bmp" etc
call 	checkFileExtension
pop 	rsi
pop 	rdi
cmp 	rax, TRUE
jne 	invalidWriteFileName
push 	rdi
push 	rsi
mov 	rdi, qword [rsi + r10 * 8]
call  	createFile							;creating file argv[3] "newFile.bmp" etc
pop 	rsi
pop 	rdi
cmp 	rax, 0
jl 		createFileError
mov 	qword [r13], rax					;write file descriptor

mov 	eax, TRUE

jmp 	done
createFileError:
mov 	rdi, errWriteFile
call 	printString
mov 	eax, FALSE
jmp 	done

invalidWriteFileName:
mov 	rdi, errWriteName
call 	printString
mov 	eax, FALSE
jmp 	done

invalidReadFileName:
mov 	rdi, errReadName
call 	printString
mov 	eax, FALSE
jmp 	done

openFileError:
mov 	rdi, errReadFile
call 	printString
mov 	eax, FALSE
jmp 	done

imInvalid:
mov 	rdi, errOption
call 	printString
mov 	eax, FALSE
jmp 	done

incorrectUsage:
mov 	rdi, usageMsg
call 	printString
mov 	eax, FALSE
jmp 	done

tooFewArgs:
mov 	rdi, errIncomplete
call 	printString
mov 	eax, FALSE
jmp 	done

tooManyArgs:
mov 	rdi, errExtra
call 	printString
mov 	eax, FALSE
jmp 	done

done:
pop 	r15
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	rbp

ret


; ***************************************************************
;  Read and verify header information
;	status = processHeaders(readFileDesc, writeFileDesc,
;				fileSize, picWidth, picHeight)

; -----
;  2 -> BM				(+0)
;  4 file size				(+2)
;  4 skip				(+6)
;  4 header size			(+10)
;  4 skip				(+14)
;  4 width				(+18)
;  4 height				(+22)
;  2 skip				(+26)
;  2 depth (16/24/32)			(+28)
;  4 compression method code		(+30)
;  4 bytes of pixel data		(+34)
;  skip remaing header entries

; -----
;   Arguments:
;	read file descriptor (value) rdi
;	write file descriptor (value) rsi
;	file size (address) rdx
;	image width (address) rcx 
;	image height (address) r8

;  Returns:
;	file size (via reference)
;	image width (via reference)
;	image height (via reference)
;	TRUE or FALSE


;	YOUR CODE GOES HERE
global processHeaders
processHeaders:

push 	rbx
push 	r9
push 	r10
push 	r11
push 	r12
push 	r13
push 	r14
push 	r15

mov 	rbx, rdi		;read file descriptor
mov 	r9, rsi			;write file descriptor
mov 	r10, 0			;counter
mov 	r12, rcx		;image width
mov 	r13, r8			;image height
mov 	r15, rdx		;file size

mov 	rax, SYS_read
mov 	rdi, rbx
mov 	rsi, header
mov 	rdx, HEADER_SIZE
syscall
cmp 	rax, 0
jl		errorOnRead

;Validate BM
mov 	al, byte [header + r10]
cmp 	al, 66
jne 	fileTypeError
inc 	r10
mov 	al, byte [header + r10]
cmp 	al, 77
jne 	fileTypeError
inc 	r10							
mov 	eax, dword [header + r10]	;file size
mov 	dword [r15], eax			;storing file size
add 	r10, 8						
mov 	eax, dword [header + r10]	;Size of header
mov 	r14d, eax					;storing header size for addition
add 	r10, 4						
mov 	eax, dword [header + r10]	;offset to start of image data in bytes
add 	r10, 4						
mov 	eax, dword [header + r10]	;image width
mov 	dword [r12], eax	
push 	rax
push 	r10
mov 	r10d, 3
mul 	r10d
mov 	qword [pixelCount], r10		;getting picWidth * 3
pop 	r10
pop 	rax
add 	r10, 4						
mov 	eax, dword [header + r10]	;image height
mov 	dword [r13], eax
add 	r10, 4						
mov 	ax, word [header + r10]		;number of planes
add 	r10, 2						
mov 	ax, word [header + r10]		;number of bits per pixel
cmp 	ax, 24
jne 	depthError
add 	r10, 2						
mov 	eax, dword [header + r10]	;Compresssion type
cmp 	eax, 0
jne 	compTypeError
add 	r10, 4						
mov 	eax, dword [header + r10]	;Image size
add 	eax, r14d					;image size + header size
mov 	r11d, dword [r15]
cmp 	dword [r15], eax			;file size == image size + header size
jne 	invalidBitmapSize

;Write to output file
mov 	rax, SYS_write
mov 	rdi, r9
mov 	rsi, header
mov 	rdx, HEADER_SIZE
syscall
cmp 	rax, 0
jl		errorToWrite

mov 	eax, TRUE
jmp 	done1

errorToWrite:
mov 	rdi, errWriteFile
call 	printString
mov 	eax, FALSE
jmp 	done1

invalidBitmapSize:
mov 	rdi, errSize
call 	printString
mov 	eax, FALSE
jmp		done1

compTypeError:
mov 	rdi, errCompType
call 	printString
mov 	eax, FALSE
jmp 	done1

depthError:
mov 	rdi, errDepth
call 	printString
mov 	eax, FALSE
jmp 	done1

fileTypeError:
mov 	rdi, errFileType
call 	printString
mov 	eax, FALSE
jmp 	done1

errorOnRead:
mov 	rdi, errReadHdr
call 	printString
mov 	eax, FALSE
jmp 	done1

done1:
pop 	r15
pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	r9
pop 	rbx

ret


; ***************************************************************
;  Return a row from read buffer
;	This routine performs all buffer management

; ----
;  HLL Call:
;	status = getRow(readFileDesc, picWidth, rowBuffer);

;   Arguments:
;	read file descriptor (value) rdi
;	image width (value) rsi
;	row buffer (address) rdx
;  Returns:
;	TRUE or FALSE

; -----
;  This routine returns TRUE when row has been returned
;	and returns FALSE only if there is an
;	error on read (which would not normally occur)
;	or the end of file.

;  The read buffer itself and some misc. variables are used
;  ONLY by this routine and as such are not passed.


;	YOUR CODE GOES HERE
global 	getRow
getRow:

push 	rbx
push 	r10
push 	r11
push 	r14
push 	r15

mov 	rbx, rdi					;file descriptor
mov 	rax, rsi					;image width
mov 	r15, rdx					;row buffer
mov 	r10, 3
mul 	r10
mov 	r10, rax					;picWidth * 3
mov 	r14, qword [buffMax]

cmp 	qword [curr], r14
jae	 	fillBuffer
jmp 	getChar
fillBuffer:
mov 	rax, SYS_read
mov 	rdi, rbx
mov 	rsi, localBuffer
mov 	rdx, BUFF_SIZE
syscall

cmp 	rax, 0
jl 		readError

cmp 	rax, 0
je 		endOfFile

mov 	qword [buffMax], rax
mov 	qword [curr], 0
getChar:
mov 	r11, qword [curr]
mov 	r14, 0
moveRow:
mov 	al, byte [localBuffer + r11]
mov 	byte [r15 + r14], al
inc 	r11
mov 	qword [curr], r11
cmp 	r11, qword [buffMax]
ja	 	readFromFile
inc 	r14
cmp 	r14, r10
jb 		moveRow

mov 	eax, TRUE
jmp 	done2

readFromFile:
mov 	rax, SYS_read
mov 	rdi, rbx
mov 	rsi, localBuffer
mov 	rdx, BUFF_SIZE
syscall

cmp 	rax, 0
jl 		readError

cmp 	rax, 0
je 		endOfFile

mov 	qword [buffMax], rax
mov 	qword [curr], 0
mov 	r11, qword [curr]

jmp 	moveRow

endOfFile:
mov 	byte [wasEOF], TRUE
mov 	eax, FALSE
jmp 	done2

readError:
mov 	rdi, errReadFile
call 	printString
mov 	eax, FALSE
jmp 	done2

done2:
pop 	r15
pop 	r14
pop 	r11
pop 	r10
pop 	rbx

ret


; ***************************************************************
;  Write image row to output file.
;	Writes exactly (width*3) bytes to file.
;	No requirement to buffer here.

; -----
;  HLL Call:
;	status = writeRow(writeFileDesc, pciWidth, rowBuffer);

;  Arguments are:
;	write file descriptor (value) rdi
;	image width (value) rsi
;	row buffer (address) rdx

;  Returns:
;	TRUE or FALSE

; -----
;  This routine returns TRUE when row has been written
;	and returns FALSE only if there is an
;	error on write (which would not normally occur).


;	YOUR CODE GOES HERE
global writeRow
writeRow:

push 	rbx
push 	r10
push 	r11

mov 	rbx, rdx			;rowBuffer address
mov 	r10, rdi			;write file descriptor
mov 	rax, rsi
mov 	r11, 3
push 	rdx
mul 	r11
pop 	rdx
mov 	r11, rax			;picWidth*3

mov 	rax, SYS_write
mov 	rdi, r10
mov 	rsi, rbx
mov 	rdx, r11
syscall
cmp 	rax, 0
jl 		errorOnWrite

mov 	eax, TRUE
jmp 	done3

errorOnWrite:
mov 	rdi, errWrite
call 	printString
mov 	eax, FALSE
jmp 	done3

done3:
pop 	r11
pop 	r10
pop 	rbx

ret


; ***************************************************************
;  Convert pixels to grayscale.

; -----
;  HLL Call:
;	status = imageCvtToBW(picWidth, rowBuffer);

;  Arguments are:
;	image width (value) rdi
;	row buffer (address) rsi
;  Returns:
;	updated row buffer (via reference)


;	YOUR CODE GOES HERE
global imageCvtToBW
imageCvtToBW:

push 	rbx
push 	r10
push 	r11
push 	r12
push 	r13
push 	r14

mov 	rbx, rsi			;row buffer
mov 	rax, rdi
mov 	r10, 3
mul 	r10
mov 	r10, rax			;width*3
mov 	r12, 3				;base to divide
mov 	r13, 0				;counter
mov 	r14, 0				;store sum
mov 	rax, 0

toBw:
mov 	rdx, 0
mov 	al, byte [rbx + r13]
add 	r14, rax
inc 	r13
push 	rax
mov 	rax, r13
div 	r12d
pop 	rax
cmp 	rdx, 0
je 		setColor
cmp 	r13, r10
jb 		toBw

jmp 	done4

setColor:
push 	r13
mov 	rax, r14
div 	r12d
dec 	r13
mov 	byte [rbx + r13], al
dec 	r13
mov 	byte [rbx + r13], al
dec 	r13
mov 	byte [rbx + r13], al
pop 	r13
mov 	rax, 0
mov 	r14, 0
jmp 	toBw
 

done4:
pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	rbx

ret


; ***************************************************************
;  Update pixels to increase brightness

; -----
;  HLL Call:
;	status = imageBrighten(picWidth, rowBuffer);

;  Arguments are:
;	image width (value) rdi
;	row buffer (address) rsi
;  Returns:
;	updated row buffer (via reference)


;	YOUR CODE GOES HERE
global imageBrighten
imageBrighten:

push 	rbx
push 	r10
push 	r11
push 	r12
push 	r13
push 	r14

mov 	rbx, rsi			;row buffer
mov 	rax, rdi
mov 	r10, 3
mul 	r10
mov 	r10, rax			;width*3
mov 	r12, 2				;base to divide
mov 	r13, 0				;counter
mov 	r14, 0				;temporarily store old colors
mov 	rax, 0

brighten:
movzx 	ax, byte [rbx + r13]
movzx 	r14w, al				;storing oldColor temporarily
div  	r12b					;oldColor/2
mov 	ah, 0					;setting upper half of ax to 0
add 	r14w, ax				;(oldColor/2) + oldColor
cmp 	r14w, 255				;if color exceeds 255 set to 255
jbe 	continue
mov 	r14b, 255
continue:
mov 	byte [rbx + r13], r14b
inc 	r13
cmp 	r13, r10
jb 		brighten

pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	rbx

ret


; ***************************************************************
;  Update pixels to darken (decrease brightness)

; -----
;  HLL Call:
;	status = imageDarken(picWidth, rowBuffer);

;  Arguments are:
;	image width (value)
;	row buffer (address)
;  Returns:
;	updated row buffer (via reference)


;	YOUR CODE GOES HERE
global 	imageDarken
imageDarken:

push 	rbx
push 	r10
push 	r11
push 	r12
push 	r13
push 	r14

mov 	rbx, rsi			;row buffer
mov 	rax, rdi
mov 	r10, 3
mul 	r10
mov 	r10, rax			;width*3
mov 	r12, 2				;base to divide
mov 	r13, 0				;counter
mov 	r14, 0				;temporarily store old colors
mov 	rax, 0

darken:
movzx 	ax, byte [rbx + r13]
div  	r12b					;oldColor/2
mov 	ah, 0					;setting upper half of ax to 0
mov 	byte [rbx + r13], al
inc 	r13
cmp 	r13, r10
jb 		darken

pop 	r14
pop 	r13
pop 	r12
pop 	r11
pop 	r10
pop 	rbx

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
	push	rbx

; -----
;  Count characters in string.

	mov	rbx, rdi			; str addr
	mov	rdx, 0
strCountLoop:
	cmp	byte [rbx], NULL
	je	strCountDone
	inc	rbx
	inc	rdx
	jmp	strCountLoop
strCountDone:

	cmp	rdx, 0
	je	prtDone

; -----
;  Call OS to output string.

	mov	rax, SYS_write			; system code for write()
	mov	rsi, rdi			; address of characters to write
	mov	rdi, STDOUT			; file descriptor for standard in
						; EDX=count to write, set above
	syscall					; system call

; -----
;  String printed, return to calling routine.

prtDone:
	pop	rbx
	ret

; ******************************************************************

;filename string (address) - rdi
;current position (value) - rsi
;return TRUE or FALSE
global checkFileExtension
checkFileExtension:

push 	r10

mov 	r10, 0
searchExt:
mov 	al, byte [rdi + r10]
inc 	r10
cmp 	al, 46
jne 	searchForPeriod
mov 	al, byte [rdi + r10]
cmp 	al, 98
jne 	invalidFileExtension
inc 	r10
mov 	al, byte [rdi + r10]
cmp 	al, 109
jne 	invalidFileExtension
inc 	r10
mov 	al, byte [rdi + r10]
cmp 	al, 112
jne 	invalidFileExtension
inc 	r10
mov 	al, byte [rdi + r10]
jmp 	extensionFound
searchForPeriod:
cmp 	al, NULL
jne 	searchExt
jmp 	invalidFileExtension

extensionFound:
mov 	eax, TRUE
jmp 	extensionReturn

invalidFileExtension:
mov 	eax, FALSE

extensionReturn:
pop 	r10

ret

;Open File
;filename (address) - rdi
global openFile
openFile:

push 	r10

lea 	r10, qword [rdi]

mov 	rax, SYS_open
mov 	rdi, r10
mov 	rsi, O_RDONLY
syscall

pop 	r10

ret

;Create File
;filename (address) - rdi
global 	createFile
createFile:

push 	r10

lea 	r10, qword [rdi]

mov 	rax, SYS_creat
mov 	rdi, r10
mov 	rsi, S_IRUSR | S_IWUSR
syscall

pop 	r10

ret