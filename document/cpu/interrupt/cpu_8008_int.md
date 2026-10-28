# CoreLAB

## Intel 8008 microprocessor

### Interrupt handling

**Operating Principle**

Upon accepting an interrupt (`INTR`), the CPU halts its normal execution flow.
Instead of fetching an instruction from memory, it reads an instruction directly
from the data bus, provided by the peripheral device that requested the interrupt.

**Transferable Opcodes**

Theoretically, any instruction can be fed into the CPU. In practice, single-byte
instructions are used almost exclusively to keep the hardware control logic
simple. While it is possible to pass multi-byte instructions (such as `CALL` or
`JMP`), the requesting hardware must place the second and third bytes of the
instruction onto the bus with the precise timing required.

**Jump Addresses**

The most frequently used instruction is `RST`. This is a single-byte subroutine
call that saves the program counter (PC) to the hardware stack and then jumps to
one of eight predefined, fixed memory addresses:

* RST 0: `$0000`
* RST 1: `$0008`
* RST 2: `$0010`
* RST 3: `$0018`
* RST 4: `$0020`
* RST 5: `$0028`
* RST 6: `$0030`
* RST 7: `$0038`

**State Saving**

Beyond saving the program counter (PC) during an `RST` operation, the CPU
performs no other actions automatically. Saving and restoring the registers
(A, B, C, D, E, H, L) and the flags is exclusively the responsibility of the
interrupt routine.
