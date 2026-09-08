ORG 0000h
    JMP 0100h       ; Jump to initialization

ORG 0008h           ; RST 1 interrupt vector
    IN 0A0h         ; Read from port A0h
    CPI 71h         ; Compare with 71h ('q')
    JZ STOP         ; If equal, jump to halt
    MOV M, A        ; Save byte to address pointed by HL
    INX H           ; Increment HL pointer
    DCR B           ; Decrement B counter
    JZ STOP         ; If counter is 0, jump to halt
    EI              ; Re-enable interrupts
    RET             ; Return to main program

STOP:               ; Address 0017h
    HLT             ; Halt processor

ORG 0100h
INIT:
    LXI SP, 1000h   ; Set stack pointer (1000h)
    LXI H, 0500h    ; Set memory pointer (0500h)
    MVI B, 0FFh     ; Set loop counter to 255
    EI              ; Enable interrupts

LOOP:
    JMP LOOP        ; Infinite wait loop
