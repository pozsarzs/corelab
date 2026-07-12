# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPort base class

TIOPort is the base class for input and output (I/O) ports. It provides a generic
interface for data communication between the simulated processor and peripherals.
It manages the direction of data flow, logical states, and provides an abstract
basis for implementing hardware-specific ports.

### Own data types

|name                             |type                                  |description               |
|---------------------------------|--------------------------------------|--------------------------|
|TLineMode                        |(lmDirect, lmBCD)                     |Data line decoding mode   |
|TLineModeHelper                  |type helper for TLineMode             |Helper                    |
|.ToString                        |String                                |Convert Enum -> String    |
|.FromString(const AValue: string)|TLineMode                             |Convert String -> Enum    |
|TSemanticVersion                 |Record                                |Semantic version          |
|TSemanticVersionHelper           |type helper for TSemanticVersion      |Helper                    |
|.ToString                        |String                                |Convert Record -> String  |
|.Compare(Other: TSemanticVersion)|Integer                               |Compare with other version|
|TInterruptCallback               |procedure of object                   |Callback procedure for IRQ|

### Protected fields

|name             |type     |C|description                          |default|
|-----------------|:-------:|-|-------------------------------------|:-----:|
|FAddressRangeSize|Byte     | |Address range size                   |1      |
|FDataInMode      |TLineMode| |Decoding input data lines            |lmBCD  |
|FDataInNegation  |Boolean  | |Negation of databit (port -> CPU)    |false  |
|FDataOutMode     |TLineMode| |Decoding output data lines           |lmBCD  |
|FDataOutNegation |Boolean  | |Negation of databit (CPU -> port)    |false  |
|FDescription     |PChar    | |Short description                    |       |
|FEnabled         |Boolean  | |Disable port without detach from bus |false  |
|FHasPanel        |Boolean  | |Does the implementation have GUI?    |false  |
|FLatchedOutput   |Boolean  | |Latched output                       |false  |
|FModName         |PChar    | |Module name                          |       |
|FReadBackOutput  |Boolean  | |Output port with read-back capability|false  |
|FSelMode         |TLineMode| |Decoding matrix selector lines       |lmBCD  |
|FSelNegation     |Boolean  | |Negation matrix selector bits        |false  |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name            |type     |R|W|description        |default|
|----------------|:-------:|-|-|-------------------|:-----:|
|AddressRangeSize|Byte     |x| |= FAddressRangeSize|       |
|DataInMode	 |TLineMode|x|x|= FDataInMode      |       |
|DataInNegation  |Boolean  |x|x|= FDataInNegation  |       |
|DataOutMode	 |TLineMode|x|x|= FDataOutMode     |       |
|DataOutNegation |Boolean  |x|x|= FDataOutNegation |       |
|Description     |PChar    |x| |= FDescription     |       |
|Enabled         |Boolean  |x|x|= FEnabled         |       |
|HasPanel        |Boolean  |x| |= FHasPanel        |       |
|LatchedOutput   |Boolean  |x| |= FLatchedOutput   |       |
|ModName         |PChar    |x| |= FModName         |       |
|ReadBackOutput  |Boolean  |x| |= FReadBackOutput  |       |
|SelMode	 |TLineMode|x|x|= FSelMode         |       |
|SelNegation     |Boolean  |x|x|= FSelNegation     |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                           |V|A|O|description                               |
|-----------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                          |x| | |Sets the initial values for the new object|
|`destructor Destroy;`                          | | |x|Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         |x|x| |Read virtual port                         |
|`procedure Reset;`                             |x|x| |Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`|x|x| |Write virtual port                        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
