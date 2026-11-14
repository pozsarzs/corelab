# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU from core_cpu unit

`TCPU` is an abstract base class for processor implementations. It defines common
CPU identity and architecture information, bus configuration, runtime state,
execution statistics, interrupt handling and event notification.

The class does not implement processor-specific register access, reset,
single-step execution, current-instruction reporting or state persistence.
These operations are left to derived CPU classes. Bus connection is also
abstract and is implemented by the derived class.

### Related types

|name                    |type          |description                                       |
|------------------------|--------------|--------------------------------------------------|
|`TProcessorDestroyEvent`|procedure type|Callback invoked when a CPU instance is destroyed.|
|`TArchitecture`         |enumeration   |CPU memory architecture.                          |
|`TEndianness`           |enumeration   |CPU byte order.                                   |
|`TCPUEvent`             |enumeration   |Generic CPU events.                               |
|`TCPUEventHandler`      |procedure type|CPU event callback.                               |
|`TSemanticVersion`      |record        |Major, minor and patch version information.       |
|`TLastInstruction`      |record        |Decoded data of the last executed instruction.    |
|`TLogRec`               |record        |Information used for the last-instruction log.    |
|`TIntLogRec`            |record        |Information used for the interrupt log.           |
|`TBusType`              |enumeration   |System bus type, declared in `core_bus`.          |

### Record fields

#### TSemanticVersion

|field  |type     |description          |
|-------|---------|---------------------|
|`Major`|`Integer`|Major version number.|
|`Minor`|`Integer`|Minor version number.|
|`Patch`|`Integer`|Patch version number.|

#### TLastInstruction

|field       |type                 |description                     |
|------------|---------------------|--------------------------------|
|`Address`   |`Word`               |Instruction address.            |
|`Opcode`    |`Byte`               |Opcode byte.                    |
|`NumPrefix` |`Byte`               |Number of prefixes.             |
|`Prefixes`  |`array[1..2] of Word`|Prefix values.                  |
|`NumOperand`|`Byte`               |Number of operands.             |
|`Operands`  |`array[1..2] of Word`|Operand values.                 |
|`Mnemonic`  |`string[32]`         |Instruction mnemonic.           |
|`Cycles`    |`Byte`               |Cycle count for the instruction.|

#### TLogRec

|field        |type        |description                 |
|-------------|------------|----------------------------|
|`InstCount`  |`Integer`   |Instruction count.          |
|`Address`    |`string[32]`|Instruction address as text.|
|`OpCode`     |`string[32]`|Opcode as text.             |
|`Mnemonic`   |`string[32]`|Instruction mnemonic.       |
|`Cycles`     |`Byte`      |Instruction cycle count.    |
|`TotalCycles`|`QWord`     |Total cycle count.          |

#### TIntLogRec

|field   |type        |description                |
|--------|------------|---------------------------|
|`Sender`|`string[32]`|Interrupt source.          |
|`Vector`|`string[32]`|Interrupt vector as text.  |
|`Status`|`string[32]`|Interrupt status as text.  |
|`Flag`  |`string[32]`|Interrupt flag information.|

### Enumeration values

#### TArchitecture

|value      |description          |
|-----------|---------------------|
|`arHarvard`|Harvard architecture.|
|`arNeumann`|Neumann architecture.|

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

`TBusType` is declared in `core_bus`. Its values used by the framework are
`btStandard` and `btMCS4`.

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

### Protected fields

|name                |type                    |description                                  |initial value|
|--------------------|------------------------|---------------------------------------------|-------------|
|`FOnEvent`          |`TCPUEventHandler`      |CPU event callback.                          |`nil`        |
|`FModname`          |`PChar`                 |Module name.                                 |not set here |
|`FDescription`      |`PChar`                 |Short description.                           |not set here |
|`FVersion`          |`TSemanticVersion`      |Module version.                              |`0.1.0`      |
|`FAddressWidth`     |`Byte`                  |Address bus width in bits.                   |not set here |
|`FArchitecture`     |`TArchitecture`         |CPU architecture.                            |not set here |
|`FBusType`          |`TBusType`              |System bus type.                             |`btStandard` |
|`FDefaultClockFreq` |`DWord`                 |Default clock frequency in hertz.            |`1000000`    |
|`FEnabled`          |`Boolean`               |Enables the CPU without detaching it.        |`False`      |
|`FEndianness`       |`TEndianness`           |CPU byte order.                              |not set here |
|`FLastInstruction`  |`TLastInstruction`      |Data of the last instruction.                |not set here |
|`FMaxCodeAddress`   |`DWord`                 |Highest code memory address.                 |not set here |
|`FMaxIOPortAddress` |`DWord`                 |Highest I/O port address.                    |not set here |
|`FMaxMemAddress`    |`DWord`                 |Highest data memory address.                 |not set here |
|`FHasSeparateIOBus` |`Boolean`               |Indicates separate memory and I/O buses.     |not set here |
|`FRunning`          |`Boolean`               |CPU execution state.                         |`False`      |
|`FHalted`           |`Boolean`               |CPU HALT state.                              |`False`      |
|`FInterruptEnabled` |`Boolean`               |Global maskable-interrupt enable flag.       |`False`      |
|`FIRQPending`       |`array[0..7] of Boolean`|Pending maskable interrupt flags.            |all `False`  |
|`FIRQVector`        |`array[0..7] of Byte`   |Interrupt vectors for the eight IRQ channels.|all `0`      |
|`FNMIPending`       |`Boolean`               |Pending non-maskable interrupt.              |`False`      |
|`FTotalCycles`      |`QWord`                 |Total CPU cycles.                            |`0`          |
|`FTotalInstructions`|`QWord`                 |Total executed instructions.                 |`0`          |
|`FOnDestroy`        |`TProcessorDestroyEvent`|CPU destruction callback.                    |not set here |
|`FRegPtr`           |`array of ^Word`        |Register pointers for derived CPU classes.   |empty        |

