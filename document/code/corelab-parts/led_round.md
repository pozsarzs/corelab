# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TLEDRound from TLED class in led_round unit

TLEDRound is a virtual round LED component derived from the TLED base class. It renders a circular LED in red, green or yellow, according to the color group supplied through the inherited `TLEDColors` structure.

### Protected fields

There are no additional protected fields declared by `TLEDRound`.

### Public methods

|name                                                                           |flags|description                                                                                             |
|-------------------------------------------------------------------------------|-----|--------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                                          |Or   |Initializes the round LED, its module information and bitmap buffer.                                    |
|`procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);`|Or   |Clears the background and renders the LED in its on or off state, including glow and reflection effects.|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`                 |Or   |Copies the internal bitmap buffer to the target canvas at the specified position.                       |

### Object properties and inherited interface

The class inherits the LED state, color and background properties from `TLED`, including `ModName`, `Description`, `Enabled`, `Color`, `BGColor` and `IsOn`.

The inherited `RETRO_COLORS` constant provides the predefined red, green and yellow color groups.

### Rendering

|state|appearance                                                                       |
|-----|---------------------------------------------------------------------------------|
|On   |Round LED filled with `OnColor`, with a `Glow` inner area and a white reflection.|
|Off  |Round LED filled with `OffColor`, with a silver reflection.                      |

### Module information

|item         |value                                 |
|-------------|--------------------------------------|
|Module name  |`Round LED`                           |
|Description  |`Red, green or yellow color round LED`|
|Buffer width |29 pixels                             |
|Buffer height|29 pixels                             |
|FrameX       |9                                     |
|FrameY       |9                                     |
