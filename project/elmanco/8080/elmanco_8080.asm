; +----------------------------------------------------------------------------+
; | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
; | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
; | elmanco_8080.asm                                                           |
; | El Manco testprogram for 8080 processor                                    |
; +----------------------------------------------------------------------------+
; This program is free software: you can redistribute it and/or modify it
; under the terms of the European Union Public License 1.2 version.
;
; This program is distributed in the hope that it will be useful, but WITHOUT
; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
; FOR A PARTICULAR PURPOSE.

; Required virtual environment
; ----------------------------
; cpu_8080
; memory_standard        1 kB	RAM at address (0000H-0400H)
; ioport_button8         at address 10H, interrupt vector CFH
; - 0:    start game
; - 1..4: stop reels
; - 7:    exit game
; ioport_disp4hexmuxbcd  at address 20H and 21H
; ioport_ledgreen8       at address 25H

; ---- CONSTANTS ----
PRT_BTN	EQU	10h		; I/O base addresses
PRT_DSP	EQU	20h
PRT_LED	EQU	25h

; ---- ENTRIES ----
	ORG	0000h
        JMP     START		; reset vector

        ORG     0008h
        JMP     BTNINT		; RST 1 interrupt vector

; ---- MAIN PROGRAM ----
        ORG     0100h
START:				; START MAIN PROGRAM
        LXI     SP, 0400h       ; set stack pointer to top of 1KB RAM
	EI			; enable interrupt

LPMAIN:				; MAIN LOOP
; -- DISPLAY --
	CALL	DSPPROC		; call display handler
	CALL	LEDPROC		; call LED handler

; -- CHECK RUN STATE --
	LXI	H, MACHINE	; H = machine state address
	MOV	A, M		; A = machine state
	MOV	E, A		; store machine state in E
	CPI	2		; check run state
	JNZ	SKRUN		; in other skip this block
	MVI	C, 4		; counter = 4
LPRUN:
	DCR	C		; decrement counter
	LXI	H, REELS	; H = reels variable address
	MVI	B, 0		; B = 0 (upper byte)
	DAD	B		; HL = HL + BC
	MOV	A, M		; A = status of a reel
	CPI	1
	JZ	NXTRUN		; if it is stopped go next
	LXI	H, DISPLAY	; H = load display variable address
	MVI	B, 0		; B = 0 (upper byte)
	DAD	B		; HL = HL + BC
	MOV	A, M		; A = digit value
	INR	A		; increment value
	ANI	0Fh		; masking value (0-FH)
	MOV	M, A		; store digit value
NXTRUN:
	MOV	A, C		; A = counter
	CPI	0		; if counter > 0 then go back
	JNZ	LPRUN
SKRUN:				; SKIP this block

; -- CHECK WIN STATE --
	MOV	A, E		; A = machine state
	CPI	1		; check "STAND" machine state
	JNZ	SKWIN		; in other skip this block

	MVI	C, 3		; counter = 3
	LXI	H, DISPLAY	; H = display variable address
	MOV	D, M		; D = digit value
LPWIN:
	INX	H		; increment variable address
	MOV	A, M		; A = next digit value
	CMP	D		; compare first and next value
	JNZ	LOSE		; if not equivalent go to lose
	DCR	C		; decrement counter
	MOV	A, C		; A = counter
	CPI	0		; if counter > 0 then go back
	JNZ	LPWIN
	LXI	H, MACHINE	; H = machine variable address 
	MVI	E, 3		; set machine state to "WIN"
	MVI	M, 3		; set machine state to "WIN"
	JMP	SKWIN		; exit from block
LOSE:
	LXI	H, MACHINE	; H = machine variable address 
	MVI	E, 4		; set machine state to "LOSE"
	MVI	M, 4		; set machine state to "LOSE"
SKWIN:				; SKIP this block

; -- CHECK EXIT STATE --
	LXI	H, MACHINE	; H = machine state address
	MOV	A, M		; A = machine state
	CPI	5
	JZ	EXIT		; if machine state is "EXIT" go exit
SKDELAY:
	JMP	LPMAIN		; go back
EXIT:
	DI			; disable interrupt
	HLT			; exit program

