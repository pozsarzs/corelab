# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplayTIL302 from TDisplay class in Display_TIL302 unit

TDisplayTIL302 is a class simulating a traditional 7-segment LED display. Based
on the input data, it creates characters by drawing lines and dots in the
internal graphics buffer, which it then renders on the target canvas.

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

### New default value of the protected fields

|name        |type |flag|description      |default |
|------------|-----|:--:|-----------------|--------|
|FDescription|PChar|    |Short description|        |
|FModName    |PChar|    |Module name      |'TIL302'|

### Protected methods

|name                                                        |flags|description                  |
|------------------------------------------------------------|:---:|-----------------------------|
|`procedure DrawDot(Status: Boolean; x, y: Byte);`           |     |Drawing dot on buffer canvas |
|`procedure DrawLine(Status: Boolean; x1, y1, x2, y2: Byte);`|     |Drawing line to buffer canvas|

### Public methods

|name                                                       |flags|description                               |
|-----------------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                                      |Or   |Sets the initial values for the new object|
|`destructor Destroy;`                                      |Or   |Frees the object's resources              |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       |Or   |Draw displayed data to internal buffer    |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer);`|Or   |Drawing to canvas of the target object    |
