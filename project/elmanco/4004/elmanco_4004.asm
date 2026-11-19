/ +----------------------------------------------------------------------------+
/ | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
/ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
/ | elmanco_4004.asm                                                           |
/ | El Manco - assembly for 4004 processor                                     |
/ +----------------------------------------------------------------------------+

/ Required virtual environment
/ ----------------------------
/ cpu_4004
/ memory_4001rom #0	256 Byte, ChipID: 0
/ memory_4001rom #1	256 Byte, ChipID: 1
/ memory_4001rom #2	256 Byte, ChipID: 2
/ memory_4002ram #0	80 x 4 bit, ChipID: 0
/ memory_4002ram #1	80 x 4 bit, ChipID: 1
/ memory_4002ram #2	80 x 4 bit, ChipID: 2
/ memory_4002ram #3	80 x 4 bit, ChipID: 3
/ ioport_button4	connected to ROM #0 I/O port, target port: 0
/ - 0:    start game
/ - 3:    exit game
/ ioport_button4	connected to ROM #1 I/O port, target port: 0
/ - 0..3: stop reels
/ ioport_disp4hexmuxbcd	connected to RAM #0-1 O port, target port: 0-1
/ ioport_ledyellow4	connected to RAM #2 O port, target port: 0-1
/ ioport_ledgreen4	connected to RAM #3 O port, target port: 0-1

	/ ---- CONSTANTS ----
ROM0 = 0			/ ROM IDs - upper four bits of SRC instruction
ROM1 = 16
ROM2 = 17
RAM0 = 0			/ RAM IDs - upper two bits of SRC instruction
RAM1 = 64			
RAM2 = 128
RAM3 = 192

/ RAM addresses (Chip 0, Register 0 ) bits: CCRR AAAA
DISPLY = 0			/ 00H..03H: display digits in BCD (1, 2, 3, 4)
REELS  = 4			/ 04H..07H: reels state (0/1: spinning/stopped)
MACHIN = 8			/ 08H: machine state (0..5: wait, stand, run, win, lose, exit)

/ ---- ENTRY ----
	= 0

/ ---- MAIN PROGRAM ----
START,				START MAIN PROGRAM
	/ RAM initialization
        LDM 0			/ A = 0
        DCL			/ select RAM bank 0 (from A)

        / set display value to 1234
        FIM 0P, DISPLY		/ R0:R1 = address of DISPLY
        SRC 0P			/ send R0:R1 to bus as RAM address
        LDM 1			/ A = 1
        WRM			/ write value A to memory
        INC 1			/ increment R1 (next address)
        SRC 0P
        LDM 2
        WRM
        INC 1
        SRC 0P
        LDM 3
        WRM
        INC 1
	SRC 0P
	LDM 4
	WRM

        / set REEL states to 1
        FIM 0P, REELS		/ R0:R1 = address of REELS
        LDM 1			/ A = 1
        SRC 0P			/ send R0:R1 to bus as RAM address
        WRM			/ write value A to memory
        INC 1			/ increment R1 (next address)
        SRC 0P
        WRM
        INC 1
        SRC 0P
        WRM
        INC 1
        SRC 0P
        WRM

        / set machine state to 0
        FIM 0P, MACHIN		/ R0:R1 = address of MACHIN
        SRC 0P			/ send R0:R1 to bus as RAM address
        LDM 1			/ A = 1
        WRM			/ write value A to memory

	JMS	LEDPRC		/ initialize LEDs
M_LOOP,				/ MAIN LOOP
	JMS	DSPPRC		/ call display handler
	JMS	BTNPRC		/ call button handler

        FIM 0P, MACHIN		/ R0:R1 = address of MACHIN
        SRC 0P			/ send R0:R1 to bus as RAM address
	RDM			/ write machine status to A




;	SHL	MACHIN		H, L = machine state address
;	LAM			A = machine state
;	CPI	2		check run state
;	JFZ	M_SKIP		in other skip this block


;	LCI	4		counter = 4
;M_DIGI				increment digits
;	DCC			decrement counter
;	SHL	REELS		H, L = reels variable address
;	LBI	0		B = 0 (upper byte)
;
;	LAC			HL = HL + C
;	ADL
;	LLA
;	JFC	M_SKP1
;	INH
;M_SKP1
;

;	LAM			A = status of a reel
;	CPI	1
;	JTZ	M_NEXT		if it is stopped go next
;	SHL	DISPLY		H, L = load display variable address
;
;	LAC			HL = HL + C
;	ADL
;	LLA
;	JFC	M_SKP2
;	INH
;M_SKP2
;
;	LAM			A = digit value
;	ADI	1		increment value
;	NDI	17B		masking value
;	LMA			store digit value
;M_NEXT
;	LAC			A = counter
;	CPI	0		if counter > 0 then go back
;	JFZ	M_DIGI
;M_SKIP				skip this block
;
;	SHL	MACHIN		H, L = machine state address
;	LAM			A = machine state
;	CPI	5		check machine state
;	JTZ	EXIT		if machine state is "EXIT" go exit
;
;	JMP	M_LOOP		go back
;EXIT
;	HLT			exit program

