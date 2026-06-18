# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## System bus base class

### Public properties

|name      |type   |description                   |
|----------|-------|------------------------------|
|CodeMemory|TMemory|Connected code memory module  |
|DataMemory|TMemory|Connected (data) memory module|
|IOPorts   |TIOPort|Connected I/O module          |

### Public methods

|name                                                |description                                        |
|----------------------------------------------------|---------------------------------------------------|
|`constructor Create;`                               |Sets the initial values for the new object.        |
|`destructor Destroy;`                               |Frees the object's resources.                      |
|`function CodeRead(Address: uint64): byte;`         |Reading code memory based on absolute address.     |
|`function IORead(Port: uint64): byte;`              |Reading I/O port based on absolute address.        |
|`function MemRead(Address: uint64): byte;`          |Reading (data) memory based on absolute address.   |
|`procedure AttachCodeMemory(AMemory: TMemory);`     |Connecting code memory (Harvard).                  |
|`procedure AttachDataMemory(AMemory: TMemory);`     |Connecting data memory (Harvard).                  |
|`procedure AttachIOPorts(APorts: TIOPort);`         |Connecting I/O ports.                              |
|`procedure AttachMemory(AMemory: TMemory);`         |Connecting memory (Neumann).                       |
|`procedure CodeWrite(Address: uint64; Value: byte);`|Writing code memory based on absolute address.     |
|`procedure IOWrite(Port: uint64; Value: byte);`     |Writing I/O port based on absolute address.        |
|`procedure MemWrite(Address: uint64; Value: byte);` |Writing (data) memory based on absolute address.   |
|`procedure Reset;`                                  |Reset all hardware components connected to the bus.| 
