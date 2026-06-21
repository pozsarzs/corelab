# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisplay base class

### Protected (color) constants

|name          |type  |value    |description               |
|--------------|------|---------|--------------------------|
|RETRO_RED_GLOW|TColor|$003333FF|Illuminated segment center|
|RETRO_RED_ON  |TColor|$000000FF|Illuminated segment       |
|RETRO_RED_OFF |TColor|$00000040|Dark segment              |
|RETRO_RED_BG  |TColor|$00000015|Display background        |

### Public properties

|name            |type     |description                        |
|----------------|---------|-----------------------------------|
|Description     |PChar    |Short description                  |
|Enabled         |boolean  |Enable port without detach from bus|
|Modname         |PChar    |Module name                        |

### Public methods

|name                                                       |description                                |
|-----------------------------------------------------------|-------------------------------------------|
|`constructor Create;`                                      |Sets the initial values for the new object.|
|`destructor Destroy;`                                      |Frees the object's resources.              |
|`procedure Reset;`                                         |Reset virtual display.                     |
|`procedure SetBlank(Status: boolean);`                     |Hide or show display content.              |
|`procedure SetLeftDot(Status: boolean);`                   |Left decimal point on and off.             |
|`procedure SetRightDot(Status: boolean);`                  |Right decimal point on and off.            |
|`procedure SetValue(Value: byte);`                         |Setting the displayed value.               |
|`procedure SetSegments(Value: byte);`                      |Turning segments on and off.               |
|`procedure DrawToBuffer(InputData: TDisplayedData);`       |Drawing to the buffer.                     |
|`procedure RenderTo(TargetCanvas: TCanvas; x, y: integer);`|Copying the buffer to a visual component.  |
