# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TStandardPort from TGIOPort class in ioport_standard unit

It reads the entered value and displays the output value.

### I/O behaviour

|port|description                                                                                                                                            |
|----|-------------------------------------------------------------------------------------------------------------------------------------------------------|
|0   |Read parses the hexadecimal text entered in the receive field and clears it after a successful read; write displays the byte as two hexadecimal digits.|

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

|name     |type |description                        |default|
|---------|-----|-----------------------------------|-------|
|`FEditRx`|TEdit|Device-specific state or GUI object|       |
|`FEditTx`|TEdit|Device-specific state or GUI object|       |

### Public methods

|name                                                       |flags|description                                          |
|-----------------------------------------------------------|-----|-----------------------------------------------------|
|`constructor Create; override;`                            |Or   |Initialises the object and its device-specific state.|
|`destructor Destroy; override;`                            |Or   |Releases the object and its allocated resources.     |
|`procedure Reset; override;`                               |Or   |Resets the device state.                             |
|`function ReadPort(APort: Word): Byte; override;`          |Or   |Reads the selected virtual I/O port.                 |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or   |Writes the selected virtual I/O port.                |
|`procedure CreatePanel; override;`                         |Or   |Creates the graphical user-interface panel.          |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                                                                    |exported name       |description                                     |
|----------------------------------------------------------------------------------------|--------------------|------------------------------------------------|
|`function CreatePort: TIOPort;`                                                         |ioport_create       |Create a new device object.                     |
|`procedure DestroyPort(APort: TIOPort);`                                                |ioport_destroy      |Destroy the device object.                      |
|`procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte);`|ioport_setinthandler|Set the interrupt callback and interrupt vector.|
|`function LoadState(APort: TIOPort; AStream: TStream): Boolean;`                        |ioport_loadstate    |Load the device state from a stream.            |
|`function SaveState(APort: TIOPort; AStream: TStream): Boolean;`                        |ioport_savestate    |Save the device state to a stream.              |
|`procedure CreatePanel(APort: TIOPort);`                                                |ioport_createpanel  |Create the graphical user-interface panel.      |
|`procedure FreePanel(APort: TIOPort);`                                                  |ioport_freepanel    |Destroy the graphical user-interface panel.     |
|`procedure ShowPanel(APort: TIOPort);`                                                  |ioport_showpanel    |Show the graphical user-interface panel.        |
|`procedure HidePanel(APort: TIOPort);`                                                  |ioport_hidepanel    |Hide the graphical user-interface panel.        |
|`procedure RenamePanel(APort: TIOPort; ACaption: PChar);`                               |ioport_renamepanel  |Change the GUI panel caption.                   |
|`function ResizePanel(APort: TIOPort; AWidth, AHeight: Integer): Boolean;`              |ioport_resizepanel  |Resize the GUI panel.                           |
|`function MovePanel(APort: TIOPort; ALeft, ATop: Integer): Boolean;`                    |ioport_movepanel    |Move the GUI panel.                             |
