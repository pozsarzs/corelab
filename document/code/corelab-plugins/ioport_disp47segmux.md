# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TDisp47segMUX from TDisplay class in ioport_disp47segmux unit

TDisp47segMUX is a module that simulates a display peripheral derived from the
class TGIOPort and TDisplayTIL302. It has its own graphical user interface,
which contents a 4-digit 7 segment TIL302 style multiplexed display with direct
inversable and BCD input (Address 0: bits: a-g, dp or low nibble: BCD input, high nibble:
rdp-000, Address 1: select a digit).

### UML diagram

![Class diagram](../diagrams/_png/ioport.png "IOPort plugin class diagram")

### Abbreviations

- _Ab_: means 'abstract',
- _Co_: means 'constant',
- _Il_: means 'inline',
- _Ol_: means 'overload',
- _Or_: means 'override',
- _Re_: means 'read',
- _Ri_: means 'reintroduce',
- _St_: means 'static',
- _Vi_: means 'virtual',
- _Wr_: means 'write'.

### Protected fields

|name        |type                   |flags|description                      |default|
|------------|-----------------------|:---:|---------------------------------|-------|
|FPanel      |TPanel                 |     |GUI container panel              |nil    |
|FPaintBox   |TPaintBox              |     |PaintBox for display rendering   |nil    |
|FDP         |array of TDisplayTIL302|     |TIL302 display component instance|nil    |
|FSelLine    |byte                   |     |Selected display                 |0      |
|FDescription|PChar                  |     |Short description                |       |
|FHasPanel   |Boolean                |     |Has GUI panel                    |true   |
|FModName    |PChar                  |     |Module name                      |       |

### Protected methods

|name                                       |flags|description                                             |
|-------------------------------------------|:---:|--------------------------------------------------------|
|`procedure PaintBoxPaint(Sender: TObject);`|     |PaintBox OnPaint event handler for rendering the display|

### Public methods

|name                                           |flags|description                               |
|-----------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                          |Or   |Sets the initial values for the new object|
|`destructor Destroy;`                          |Or   |Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         |Or   |Read virtual port                         |
|`procedure Reset;`                             |Or   |Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`|Or   |Write virtual port                        |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                                                   |exported name     |description      |
|-----------------------------------------------------------------------|------------------|-----------------|
|`function CreatePort: TIOPort;`                                        |ioport_create     |Create port      |
|`procedure DestroyPort(Port: TIOPort));`                               |ioport_destroy    |Destroy port     |
|`function MovePanel(Port: TIOPort; Left, Top: Integer): Boolean;`      |ioport_movepanel  |Move GUI panel   |
|`function ResizePanel(Port: TIOPort; Width, Height: Integer): Boolean;`|ioport_resizepanel|Resize GUI panel |
|`procedure CreatePanel(Port: TIOPort);`                                |ioport_createpanel|Create GUI panel |
|`procedure FreePanel(Port: TIOPort);`                                  |ioport_freepanel  |Destroy GUI panel|
|`procedure HidePanel(Port: TIOPort);`                                  |ioport_hidepanel  |Hide GUI panel   |
|`procedure RenamePanel(Port: TIOPort; Caption: PChar);`                |ioport_renamepanel|Rename GUI panel |
|`procedure ShowPanel(Port: TIOPort);`                                  |ioport_showpanel  |Show GUI panel   |
