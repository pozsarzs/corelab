# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TMemory base class

### Public properties

|name            |type     |description                          |
|----------------|---------|-------------------------------------|
|AddressRangeSize|dword    |Address range size (max. 2^24 byte)  |
|Description     |PChar    |Short description                    |
|Enabled         |boolean  |Enable memory without detach from bus|
|MemoryMode      |TPortMode|Memory operation mode                |
|Modname         |PChar    |Module name                          |

### Public methods

|name                                                               |description                                |
|-------------------------------------------------------------------|-------------------------------------------|
|`constructor Create;`                                              |Sets the initial values for the new object.|
|`destructor Destroy;`                                              |Frees the object's resources.              |
|`function ReadMemory(Address: dword): byte;`                       |Read virtual memory.                       |
|`procedure Reset;`                                                 |Reset virtual memory.                      |
|`procedure WriteMemory(Address: dword; Value: byte);`              |Write virtual memory.                      |
|`procedure LoadFromStream(Stream: TStream; Address, Count: dword);`|Load memory content from stream.           |
|`procedure SaveToStream(Stream: TStream; Address, Count: dword);`  |Save memory content to stream.             |
