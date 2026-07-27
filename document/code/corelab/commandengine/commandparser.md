# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandParser base class in CommandParser unit

TCommandParser is the base class responsible for lexical processing of input
command strings, splitting the raw text into tokens that can be interpreted by
the command interpreter.

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

### Public methods

|name                                                                            |flags|description                               |
|--------------------------------------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                                                           |Vi   |Sets the initial values for the new object|
|`destructor Destroy;`                                                           |Or   |Frees the object's resources              |
|`function Tokenize(const ALine: string; AContext: TCommandContext): TTokenList;`|Vi   |Parses the input string and splits it into a sequence of individual tokens.|
