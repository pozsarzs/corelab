# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPort base class

TIOPort is the base class for input and output (I/O) ports. It provides a generic
interface for data communication between the simulated processor and peripherals.
It manages the direction of data flow, logical states, and provides an abstract
basis for implementing hardware-specific ports.

### Own data types

|name                             |type                                  |description              |
|---------------------------------|--------------------------------------|-------------------------|
|TLineMode                        |(lmDirect, lmBCD)                     |Data line decoding mode  |
|TLineModeHelper                  |type helper for TLineMode             |Helper                   |
|.ToString                        |String                                |Convert Enum -> String   |
|.FromString(const AValue: string)|TLineMode                             |Convert String -> Enum   |
|TPortMode                        |(pmReadOnly, pmWriteOnly, pmReadWrite)|Port operation mode      |
|TPortModeHelper                  |type helper for TPortMode             |Helper                   |
|.ToString                        |String                                |Convert Enum -> String   |
|.FromString(const AValue: string)|TPortMode                             |Convert String -> Enum   |
|TResponse                        |(rp00, rpFF)                          |Response of the null port|
|TResponseHelper                  |type helper for TResponse             |Helper                   |
|.ToString                        |String                                |Convert Enum -> String   |
|.FromString(const AValue: string)|TResponse                             |Convert String -> Enum   |

### Protected fields

|name             |type     |C|description                          |default    |
|-----------------|:-------:|-|-------------------------------------|:---------:|
|FAddressRangeSize|Byte     | |Address range size                   |1          |
|FDataInMode      |TLineMode| |Decoding input data lines            |lmBCD      |
|FDataInNegation  |Boolean  | |Negation of databit (port -> CPU)    |false      |
|FDataOutMode     |TLineMode| |Decoding output data lines           |lmBCD      |
|FDataOutNegation |Boolean  | |Negation of databit (CPU -> port)    |false      |
|FDescription     |PChar    | |Short description                    |           |
|FEnabled         |Boolean  | |Disable port without detach from bus |false      |
|FHasGUI          |Boolean  | |Does the implementation have a GUI?  |false      |
|FLatchedOutput   |Boolean  | |Latched output                       |false      |
|FModName         |PChar    | |Module name                          |           |
|FPortMode        |TPortMode| |Port operation mode                  |pmReadWrite|
|FReadBackOutput  |Boolean  | |Output port with read-back capability|false      |
|FResponse        |TResponse| |Null device response mode            |rp00       |
|FSelMode         |TLineMode| |Decoding matrix selector lines       |lmBCD      |
|FSelNegation     |Boolean  | |Negation matrix selector bits        |false      |
|FTitle           |PChar    | |Form title                           |= FModName |

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
|HasGUI          |Boolean  |x| |= FHasGUI          |       |
|LatchedOutput   |Boolean  |x| |= FLatchedOutput   |       |
|ModName         |PChar    |x| |= FModName         |       |
|PortMode        |TPortMode|x| |= FPortMode        |       |
|ReadBackOutput  |Boolean  |x| |= FReadBackOutput  |       |
|Response        |TResponse|x|x|= FResponse        |       |
|SelMode	 |TLineMode|x|x|= FSelMode         |       |
|SelNegation     |Boolean  |x|x|= FSelNegation     |       |
|Title           |PChar    |x|x|= FTitle           |       |

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
