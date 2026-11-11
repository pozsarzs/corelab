; +----------------------------------------------------------------------------+
; | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
; | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
; | elmanco_8080.asm                                                           |
; | El Manco - assembly for 8080 processor                                     |
; +----------------------------------------------------------------------------+

; Required virtual environment
; ----------------------------
; cpu_8080
; memory_standard	1 kB RAM at address (0000H-0400H)
; ioport_button8	at address 10H, interrupt vector CFH
; - 0:    start game
; - 1..4: stop reels
; - 7:    exit game
; ioport_disp4hexmuxbcd	at address 20H and 21H
; ioport_ledgreen8	at address 25H

	; ---- CONSTANTS ----
PRT_BTN	EQU	10h		; I/O base addresses
PRT_DSP	EQU	20h
PRT_LED	EQU	25h

	; ---- ENTRIES ----
	ORG	0000h
	JMP	START		; reset vector

	ORG	0008h
	JMP	BTNINT		; RST 1 interrupt vector

	; ---- MAIN PROGRAM ----
	ORG	0100h
START:				; START MAIN PROGRAM
	LXI	SP, 0400h	; set stack pointer to top of 1KB RAM
	CALL	LEDPROC		; initialize LEDs
	EI			; enable interrupt

M_LOOP:				; MAIN LOOP
	CALL	DSPPROC		; call display handler

	LXI	H, MACHINE	; HL = machine state address
	MOV	A, M		; A = machine state
	MOV	E, A		; store machine state in E
	CPI	2		; check run state
	JNZ	M_SKIP		; in other skip this block
	MVI	C, 4		; counter = 4
M_DIGITS:			; increment digits
	DCR	C		; decrement counter
	LXI	H, REELS	; HL = reels variable address
	MVI	B, 0		; B = 0 (upper byte)
	DAD	B		; HL = HL + BC
	MOV	A, M		; A = status of a reel
	CPI	1
	JZ	M_NEXT		; if it is stopped go next
	LXI	H, DISPLAY	; HL = load display variable address
	MVI	B, 0		; B = 0 (upper byte)
	DAD	B		; HL = HL + BC
	MOV	A, M		; A = digit value
	INR	A		; increment value
	ANI	0Fh		; masking value (0-FH)
	MOV	M, A		; store digit value
M_NEXT:
	MOV	A, C		; A = counter
	CPI	0		; if counter > 0 then go back
	JNZ	M_DIGITS
M_SKIP:				; skip this block

	LXI	H, MACHINE	; HL = machine state address
	MOV	A, M		; A = machine state
	CPI	5		; check machine state
	JZ	EXIT		; if machine state is "EXIT" go exit

	JMP	M_LOOP		; go back
EXIT:
	DI			; disable interrupt
	HLT			; exit program

	; ---- BUTTON INTERRUPT SERVICE ROUTINE (ISR) ----
BTNINT:
	DI
	PUSH	PSW
	PUSH	H
	PUSH	B
	IN	PRT_BTN
	MOV	B, A
B_B0:				; start machine
	MOV	A, B
	ANI	01H
	JZ	B_CHKRUN	; verify running state

	XRA	A		; unlock all reels
	LXI	H, REELS	; HL = reels state address
	MOV	M, A		; set reel states to "SPINNING"
	INX	H
	MOV	M, A
	INX	H
	MOV	M, A
	INX	H
	MOV	M, A

	LXI	H, MACHINE	; HL = machine state address
	MVI	M, 2		; set machine state to "RUN"
	JMP	B_REELS

B_CHKRUN:
	LDA	MACHINE
	CPI	2		; is machine running?
	JNZ	B_B7		; skip stop buttons if not running

B1_BTN:				; stop reel #1
	MOV	A, B
	ANI	02H
	JZ	B_B2
	LXI	H, REELS
	MVI	M, 1		; set reel #1 state to "STOPPED"
	JMP	B_REELS
B_B2:				; stop reel #2
	MOV	A, B
	ANI	04H
	JZ	B_B3
	LXI	H, REELS + 1	
	MVI	M, 1		; set reel #2 state to "STOPPED"		
	JMP	B_REELS
