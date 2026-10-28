# CoreLAB

## Intel 8080 microprocessor

### Interrupt handling

**Operating Principle**

The 8080 has a single hardware interrupt mode (corresponding to the "IM 0" mode
of the Z80). If interrupts are enabled (following an `EI` instruction) and a
signal is received on the **INT** pin, the CPU interrupts its normal execution
flow. Instead of reading from memory, the CPU initiates an `INTA`
(Interrupt Acknowledge) cycle and reads the instruction to be executed from the
data bus. Upon acceptance of an interrupt, the interrupt-enable flag is
automatically disabled (as if a `DI` instruction had been executed).

**Supplied Opcodes**

* Any valid 8080 instruction can be supplied to the processor.
* Single-byte instructions are most commonly used, as this is the simplest
  approach from a hardware control perspective.
* Multi-byte instructions (e.g., a 3-byte `CALL a16`) can also be supplied.
  In such cases, the interrupt control hardware (such as an Intel 8259) must
  place the second and third bytes onto the bus, synchronized with the CPU's
  corresponding read cycles.

**Jump Addresses**

If the interrupt hardware supplies a single-byte instruction, it is almost
exclusively an `RST` (Restart) instruction. This automatically saves the program
counter to the stack, then jumps to one of eight hard-wired addresses in the
zero page:

* RST 0: `$0000` (Opcode: `$C7`)
* RST 1: `$0008` (Opcode: `$CF`)
* RST 2: `$0010` (Opcode: `$D7`)
* RST 3: `$0018` (Opcode: `$DF`)
* RST 4: `$0020` (Opcode: `$E7`)
* RST 5: `$0028` (Opcode: `$EF`)
* RST 6: `$0030` (Opcode: `$F7`)
* RST 7: `$0038` (Opcode: `$FF`)
