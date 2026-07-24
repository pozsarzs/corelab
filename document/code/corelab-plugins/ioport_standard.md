# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TStandardPort class

TStandardPort is a module implementing general-purpose input and output
operations from the TGIOPort class. It has its own graphical interface, which
in a simple window provides the possibility to display the (output) values sent
to the port in hexadecimal format, as well as to manually specify the (input)
values​to be read from it.

### Modified inherited protected fields

|name          |type   |C|description      |value|
|--------------|-------|-|-----------------|:---:|
|FDescription  |PChar  | |Short description|     |
|FHasPanel     |Boolean| |Has GUI panel    |true |
|FLatchedOutput|Boolean| |Store output data|true |
|FModName      |PChar  | |Module name      |     |

**Note**:  
- _C_: means 'constant'.

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
