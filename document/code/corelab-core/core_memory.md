# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TMemory base class in core_memory unit

TMemory is an abstract base class for memory modules. It provides a unified basis
for implementing hardware-specific memory types.

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

|name                             |type                       |description           |
|---------------------------------|---------------------------|----------------------|
|TMemoryMode                      |(mmRAM, mmROM)             |Memory operation mode |
|TMemoryModeHelper                |type helper for TMemoryMode|Helper                |
|.ToString                        |String                     |Convert Enum -> String|
|.FromString(const AValue: string)|TMemoryMode                |Convert String -> Enum|

### Protected fields

|name             |type       |flags|description                           |default|
|-----------------|-----------|:---:|--------------------------------------|-------|
|FAddressRangeSize|Byte       |     |Address range size (max. 2^24 byte)   |1024   |
|FDescription     |PChar      |     |Short description                     |       |
|FEnabled         |Boolean    |     |Disable memory without detach from bus|false  |
|FMemoryMode      |TMemoryMode|     |Memory operation mode                 |mmRAM  |
|FModName         |PChar      |     |Module name                           |'RAM'  |

### Public properties

|name            |type       |flags |description        |default|
|----------------|-----------|:----:|-------------------|-------|
|AddressRangeSize|Byte       |Re, Wr|= FAddressRangeSize|       |
|Description     |PChar      |Re, Wr|= FDescription     |       |
|Enabled         |Boolean    |Re, Wr|= FEnabled         |       |
|MemoryMode      |TMemoryMode|Re, Wr|= FMemoryMode      |       |
|ModName         |PChar      |Re, Wr|= FModName         |       |

### Public methods

|name                                                               |flags|description                               |
|-------------------------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                                              |Vi   |Sets the initial values for the new object|
|`destructor Destroy;`                                              |Or   |Frees the object's resources              |
|`function ReadMemory(Address: DWord): Byte;`                       |Vi   |Read virtual memory                       |
|`procedure LoadFromStream(Stream: TStream; Address, Count: DWord);`|Vi   |Load memory content from stream           |
|`procedure Reset;`                                                 |Vi   |Reset virtual memory                      |
|`procedure SaveToStream(Stream: TStream; Address, Count: DWord);`  |Vi   |Save memory content to stream             |
|`procedure WriteMemory(Address: DWord; Value: Byte);`              |Vi   |Write virtual memory                      |
