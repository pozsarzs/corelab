# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplayTIL311 class

TDisplayTIL311 is a class that simulates an LED display capable of displaying
hexadecimal characters (0-F) with built-in logic. Instead of 7-segment line
drawing, based on a built-in character map (CHARMAP_TIL311), it builds up the
numbers and letters to be displayed in the memory buffer from dots (dot matrix).

### New default value of the protected fields

|name          |type         |C|description              |default   |
|--------------|:-----------:|-|-------------------------|:--------:|
|FDescription  |PChar        | |Short description        |short text|
|FModName      |PChar        | |Module name              |'TIL311'  |

**Note**:  
- _C_: means 'constant'.

### Own protected fields

|name          |type         |C|description        |default|
|--------------|:-----------:|-|-------------------|:-----:|
|CHARMAP_TIL311|array of Byte|x|Character map [0-F]|       |

**Note**:  
- _C_: means 'constant'.

### Own protected methods

|name                                                        |V|A|O|description                  |
|------------------------------------------------------------|-|-|-|-----------------------------|
|`procedure DrawDot(Status: Boolean; x, y: byte);`           | | | |Drawing dot on buffer canvas |

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