; ---- BUTTON HANDLER ----
BTNINT:
	DI
        PUSH    PSW
        PUSH    H
        PUSH	B
        IN      PRT_BTN
        MOV	B, A
B0_BTN:				; START MACHINE
	MOV	A, B
        ANI	01H
        JZ	B1_BTN

        XRA	A		; unlock all reels
	LXI	H, REELS	; H = reels state address
	MOV	M, A		; set reel states to "SPINNING"
	INX	H
	MOV	M, A
	INX	H
	MOV	M, A
	INX	H
	MOV	M, A

	LXI	H, MACHINE	; H = machine state address
	MVI	M, 2		; set machine state to "RUN"
	JMP	RLSBTN
B1_BTN:				; STOP REEL #1
	MOV	A, B
        ANI	02H
	JZ	B2_BTN
	LXI	H, REELS	; H = reels state address
	MVI	M, 1		; set reel state to "STOPPED"
	JMP	RLSBTN
B2_BTN:				; STOP REEL #2
	MOV	A, B
        ANI	04H
	JZ	B3_BTN
	LXI	H, REELS + 1	; H = reels state address
	MVI	M, 1		; set reel state to "STOPPED"
	JMP	RLSBTN
B3_BTN:				; STOP REEL #3
	MOV	A, B
        ANI	08H
	JZ	B4_BTN
	LXI	H, REELS + 2	; H = reels state address
	MVI	M, 1		; set reel state to "STOPPED"
	JMP	RLSBTN
B4_BTN:				; STOP REEL #4
	MOV	A, B
        ANI	10H
	JZ	B7_BTN
	LXI	H, REELS + 3	; H = reels state address
	MVI	M, 1		; set reel state to "STOPPED"
	JMP	RLSBTN
B7_BTN:				; EXIT MACHINE
	MOV	A, B
        ANI	80H
	JZ	RLSBTN
	LXI	H, MACHINE	; H = machine state address
	MVI	M, 5		; set machine state to "EXIT"
RLSBTN:
	LXI	H, REELS	; check all reel states
	MOV	A, M
	INX	H
	ADD	M
	INX	H
	ADD	M
	INX	H
	ADD	M
	CPI	4
	JNZ	RETBTN		; if all are "STOPPED", set machine state to "STOP"
	LXI	H, MACHINE	; H = machine state address
	MVI	M, 1		; machine state = 1
RETBTN:
	POP	B
        POP     H
        POP     PSW
        EI
        RET

; ---- DISPLAY HANDLER ----
DSPPROC:
	MVI	C, 4		; counter = 4
DSPLOOP:
	DCR	C		; decrement counter
	MOV	A, C		;
	OUT	PRT_DSP + 1	; select display digit (3..0)
	LXI	H, DISPLAY	; H = variable address
	MVI	B, 0		; B = 0
	DAD	B		; HL = HL + BC
	MOV	A, M		; load digit value
	OUT	PRT_DSP		; write to display
	MOV	A, C		; A = counter
	CPI	0
	JNZ	DSPLOOP		; if not zero go back
	RET

; ---- LED HANDLER ----
LEDPROC:
	LXI	H, MACHINE	; H = machine state address
	MOV	A, M		; A = machine state
	CPI	4
	JNZ	ST3LED
	MVI	A, 81H		; at state "LOSE"
	OUT	PRT_LED
	RET
ST3LED:
	CPI	3
	JNZ	ST2LED
	MVI	A, 7EH		; at state "WIN"
	OUT	PRT_LED
	RET
ST2LED:
	CPI	2
	JNZ	ST1LED
	LXI	H, RUNLGHT	; at state "RUN"
	MOV	A, M
	CMA
	MOV	M, A
	OUT	PRT_LED
	RET
ST1LED:
	XRA	A		; at other states
	OUT	PRT_LED
	RET

; ---- VARIABLES ----
DISPLAY	DB	1, 2, 3, 4	; display digits in BCD (0000 nnnn) 
REELS	DB	0, 0, 0, 0	; 0=spinning, 1=stopped
MACHINE	DB	0		; machine state: 0..5: wait, stand, run, win, lose, exit
RUNLGHT	DB	AAH		; running light sample (AAH/55H)
	END
