# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplayTIL302 from TDisplay class in display_til302 unit

TDisplayTIL302 is a virtual display component derived from the TDisplay base class. It simulates the Texas Instruments TIL302 seven-segment LED display introduced in 1971. The component renders seven segments and two decimal points into an internal bitmap buffer using the retro-red display colors defined by the base class.

### Display layout

The seven segment bits are assigned as follows:

|bit|segment|coordinates|
|---:|:---:|:---:|
|0|A|43,05 – 85,05|
|1|B|85,05 – 79,47|
|2|C|79,47 – 73,89|
|3|D|31,89 – 73,89|
|4|E|31,89 – 37,47|
|5|F|37,47 – 43,05|
|6|G|37,47 – 79,47|
|7|–|unused|

The left decimal point is drawn at `(3,91)` and the right decimal point at `(101,91)`.

### Protected methods

|name|flags|description|
|---|:---:|---|
|`procedure DrawDot(AStatus: Boolean; Ax, Ay: Byte);`| |Draws a decimal-point LED into the internal buffer.|
|`procedure DrawLine(AStatus: Boolean; Ax1, Ay1, Ax2, Ay2: Byte);`| |Draws an active seven-segment line. Active segments are rendered as dashed lines; horizontal segments use four dashes and vertical segments use three. Inactive segments are not drawn.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Or|Initializes the TIL302 display, its module information and bitmap buffer.|
|`destructor Destroy;`|Or|Destroys the display object.|
|`procedure DrawToBuffer(AInputData: TDisplayedData);`|Or|Clears the buffer and renders the seven segments and decimal points according to the supplied display data.|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Or|Copies the internal bitmap buffer to the target canvas at the specified position.|

### Object properties and inherited interface

The class inherits the display state, properties and control methods from `TDisplay`, including `ModName`, `Description`, `Enabled`, `SetBlank`, `SetLeftDot`, `SetRightDot`, `SetSegments` and `SetValue`.

### Module information

|item|value|
|---|---|
|Module name|`TIL302`|
|Description|`Texas Instruments TIL302 LED display (1971)`|
|Buffer width|118 pixels|
|Buffer height|122 pixels|
|FrameX|14|
|FrameY|28|
