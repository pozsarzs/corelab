# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommandParser from commandparser unit

`TCommandParser` is the command-line tokenizer used by the command engine. It separates a command line into `TToken` objects using spaces and tab characters, while preserving text enclosed in matching single or double quotes as one token.

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Creates the parser object.|
|`destructor Destroy;`|Or|Destroys the parser object.|
|`function Tokenize(const ALine: string; AContext: TCommandContext): TTokenList;`|Vi|Converts a command line into a token list.|

### Tokenization rules

|input|behaviour|
|---|---|
|Space (`#32`)|Separates tokens.|
|Tab (`#9`)|Separates tokens.|
|`'`|Starts or ends a single-quoted section.|
|`"`|Starts or ends a double-quoted section.|
|Other characters|Are appended to the current token.|
|Empty input|Returns an empty `TTokenList`.|

Quote characters are not included in the resulting token text. A quoted section may contain spaces or tabs.

The `AContext` parameter is currently not used. The source contains a commented-out variable-expansion call, so variable expansion is not currently performed by this tokenizer.

An unmatched quote leaves the parser in quote mode until the end of the input; the accumulated text is still emitted as the final token.
