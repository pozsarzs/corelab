# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU and related types from core_cpu unit

`TCPU` is an abstract base class for processor implementations. It defines common
CPU identity and architecture information, runtime state, execution statistics,
interrupt handling, event notification and connection to an external `ISysBus`.

Processor-specific register access, reset, single-step execution,
current-instruction reporting and state persistence are left abstract for derived
CPU classes.

### Related types

|name              |type          |description                                     |
|------------------|--------------|------------------------------------------------|
|`TArchitecture`   |enumeration   |CPU memory architecture.                        |
|`TEndianness`     |enumeration   |CPU byte order.                                 |
|`TCPUEvent`       |enumeration   |Generic CPU events.                             |
|`TCPUEventHandler`|procedure type|CPU event callback.                             |
|`TSemanticVersion`|record        |Major, minor and patch version information.     |
|`TLogRec`         |record        |Information about the last executed instruction.|

`TArchitecture` contains `arHarvard` and `arNeumann`.

### Enumeration values

#### TArchitecture

|value      |description              |
|-----------|-------------------------|
|`arHarvard`|Harvard architecture.    |
|`arNeumann`|von Neumann architecture.|

#### TEndianness

|value     |description              |
|----------|-------------------------|
|`enLittle`|Little-endian byte order.|
|`enBig`   |Big-endian byte order.   |

#### TCPUEvent

|value                  |description                |
|-----------------------|---------------------------|
|`ceInstructionBoundary`|Instruction boundary event.|
|`ceInterrupt`          |Interrupt event.           |
|`ceHalt`               |CPU halt event.            |
|`ceReset`              |CPU reset event.           |

### Type helpers

|name                             |description                                            |
|---------------------------------|-------------------------------------------------------|
|`TArchitectureHelper.ToString`   |Converts an architecture value to its enumeration name.|
|`TArchitectureHelper.FromString` |Converts a name to `TArchitecture` using RTTI.         |
|`TEndiannessHelper.ToString`     |Converts an endianness value to its enumeration name.  |
|`TEndiannessHelper.FromString`   |Converts a name to `TEndianness` using RTTI.           |
|`TCPUEventHelper.ToString`       |Converts a CPU event value to its enumeration name.    |
|`TCPUEventHelper.FromString`     |Converts a name to `TCPUEvent` using RTTI.             |
|`TSemanticVersionHelper.ToString`|Formats a version as `Major.Minor.Patch`.              |
|`TSemanticVersionHelper.Compare` |Compares two versions and returns `-1`, `0` or `1`.    |

### `ISysBus` interface

The CPU stores an `ISysBus` reference in `FBus`.

|method                                     |description                   |
|-------------------------------------------|------------------------------|
|`MemRead(AAddress: UInt64): Byte`          |Reads a byte from data memory.|
|`MemWrite(AAddress: UInt64; AValue: Byte)` |Writes a byte to data memory. |
|`CodeRead(AAddress: UInt64): Byte`         |Reads a byte from code memory.|
|`CodeWrite(AAddress: UInt64; AValue: Byte)`|Writes a byte to code memory. |
|`IORead(APort: UInt64): Byte`              |Reads a byte from an I/O port.|
|`IOWrite(APort: UInt64; AValue: Byte)`     |Writes a byte to an I/O port. |

### Protected fields

|name               |type              |description                               |initial value  |
|-------------------|------------------|------------------------------------------|---------------|
|`FBus`             |`ISysBus`         |Connected external bus.                   |`nil`          |
|`FInstanceID`      |`Integer`         |Module instance identifier.               |`-1`           |
|`FOnEvent`         |`TCPUEventHandler`|CPU event callback.                       |`nil`          |
|`FModname`         |`PChar`           |Module name.                              |not initialized|
|`FDescription`     |`PChar`           |Short description.                        |not initialized|
|`FVersion`         |`TSemanticVersion`|Module version.                           |`0.1.0`        |
|`FAddressWidth`    |`Byte`            |Address bus width in bits.                |not initialized|
|`FArchitecture`    |`TArchitecture`   |CPU architecture.                         |not initialized|
|`FEnabled`         |`Boolean`         |Enables CPU without bus detachment.       |`False`        |
|`FEndianness`      |`TEndianness`     |CPU byte order.                           |not initialized|
|`FMaxCodeAddress`  |`DWord`           |Highest code memory address.              |not initialized|
|`FMaxIOPortAddress`|`DWord`           |Highest I/O port address.                 |not initialized|
|`FMaxMemAddress`   |`DWord`           |Highest data memory address.              |not initialized|
|`FHasSeparateIOBus`|`Boolean`         |Indicates separate memory and I/O buses.  |not initialized|
|`FRunning`         |`Boolean`         |CPU execution state.                      |`False`        |
|`FHalted`          |`Boolean`         |CPU HALT state.                           |`False`        |
|`FInterruptEnabled`|`Boolean`         |Global maskable-interrupt enable flag.    |`False`        |
|`FIRQPending`      |`Boolean`         |Pending maskable interrupt.               |`False`        |
|`FIRQVector`       |`Byte`            |Received interrupt vector.                |`0`            |
|`FNMIPending`      |`Boolean`         |Pending non-maskable interrupt.           |`False`        |
|`FCycles`          |`QWord`           |Total CPU cycles.                         |`0`            |
|`FInstructions`    |`QWord`           |Total executed instructions.              |`0`            |
|`FRegPtr`          |`array of ^Word`  |Register pointers for derived CPU classes.|empty          |

