# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPort base class in core_ioport unit

TIOPort is the base class for input and output (I/O) ports. It provides a generic
interface for data communication between the simulated processor and peripherals.
It manages the direction of data flow, logical states, and provides an abstract
basis for implementing hardware-specific ports.

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

|name                             |type                            |description               |
|---------------------------------|--------------------------------|--------------------------|
|TLineMode                        |(lmDirect, lmBCD)               |Data line decoding mode   |
|TLineModeHelper                  |type helper for TLineMode       |Helper                    |
|.ToString                        |string                          |Convert Enum -> string    |
|.FromString(const AValue: string)|TLineMode                       |Convert String -> Enum    |
|TSemanticVersion                 |Record                          |Semantic version          |
|TSemanticVersionHelper           |type helper for TSemanticVersion|Helper                    |
|.ToString                        |string                          |Convert Record -> string  |
|.Compare(Other: TSemanticVersion)|Integer                         |Compare with other version|
|TInterruptCallback               |procedure of object             |Callback procedure for IRQ|

### Protected fields

|name             |type     |flags|description                          |default|
|-----------------|---------|:---:|-------------------------------------|-------|
|FAddressRangeSize|Byte     |     |Address range size                   |1      |
|FDataInMode      |TLineMode|     |Decoding input data lines            |lmBCD  |
|FDataInNegation  |Boolean  |     |Negation of databit (port -> CPU)    |false  |
|FDataOutMode     |TLineMode|     |Decoding output data lines           |lmBCD  |
|FDataOutNegation |Boolean  |     |Negation of databit (CPU -> port)    |false  |
|FDescription     |PChar    |     |Short description                    |       |
|FEnabled         |Boolean  |     |Disable port without detach from bus |false  |
|FHasPanel        |Boolean  |     |Does the implementation have GUI?    |false  |
|FLatchedOutput   |Boolean  |     |Latched output                       |false  |
|FModName         |PChar    |     |Module name                          |       |
|FReadBackOutput  |Boolean  |     |Output port with read-back capability|false  |
|FSelMode         |TLineMode|     |Decoding matrix selector lines       |lmBCD  |
|FSelNegation     |Boolean  |     |Negation matrix selector bits        |false  |

### Public properties

|name            |type     |flags |description        |default|
|----------------|---------|:----:|-------------------|-------|
|AddressRangeSize|Byte     |Re    |= FAddressRangeSize|       |
|DataInMode	 |TLineMode|Re, Wr|= FDataInMode      |       |
|DataInNegation  |Boolean  |Re, Wr|= FDataInNegation  |       |
|DataOutMode	 |TLineMode|Re, Wr|= FDataOutMode     |       |
|DataOutNegation |Boolean  |Re, Wr|= FDataOutNegation |       |
|Description     |PChar    |Re    |= FDescription     |       |
|Enabled         |Boolean  |Re, Wr|= FEnabled         |       |
|HasPanel        |Boolean  |Re    |= FHasPanel        |       |
|LatchedOutput   |Boolean  |Re    |= FLatchedOutput   |       |
|ModName         |PChar    |Re    |= FModName         |       |
|ReadBackOutput  |Boolean  |Re    |= FReadBackOutput  |       |
|SelMode	 |TLineMode|Re, Wr|= FSelMode         |       |
|SelNegation     |Boolean  |Re, Wr|= FSelNegation     |       |

### Public methods

|name                                           |flags |description                               |
|-----------------------------------------------|:----:|------------------------------------------|
|`constructor Create;`                          |Vi    |Sets the initial values for the new object|
|`destructor Destroy;`                          |Or    |Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         |Vi, Ab|Read virtual port                         |
|`procedure Reset;`                             |Vi, Ab|Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`|Vi, Ab|Write virtual port                        |
