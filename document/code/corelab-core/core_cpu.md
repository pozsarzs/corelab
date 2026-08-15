# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU and related types from core_cpu unit

`TCPU` is an abstract base class for processor implementations. It defines common CPU identity and architecture information, runtime state, execution statistics, event notification, interrupt handling, instance identification, enable state, and connection to an external `ISysBus` implementation.

The class does not implement processor-specific register access, reset, single-step execution, instruction decoding, or state persistence. These operations are left abstract for derived CPU classes.

### Related types

|name|type|description|
|---|---|---|
|`TArchitecture`|enumeration|CPU memory architecture: `arHarvad` or `arNeumann`.|
|`TEndianness`|enumeration|CPU byte order: `enLittle` or `enBig`.|
|`TCPUEvent`|enumeration|Generic CPU events: instruction boundary, interrupt, halt, and reset.|
|`TCPUEventHandler`|procedure type|Callback receiving the sender object and a CPU event.|
|`ISysBus`|interface|System-bus interface used by the CPU for memory and I/O access.|
|`TSemanticVersion`|record|Major, minor, and patch version information.|

The source defines the architecture member as `arHarvad` with this spelling.

### Type helpers

|name|description|
|---|---|
|`TArchitectureHelper.ToString`|Converts an architecture value to its enumeration name.|
|`TArchitectureHelper.FromString`|Converts an enumeration name to a `TArchitecture` value using RTTI.|
|`TEndiannessHelper.ToString`|Converts an endianness value to its enumeration name.|
|`TEndiannessHelper.FromString`|Converts an enumeration name to a `TEndianness` value using RTTI.|
|`TCPUEventHelper.ToString`|Converts a CPU event value to its enumeration name.|
|`TCPUEventHelper.FromString`|Converts an enumeration name to a `TCPUEvent` value using RTTI.|
|`TSemanticVersionHelper.ToString`|Formats a version as `Major.Minor.Patch`.|
|`TSemanticVersionHelper.Compare`|Compares two semantic versions and returns `-1`, `0`, or `1`. The comparison is relative to the current version.|

### `ISysBus` interface

The CPU stores an `ISysBus` reference in `FBus`. The interface provides the CPU-side system-bus operations:

|method|description|
|---|---|
|`MemRead(AAddress: UInt64): Byte`|Read a byte from data memory.|
|`MemWrite(AAddress: UInt64; AValue: Byte)`|Write a byte to data memory.|
|`CodeRead(AAddress: UInt64): Byte`|Read a byte from code memory.|
|`CodeWrite(AAddress: UInt64; AValue: Byte)`|Write a byte to code memory.|
|`IORead(APort: UInt64): Byte`|Read a byte from an I/O port.|
|`IOWrite(APort: UInt64; AValue: Byte)`|Write a byte to an I/O port.|

### Protected fields

|name|type|description|initial value|
|---|---|---|---|
|`FBus`|`ISysBus`|Connected external system bus.|`nil`|
|`FInstanceID`|`Integer`|Module instance identifier.|`-1`|
|`FOnEvent`|`TCPUEventHandler`|CPU event callback.|`nil`|
|`FModname`|`PChar`|Module name.|not initialized here|
|`FDescription`|`PChar`|Short description.|not initialized here|
|`FVersion`|`TSemanticVersion`|Module version.|`0.1.0`|
|`FArchitecture`|`TArchitecture`|CPU architecture.|not initialized here|
|`FBitWidth`|`Byte`|Processor word size in bits.|not initialized here|
|`FAddressWidth`|`Byte`|Address bus width in bits.|not initialized here|
|`FEnabled`|`Boolean`|Enables the CPU without detaching it from the bus.|`False`|
|`FEndianness`|`TEndianness`|CPU byte order.|not initialized here|
|`FMaxMemAddress`|`QWord`|Highest data-memory address.|not initialized here|
|`FMaxCodeAddress`|`QWord`|Highest code-memory address.|not initialized here|
|`FMaxIOPortAddress`|`QWord`|Highest I/O-port address.|not initialized here|
|`FHasSeparateIOBus`|`Boolean`|Indicates separate memory and I/O buses.|not initialized here|
|`FRunning`|`Boolean`|CPU execution state.|`False`|
|`FHalted`|`Boolean`|CPU HALT state.|`False`|
|`FInterruptEnabled`|`Boolean`|Global maskable-interrupt enable flag.|`False`|
|`FIRQPending`|`Boolean`|Pending maskable interrupt.|`False`|
|`FNMIPending`|`Boolean`|Pending non-maskable interrupt.|`False`|
|`FCycles`|`QWord`|Total CPU cycles.|`0`|
|`FInstructions`|`QWord`|Total executed instructions.|`0`|
|`FRegPtr`|`array of ^QWord`|Register pointers intended for derived CPU implementations.|empty|

### Protected methods

