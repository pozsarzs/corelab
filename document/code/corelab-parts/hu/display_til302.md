# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplayTIL302 osztály a TDisplay osztályból, a display_til302 modulban

A TDisplayTIL302 a TDisplay alaposztályból származó virtuális kijelzőkomponens. Az 1971-ben bemutatott Texas Instruments TIL302 hét szegmenses LED-kijelzőt szimulálja. A komponens a hét szegmenst és a két tizedespontot egy belső bitképpufferbe rajzolja, az alaposztályban meghatározott retró vörös kijelzőszínekkel.

### A kijelző elrendezése

A szegmensek bitjeinek kiosztása:

|bit|segment|coordinates  |
|---|-------|-------------|
|0  |A      |43,05 – 85,05|
|1  |B      |85,05 – 79,47|
|2  |C      |79,47 – 73,89|
|3  |D      |31,89 – 73,89|
|4  |E      |31,89 – 37,47|
|5  |F      |37,47 – 43,05|
|6  |G      |37,47 – 79,47|
|7  |–      |unused       |

A bal oldali tizedespont a `(3,91)`, a jobb oldali a `(101,91)` koordinátára kerül.

### Védett metódusok

|name                                                             |flags|description                                                                                                                                                                            |
|-----------------------------------------------------------------|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`procedure DrawDot(AStatus: Boolean; Ax, Ay: Byte);`             |     |Draws a decimal-point LED into the internal buffer.                                                                                                                                    |
|`procedure DrawLine(AStatus: Boolean; Ax1, Ay1, Ax2, Ay2: Byte);`|     |Draws an active seven-segment line. Active segments are rendered as dashed lines; horizontal segments use four dashes and vertical segments use three. Inactive segments are not drawn.|

### Nyilvános metódusok

|name                                                          |flags|description                                                                                                |
|--------------------------------------------------------------|-----|-----------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                         |Or   |Initializes the TIL302 display, its module information and bitmap buffer.                                  |
|`destructor Destroy;`                                         |Or   |Destroys the display object.                                                                               |
|`procedure DrawToBuffer(AInputData: TDisplayedData);`         |Or   |Clears the buffer and renders the seven segments and decimal points according to the supplied display data.|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Or   |Copies the internal bitmap buffer to the target canvas at the specified position.                          |

### Objektumtulajdonságok és örökölt interfész

Az osztály a `TDisplay` osztályból örökli a kijelző állapotát, tulajdonságait és vezérlőmetódusait, többek között a `ModName`, `Description`, `Enabled`, `SetBlank`, `SetLeftDot`, `SetRightDot`, `SetSegments` és `SetValue` elemeket.

### Moduladatok

|item         |value                                        |
|-------------|---------------------------------------------|
|Module name  |`TIL302`                                     |
|Description  |`Texas Instruments TIL302 LED display (1971)`|
|Buffer width |118 pixels                                   |
|Buffer height|122 pixels                                   |
|FrameX       |14                                           |
|FrameY       |28                                           |
