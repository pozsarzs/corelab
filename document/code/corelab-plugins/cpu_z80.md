# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TZ80CPU from TCPU class in cpu_z80 unit

`TZ80CPU` is the Zilog Z80 processor implementation for the CoreLAB framework.
It derives from `TCPU` and implements the Z80 register set, flag handling,
reset operation, state persistence, instruction stepping, interrupt handling,
interrupt reporting, current-instruction reporting and register access.

### CPU configuration

The constructor configures the inherited `TCPU` properties as follows:

|item                    |value                      |
|------------------------|---------------------------|
|Module name             |`Z80`                      |
|Description             |`Zilog Z80 microprocessor` |
|Architecture            |`arNeumann`                |
|Address width           |16                         |
|Endianness              |`enLittle`                 |
|Maximum memory address  |`$FFFF`                    |
|Maximum code address    |`$FFFF`                    |
|Maximum I/O port address|`$00FF`                    |
|Separate I/O bus        |`True`                     |
|Default clock frequency |2500000 Hz (2.5 MHz)       |

### Reset state

`Reset` disables execution, clears the halt and interrupt-pending states,
resets the execution counters, clears the complete `TZ80Registers` record and
sets the stack pointer to `$FFFF`.

|register/state     |value  |
|-------------------|-------|
|`PC`               |`$0000`|
|`SP`               |`$FFFF`|
|`Running`          |`False`|
|`Halted`           |`False`|
|`InterruptEnabled` |`False`|
|`FIRQPending`      |`False`|
|`FNMIPending`      |`False`|
|`TotalCycles`      |`0`    |
|`TotalInstructions`|`0`    |

Because the complete register record is cleared, the main and alternate
register sets, the index registers, `I`, and `R` are initially zero. The method
emits the inherited `ceReset` event.

The source does not explicitly reset `FInterruptMode` or
`FInterruptEnabled2`. These fields are not part of `TZ80Registers`.

### Instruction execution

`Step` performs the following operations:

1. Stops immediately when the CPU is disabled (`FEnabled = False`).
2. Calls `CheckInterrupts`; execution stops immediately when an interrupt is accepted.
3. Stops immediately if the CPU is halted.
4. Initializes the last-instruction address, cycle count, prefix count and operand count.
5. Fetches bytes from the system bus at the current `PC`, incrementing `PC` after each fetch.
6. Recognizes repeated `DD` and `FD` prefix bytes, records four cycles for each such prefix, and selects the corresponding prefix mode.
7. Passes the final opcode and selected prefix to `RunOpCode`.
8. Adds the instruction cycle count to `FTotalCycles`.
9. Emits `ceInstructionBoundary`.
10. Increments `FTotalInstructions`.

`RunOpCode` dispatches to one of seven included microcode sources according to
the prefix mode: unprefixed, `CB`, `DD`, `ED`, `FD`, `DDCB` or `FDCB`.
The supplied `Step` implementation explicitly consumes `DD` and `FD` prefixes;
the handling of other prefix sequences depends on the included microcode.

The source requires a connected `FBus` for instruction fetching. Memory and
I/O operations are delegated to the bus calls used by the microcode.

### Flag handling

`UpdateFlags` updates the Z80 flag register `F` using the supplied result,
original value, operand and two mode parameters.

|flag |meaning                                                     |
|-----|------------------------------------------------------------|
|`S`  |Sign, copied from bit 7 of the 8-bit result                 |
|`Z`  |Zero, set when the 8-bit result is zero                     |
|`Y`  |Undocumented flag bit 5, copied from bit 5 of the result    |
|`H`  |Half-carry, calculated from bit 4 of the result and operands|
|`X`  |Undocumented flag bit 3, copied from bit 3 of the result    |
|`P/V`|Parity or arithmetic overflow, selected by the `P` parameter|
|`N`  |Add/subtract flag, set when the `N` parameter is `True`     |
|`C`  |Carry, copied from bit 8 of the 16-bit result               |

