# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## ChkInt8080 example program

The code is a simple, interrupt-driven data collection routine:
 * At startup (`0000h`), the machine jumps to address `0100h` to initialize.
 * It sets the stack pointer (`1000h`), a memory pointer (`0500h`), and register
   `B` as a counter to 255 (`FFh`), enables interrupts, and waits in an infinite
   loop.
 * Triggered by the `RST 1` hardware interrupt (address `0008h`), it reads a
   byte from port `A0h`.
 * If the read value is `71h` (lowercase 'q'), or the number of read bytes
   reaches 255, the machine halts (`HLT` at address `0017h`).
 * Otherwise, it saves the read byte to memory, increments the memory pointer,
   decrements the counter, re-enables interrupts, and returns to the infinite
   loop.
