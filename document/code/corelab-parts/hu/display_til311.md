# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplayTIL311 osztály a TDisplay osztályból, a display_til311 modulban

A TDisplayTIL311 a TDisplay alaposztályból származó virtuális kijelzőkomponens. Az 1972-ben bemutatott Texas Instruments TIL311 hexadecimális LED-kijelzőt szimulálja. A komponens a 0–F hexadecimális értékeket 4×7-es pontmátrixként jeleníti meg, és két tizedespont-LED-et biztosít.

### Karaktertérkép

A kijelző beépített, 16 karakterből álló térképet használ a `0`–`9` hexadecimális számjegyekhez és az `A`–`F` betűkhöz. Minden karakter hét, egyenként négy LED-pozícióból álló sorból épül fel.

A TIL311 karakteralakjának reprodukálásához a megvalósítás az 1., 2., 4. és 5. sorban elhagyja a két belső pontot.

### Védett tagok

|name                                                |flags|description                                                                                     |
|----------------------------------------------------|-----|------------------------------------------------------------------------------------------------|
|`procedure DrawDot(AStatus: Boolean; Ax, Ay: Byte);`|     |Draws a single display dot into the internal buffer.                                            |
|`CHARMAP_TIL311`                                    |Co   |16-entry hexadecimal character map; each entry contains seven 4-bit rows for characters `0`–`F`.|

### Nyilvános metódusok

|name                                                          |flags|description                                                                      |
|--------------------------------------------------------------|-----|---------------------------------------------------------------------------------|
|`constructor Create;`                                         |Or   |Initializes the TIL311 display, its module information and bitmap buffer.        |
|`destructor Destroy;`                                         |Or   |Destroys the display object.                                                     |
|`procedure DrawToBuffer(AInputData: TDisplayedData);`         |Or   |Clears the buffer and renders the selected hexadecimal value and decimal points. |
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Or   |Copies the internal bitmap buffer to the target canvas at the specified position.|

### Objektumtulajdonságok és örökölt interfész

Az osztály a `TDisplay` osztályból örökli a kijelző állapotát, tulajdonságait és vezérlőmetódusait, többek között a `ModName`, `Description`, `Enabled`, `SetBlank`, `SetLeftDot`, `SetRightDot`, `SetSegments` és `SetValue` elemeket.

A TIL311 megjelenítésekor a `Value` mező a 16 karakteres hexadecimális térkép indexeként szolgál. A hét szegmens állapotát tároló `Segments` mezőt ez a megvalósítás nem használja.

### Moduladatok

|item         |value                                        |
|-------------|---------------------------------------------|
|Module name  |`TIL311`                                     |
|Description  |`Texas Instruments TIL311 LED display (1972)`|
|Buffer width |118 pixels                                   |
|Buffer height|122 pixels                                   |
|FrameX       |14                                           |
|FrameY       |28                                           |
