# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplay base class

TDisplay is the base class for display modules. It provides a general abstraction
layer for visual simulation, which uniformly handles the data to be displayed
(BCD values, raw segment data, decimal points), the internal drawing buffer, and
the color settings responsible for the retro-style display.

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

|name          |type          |C|description              |default  |
|--------------|--------------|-|-------------------------|:-------:|
|FModname      |PChar         | |Module name              |         |
|FDescription  |PChar         | |Short description        |         |
|FEnabled      |Boolean       | |Enable displaying        |         |
|FBuffer       |TBitmap       | |Internal drawing buffer  |         |
|FDisplayedData|TDisplayedData| |Displayed value or symbol|         |
|RETRO_RED_GLOW|TColor        |x|Center glow segment color|$003333FF|
|RETRO_RED_ON  |TColor        |x|Glow segment color       |$000000FF|
|RETRO_RED_OFF |TColor        |x|Dark segment color       |$00000040|
|RETRO_RED_BG  |TColor        |x|Background color         |$00000015|

**Note**:  
- _C_: means 'constant'.

### Public properties

|name       |type   |R|W|description   |default|
|-----------|-------|-|-|--------------|:-----:|
|Description|PChar  |x| |= FDescription|       |
|Enabled    |Boolean|x|x|= FEnabled    |       |
|ModName    |PChar  |x| |= FModName    |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                       |V|A|O|description                               |
|-----------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                                      |x| | |Sets the initial values for the new object|
|`destructor Destroy;`                                      |x| | |Frees the object's resources              |
|`procedure Reset;`                                         |x| | |Reset display                             |
|`procedure SetBlank(Status: Boolean);`                     |x| | |Blank display                             |
|`procedure SetLeftDot(Status: Boolean);`                   |x| | |Set left decimal point status             |
|`procedure SetRightDot(Status: Boolean);`                  |x| | |Set right decimal point status            |
|`procedure SetValue(Value: Byte);`                         |x| | |Set input BCD value                       |
|`procedure SetSegments(Value: Byte);`                      |x| | |Set input segment data                    |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       |x|x| |Draw displayed data to internal buffer    |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer);`|x|x| |Drawing to canvas of the target object    |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
