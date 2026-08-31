# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommandParser from commandparser unit

`TCommandParser` is the command-line tokenizer used by the command engine. It
separates a command line into `TToken` objects using spaces and tab characters,
while preserving text enclosed in matching single or double quotes as one token.

### Public methods

|name                                                                            |flags|description                               |
|--------------------------------------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                                                           |Vi   |Creates the parser object.                |
|`destructor Destroy;`                                                           |Or   |Destroys the parser object.               |
|`function Tokenize(const ALine: string; AContext: TCommandContext): TTokenList;`|Vi   |Converts a command line into a token list.|