|name|flags|description|
|---|:---:|---|
|`procedure EmitEvent(AEvent: TCPUEvent);`|Vi|Sends a CPU event to the registered `OnEvent` callback when one is assigned.|
|`procedure DoInterrupt(AEvent: TCPUEvent);`|Vi|Dispatches an accepted interrupt through `EmitEvent`.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`procedure ConnectBus(const Bus: ISysBus);`|Vi|Stores the supplied external system-bus reference in `FBus`.|
|`constructor Create;`|Vi|Initializes the common CPU state, instance ID, enable state, interrupt state, execution counters and version.|
|`destructor Destroy;`|Or|Destroys the CPU instance.|
|`procedure SetRegister(const RegName: PChar; AValue: QWord);`|Ab,Vi|Sets a processor register; implementation is supplied by the derived CPU.|
|`function GetRegister(const RegName: PChar): QWord;`|Ab,Vi|Reads a processor register; implementation is supplied by the derived CPU.|
|`procedure Run;`|Vi|Sets the CPU running state to `True`.|
|`procedure Step;`|Ab,Vi|Executes one processor step; implementation is supplied by the derived CPU.|
|`procedure Stop;`|Vi|Sets the CPU running state to `False`.|
|`function GetCurrentInstruction: PChar;`|Ab,Vi|Returns the current instruction representation; implementation is supplied by the derived CPU.|
|`procedure IRQ;`|Vi|Sets the pending maskable-interrupt flag and emits a `ceInterrupt` event.|
|`procedure NMI;`|Vi|Sets the pending non-maskable-interrupt flag and emits a `ceInterrupt` event.|
|`function CheckInterrupts: Boolean;`| |Accepts and dispatches a pending interrupt when applicable.|
|`procedure Reset;`|Ab,Vi|Resets the processor; implementation is supplied by the derived CPU.|
|`function LoadState(AStream: TStream): Boolean;`|Ab,Vi|Loads CPU state from a stream; implementation is supplied by the derived CPU.|
|`function SaveState(AStream: TStream): Boolean;`|Ab,Vi|Saves CPU state to a stream; implementation is supplied by the derived CPU.|

### Public properties

|name|type|access|description|
|---|---|:---:|---|
|`AddressWidth`|`Byte`|Re|Address bus width in bits.|
|`Architecture`|`TArchitecture`|Re|CPU architecture.|
|`BitWidth`|`Byte`|Re|Processor word size in bits.|
|`Cycles`|`QWord`|Re|Total cycle counter.|
|`Description`|`PChar`|Re|Short module description.|
|`Enabled`|`Boolean`|Re/Wr|Enables or disables the CPU without detaching it from the bus.|
|`Endianness`|`TEndianness`|Re|CPU byte order.|
|`Halted`|`Boolean`|Re|Current HALT state.|
|`HasSeparateIOBus`|`Boolean`|Re|Whether separate memory and I/O buses are supported.|
|`InstanceID`|`Integer`|Re/Wr|Module instance identifier.|
|`Instructions`|`QWord`|Re|Total executed instruction counter.|
|`InterruptEnabled`|`Boolean`|Re|Global maskable-interrupt enable state.|
|`MaxCodeAddress`|`QWord`|Re|Highest code-memory address.|
|`MaxIOPortAddress`|`QWord`|Re|Highest I/O-port address.|
|`MaxMemAddress`|`QWord`|Re|Highest data-memory address.|
|`Modname`|`PChar`|Re|Module name.|
|`OnEvent`|`TCPUEventHandler`|Re/Wr|CPU event callback.|
|`Running`|`Boolean`|Re|Current execution state.|
|`Version`|`TSemanticVersion`|Re|Module version.|

### Execution state

`Run` sets `Running` to `True`, while `Stop` sets it to `False`. The base class does not itself execute instructions; derived CPU classes provide `Step` and the processor-specific execution logic.

### Interrupt handling

`IRQ` marks a maskable interrupt as pending and emits `ceInterrupt`.

`NMI` marks a non-maskable interrupt as pending and emits `ceInterrupt`.

`CheckInterrupts` gives priority to NMI. A pending NMI is accepted unconditionally. A pending IRQ is accepted only when `InterruptEnabled` is `True`.

When an interrupt is accepted:

1. The corresponding pending flag is cleared.
2. `Halted` is cleared.
3. `DoInterrupt(ceInterrupt)` is called.
4. The function returns `True`.

If no interrupt can be accepted, the function returns `False`.

### Module state

The constructor initializes:

|item|initial value|
|---|---|
|`InstanceID`|`-1`|
|`Enabled`|`False`|
|`Running`|`False`|
|`Halted`|`False`|
|`InterruptEnabled`|`False`|
|`IRQPending`|`False`|
|`NMIPending`|`False`|
|`Cycles`|`0`|
|`Instructions`|`0`|
|`Version`|`0.1.0`|

The module identity, architecture parameters and bus limits are not initialized by the base constructor; derived CPU implementations are expected to configure them.
