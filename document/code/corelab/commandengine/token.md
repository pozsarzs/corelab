# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TToken from token unit

`TToken` represents one lexical token produced by `TCommandParser`. It stores
the original token text without further interpretation.

### Protected fields

|name      |type    |description                      |
|----------|--------|---------------------------------|
|`FRawText`|`string`|Raw textual content of the token.|

### Public methods

|name                                         |flags|description                                      |
|---------------------------------------------|:---:|-------------------------------------------------|
|`constructor Create(const ARawText: string);`|Ri,Vi|Creates a token and stores the supplied raw text.|
|`destructor Destroy;`                        |Or   |Destroys the token object.                       |

### Public properties

|name     |type    |access|description              |
|---------|--------|------|-------------------------|
|`RawText`|`string`|read  |Text stored in the token.|

### Token list

`TTokenList` is a specialized `TObjectList<TToken>` used to store token objects.
As a `TObjectList`, it owns the contained `TToken` instances.