When `P` is `True`, bit `P/V` is set for even parity. Otherwise, the method
calculates arithmetic overflow, using subtraction rules when `N` is `True`
and addition rules otherwise. The `N` parameter also controls the subtract
flag.

### Interrupt handling

`CheckInterrupts` checks the non-maskable interrupt first. If `FNMIPending` is
set, it clears the pending flag, exits the halted state, calls
`DoInterrupt(ceInterrupt, imNMI)`, and reports that an interrupt was accepted.

It then checks the entries of `FIRQPending` in ascending index order. A
maskable request is accepted only when its pending flag and
`FInterruptEnabled` are both set. The selected pending flag is cleared, the
halted state is exited, and `DoInterrupt` is called with the entry index as
the mode argument. Only one interrupt is accepted per check.

`DoInterrupt` first calls the inherited interrupt handler. For a maskable
interrupt it clears both `FInterruptEnabled` and `FInterruptEnabled2`, then
pushes the current `PC` onto the stack, high byte first and low byte second.

- **NMI:** sets `PC` to `$0066`, adds 11 cycles and returns.
- **IM 0:** accepts the supplied vector only when it has the RST encoding
  (`FIRQVector[AMode] >= $C0` and its low three bits are `$07`). The restart
  address is `((FIRQVector[AMode] shr 3) and $07) * 8`; 13 cycles are added.
- **IM 1:** sets `PC` to `$0038` and adds 13 cycles.
- **IM 2:** forms the vector-table address from `I` as the high byte and the
  supplied interrupt vector as the low byte. It reads the new `PC` as a
  little-endian word from that address and adds 19 cycles.

The interrupt mode is held in `FInterruptMode`. The source declares the
constants `imINT_IM0`, `imINT_IM1`, `imINT_IM2` and `imNMI` for the interrupt
mode values 0, 1, 2 and 255 respectively.

`NMI` does nothing when the CPU is disabled. Otherwise it sets
`FNMIPending`, copies `FInterruptEnabled` to `FInterruptEnabled2`, disables
maskable interrupts and emits `ceInterrupt`.

`GetCurrentInterrupt(AMode)` reports the selected vector as two hexadecimal
digits. The `Flag` field is `EI` when `FInterruptEnabled` is set and `DI`
otherwise. The `Status` field is `Pending` when `FIRQPending[AMode]` is set;
otherwise it is empty. The `Sender` field is empty.

### Current-instruction information

`GetCurrentInstruction` returns a `TLogRec` containing:

1. the total instruction count;
2. the instruction address as four hexadecimal digits;
3. the opcode as two hexadecimal digits, followed by up to two recorded operand bytes;
4. the mnemonic, with one or two operands formatted when the mnemonic contains `%`, or appended as hexadecimal values otherwise;
5. the last instruction's cycle count;
6. the total cycle count.

The method formats the opcode and recorded operands from `FLastInstruction`.
The exact mnemonic and operand contents depend on the included microcode.

### Register access

`GetRegister` and `SetRegister` compare register names case-insensitively
using `UpperCase`.

|register|width |readable|writable|
|--------|------|--------|--------|
|`A`     |8 bit |Yes     |Yes     |
|`B`     |8 bit |Yes     |Yes     |
|`C`     |8 bit |Yes     |Yes     |
|`D`     |8 bit |Yes     |Yes     |
|`E`     |8 bit |Yes     |Yes     |
|`H`     |8 bit |Yes     |Yes     |
|`L`     |8 bit |Yes     |Yes     |
|`F`     |8 bit |Yes     |Yes     |
|`PC`    |16 bit|Yes     |Yes     |
|`SP`    |16 bit|Yes     |Yes     |
|`IX`    |16 bit|Yes     |Yes     |
|`IY`    |16 bit|Yes     |Yes     |
|`I`     |8 bit |Yes     |Yes     |
|`R`     |8 bit |Yes     |Yes     |

Eight-bit registers are masked with `$FF`; 16-bit registers are masked with
`$FFFF`.

Unrecognized names do not change any register in `SetRegister`, and
`GetRegister` returns `0`.

### Public register enumeration

The public register enumeration contains fourteen entries:

