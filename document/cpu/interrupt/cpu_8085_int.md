# CoreLAB

## Intel 8085 microprocessor

### Interrupt handling

**Operating Principle**

The 8085 features five dedicated interrupt inputs with a built-in priority
hierarchy: **TRAP** (highest) > **RST 7.5** > **RST 6.5** > **RST 5.5** >
**INTR** (lowest). Among these, TRAP is non-maskable (NMI). RST 5.5,
6.5, and 7.5 can be individually enabled or disabled via a software-controlled
interrupt mask (using the `SIM` instruction). Additionally, INTR and
RST 5.5–7.5 can be disabled globally using the `DI` instruction.

**Supplied Opcodes**

Only the INTR input expects an external instruction; it functions exactly
like the interrupt mechanism of the 8080. The external interrupt-control
hardware must place an instruction (typically an `RST n` or a 3-byte `CALL`)
onto the bus.

In the case of TRAP and RST 5.5/6.5/7.5, no opcode is supplied. The CPU
generates a subroutine call internally—without reading the data bus—and
automatically saves the program counter (PC) onto the stack.

**Jump Addresses**

Jump addresses for dedicated hardware interrupts (internal, opcode-less):

* TRAP:    `$0024`
* RST 5.5: `$002C`
* RST 6.5: `$0034`
* RST 7.5: `$003C`

The addresses for standard 1-byte RST instructions—triggered via the INTR input
or invoked via software from the program code—are the same as those for the
8080 processor:

* RST 0: `$0000`
* RST 1: `$0008`
* RST 2: `$0010`
* RST 3: `$0018`
* RST 4: `$0020`
* RST 5: `$0028`
* RST 6: `$0030`
* RST 7: `$0038`