;* ---- BUTTON HANDLER SUBROUTINE ----
;BTNPRC
;	INP	PRTBTN
;	LBA
;B_B0				start machine
;	LAB
;	NDI	01B
;	JTZ	B_CHKR		verify running state
;
;	XRA			unlock all reels
;	SHL	REELS		HL = reels state address
;	LMA			set reel states to "SPINNING"
;	INL
;	JFZ	B_SKIP1
;	INH
;B_SKIP1
;	LMA
;	INL
;	JFZ	B_SKIP2
;	INH
;B_SKIP2
;	LMA
;	INL
;	JFZ	B_SKIP3
;	INH
;B_SKIP3
;	LMA
;
;	SHL	MACHIN		H, L = machine state address
;	LMI	2		set machine state to "RUN"
;	JMP	B_RET
;B_CHKR
;	SHL	MACHIN
;	LAM
;	CPI	2		is machine running?
;	JFZ	B_B7		skip stop buttons if not running
;
;B_B1				stop reel #1
;	LAB
;	NDI	02B
;	JTZ	B_B2
;	SHL	REELS
;	LMI	1		set reel #1 state to "STOPPED"
;	JMP	B_REEL
;B_B2				stop reel #2
;	LAB
;	NDI	04B
;	JTZ	B_B3
;	SHL	REELS + 1
;	LMI	1		set reel #2 state to "STOPPED"		
;	JMP	B_REEL
;B_B3				stop reel #3
;	LAB
;	NDI	10B
;	JTZ	B_B4
;	SHL	REELS + 2
;	LMI	1		set reel #3 state to "STOPPED"
;	JMP	B_REEL
;B_B4				stop reel #4
;	LAB
;	NDI	20B
;	JTZ	B_B7
;	SHL	REELS + 3
;	LMI	1		set reel #4 state to "STOPPED"
;	JMP	B_REEL
;B_B7				exit machine
;	LAB
;	NDI	200B
;	JTZ	B_RET
;	LMI	5
;	JMP	B_RET
;	NOP
;
;* -- CHECK WIN STATE --
;B_REEL
;	SHL	REELS		check all reel states
;	LAM
;	INL
;	JFZ	B_SKIP4
;	INH
;B_SKIP4
;	ADM
;	INL
;	JFZ	B_SKIP5
;	INH
;B_SKIP5
;	ADM
;	INL
;	JFZ	B_SKIP6
;	INH
;B_SKIP6
;	ADM
;	CPI	4
;	JFZ	B_RET		if not all are standing, then return
;
;	LCI	3		counter = 3
;	SHL	DISPLY
;	LDM			first reel value
;B_WIN
;	INL
;	JFZ	B_SKIP7
;	INH
;B_SKIP7
;	LAM			next reel value
;	CPD	
;	JFZ	B_LOSE		different -> "LOSE"
;	DCC
;	LAC
;	CPI	0
;	JFZ	B_WIN
;
;	SHL	MACHIN
;
;	LMI	3		set machine state to "WIN"
;	JMP	B_RET
;B_LOSE
;	SHL	MACHIN
;	LMI	4		set machine state to "LOSE"
;
;B_RET
;	CAL	LEDPRC		refresh LEDs
;	RET
;
;* ---- DISPLAY HANDLER SUBROUTINE ----
;DSPPRC
;	LCI	4		counter = 4
;D_LOOP
;	DCC			decrement counter
;	LAC
;	OUT	PRTDSP + 1	select display digit (3..0)
;	SHL	DISPLY		H, L = variable address
;
;	LAC			HL = HL + C
;	ADL
;	LLA
;	JFC	D_SKIP
;	INH
;D_SKIP
;
;	LAM			load digit value
;	OUT	PRTDSP		write to display
;	LAC			A = counter
;	CPI	0
;	JFZ	D_LOOP		if not zero go back
;	RET
;
;* ---- LED HANDLER SUBROUTINE ----
;LEDPRC
;	LCI	0		LED 0-7 -> 0000 0000
;	SHL	REELS + 3
;	LAM			reel #3 state
;	ORA
;	JFZ	L_R2
;	LAC
;	ORI	10B		LED 0-7 -> xxx1 xxxx 
;	LCA
;L_R2
;	SHL	REELS + 2
;	LAM			reel #2 state
;	ORA
;	JFZ	L_R3
;	LAC
;	ORI	04B		LED 0-7 -> xx1x xxxx 
;	LCA
;L_R3
;	SHL	REELS + 1
;	LAM			reel #1 state
;	ORA
;	JFZ	L_R4
;	LAC
;	ORI	02B		LED 0-7 -> x1xx xxxx 
;	LCA
;L_R4
;	SHL	REELS
;	LAM			reel #0 state
;	ORA
;	JFZ	L_MACH
;	LAC
;	ORI	01B		LED 0-7 -> 1xxx xxxx 
;	LCA
;L_MACH
;	SHL	MACHIN
;	LAM			machine state
;	CPI	2		running?
;	JFZ	L_WIN
;	LAC
;	ORI	140B		LED 0-7 -> xxxx 0110
;	LCA
;	JMP	L_OUT
;L_WIN
;	CPI	3		stand and win?
;	JFZ	L_OUT
;	LAC
;	ORI	360B		LED 0-7 -> xxxx 1111 
;	LCA
;L_OUT
;	LAC
;	OUT	PRTLED		write to LEDs
;	RET
