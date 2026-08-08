# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU and related types from core_cpu unit

`TCPU` is an abstract base class for processor implementations. It defines common CPU identity and architecture information, runtime state, execution statistics, event notification, interrupt handling, and connection to an external `ICPUBus` implementation.

The class does not implement processor-specific register access, reset, single-step execution, or instruction decoding. These operations are left abstract for derived CPU classes.

### Related types

|name |type |description |
|-----|-----|------------|
|`TArchitecture`|enumeration|CPU memory architecture: `arHarvad` or `arNeumann`|
|`TEndianness`|enumeration|CPU byte order: `enLittle` or `enBig`|
|`TCPUEvent`|enumeration|Generic CPU events: instruction boundary, interrupt, halt, and reset|
|`TCPUEventHandler`|procedure type|Callback receiving a CPU event|
|`ICPUBus`|interface|Generic bus interface for data memory, code memory, and I/O access|
|`TSemanticVersion`|record|Major, minor, and patch version information|

The source defines the architecture member as `arHarvad` (with this spelling).

### Type helpers

|name |description |
|-----|------------|
|`TArchitectureHelper.ToString`|Converts an architecture value to its enumeration name|
|`TArchitectureHelper.FromString`|Converts an enumeration name to `TArchitecture`|
|`TEndiannessHelper.ToString`|Converts an endianness value to its enumeration name|
|`TEndiannessHelper.FromString`|Converts an enumeration name to `TEndianness`|
|`TCPUEventHelper.ToString`|Converts a CPU event value to its enumeration name|
|`TCPUEventHelper.FromString`|Converts an enumeration name to `TCPUEvent`|
|`TSemanticVersionHelper.ToString`|Formats a version as `Major.Minor.Patch`|
|`TSemanticVersionHelper.Compare`|Compares two semantic versions; returns `-1`, `0`, or `1`|

### `ICPUBus` interface

|method |description |
|-------|------------|
|`function MemRead(AAddress: UInt64): Byte;`|Read a byte from data memory|
|`procedure MemWrite(AAddress: UInt64; AValue: Byte);`|Write a byte to data memory|
|`function CodeRead(AAddress: UInt64): Byte;`|Read a byte from code memory|
|`procedure CodeWrite(AAddress: UInt64; AValue: Byte);`|Write a byte to code memory|
|`function IORead(APort: UInt64): Byte;`|Read a byte from an I/O port|
|`procedure IOWrite(APort: UInt64; AValue: Byte);`|Write a byte to an I/O port|

### Protected fields

|name |type |description |initial value|
|-----|-----|-------------|-------------|
|`FBus`|`ICPUBus`|Connected external bus|`nil`|
|`FOnEvent`|`TCPUEventHandler`|CPU event callback|`nil`|
|`FModname`|`PChar`|Module name|not initialized here|
|`FDescription`|`PChar`|Short description|not initialized here|
|`FVersion`|`TSemanticVersion`|Module version|`0.1.0`|
|`FArchitecture`|`TArchitecture`|CPU architecture|not initialized here|
|`FBitWidth`|`Byte`|Processor word size in bits|not initialized here|
|`FAddressWidth`|`Byte`|Address bus width in bits|not initialized here|
|`FEndianness`|`TEndianness`|CPU byte order|not initialized here|
|`FMaxMemAddress`|`QWord`|Highest data-memory address|not initialized here|
|`FMaxCodeAddress`|`QWord`|Highest code-memory address|not initialized here|
|`FMaxIOPortAddress`|`QWord`|Highest I/O-port address|not initialized here|
|`FHasSeparateIOBus`|`Boolean`|Indicates separate memory and I/O buses|not initialized here|
|`FRunning`|`Boolean`|CPU execution state|`false`|
|`FHalted`|`Boolean`|CPU HALT state|`false`|
|`FInterruptEnabled`|`Boolean`|Global maskable-interrupt enable flag|`false`|
|`FIRQPending`|`Boolean`|Pending maskable interrupt|`false`|
|`FNMIPending`|`Boolean`|Pending non-maskable interrupt|`false`|
|`FCycles`|`QWord`|Total CPU cycles|`0`|
|`FInstructions`|`QWord`|Total executed instructions|`0`|
|`FRegPtr`|array of `^QWord`|Pointers used by derived CPU implementations for registers|empty|

