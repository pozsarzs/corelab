# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TToken base class in Token unit

TToken is a fundamental data structure in the CoreLAB parsing system. It
represents a single lexical unit, such as a keyword, identifier, or symbol,
extracted from the input command line during the tokenization process.

### UML diagram

![Class diagram](../diagrams/_png/commandengine.png "CoreLAB CommandEngine class diagram")

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

|name      |type                            |description   |
|----------|--------------------------------|--------------|
|TTokenList|specialize TObjectList\<TToken\>|TokenList type| 

### Protected fields

|name    |type  |flags|description             |default|
|--------|------|:---:|------------------------|-------|
|FRawText|string|     |Token in raw text format|       |

### Public properties

|name   |type  |flags|description|default|
|-------|------|:---:|-----------|-------|
|RawText|string|Re   |= FRawText |       |

### Public methods

|name                                         |flags |description                               |
|---------------------------------------------|:----:|------------------------------------------|
|`constructor Create(const ARawText: string);`|Vi, Re|Sets the initial values for the new object|
|`destructor Destroy;`                        |Or    |Frees the object's resources              |
