* +----------------------------------------------------------------------------+
* | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
* | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
* | elmanco_8008.asm                                                           |
* | El Manco - assembly for 8008 processor                                     |
* +----------------------------------------------------------------------------+

* Required virtual environment
* ----------------------------
* cpu_8008
* memory_standard	1 kB RAM at address (0000B-2000B)
* ioport_button8	at address 00H, interrupt vector CF
* - 0:    start game
* - 1..4: stop reels
* - 7:    exit game
* ioport_disp4hexmuxbcd	at address 20H and 21H
* ioport_ledgreen8	at address 25H

* ---- CONSTANTS ----
PRTBTN	EQU	00B		I/O base addresses
PRTDSP	EQU	20B
PRTLED	EQU	25B

* ---- ENTRIES ----
	ORG	0000B
	JMP	START		reset vector

* ---- MAIN PROGRAM ----
	ORG	0400B
START				START MAIN PROGRAM
	CAL	LEDPRC		initialize LEDs

M_LOOP				MAIN LOOP
	CAL	DSPPRC		call display handler
	CAL	BTNPRC

	SHL	MACHIN		H, L = machine state address
	LAM			A = machine state
	CPI	2		check run state
	JFZ	M_SKIP		in other skip this block
	LCI	4		counter = 4
M_DIGI				increment digits
	DCC			decrement counter
	SHL	REELS		H, L = reels variable address
	LBI	0		B = 0 (upper byte)

	LAC			HL = HL + C
	ADL
	LLA
	JFC	M_SKP1
	INH
M_SKP1

	LAM			A = status of a reel
	CPI	1
	JZ	M_NEXT		if it is stopped go next
	SHL	DISPLY		H, L = load display variable address

	LAC			HL = HL + C
	ADL
	LLA
	JFC	M_SKP2
	INH
M_SKP2

	LAM			A = digit value
	ADI	1		increment value
	NDI	17B		masking value
	LMA			store digit value
M_NEXT
	LAC			A = counter
	CPI	0		if counter > 0 then go back
	JFZ	M_DIGI
M_SKIP				skip this block

	SHL	MACHIN		H, L = machine state address
	LAM			A = machine state
	CPI	5		check machine state
	JZ	EXIT		if machine state is "EXIT" go exit

	JMP	M_LOOP		go back
EXIT
	HLT			exit program

* ---- BUTTON HANDLER SUBROUTINE ----
BTNPRC
	INP	PRTBTN
	LBA
B_B0				start machine
	LAB
	NDI	01B
	JZ	B_CHKR		verify running state

	XRA			unlock all reels
	SHL	REELS		HL = reels state address
	LMA			set reel states to "SPINNING"
	INL
	JFZ	B_SKIP1
	INH
B_SKIP1
	LMA
	INL
	JFZ	B_SKIP2
	INH
B_SKIP2
	LMA
	INL
	JFZ	B_SKIP3
	INH
B_SKIP3
	LMA

	SHL	MACHIN		H, L = machine state address
	LMI	2		set machine state to "RUN"
	JMP	B_REEL

B_CHKR
	SHL	MACHIN
	LAM
	CPI	2		is machine running?
	JFZ	B_B7		skip stop buttons if not running

B_B1				stop reel #1
	LAB
	NDI	02B
	JZ	B_B2
	SHL	REELS
	LMI	1		set reel #1 state to "STOPPED"
	JMP	B_REEL
B_B2				stop reel #2
	LAB
	NDI	04B
	JZ	B_B3
	SHL	REELS + 1
	LMI	1		set reel #2 state to "STOPPED"		
	JMP	B_REEL
B_B3				stop reel #3
	LAB
	NDI	10B
	JZ	B_B4
	SHL	REELS + 2
	LMI	1		set reel #3 state to "STOPPED"
	JMP	B_REEL
B_B4				stop reel #4
	LAB
	NDI	20B
	JZ	B_B7
	SHL	REELS + 3
	LMI	1		set reel #4 state to "STOPPED"
	JMP	B_REEL
B_B7				exit machine
	LAB
	NDI	200B
	JZ	B_REEL
	SHL	MACHIN	
	LMI	5		set machine state to "EXIT"

* -- CHECK WIN STATE --
B_REEL
	SHL	REELS		check all reel states
	LAM
	INL
	JFZ	B_SKIP4
	INH
B_SKIP4
	ADM
	INL
	JFZ	B_SKIP5
	INH
B_SKIP5
	ADM
	INL
	JFZ	B_SKIP6
	INH
B_SKIP6
	ADM
	CPI	4
	JFZ	B_RET		if not all are standing, then return

	LCI	3		counter = 3
	SHL	DISPLY
	LDM			first reel value
B_WIN
	INL
	JFZ	B_SKIP7
	INH
B_SKIP7
	LAM			next reel value
	CPD	
	JFZ	B_LOSE		different -> "LOSE"
	DCC
	LAC
	CPI	0
	JFZ	B_WIN

	SHL	MACHIN
	LMI	3		set machine state to "WIN"
	JMP	B_RET
B_LOSE
	SHL	MACHIN
	LMI	4		set machine state to "LOSE"

B_RET
	CAL	LEDPRC		refresh LEDs
	RET

* ---- DISPLAY HANDLER SUBROUTINE ----
DSPPRC
	LCI	4		counter = 4
D_LOOP
	DCC			decrement counter
	LAC
	OUT	PRTDSP + 1	select display digit (3..0)
	SHL	DISPLY		H, L = variable address

	LAC			HL = HL + C
	ADL
	LLA
	JFC	D_SKIP
	INH
D_SKIP

	LAM			load digit value
	OUT	PRTDSP		write to display
	LAC			A = counter
	CPI	0
	JFZ	D_LOOP		if not zero go back
	RET

* ---- LED HANDLER SUBROUTINE ----
LEDPRC
	LCI	0		LED 0-7 -> 0000 0000
	SHL	REELS + 3
	LAM			reel #3 state
	ORA
	JFZ	L_R2
	LAC
	ORI	10B		LED 0-7 -> xxx1 xxxx 
	LCA
L_R2
	SHL	REELS + 2
	LAM			reel #2 state
	ORA
	JFZ	L_R3
	LAC
	ORI	04B		LED 0-7 -> xx1x xxxx 
	LCA
L_R3
	SHL	REELS + 1
	LAM			reel #1 state
	ORA
	JFZ	L_R4
	LAC
	ORI	02B		LED 0-7 -> x1xx xxxx 
	LCA
L_R4
	SHL	REELS
	LAM			reel #0 state
	ORA
	JFZ	L_MACH
	LAC
	ORI	01B		LED 0-7 -> 1xxx xxxx 
	LCA
L_MACH
	SHL	MACHIN
	LAM			machine state
	CPI	2		running?
	JFZ	L_WIN
	LAC
	ORI	140B		LED 0-7 -> xxxx 0110
	LCA
	JMP	L_OUT
L_WIN
	CPI	3		stand and win?
	JFZ	L_OUT
	LAC
	ORI	360B		LED 0-7 -> xxxx 1111 
	LCA
L_OUT
	LAC
	OUT	PRTLED		write to LEDs
	RET

* ---- VARIABLES ----
DISPLY	DEF	1, 2, 3, 4	display digits in BCD (0000 nnnn)
REELS	DEF	1, 1, 1, 1	reels state (0/1: spinning/stopped)
MACHIN	DEF	0		machine state (0..5: wait, stand, run, win, lose, exit)
	END