### Protected methods

|name |flags|description |
|-----|:---:|------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`|Vi|Send a CPU event to the registered host callback|
|`procedure DoInterrupt(AEvent: TCPUEvent);`|Vi|Dispatch an accepted interrupt as a CPU event|

### Public methods

|name |flags|description |
|-----|:---:|------------|
|`constructor Create;`|Vi|Initialize common CPU execution state, counters, and version|
|`destructor Destroy;`|Vi|Destroy the CPU instance|
|`procedure SetRegister(const RegName: PChar; AValue: QWord);`|Ab,Vi|Set a processor register; implementation is supplied by the derived CPU|
|`function GetRegister(const RegName: PChar): QWord;`|Ab,Vi|Read a processor register; implementation is supplied by the derived CPU|
|`procedure Reset;`|Ab,Vi|Reset the processor; implementation is supplied by the derived CPU|
|`procedure Run;`|Vi|Set the CPU running state|
|`procedure Step;`|Ab,Vi|Execute one processor step; implementation is supplied by the derived CPU|
|`procedure Stop;`|Vi|Clear the CPU running state|
|`function GetCurrentInstruction: PChar;`|Ab,Vi|Return the current instruction representation; implementation is supplied by the derived CPU|
|`procedure IRQ;`|Vi|Set the pending maskable-interrupt flag and emit an interrupt event|
|`procedure NMI;`|Vi|Set the pending non-maskable-interrupt flag and emit an interrupt event|
|`function CheckInterrupts: Boolean;`| |Accept and dispatch a pending interrupt when applicable|
|`procedure ConnectBus(const Bus: ICPUBus);`|Vi|Store the external CPU bus reference|

### Public properties

|name |type |access|description|
|-----|-----|:----:|-----------|
|`Modname`|`PChar`|Re|Module name|
|`Description`|`PChar`|Re|Short description|
|`Architecture`|`TArchitecture`|Re|CPU architecture|
|`BitWidth`|`Byte`|Re|Processor word size in bits|
|`AddressWidth`|`Byte`|Re|Address bus width in bits|
|`Endianness`|`TEndianness`|Re|CPU byte order|
|`MaxMemAddress`|`QWord`|Re|Highest data-memory address|
|`MaxCodeAddress`|`QWord`|Re|Highest code-memory address|
|`MaxIOPortAddress`|`QWord`|Re|Highest I/O-port address|
|`HasSeparateIOBus`|`Boolean`|Re|Whether separate memory and I/O buses are supported|
|`Running`|`Boolean`|Re|Current execution state|
|`Halted`|`Boolean`|Re|Current HALT state|
|`InterruptEnabled`|`Boolean`|Re|Global maskable-interrupt enable state|
|`Cycles`|`QWord`|Re|Total cycle counter|
|`Instructions`|`QWord`|Re|Total instruction counter|
|`OnEvent`|`TCPUEventHandler`|Re/Wr|CPU event callback|
|`Version`|`TSemanticVersion`|Re|Module version|

### Interrupt handling

`IRQ` marks a maskable interrupt as pending. `NMI` marks a non-maskable interrupt as pending. Both methods emit `ceInterrupt`.

`CheckInterrupts` gives priority to NMI. A pending NMI is accepted unconditionally; a pending IRQ is accepted only when `InterruptEnabled` is true. When an interrupt is accepted, the corresponding pending flag is cleared, `Halted` is cleared, `DoInterrupt` is called, and the function returns `true`. Otherwise it returns `false`.
