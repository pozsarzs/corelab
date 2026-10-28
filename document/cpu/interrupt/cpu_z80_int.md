# CoreLAB

## Zilog Z80 microprocessor

### Interrupt handling

This microprocessor features an **NMI** (Non-Maskable Interrupt) input and an
**INT** input. The NMI cannot be disabled, whereas the INT can be enabled or
disabled via software using the `EI` and `DI` instructions. The INT input
supports three operating modes (IM0–2).

**Operating Principle**

- _NMI_: No instruction or vector is passed via the data bus. The CPU
  automatically saves the Program Counter (PC) onto the stack.
- _INT – IM0_: The peripheral places a machine-code instruction (opcode) onto
  the data bus.
- _INT – IM1_: The peripheral does not need to place any data on the bus. The
  CPU automatically generates an internal `RST 38H` instruction.
- _INT – IM2_: The peripheral provides an 8-bit **vector** (the lower portion of
  an address) on the data bus, rather than an opcode. Due to hardware conventions,
  this value is typically an even number.

**Opcodes/Vectors That Can Be Passed**

- _NMI_: None.
- _INT – IM0_: Any valid instruction; however, single-byte `RST` calls are used
  almost exclusively.
- _INT – IM1_: None.
- _INT – IM2_: A vector.

**Jump Addresses**

- _NMI_: Fixed at `$0066`.
- _INT - IM0_: `$0000`, `$0008`, `$0010`, `$0018`, `$0020`, `$0028`, `$0030`, `$0038`.
- _INT - IM1_: Fixed at `$0038`.
- _INT - IM2_: The CPU constructs a 16-bit pointer where the high byte is taken
  from the dedicated `I` (Interrupt) register, and the low byte is the vector
  received from the bus. The CPU reads the value stored at this 16-bit address
  (and the subsequent address) and jumps to the memory address obtained. A
  complete interrupt vector table consisting of 128 entries is available anywhere
  in memory.
