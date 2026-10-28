# CoreLAB

## Intel 4040 microprocessor

### Interrupt handling

**Operating Principle**

The 4040 features a single hardware interrupt input (the **INTERRUPT** pin).
Interrupts can be enabled via software using the `ENI` (Enable Interrupt)
instruction and disabled using the `DIN` (Disable Interrupt) instruction. Upon
accepting an interrupt, the CPU completes the current instruction and then
automatically saves the program counter (PC) to an expanded (7-level) internal
hardware stack.

**Opcode Handling**

During this process, the 4040 does not fetch any opcodes or interrupt vectors
from the data bus. The procedure is entirely internal and hardwired.

**Jump Addresses**

The processor jumps to a fixed address in ROM—specifically `$003`—and begins
executing the interrupt routine from that location.

**State Preservation**

There is no automatic saving of registers or flags (only the PC is saved);
therefore, the programmer must ensure these are preserved via software. To
return from an interrupt routine, the `BBS` instruction—introduced specifically
for the 4040—must be used. This instruction not only restores the program
counter (PC) from the stack but also clears the `INTA` (Interrupt Acknowledge)
state at the hardware level, thereby enabling the system to accept subsequent
interrupts.
