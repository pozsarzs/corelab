# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TSysBus base class in core_sysbus unit

TBus is an abstract base class for buses in a simulated system. This component is
responsible for establishing the physical or logical connection between the
processor, memory modules, and I/O ports. It provides a unified interface for
reading and writing data, instructions, and I/O operations, transparently
supporting both Neumann and Harvard architectures.

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

### Protected fields

|name       |type   |flags|description                   |default|
|-----------|-------|:---:|------------------------------|-------|
|FCodeMemory|TMemory|     |Connected code memory module  |nil    |
|FDataMemory|TMemory|     |Connected (data) memory module|nil    |
|FIOPorts   |TIOPort|     |Connected I/O module          |nil    |

### Public properties

|name      |type   |flags|description  |default|
|----------|-------|:---:|-------------|-------|
|CodeMemory|TMemory|Re   |= FCodeMemory|       |
|DataMemory|TMemory|Re   |= FDataMemory|       |
|IOPorts   |TIOPort|Re   |= FIOPorts   |       |

### Public methods

|name                                                  |flags|description                                       |
|------------------------------------------------------|:---:|--------------------------------------------------|
|`constructor Create;`                                 |Vi   |Sets the initial values for the new object        |
|`destructor Destroy;`                                 |Vi   |Frees the object's resources                      |
|`function CodeRead(AAddress: UInt64): Byte;`          |Vi   |Reading code memory based on absolute address     |
|`function IORead(APort: UInt64): Byte;`               |Vi   |Reading I/O port based on absolute address        |
|`function MemRead(AAddress: UInt64): Byte;`           |Vi   |Reading (data) memory based on absolute address   |
|`procedure AttachCodeMemory(AMemory: TMemory);`       |Vi   |Connecting code memory (Harvard)                  |
|`procedure AttachDataMemory(AMemory: TMemory);`       |Vi   |Connecting data memory (Harvard)                  |
|`procedure AttachIOPorts(APorts: TIOPort);`           |Vi   |Connecting I/O ports                              |
|`procedure AttachMemory(AMemory: TMemory);`           |Vi   |Connecting memory (Neumann)                       |
|`procedure CodeWrite(AAddress: UInt64; AValue: Byte);`|Vi   |Writing code memory based on absolute address     |
|`procedure IOWrite(APort: UInt64; AValue: Byte);`     |Vi   |Writing I/O port based on absolute address        |
|`procedure MemWrite(AAddress: UInt64; AValue: Byte);` |Vi   |Writing (data) memory based on absolute address   |
|`procedure Reset;`                                    |Vi   |Reset all hardware components connected to the bus| 
