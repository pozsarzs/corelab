# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TMemory base class

### Public properties

|name            |type     |description                          |
|----------------|---------|-------------------------------------|
|AddressRangeSize|byte     |Address range size                   |
|Description     |PChar    |Short description                    |
|Enabled         |boolean  |Enable memory without detach from bus|
|MemoryMode      |TPortMode|Memory operation mode                |
|Modname         |PChar    |Module name                          |

### Public methods

|name                                                 |description                                |
|-----------------------------------------------------|-------------------------------------------|
|`constructor Create;`                                |Sets the initial values for the new object.|
|`destructor Destroy;`                                |Frees the object's resources.              |
|`function ReadMemory(Address: qword): byte;`         |Read virtual memory.                       |
|`procedure Reset;`                                   |Reset virtual memory.                      |
|`procedure WriteMemory(Address: qword; Value: byte);`|Write virtual memory.                      |
