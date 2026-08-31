# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplayTIL311 from TDisplay class in display_til311 unit

TDisplayTIL311 is a virtual display component derived from the TDisplay base class. It simulates the Texas Instruments TIL311 hexadecimal LED display introduced in 1972. The component renders hexadecimal values 0–F as a 4×7 dot matrix and provides two decimal-point LEDs.

### Character map

The display uses a built-in 16-character map for hexadecimal digits `0`–`9` and letters `A`–`F`. Each character consists of seven rows of four LED positions.

The implementation suppresses the two inner dots on rows 1, 2, 4 and 5 to reproduce the TIL311 character shape.

### Protected members

|name                                                |flags|description                                                                                     |
|----------------------------------------------------|-----|------------------------------------------------------------------------------------------------|
|`procedure DrawDot(AStatus: Boolean; Ax, Ay: Byte);`|     |Draws a single display dot into the internal buffer.                                            |
|`CHARMAP_TIL311`                                    |Co   |16-entry hexadecimal character map; each entry contains seven 4-bit rows for characters `0`–`F`.|

### Public methods

|name                                                          |flags|description                                                                      |
|--------------------------------------------------------------|-----|---------------------------------------------------------------------------------|
|`constructor Create;`                                         |Or   |Initializes the TIL311 display, its module information and bitmap buffer.        |
|`destructor Destroy;`                                         |Or   |Destroys the display object.                                                     |
|`procedure DrawToBuffer(AInputData: TDisplayedData);`         |Or   |Clears the buffer and renders the selected hexadecimal value and decimal points. |
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Or   |Copies the internal bitmap buffer to the target canvas at the specified position.|

### Object properties and inherited interface

The class inherits the display state, properties and control methods from `TDisplay`, including `ModName`, `Description`, `Enabled`, `SetBlank`, `SetLeftDot`, `SetRightDot`, `SetSegments` and `SetValue`.

For TIL311 rendering, the `Value` field is used as an index into the 16-character hexadecimal map. The seven-segment `Segments` field is not used by this implementation.

### Module information

|item         |value                                        |
|-------------|---------------------------------------------|
|Module name  |`TIL311`                                     |
|Description  |`Texas Instruments TIL311 LED display (1972)`|
|Buffer width |118 pixels                                   |
|Buffer height|122 pixels                                   |
|FrameX       |14                                           |
|FrameY       |28                                           |
