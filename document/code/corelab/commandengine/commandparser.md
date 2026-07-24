# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandParser base class

TCommandParser is the base class responsible for lexical processing of input
command strings, splitting the raw text into tokens that can be interpreted by
the command interpreter.

### Public methods

|name                                                                            |V|A|O|description                                                                |
|--------------------------------------------------------------------------------|-|-|-|---------------------------------------------------------------------------|
|`constructor Create;`                                                           |x| | |Sets the initial values for the new object                                 |
|`destructor Destroy;`                                                           | | |x|Frees the object's resources                                               |
|`function Tokenize(const ALine: string; AContext: TCommandContext): TTokenList;`|x| | |Parses the input string and splits it into a sequence of individual tokens.|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
