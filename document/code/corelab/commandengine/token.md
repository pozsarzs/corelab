# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TToken base class

TToken is a fundamental data structure in the CoreLAB parsing system. It
represents a single lexical unit, such as a keyword, identifier, or symbol,
extracted from the input command line during the tokenization process.

### Own data types

|name      |type                          |description   |
|----------|------------------------------|--------------|
|TTokenList|specialize TObjectList<TToken>|TokenList type| 

### Protected fields

|name    |type  |C|description             |default|
|--------|------|-|------------------------|:-----:|
|FRawText|string| |Token in raw text format|       |                                       |       |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name            |type            |R|W|description        |default|
|----------------|----------------|-|-|-------------------|-------|
|RawText         |                |x| |= FRawText         |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                      |V|A|O|description                               |
|----------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create(const ARawText: string); reintroduce;`|x| | |Sets the initial values for the new object|
|`destructor Destroy;`                                     | | |x|Frees the object's resources              |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
