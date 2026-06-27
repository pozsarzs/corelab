# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplayTIL302 class

TDisplayTIL302 is a class simulating a traditional 7-segment LED display. Based
on the input data, it creates characters by drawing lines and dots in the
internal graphics buffer, which it then renders on the target canvas.

### New default value of the protected fields

|name        |type     |C|description        |default   |
|------------|:-------:|-|-------------------|:--------:|
|FDescription|PChar    | |Short description  |short text|
|FModName    |PChar    | |Module name        |'TIL302'  |

**Note**:  
- _C_: means 'constant'.

### Own protected methods

|name                                                        |V|A|O|description                  |
|------------------------------------------------------------|-|-|-|-----------------------------|
|`procedure DrawDot(Status: Boolean; x, y: Byte);`           | | | |Drawing dot on buffer canvas |
|`procedure DrawLine(Status: Boolean; x1, y1, x2, y2: Byte);`| | | |Drawing line to buffer canvas|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

### Own public methods

|name                                                       |V|A|O|description                               |
|-----------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                                      | | |x|Sets the initial values for the new object|
|`destructor Destroy;`                                      | | |x|Frees the object's resources              |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       | | |x|Draw displayed data to internal buffer    |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer);`| | |x|Drawing to canvas of the target object    |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
