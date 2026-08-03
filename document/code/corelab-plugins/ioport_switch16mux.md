# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TSwitch16MUX from TGIOPort class in ioport_switch16mux unit

TSwitch16MUX is a module that simulates a read-only input peripheral derived
from the class TGIOPort. It has its own graphical user interface, which displays
a matrix of 16 push switches. The column to be read can be selected directly by
an active bit (up to 8 lines) or by specifying the line BCD (up to 16 lines). The
active bit can be high or low). The output returns the switches status.

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

|name        |type   |flags|description      |default|
|------------|-------|:---:|-----------------|-------|
|FDescription|PChar  |     |Short description|       |
|FHasPanel   |Boolean|     |Has GUI panel    |true   |
|FModName    |PChar  |     |Module name      |       |

### Protected methods

|name                             |flags|description       |
|---------------------------------|:---:|------------------|
|`procedure AllRelease(mx: byte);`|     |Release all button|

### Public methods

|name                                             |flags|description                               |
|-------------------------------------------------|:---:|------------------------------------------|
|`constructor Create;`                            |Or   |Sets the initial values for the new object|
|`destructor Destroy;`                            |Or   |Frees the object's resources              |
|`function ReadPort(APort: Byte): Byte;`          |Or   |Read virtual port                         |
|`procedure Reset;`                               |Or   |Reset virtual port                        |
|`procedure WritePort(APort: Byte; AValue: Byte);`|Or   |Write virtual port                        |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                                                      |exported name     |description      |
|--------------------------------------------------------------------------|------------------|-----------------|
|`function CreatePort: TIOPort;`                                           |ioport_create     |Create port      |
|`procedure DestroyPort(APort: TIOPort));`                                 |ioport_destroy    |Destroy port     |
|`function MovePanel(APort: TIOPort; ALeft, ATop: Integer): Boolean;`      |ioport_movepanel  |Move GUI panel   |
|`function ResizePanel(APort: TIOPort; AWidth, AHeight: Integer): Boolean;`|ioport_resizepanel|Resize GUI panel |
|`procedure CreatePanel(APort: TIOPort);`                                  |ioport_createpanel|Create GUI panel |
|`procedure FreePanel(APort: TIOPort);`                                    |ioport_freepanel  |Destroy GUI panel|
|`procedure HidePanel(APort: TIOPort);`                                    |ioport_hidepanel  |Hide GUI panel   |
|`procedure RenamePanel(APort: TIOPort; ACaption: PChar);`                 |ioport_renamepanel|Rename GUI panel |
|`procedure ShowPanel(APort: TIOPort);`                                    |ioport_showpanel  |Show GUI panel   |