|index|name|size     |
|-----|----|---------|
|0    |`A` |2 nibbles|
|1    |`B` |2 nibbles|
|2    |`C` |2 nibbles|
|3    |`D` |2 nibbles|
|4    |`E` |2 nibbles|
|5    |`H` |2 nibbles|
|6    |`L` |2 nibbles|
|7    |`F` |2 nibbles|
|8    |`PC`|4 nibbles|
|9    |`SP`|4 nibbles|
|10   |`IX`|4 nibbles|
|11   |`IY`|4 nibbles|
|12   |`I` |2 nibbles|
|13   |`R` |2 nibbles|

`GetRegisterCount` returns the number of entries in `PubRegNames`.
`GetRegisterName` returns the register name for a valid index and `nil`
otherwise. `GetRegisterSize` returns the corresponding size in nibbles and
`0` for an invalid index.

### TZ80Registers

`TZ80Registers` is a variant record providing access to both 16-bit register
pairs and their individual 8-bit components.

|16-bit register|8-bit representation|
|---------------|--------------------|
|`BC`           |`B`, `C`            |
|`DE`           |`D`, `E`            |
|`HL`           |`H`, `L`            |
|`AF`           |`A`, `F`            |
|`BC_`          |`B_`, `C_`          |
|`DE_`          |`D_`, `E_`          |
|`HL_`          |`H_`, `L_`          |
|`AF_`          |`A_`, `F_`          |
|`PC`           |`PCH`, `PCL`        |
|`SP`           |`SPH`, `SPL`        |
|`IX`           |`IXH`, `IXL`        |
|`IY`           |`IYH`, `IYL`        |

The record also contains the 8-bit interrupt vector register `I` and refresh
register `R`. The alternate register set is represented by the suffixed
register pairs and bytes.

### Internal register names and opcode prefixes

The internal register-name tables define the following indexed register
operands:

|index|`RegNames`|`XRegNames`|`YRegNames`|
|-----|----------|-----------|-----------|
|0    |`B`       |`B`        |`B`        |
|1    |`C`       |`C`        |`C`        |
|2    |`D`       |`D`        |`D`        |
|3    |`E`       |`E`        |`E`        |
|4    |`H`       |`IXH`      |`IYH`      |
|5    |`L`       |`IXL`      |`IYL`      |
|6    |`(HL)`    |`(IX)`     |`(IY)`     |
|7    |`A`       |`A`        |`A`        |

The prefix constants select the microcode source:

|constant|value|purpose                |
|--------|-----|-----------------------|
|`prNone`|0    |Unprefixed opcode      |
|`prCB`  |1    |`CB` prefix            |
|`prDD`  |2    |`DD` prefix            |
|`prED`  |3    |`ED` prefix            |
|`prFD`  |4    |`FD` prefix            |
|`prDDCB`|5    |`DD CB` prefix sequence|
|`prFDCB`|6    |`FD CB` prefix sequence|

### Protected fields and methods

|name                |type                  |description                                                                     |
|--------------------|----------------------|--------------------------------------------------------------------------------|
|`RegPointers`       |`array[0..7] of PByte`|Pointers to the 8-bit register variables used by the instruction implementation.|
|`FBus`              |`IStandardBus`        |Connected external system bus.                                                  |
|`FRegs`             |`TZ80Registers`       |The complete Z80 register set.                                                  |
|`FInterruptMode`    |`Byte`                |Selected maskable interrupt mode.                                               |
|`FInterruptEnabled2`|`Boolean`             |Secondary interrupt-enable state (`IFF2`).                                      |

|method                                                                                                     |flags     |description                                                                        |
|-----------------------------------------------------------------------------------------------------------|----------|-----------------------------------------------------------------------------------|
|`procedure UpdateFlags(Value16: Word; OldValue, ValueToAdd: Byte; N: Boolean = False; P: Boolean = False);`|          |Updates the Z80 flag register, including parity/overflow and add/subtract handling.|
|`procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0); override;`                                     |`override`|Handles NMI and maskable interrupt processing for the selected interrupt mode.     |
|`procedure RunOpCode(AOC: Byte; APrefix: Byte = 0);`                                                       |          |Dispatches the opcode to the corresponding included microcode source.              |

