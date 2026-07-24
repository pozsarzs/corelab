# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TSysBus base class

TBus is an abstract base class for buses in a simulated system. This component is
responsible for establishing the physical or logical connection between the
processor, memory modules, and I/O ports. It provides a unified interface for
reading and writing data, instructions, and I/O operations, transparently
supporting both Neumann and Harvard architectures.

### Protected fields

|name       |type   |C|description                   |default|
|-----------|-------|-|------------------------------|:-----:|
|FCodeMemory|TMemory| |Connected code memory module  |nil    |
|FDataMemory|TMemory| |Connected (data) memory module|nil    |
|FIOPorts   |TIOPort| |Connected I/O module          |nil    |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name      |type   |R|W|description  |default|
|----------|-------|-|-|-------------|:-----:|
|CodeMemory|TMemory|x| |= FCodeMemory|       |
|DataMemory|TMemory|x| |= FDataMemory|       |
|IOPorts   |TIOPort|x| |= FIOPorts   |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                |V|A|O|description                                       |
|----------------------------------------------------|-|-|-|--------------------------------------------------|
|`constructor Create;`                               |x| | |Sets the initial values for the new object        |
|`destructor Destroy;`                               |x| | |Frees the object's resources                      |
|`function CodeRead(Address: UInt64): Byte;`         |x| | |Reading code memory based on absolute address     |
|`function IORead(Port: UInt64): Byte;`              |x| | |Reading I/O port based on absolute address        |
|`function MemRead(Address: UInt64): Byte;`          |x| | |Reading (data) memory based on absolute address   |
|`procedure AttachCodeMemory(AMemory: TMemory);`     |x| | |Connecting code memory (Harvard)                  |
|`procedure AttachDataMemory(AMemory: TMemory);`     |x| | |Connecting data memory (Harvard)                  |
|`procedure AttachIOPorts(APorts: TIOPort);`         |x| | |Connecting I/O ports                              |
|`procedure AttachMemory(AMemory: TMemory);`         |x| | |Connecting memory (Neumann)                       |
|`procedure CodeWrite(Address: UInt64; Value: Byte);`|x| | |Writing code memory based on absolute address     |
|`procedure IOWrite(Port: UInt64; Value: Byte);`     |x| | |Writing I/O port based on absolute address        |
|`procedure MemWrite(Address: UInt64; Value: Byte);` |x| | |Writing (data) memory based on absolute address   |
|`procedure Reset;`                                  |x| | |Reset all hardware components connected to the bus| 

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
