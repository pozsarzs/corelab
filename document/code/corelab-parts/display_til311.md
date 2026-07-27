# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplayTIL311 from TDisplay class in Display_TIL311 unit

TDisplayTIL311 is a class that simulates an LED display capable of displaying
hexadecimal characters (0-F) with built-in logic. Instead of 7-segment line
drawing, based on a built-in character map (CHARMAP_TIL311), it builds up the
numbers and letters to be displayed in the memory buffer from dots (dot matrix).

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

### Protected fields

|name          |type         |flags|description        |default |
|--------------|-------------|:---:|-------------------|--------|
|FDescription  |PChar        |     |Short description  |        |
|FModName      |PChar        |     |Module name        |'TIL311'|
|CHARMAP_TIL311|array of Byte|Co   |Character map [0-F]|        |

### Protected methods

|name                                             |flags|description                 |
|-------------------------------------------------|:---:|----------------------------|
|`procedure DrawDot(Status: Boolean; x, y: byte);`|     |Drawing dot on buffer canvas|

### Public methods

|name                                                       |flags|description                               |
|-----------------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                                      |Or   |Sets the initial values for the new object|
|`destructor Destroy;`                                      |Or   |Frees the object's resources              |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       |Or   |Draw displayed data to internal buffer    |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer);`|Or   |Drawing to canvas of the target object    |
