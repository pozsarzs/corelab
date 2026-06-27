# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TMemory base class

TMemory is an abstract base class for memory modules. It provides a unified basis
for implementing hardware-specific memory types.

### Own data types

|name       |type          |description          |
|-----------|--------------|---------------------|
|TMemoryMode|(mmRAM, mmROM)|Memory operation mode|

### Protected fields

|name             |type       |C|description                           |default|
|-----------------|:---------:|-|--------------------------------------|:-----:|
|FAddressRangeSize|Byte       | |Address range size (max. 2^24 byte)   |1024   |
|FDescription     |PChar      | |Short description                     |       |
|FEnabled         |Boolean    | |Disable memory without detach from bus|false  |
|FMemoryMode      |TMemoryMode| |Memory operation mode                 |mmRAM  |
|FModName         |PChar      | |Module name                           |'RAM'  |

### Public properties

|name            |type       |R|W|description        |default|
|----------------|:---------:|-|-|-------------------|:-----:|
|AddressRangeSize|Byte       |x|x|= FAddressRangeSize|       |
|Description     |PChar      |x|x|= FDescription     |       |
|Enabled         |Boolean    |x|x|= FEnabled         |       |
|MemoryMode      |TMemoryMode|x|x|= FMemoryMode      |       |
|ModName         |PChar      |x|x|= FModName         |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                               |V|A|O|description                               |
|-------------------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                                              |x| | |Sets the initial values for the new object|
|`destructor Destroy;`                                              | | |x|Frees the object's resources              |
|`function ReadMemory(Address: DWord): Byte;`                       |x| | |Read virtual memory                       |
|`procedure LoadFromStream(Stream: TStream; Address, Count: DWord);`|x| | |Load memory content from stream           |
|`procedure Reset;`                                                 |x| | |Reset virtual memory                      |
|`procedure SaveToStream(Stream: TStream; Address, Count: DWord);`  |x| | |Save memory content to stream             |
|`procedure WriteMemory(Address: DWord; Value: Byte);`              |x| | |Write virtual memory                      |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
