# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCPU base class in core_cpu unit

TCPU is an abstract base class for simulating central processing units (CPU),
microprocessors, and microcontrollers (MCU). It provides unified management of
instruction execution, interrupt handling, memory bus communication (data, code,
I/O), and internal states, supporting both Neumann and Harvard architectures.

### Abbreviations

- _Ab_: means 'abstract',
- _Co_: means 'constant',
- _Il_: means 'inline',
- _Ol_: means 'overload',
- _Or_: means 'override',
- _Re_: means 'read',
- _Ri_: means 'reintroduce',
- _St_: means 'static',
- _Vi_: means 'virtual',
- _Wr_: means 'write'.

### Own data types

|name                             |type                                                     |description                     |
|---------------------------------|---------------------------------------------------------|--------------------------------|
|TArchitecture                    |(arHarvard,arNeumann)                                    |Type of architecture            |
|TTArchitectureHelper             |type helper for TArchitecture                            |Helper                          |
|.ToString                        |String                                                   |Convert Enum -> String          |
|.FromString(const AValue: string)|TArchitecture                                            |Convert String -> Enum          |
|TEndianness                      |(enLittle, enBig)                                        |CPU byte order                  |
|TEndiannessHelper                |type helper for TEndianness                              |Helper                          |
|.ToString                        |string                                                   |Convert Enum -> String          |
|.FromString(const AValue: string)|TEndianness                                              |Convert String -> Enum          |
|TCPUEvent                        |(ceInstructionBoundary, ceInterrupt, ceHalt, ceReset)    |Generic CPU events (for tracing)|
|TCPUEventHelper                  |type helper for TCPUEvent                                |Helper                          |
|.ToString                        |string                                                   |Convert Enum -> String          |
|.FromString(const AValue: string)|TCPUEvent                                                |Convert String -> Enum          |
|TCPUEventHandler                 |`procedure(Sender: TObject; Event: TCPUEvent) of Object;`|Event callback type             |

### Own interfaces

|name                                                |description                   |
|----------------------------------------------------|------------------------------|
|ICPUBus                                             |Generic CPU bus interface     |
|`function CodeRead(Address: UInt64): Byte;`         |Read a byte from code memory  |
|`function IORead(Port: UInt64): Byte;`              |Read a byte from I/O port     |
|`function MemRead(Address: UInt64): Byte;`          |Read a byte from (data) memory|
|`procedure CodeWrite(Address: UInt64; Value: Byte);`|Write a byte to code memory   |
|`procedure IOWrite(Port: UInt64; Value: Byte);`     |Write a byte to I/O port      |
|`procedure MemWrite(Address: UInt64; Value: Byte);` |Write a byte to (data) memory |

### Protected fields

|name             |type            |flags|description                            |default|
|-----------------|----------------|:---:|---------------------------------------|-------|
|FAddressWidth    |Byte            |     |Address bus width in bits              |       |
|FArchitecture    |TArchitecture   |     |Type of architecture                   |       |
|FBitWidth        |Byte            |     |Main processor word size in bits       |       |
|FCycles          |QWord           |     |Total cycles                           |0      |
|FDescription     |PChar           |     |Short description                      |       |
|FEndianness      |TEndianness     |     |Byte order                             |       |
|FHalted          |Boolean         |     |CPU HALT state                         |false  |
|FHasSeparateIOBus|Boolean         |     |Indicates separate memory and I/O buses|       |
|FInstructions    |QWord           |     |Total executed instructions            |0      |
|FInterruptEnabled|Boolean         |     |Global interrupt enable flag           |false  |
|FIRQPending      |Boolean         |     |Pending maskable interrupt             |false  |
|FMaxCodeAddress  |QWord           |     |The highest code memory address        |       |
|FMaxIOPortAddress|QWord           |     |The highest I/O port address           |       |
|FMaxMemAddress   |QWord           |     |The highest (data) memory address      |       |
|FModname         |PChar           |     |Module name (CPU type)                 |       |
|FNMIPending      |Boolean         |     |Pending non-maskable interrupt         |false  |
|FOnEvent         |TCPUEventHandler|     |Event callback                         |       |
|FRunning         |Boolean         |     |CPU execution state                    |false  |
|FRegPtr          |array of ^QWord |     |Pointers to registers                  |       |

### Public properties

|name            |type            |flags |description        |default|
|----------------|----------------|:----:|-------------------|-------|
|AddressWidth    |Byte            |Re    |= FAddressWidth    |       |
|Architecture    |TArchitecture   |Re    |= FArchitecture    |       |
|BitWidth        |Byte            |Re    |= FBitWidth        |       |
|Cycles          |QWord           |Re    |= FCycles          |       |
|Description     |PChar           |Re    |= FDescription     |       |
|Endianness      |TEndianness     |Re    |= FEndianness      |       |
|Halted          |Boolean         |Re    |= FHalted          |       |
|HasSeparateIOBus|Boolean         |Re    |= FHasSeparateIOBus|       |
|Instructions    |QWord           |Re    |= FInstructions    |       |
|InterruptEnabled|Boolean         |Re    |= FInterruptEnabled|       |
|IRQPending      |Boolean         |Re    |= FIRQPending      |       |
|MaxCodeAddress  |QWord           |Re    |= FMaxCodeAddress  |       |
|MaxIOPortAddress|QWord           |Re    |= FMaxIOPortAddress|       |
|MaxMemAddress   |QWord           |Re    |= FMaxMemAddress   |       |
|Modname         |PChar           |Re    |= FModname         |       |
|NMIPending      |Boolean         |Re    |= FNMIPending      |       |
|OnEvent         |TCPUEventHandler|Re, Wr|= FOnEvent         |       |
|Running         |Boolean         |Re    |= FRunning         |       |

### Public methods

|name                                                        |flags |description                               |
|------------------------------------------------------------|:----:|------------------------------------------|
|`constructor Create;`                                       |Vi    |Sets the initial values for the new object|
|`destructor Destroy;`                                       |Vi    |Frees the object's resources              |
|`function CheckInterrupts: Boolean;`                        |Vi, Ab|Interrupt handler                         |
|`function GetCurrentInstruction: PChar;`                    |Vi, Ab|Get last instruction (mnemonic)           |
|`function GetRegister(const RegName: PChar): QWord;`        |Vi, Ab|Get register content                      |
|`procedure ConnectBus(const Bus: ICPUBus);`                 |Vi    |Connect CPU to external system bus        |
|`procedure IRQ;`                                            |Vi    |Signal maskable interrupt                 |
|`procedure NMI;`                                            |Vi    |Signal non-maskable interrupt             |
|`procedure Reset;`                                          |Vi, Ab|Reset CPU                                 |
|`procedure Run;`                                            |Vi    |Start CPU execution                       |
|`procedure SetRegister(const RegName: PChar; Value: QWord);`|Vi, Ab|Set register content                      |
|`procedure Step;`                                           |Vi    |Execute single instruction                |
|`procedure Stop;`                                           |Vi    |Stop CPU execution                        |