### State persistence

`LoadState` reads the following data in order:

|order|data                |
|-----|--------------------|
|1    |`FEnabled`          |
|2    |`FRegs`             |
|3    |`FLastInstruction`  |
|4    |`FRunning`          |
|5    |`FHalted`           |
|6    |`FInterruptEnabled` |
|7    |`FInterruptEnabled2`|
|8    |`FInterruptMode`    |
|9    |`FIRQPending`       |
|10   |`FNMIPending`       |
|11   |`FTotalCycles`      |
|12   |`FTotalInstructions`|

If a stream exception occurs, `LoadState` returns `False`; otherwise it returns
`True`.

`SaveState` writes the same fields in the same order and returns `True` after
the write operations complete.

### Public methods

|name                                                          |flags     |description                                                                                                                                                             |
|--------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                         |`override`|Creates a Zilog Z80 CPU, configures its architecture parameters and register pointers, and performs a reset.                                                            |
|`function CheckInterrupts: Boolean;`                          |`override`|Checks pending NMI and maskable interrupt requests and accepts at most one request per call.                                                                            |
|`procedure Reset;`                                            |`override`|Clears the register set, execution and pending-interrupt state, resets counters, sets `PC` to `0` and `SP` to `$FFFF`, and emits `ceReset`.                             |
|`function ConnectBus(const ABus: IInterface): Boolean;`       |`override`|Connects the supplied interface when it supports `IStandardBus`.                                                                                                        |
|`function LoadState(AStream: TStream): Boolean;`              |`override`|Loads the enabled state, register set, last-instruction record, execution state, interrupt state and counters from a stream.                                            |
|`function SaveState(AStream: TStream): Boolean;`              |`override`|Saves the enabled state, register set, last-instruction record, execution state, interrupt state and counters to a stream.                                              |
|`procedure NMI;`                                              |`override`|Queues a non-maskable interrupt, saves the current maskable-interrupt enable state in `IFF2`, disables maskable interrupts and emits `ceInterrupt`.                     |
|`procedure Step;`                                             |`override`|Fetches and executes an instruction, handles the `DD`/`FD` prefix bytes, accounts for cycles, emits the instruction-boundary event and increments the instruction count.|
|`function GetCurrentInstruction: TLogRec;`                    |`override`|Returns structured information about the most recently executed instruction.                                                                                            |
|`function GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec;`  |`override`|Returns the selected interrupt vector, interrupt-enable state and pending status.                                                                                       |
|`function GetRegister(const RegName: PChar): Word;`           |`override`|Returns the value of the named public register.                                                                                                                         |
|`procedure SetRegister(const RegName: PChar; Value: Word);`   |`override`|Sets the named public register, masking the value to the register width.                                                                                                |
|`function GetRegisterCount: Byte;`                            |`override`|Returns the number of publicly enumerated registers.                                                                                                                    |
|`function GetRegisterName(AIndex: Byte): PChar;`              |`override`|Returns the public register name for a valid index.                                                                                                                     |
|`function GetRegisterSize(AIndex: Byte): Byte;`               |`override`|Returns the public register size in nibbles for a valid index.                                                                                                          |

### Exported plugin interface

The unit is compiled as the `cpu_z80` dynamic library and exports four plugin
entry points:

|exported name  |function    |description                                                                                    |
|---------------|------------|-----------------------------------------------------------------------------------------------|
|`cpu_create`   |`CreateCPU` |Creates and returns a new `TZ80CPU` instance as `TCPU`.                                        |
|`cpu_destroy`  |`DestroyCPU`|Destroys the supplied CPU instance when it is assigned.                                        |
|`cpu_loadstate`|`LoadState` |Loads state through the supplied `TCPU` reference. Returns `False` when the reference is `nil`.|
|`cpu_savestate`|`SaveState` |Saves state through the supplied `TCPU` reference. Returns `False` when the reference is `nil`.|