### Protected methods

|name                                                        |flags|description                                       |
|------------------------------------------------------------|-----|--------------------------------------------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`                   |Vi   |Sends an event to the registered callback.        |
|`procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0);`|Vi   |Dispatches an interrupt event through `EmitEvent`.|

### Public methods

|name                                                        |flags|description                                                                                  |
|------------------------------------------------------------|-----|---------------------------------------------------------------------------------------------|
|`function ConnectBus(const ABus: IInterface): Boolean;`     |Ab,Vi|Abstract bus connection implemented by derived classes.                                      |
|`constructor Create;`                                       |Vi   |Initializes runtime flags, interrupt arrays, counters, bus type, clock frequency and version.|
|`destructor Destroy;`                                       |Or   |Calls `OnDestroy` when assigned, then destroys the instance.                                 |
|`function CheckInterrupts: Boolean;`                        |Vi   |Accepts one pending interrupt, if one can be accepted.                                       |
|`function GetCurrentInstruction: TLogRec;`                  |Ab,Vi|Returns current-instruction log data; abstract.                                              |
|`function GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec;`|Vi   |Returns interrupt log data; the base implementation clears `Sender` only.                    |
|`function GetRegister(const RegName: PChar): Word;`         |Ab,Vi|Reads a processor register; implemented by derived classes.                                  |
|`function GetRegisterCount: Byte;`                          |Ab,Vi|Returns the number of processor registers.                                                   |
|`function GetRegisterName(AIndex: Byte): PChar;`            |Ab,Vi|Returns a register name by index.                                                            |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |Ab,Vi|Returns a register size by index.                                                            |
|`function LoadState(AStream: TStream): Boolean;`            |Ab,Vi|Loads processor state; implemented by derived classes.                                       |
|`function SaveState(AStream: TStream): Boolean;`            |Ab,Vi|Saves processor state; implemented by derived classes.                                       |
|`procedure IRQ(AVector: Byte; AMode: Byte = 0);`            |Vi   |Sets the pending IRQ and vector for the selected channel, then emits `ceInterrupt`.          |
|`procedure NMI;`                                            |Vi   |Sets the pending NMI and emits `ceInterrupt`.                                                |
|`procedure Reset;`                                          |Ab,Vi|Resets the processor; implemented by derived classes.                                        |
|`procedure Run;`                                            |Vi   |Sets the running state if the CPU is enabled.                                                |
|`procedure SetRegister(const RegName: PChar; AValue: Word);`|Ab,Vi|Sets a processor register; implemented by derived classes.                                   |
|`procedure Step;`                                           |Ab,Vi|Executes one processor step; implemented by derived classes.                                 |
|`procedure Stop;`                                           |Vi   |Clears the running state.                                                                    |

### Interrupt handling

The base class provides eight maskable interrupt channels, indexed from `0` to `7`.
`IRQ(AVector, AMode)` stores the vector and sets the pending flag for the selected
channel. `CheckInterrupts` checks NMI first. If no NMI is pending, it scans the
maskable channels in ascending index order and accepts the first pending IRQ when
global maskable interrupts are enabled. Accepting an interrupt clears its pending
flag and the CPU HALT state, calls `DoInterrupt` and returns `True`. At most one
interrupt is accepted per call.

Both `IRQ` and `NMI` do nothing when the CPU is disabled. The base implementation
of `DoInterrupt` only emits the supplied CPU event; its `AMode` parameter is not
otherwise used there.

### Public properties

|name               |type                    |access|description                               |
|-------------------|------------------------|------|------------------------------------------|
|`AddressWidth`     |`Byte`                  |Re    |Address bus width in bits.                |
|`Architecture`     |`TArchitecture`         |Re    |CPU architecture.                         |
|`BusType`          |`TBusType`              |Re    |System bus type.                          |
|`DefaultClockFreq` |`DWord`                 |Re    |Default clock frequency in hertz.         |
|`TotalCycles`      |`QWord`                 |Re    |Total CPU cycle counter.                  |
|`Description`      |`PChar`                 |Re    |Short module description.                 |
|`Enabled`          |`Boolean`               |Re/Wr |Enables or disables CPU operation.        |
|`Endianness`       |`TEndianness`           |Re    |CPU byte order.                           |
|`Halted`           |`Boolean`               |Re    |Current CPU HALT state.                   |
|`HasSeparateIOBus` |`Boolean`               |Re    |Whether memory and I/O buses are separate.|
|`TotalInstructions`|`QWord`                 |Re    |Total executed instruction counter.       |
|`InterruptEnabled` |`Boolean`               |Re    |Global maskable-interrupt state.          |
|`MaxCodeAddress`   |`DWord`                 |Re    |Highest code memory address.              |
|`MaxIOPortAddress` |`DWord`                 |Re    |Highest I/O port address.                 |
|`MaxMemAddress`    |`DWord`                 |Re    |Highest data memory address.              |
|`Modname`          |`PChar`                 |Re    |Module name.                              |
|`OnEvent`          |`TCPUEventHandler`      |Re/Wr |CPU event callback.                       |
|`Running`          |`Boolean`               |Re    |Current execution state.                  |
|`Version`          |`TSemanticVersion`      |Re    |Module version.                           |
|`OnDestroy`        |`TProcessorDestroyEvent`|Re/Wr |Callback invoked during destruction.      |
