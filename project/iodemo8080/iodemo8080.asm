; +----------------------------------------------------------------------------+
; | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
; | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
; | iodemo8080.asm                                                             |
; | CoreLAB 8080 Demo program                                                  |
; +----------------------------------------------------------------------------+

; RAM: 1024 bytes (0000h - 03FFh)


        ORG     0000h
        JMP     START           ; Reset vector

        ; RST 1 interrupt vector (0008h) - Keyboard interrupt
        ORG     0008h
        JMP     KEY_ISR

        ; RST 2 interrupt vector (0010h) - Console interrupt
        ORG     0010h
        JMP     CONSOLE_ISR

        ORG     0040h           ; Program start after vectors

PORT_CONSOLE  EQU 80h
PORT_KEYBOARD EQU 81h
PORT_DISPLAY  EQU 90h

START:
        LXI     SP, 0400h       ; Set stack pointer to top of 1KB RAM
        EI                      ; Enable interrupts

        ; Print welcome message to console
        LXI     H, MSG_START
        CALL    PRINT_STR

MAIN_LOOP:
        ; Check for 'q' from console to quit
        IN      PORT_CONSOLE
        CPI     'q'
        JZ      EXIT
        JMP     MAIN_LOOP

EXIT:
        DI
        HLT

; --- Keyboard Interrupt Service Routine (ISR) ---
KEY_ISR:
        PUSH    PSW
        PUSH    H

        IN      PORT_KEYBOARD   ; Read key value from port 81h
        OUT     PORT_DISPLAY    ; Output value to display port 90h

        ; Print notification to console
        LXI     H, MSG_KEY_INPUT
        CALL    PRINT_STR

        POP     H
        POP     PSW
        EI
        RET

; --- Console Interrupt Service Routine (ISR) ---
CONSOLE_ISR:
        PUSH    PSW
        PUSH    H

        IN      PORT_CONSOLE
        LXI     H, MSG_CONSOLE_INPUT
        CALL    PRINT_STR

        POP     H
        POP     PSW
        EI
        RET

; --- String Printing Subroutine ---
PRINT_STR:
        MOV     A, M
        ORA     A
        RZ                      ; Return if zero terminator
        OUT     PORT_CONSOLE
        INX     H
        JMP     PRINT_STR

MSG_START:
        DB      'CoreLAB 8080 - Started. Waiting for input...', 0Ah, 0Dh, 0
MSG_KEY_INPUT:
        DB      'Input received from keyboard port!', 0Ah, 0Dh, 0
MSG_CONSOLE_INPUT:
        DB      'Input received from console port!', 0Ah, 0Dh, 0