### Protected methods

|name                                       |flags|description                            |
|-------------------------------------------|-----|---------------------------------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`  |Vi   |Sends a CPU event to the host callback.|
|`procedure DoInterrupt(AEvent: TCPUEvent);`|Vi   |Dispatches an accepted interrupt event.|

### Public methods

|name                                                        |flags|description                                                  |
|------------------------------------------------------------|-----|-------------------------------------------------------------|
|`procedure ConnectBus(const Bus: ISysBus);`                 |Vi   |Connects the CPU to an external system bus.                  |
|`constructor Create;`                                       |Vi   |Initializes CPU state, interrupt flags, counters and version.|
|`destructor Destroy;`                                       |Or   |Destroys the CPU instance.                                   |
|`procedure SetRegister(const RegName: PChar; AValue: Word);`|Ab,Vi|Sets a processor register; implemented by derived classes.   |
|`function GetRegister(const RegName: PChar): Word;`         |Ab,Vi|Reads a processor register; implemented by derived classes.  |
|`function GetRegisterCount: Byte;`                          |Ab,Vi|Returns the number of processor registers.                   |
|`function GetRegisterName(AIndex: Byte): PChar;`            |Ab,Vi|Returns a register name by index.                            |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |Ab,Vi|Returns a register size by index.                            |
|`procedure Run;`                                            |Vi   |Starts execution when the CPU is enabled.                    |
|`procedure Step;`                                           |Ab,Vi|Executes one processor step; implemented by derived classes. |
|`procedure Stop;`                                           |Vi   |Stops CPU execution.                                         |
|`function GetCurrentInstruction: TLogRec;`                  |Ab,Vi|Returns information about the current instruction.           |
|`procedure IRQ(AVector: Byte);`                             |Vi   |Sets the pending IRQ and stores its vector.                  |
|`procedure NMI;`                                            |Vi   |Sets the pending non-maskable interrupt.                     |
|`function CheckInterrupts: Boolean;`                        |     |Accepts a pending interrupt when applicable.                 |
|`procedure Reset;`                                          |Ab,Vi|Resets the processor; implemented by derived classes.        |
|`function LoadState(AStream: TStream): Boolean;`            |Ab,Vi|Loads processor state; implemented by derived classes.       |
|`function SaveState(AStream: TStream): Boolean;`            |Ab,Vi|Saves processor state; implemented by derived classes.       |

### Public properties

|name              |type              |access    |description                               |
|------------------|------------------|----------|------------------------------------------|
|`AddressWidth`    |`Byte`            |read      |Address bus width in bits.                |
|`Architecture`    |`TArchitecture`   |read      |CPU architecture.                         |
|`Cycles`          |`QWord`           |read      |Total CPU cycle counter.                  |
|`Description`     |`PChar`           |read      |Short module description.                 |
|`Enabled`         |`Boolean`         |read/write|Enables or disables CPU operation.        |
|`Endianness`      |`TEndianness`     |read      |CPU byte order.                           |
|`Halted`          |`Boolean`         |read      |Current CPU HALT state.                   |
|`HasSeparateIOBus`|`Boolean`         |read      |Whether memory and I/O buses are separate.|
|`InstanceID`      |`Integer`         |read/write|Module instance identifier.               |
|`Instructions`    |`QWord`           |read      |Total executed instruction counter.       |
|`InterruptEnabled`|`Boolean`         |read      |Global maskable-interrupt state.          |
|`MaxCodeAddress`  |`DWord`           |read      |Highest code memory address.              |
|`MaxIOPortAddress`|`DWord`           |read      |Highest I/O port address.                 |
|`MaxMemAddress`   |`DWord`           |read      |Highest data memory address.              |
|`Modname`         |`PChar`           |read      |Module name.                              |
|`OnEvent`         |`TCPUEventHandler`|read/write|CPU event callback.                       |
|`Running`         |`Boolean`         |read      |Current execution state.                  |
|`Version`         |`TSemanticVersion`|read      |Module version.                           |
