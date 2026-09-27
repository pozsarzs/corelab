# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TLEDSquare osztály a TLED osztályból, a led_square modulban

A TLEDSquare a TLED alaposztályból származó virtuális négyzet alakú LED-komponens. Az örökölt `TLEDColors` struktúrában megadott színcsoportnak megfelelően vörös, zöld vagy sárga négyzet alakú LED-et jelenít meg.

### Védett mezők

A `TLEDSquare` nem deklarál további védett mezőket.

### Nyilvános metódusok

|name                                                                           |flags|description                                                                                             |
|-------------------------------------------------------------------------------|-----|--------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                                          |Or   |Initializes the square LED, its module information and bitmap buffer.                                   |
|`procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);`|Or   |Clears the background and renders the LED in its on or off state, including glow and reflection effects.|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`                 |Or   |Copies the internal bitmap buffer to the target canvas at the specified position.                       |

### Objektumtulajdonságok és örökölt interfész

Az osztály a `TLED` osztályból örökli a LED állapotát, szín- és háttértulajdonságait, többek között a `ModName`, `Description`, `Enabled`, `Color`, `BGColor` és `IsOn` elemeket.

Az örökölt `RETRO_COLORS` konstans biztosítja az előre meghatározott vörös, zöld és sárga színcsoportokat.

### Megjelenítés

|state|appearance                                                                        |
|-----|----------------------------------------------------------------------------------|
|On   |Square LED filled with `OnColor`, with a `Glow` inner area and a white reflection.|
|Off  |Square LED filled with `OffColor`, with a silver reflection.                      |

### Moduladatok

|item         |value                                  |
|-------------|---------------------------------------|
|Module name  |`Square LED`                           |
|Description  |`Red, green or yellow color square LED`|
|Buffer width |15 pixels                              |
|Buffer height|15 pixels                              |
|FrameX       |1                                      |
|FrameY       |1                                      |
