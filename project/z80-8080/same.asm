; *** 8080 assembly ***
; The program reads the 8 bytes from address 1000h, adds its own sequence number
; to each one (as a kind of transformation), and then saves the results in
; reverse order starting at address 1008h.

ORG	0000h			; Program starts from the beginning of ROM, at address 0000h

START:
	LXI	SP, 2000h	; Initialize Stack Pointer into RAM (for safety/standard practice)

				; Prepare registers for data copying and transformation
	LXI	H, 1000h	; HL = Source address pointer (4096 = 1000h)
	LXI	D, 100Fh	; DE = End of destination address (4104 + 7 = 410Fh) -> filling backwards
	MVI	C, 8		; C = Loop counter (8 bytes of data to process)
	MVI	B, 0		; B = Transformation value / index (ranges from 0 to 7)

LOOP:
	MOV	A, M		; Load current data byte from source (pointed by HL) into Accumulator
	ADD	B		; Transformation: add the sequence index (B) to the data
	
	STAX	D		; Store the result at the destination address (pointed by DE)
	
	INX	H		; Increment source pointer (HL -> next byte)
	DCX	D		; Decrement destination pointer (DE -> filling in reverse order)
	INR	B		; Increment transformation index (B)
	
	DCR	C		; Decrement loop counter (C)
	JNZ	LOOP		; If C is not 0, jump back and repeat the loop

HALT_LOOP:
	HLT			; Halt CPU / Stop program execution
	JMP	HALT_LOOP	; Safety infinite loop (in case an interrupt wakes the CPU)
