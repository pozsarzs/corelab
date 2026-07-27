# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplay base class in core_display unit

TDisplay is the base class for display modules. It provides a general abstraction
layer for visual simulation, which uniformly handles the data to be displayed
(BCD values, raw segment data, decimal points), the internal drawing buffer, and
the color settings responsible for the retro-style display.

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

|name          |type   |description                     |
|--------------|-------|--------------------------------|
|TDisplayedData|Record |Displayed value or symbol       |
|.Blank        |Boolean|Blank display                   |
|.LeftDot      |Boolean|Left decimal point              |
|.RightDot     |Boolean|Right decimal point             |
|.Segments     |Byte   |Segments, bit 0-6 -> segment a-g|
|.Value        |Byte   |Value in BCD format (low nibble)|

### Protected fields

|name          |type          |flags|description              |default  |
|--------------|--------------|:---:|-------------------------|---------|
|FModname      |PChar         |     |Module name              |         |
|FDescription  |PChar         |     |Short description        |         |
|FEnabled      |Boolean       |     |Enable displaying        |         |
|FBuffer       |TBitmap       |     |Internal drawing buffer  |         |
|FDisplayedData|TDisplayedData|     |Displayed value or symbol|         |
|RETRO_RED_GLOW|TColor        |Co   |Center glow segment color|$003333FF|
|RETRO_RED_ON  |TColor        |Co   |Glow segment color       |$000000FF|
|RETRO_RED_OFF |TColor        |Co   |Dark segment color       |$00000040|
|RETRO_RED_BG  |TColor        |Co   |Background color         |$00000015|

### Public properties

|name       |type   |flags |description   |default|
|-----------|-------|:----:|--------------|-------|
|Description|PChar  |Re    |= FDescription|       |
|Enabled    |Boolean|Re, Wr|= FEnabled    |       |
|ModName    |PChar  |Re    |= FModName    |       |

### Public methods

|name                                                       |flags |description                               |
|-----------------------------------------------------------|:----:|------------------------------------------|
|`constructor Create;`                                      |Vi    |Sets the initial values for the new object|
|`destructor Destroy;`                                      |Vi    |Frees the object's resources              |
|`procedure Reset;`                                         |Vi    |Reset display                             |
|`procedure SetBlank(Status: Boolean);`                     |Vi    |Blank display                             |
|`procedure SetLeftDot(Status: Boolean);`                   |Vi    |Set left decimal point status             |
|`procedure SetRightDot(Status: Boolean);`                  |Vi    |Set right decimal point status            |
|`procedure SetValue(Value: Byte);`                         |Vi    |Set input BCD value                       |
|`procedure SetSegments(Value: Byte);`                      |Vi    |Set input segment data                    |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       |Vi, Ab|Draw displayed data to internal buffer    |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer);`|Vi, Ab|Drawing to canvas of the target object    |
