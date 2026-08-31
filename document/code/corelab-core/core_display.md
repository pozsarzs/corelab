# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplay from core_display unit

`TDisplay` is an abstract base class for graphical display implementations.
It stores the displayed BCD value, seven-segment data, two decimal-point states,
and a blank state. Derived classes provide the actual drawing and rendering
operations.

### `TDisplayedData` record

|field     |type     |description                          |
|----------|---------|-------------------------------------|
|`Blank`   |`Boolean`|Blank-display state                  |
|`LeftDot` |`Boolean`|Left decimal-point state             |
|`RightDot`|`Boolean`|Right decimal-point state            |
|`Segments`|`Byte`   |Seven-segment data; bits 0–6 are used|
|`Value`   |`Byte`   |BCD value; bits 0–3 are used         |

### Protected fields

|name            |type            |description            |
|----------------|----------------|-----------------------|
|`FModname`      |`PChar`         |Module name            |
|`FDescription`  |`PChar`         |Short description      |
|`FEnabled`      |`Boolean`       |Enable displaying      |
|`FBuffer`       |`TBitmap`       |Internal drawing buffer|
|`FDisplayedData`|`TDisplayedData`|Current display data   |

### Protected constants

|name            |type    |value      |description                       |
|----------------|--------|-----------|----------------------------------|
|`RETRO_RED_GLOW`|`TColor`|`$003333FF`|Retro-red LED glow color          |
|`RETRO_RED_ON`  |`TColor`|`$000000FF`|Retro-red active color            |
|`RETRO_RED_OFF` |`TColor`|`$00000040`|Retro-red inactive color          |
|`RETRO_RED_BG`  |`TColor`|`$00000015`|Retro-red display background color|

### Public methods

|name                                                          |flags|description                                                                            |
|--------------------------------------------------------------|-----|---------------------------------------------------------------------------------------|
|`constructor Create;`                                         |Vi   |Create the display and its internal bitmap buffer                                      |
|`destructor Destroy;`                                         |Vi   |Free the internal bitmap buffer                                                        |
|`procedure Reset;`                                            |Vi   |Clear blank and decimal-point states and reset segment/value data                      |
|`procedure DrawToBuffer(AInputData: TDisplayedData);`         |Ab,Vi|Draw the supplied display data into the internal buffer; implemented by a derived class|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Ab,Vi|Render the display onto a target canvas; implemented by a derived class                |
|`procedure SetBlank(AStatus: Boolean);`                       |Vi   |Set the blank state and redraw                                                         |
|`procedure SetLeftDot(AStatus: Boolean);`                     |Vi   |Set the left decimal-point state and redraw                                            |
|`procedure SetRightDot(AStatus: Boolean);`                    |Vi   |Set the right decimal-point state and redraw                                           |
|`procedure SetSegments(AValue: Byte);`                        |Vi   |Set the seven-segment data and redraw                                                  |
|`procedure SetValue(AValue: Byte);`                           |Vi   |Set the BCD value using the low four bits and redraw                                   |

### Public properties

|name         |type     |access|description      |
|-------------|---------|------|-----------------|
|`ModName`    |`PChar`  |Re    |Module name      |
|`Description`|`PChar`  |Re    |Short description|
|`Enabled`    |`Boolean`|Re/Wr |Enable displaying|
