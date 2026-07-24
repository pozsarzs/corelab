# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TSwitch16BCD class

TSwitch16BCD is a module that simulates a read-only input peripheral derived
from the class TGIOPort. It has its own graphical user interface, which displays
a matrix of 16 push buttons. Only one button can be pressed at a time. The output
returns the number of the pressed button.

### Modified inherited protected fields

|name        |type   |C|description      |value|
|------------|-------|-|-----------------|:---:|
|FDescription|PChar  | |Short description|     |
|FHasPanel   |Boolean| |Has GUI panel    |true |
|FModName    |PChar  | |Module name      |     |

**Note**:  
- _C_: means 'constant'.

### Own protected methods

|name                             |V|A|O|description       |
|---------------------------------|-|-|-|------------------|
|`procedure AllRelease(mx: byte);`| | | |Release all button|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

### Own public methods

|name                                           |V|A|O|description                               |
|-----------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                          | | |x|Sets the initial values for the new object|
|`destructor Destroy;`                          | | |x|Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         | | |x|Read virtual port                         |
|`procedure Reset;`                             | | |x|Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`| | |x|Write virtual port                        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

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
