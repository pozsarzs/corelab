# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCPU base class

TCPU is an abstract base class for simulating central processing units (CPU),
microprocessors, and microcontrollers (MCU). It provides unified management of
instruction execution, interrupt handling, memory bus communication (data, code,
I/O), and internal states, supporting both Neumann and Harvard architectures.

### Own data types

|name                             |type                                                     |description                     |
|---------------------------------|---------------------------------------------------------|--------------------------------|
|TArchitecture                    |(arHarvard,arNeumann)                                    |Type of architecture            |
|TTArchitectureHelper             |type helper for TArchitecture                            |Helper                          |
|.ToString                        |String                                                   |Convert Enum -> String          |
|.FromString(const AValue: string)|TArchitecture                                            |Convert String -> Enum          |
|TEndianness                      |(enLittle, enBig)                                        |CPU byte order                  |
|TEndiannessHelper                |type helper for TEndianness                              |Helper                          |
|.ToString                        |String                                                   |Convert Enum -> String          |
|.FromString(const AValue: string)|TEndianness                                              |Convert String -> Enum          |
|TCPUEvent                        |(ceInstructionBoundary, ceInterrupt, ceHalt, ceReset)    |Generic CPU events (for tracing)|
|TCPUEventHelper                  |type helper for TCPUEvent                                |Helper                          |
|.ToString                        |String                                                   |Convert Enum -> String          |
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

|name             |type            |C|description                            |default|
|-----------------|----------------|-|---------------------------------------|:-----:|
|FAddressWidth    |Byte            | |Address bus width in bits              |       |
|FArchitecture    |TArchitecture   | |Type of architecture                   |       |
|FBitWidth        |Byte            | |Main processor word size in bits       |       |
|FCycles          |QWord           | |Total cycles                           |0      |
|FDescription     |PChar           | |Short description                      |       |
|FEndianness      |TEndianness     | |Byte order                             |       |
|FHalted          |Boolean         | |CPU HALT state                         |false  |
|FHasSeparateIOBus|Boolean         | |Indicates separate memory and I/O buses|       |
|FInstructions    |QWord           | |Total executed instructions            |0      |
|FInterruptEnabled|Boolean         | |Global interrupt enable flag           |false  |
|FIRQPending      |Boolean         | |Pending maskable interrupt             |false  |
|FMaxCodeAddress  |QWord           | |The highest code memory address        |       |
|FMaxIOPortAddress|QWord           | |The highest I/O port address           |       |
|FMaxMemAddress   |QWord           | |The highest (data) memory address      |       |
|FModname         |PChar           | |Module name (CPU type)                 |       |
|FNMIPending      |Boolean         | |Pending non-maskable interrupt         |false  |
|FOnEvent         |TCPUEventHandler| |Event callback                         |       |
|FRunning         |Boolean         | |CPU execution state                    |false  |
|FRegPtr          |array of ^QWord | |Pointers to registers                  |       |

**Note**:  
- _C_: means 'constant'.

### Protected methods

|name                                      |V|A|description              |
|------------------------------------------|-|-|-------------------------|
|`procedure EmitEvent(Event: TCPUEvent);`  |x| |Event release event      |
|`procedure DoInterrupt(Event: TCPUEvent);`|x| |Interrupt execution event|

### Public properties

|name            |type            |R|W|description        |default|
|----------------|----------------|-|-|-------------------|-------|
|AddressWidth    |Byte            |x| |= FAddressWidth    |       |
|Architecture    |TArchitecture   |x| |= FArchitecture    |       |
|BitWidth        |Byte            |x| |= FBitWidth        |       |
|Cycles          |QWord           |x| |= FCycles          |       |
|Description     |PChar           |x| |= FDescription     |       |
|Endianness      |TEndianness     |x| |= FEndianness      |       |
|Halted          |Boolean         |x| |= FHalted          |       |
|HasSeparateIOBus|Boolean         |x| |= FHasSeparateIOBus|       |
|Instructions    |QWord           |x| |= FInstructions    |       |
|InterruptEnabled|Boolean         |x| |= FInterruptEnabled|       |
|IRQPending      |Boolean         |x| |= FIRQPending      |       |
|MaxCodeAddress  |QWord           |x| |= FMaxCodeAddress  |       |
|MaxIOPortAddress|QWord           |x| |= FMaxIOPortAddress|       |
|MaxMemAddress   |QWord           |x| |= FMaxMemAddress   |       |
|Modname         |PChar           |x| |= FModname         |       |
|NMIPending      |Boolean         |x| |= FNMIPending      |       |
|OnEvent         |TCPUEventHandler|x|x|= FOnEvent         |       |
|Running         |Boolean         |x| |= FRunning         |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                        |V|A|O|description                               |
|------------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                                       |x| | |Sets the initial values for the new object|
|`destructor Destroy;`                                       |x| | |Frees the object's resources              |
|`function CheckInterrupts: Boolean;`                        |x| | |Interrupt handler                         |
|`function GetCurrentInstruction: PChar;`                    |x|x| |Get last instruction (mnemonic)           |
|`function GetRegister(const RegName: PChar): QWord;`        |x|x| |Get register content                      |
|`procedure ConnectBus(const Bus: ICPUBus);`                 |x| | |Connect CPU to external system bus        |
|`procedure IRQ;`                                            |x| | |Signal maskable interrupt                 |
|`procedure NMI;`                                            |x| | |Signal non-maskable interrupt             |
|`procedure Reset;`                                          |x|x| |Reset CPU                                 |
|`procedure Run;`                                            |x| | |Start CPU execution                       |
|`procedure SetRegister(const RegName: PChar; Value: QWord);`|x|x| |Set register content                      |
|`procedure Step;`                                           |x| | |Execute single instruction                |
|`procedure Stop;`                                           |x| | |Stop CPU execution                        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
