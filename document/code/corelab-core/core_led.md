# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TLED from core_led unit

`TLED` is an abstract base class for graphical LED implementations. It stores
the LED state, color set, background color, and an internal bitmap buffer.
Derived classes implement drawing the LED into the buffer and rendering it onto
a target canvas.

### Related types

|name         |type       |description                                                          |
|-------------|-----------|---------------------------------------------------------------------|
|`TColorGroup`|enumeration|Retro LED color groups: `clRetroGreen`, `clRetroRed`, `clRetroYellow`|
|`TLEDColors` |record     |Contains glow, active, and inactive LED colors                       |

### `TLEDColors` record

|field     |type    |description  |
|----------|--------|-------------|
|`Glow`    |`TColor`|Glow color   |
|`OnColor` |`TColor`|LED-on color |
|`OffColor`|`TColor`|LED-off color|

### `RETRO_COLORS`

`RETRO_COLORS` supplies predefined `TLEDColors` values for the three `TColorGroup` members.

|group          |Glow       |OnColor    |OffColor   |
|---------------|-----------|-----------|-----------|
|`clRetroGreen` |`$0088FF88`|`$0000D000`|`$00156515`|
|`clRetroRed`   |`$008888FF`|`$000000D0`|`$00000075`|
|`clRetroYellow`|`$0088FFFF`|`$0000D0D0`|`$00146666`|

### Protected fields

|name          |type        |description                    |
|--------------|------------|-------------------------------|
|`FModname`    |`PChar`     |Module name                    |
|`FDescription`|`PChar`     |Short description              |
|`FEnabled`    |`Boolean`   |Enable displaying              |
|`FBuffer`     |`TBitmap`   |Internal drawing buffer        |
|`FBGColor`    |`TColor`    |Background color around the LED|
|`FColor`      |`TLEDColors`|Current LED color set          |
|`FIsOn`       |`Boolean`   |Current LED state              |

### Public methods

|name                                                                           |flags|description                                                                         |
|-------------------------------------------------------------------------------|-----|------------------------------------------------------------------------------------|
|`constructor Create;`                                                          |Vi   |Create the internal bitmap buffer                                                   |
|`destructor Destroy;`                                                          |Vi   |Free the internal bitmap buffer                                                     |
|`procedure Reset;`                                                             |Vi   |Set the LED state to off and redraw                                                 |
|`procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);`|Ab,Vi|Draw the LED into the internal buffer; implementation is supplied by a derived class|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`                 |Ab,Vi|Render the LED onto a target canvas; implementation is supplied by a derived class  |
|`procedure SetBGColor(ABGColor: TColor);`                                      |Vi   |Set the background color and redraw                                                 |
|`procedure SetColor(AColor: TLEDColors);`                                      |Vi   |Set the LED color set and redraw                                                    |
|`procedure SetOn(AStatus: Boolean);`                                           |Vi   |Set the LED state and redraw                                                        |

### Public properties

|name         |type        |access|description                                      |
|-------------|------------|------|-------------------------------------------------|
|`ModName`    |`PChar`     |Re    |Module name                                      |
|`Description`|`PChar`     |Re    |Short description                                |
|`Enabled`    |`Boolean`   |Re/Wr |Enable displaying                                |
|`Color`      |`TLEDColors`|Re/Wr |Current LED colors; writes use `SetColor`        |
|`BGColor`    |`TColor`    |Re/Wr |Current background color; writes use `SetBGColor`|
|`IsOn`       |`Boolean`   |Re/Wr |Current LED state; writes use `SetOn`            |