B_B3:				; stop reel #3
	MOV	A, B
	ANI	08H
	JZ	B_B4
	LXI	H, REELS + 2	
	MVI	M, 1		; set reel #3 state to "STOPPED"
	JMP	B_REELS
B_B4:				; stop reel #4
	MOV	A, B
	ANI	10H
	JZ	B_B7
	LXI	H, REELS + 3
	MVI	M, 1		; set reel #4 state to "STOPPED"
	JMP	B_REELS
B_B7:				; exit machine
	MOV	A, B
	ANI	80H
	JZ	B_REELS
	LXI	H, MACHINE	
	MVI	M, 5		; set machine state to "EXIT"

	; -- CHECK WIN STATE --
B_REELS:
	LXI	H, REELS	; check all reel states
	MOV	A, M
	INX	H
	ADD	M
	INX	H
	ADD	M
	INX	H
	ADD	M
	CPI	4
	JNZ	B_RET		; if not all are standing, then return

	MVI	C, 3		; counter = 3
	LXI	H, DISPLAY
	MOV	D, M		; first reel value
B_WIN:
	INX	H
	MOV	A, M		; next reel value
	CMP	D
	JNZ	B_LOSE		; different -> "LOSE"
	DCR	C
	MOV	A, C
	CPI	0
	JNZ	B_WIN

	LXI	H, MACHINE
	MVI	M, 3		; set machine state to "WIN"
	JMP	B_RET
B_LOSE:
	LXI	H, MACHINE
	MVI	M, 4		; set machine state to "LOSE"

B_RET:
	CALL	LEDPROC		; refresh LEDs
	POP	B
	POP	H
	POP	PSW
	EI
	RET

	; ---- DISPLAY HANDLER SUBROUTINE ----
DSPPROC:
	MVI	C, 4		; counter = 4
D_LOOP:
	DCR	C		; decrement counter
	MOV	A, C		;
	OUT	PRT_DSP + 1	; select display digit (3..0)
	LXI	H, DISPLAY	; HL = variable address
	MVI	B, 0		; B = 0
	DAD	B		; HL = HL + BC
	MOV	A, M		; load digit value
	OUT	PRT_DSP		; write to display
	MOV	A, C		; A = counter
	CPI	0
	JNZ	D_LOOP		; if not zero go back
	RET

	; ---- LED HANDLER SUBROUTINE ----
LEDPROC:
	MVI	C, 0		; LED 0-7 -> 0000 0000
	LDA	REELS + 3	; reel #3 state
	ORA	A
	JNZ	L_R2
	MOV	A, C
	ORI	08H		; LED 0-7 -> xxx1 xxxx 
	MOV	C, A
L_R2:
	LDA	REELS + 2	; reel #2 state
	ORA	A
	JNZ	L_R3
	MOV	A, C
	ORI	04H		; LED 0-7 -> xx1x xxxx 
	MOV	C, A
L_R3:
	LDA	REELS + 1	; reel #1 state
	ORA	A
	JNZ	L_R4
	MOV	A, C
	ORI	02H		; LED 0-7 -> x1xx xxxx 
	MOV	C, A
L_R4:
	LDA	REELS		; reel #0 state
	ORA	A
	JNZ	L_MACH
	MOV	A, C
	ORI	01H		; LED 0-7 -> 1xxx xxxx 
	MOV	C, A
L_MACH:
	LDA	MACHINE		; machine state
	CPI	2		; running?
	JNZ	L_WIN
	MOV	A, C
	ORI	60H		; LED 0-7 -> xxxx 0110
	MOV	C, A
	JMP	L_OUT
L_WIN:
	CPI	3		; stand and win?
	JNZ	L_OUT
	MOV	A, C
	ORI	0F0H		; LED 0-7 -> xxxx 1111 
	MOV	C, A
L_OUT:
	MOV	A, C
	OUT	PRT_LED		; write to LEDs
	RET

	; ---- VARIABLES ----
DISPLAY	DB	1, 2, 3, 4	; display digits in BCD (0000 nnnn)
REELS	DB	1, 1, 1, 1	; reels' state (0/1: spinning/stopped)
MACHINE	DB	0		; machine state (0..5: wait, stand, run, win, lose, exit)
	END
