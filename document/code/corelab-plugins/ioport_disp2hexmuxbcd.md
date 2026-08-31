# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisp2HexMUXBCD from TGIOPort class in ioport_disp2hexmuxbcd unit

TIL311 style display; A0: low nibble: BCD input, high nibble: 0-blank-ldp-rdp., A1: select.

### I/O behaviour

|port|description                                                                                                               |
|----|--------------------------------------------------------------------------------------------------------------------------|
|0   |Writes the selected TIL311-style digit: bit 6 blank, bit 5 left decimal point, bit 4 right decimal point, bits 0..3 value.|
|1   |Selects the display digit, accepting indices from 0 to the last digit.                                                    |

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

### Private fields

|name    |type                  |description                        |default|
|--------|----------------------|-----------------------------------|-------|
|`FValue`|array[0..MAXX] of Byte|Device-specific state or GUI object|0      |

### Protected fields

|name       |type                            |description                        |default|
|-----------|--------------------------------|-----------------------------------|-------|
|`FPanel`   |TPanel                          |Device-specific state or GUI object|nil    |
|`FPaintBox`|TPaintBox                       |Device-specific state or GUI object|nil    |
|`FDP`      |array[0..MAXX] of TDisplayTIL311|Device-specific state or GUI object|       |
|`FSelLine` |Byte                            |Device-specific state or GUI object|0      |

### Protected methods

|name                                       |flags|description                                   |
|-------------------------------------------|-----|----------------------------------------------|
|`procedure PaintBoxPaint(Sender: TObject);`|     |Paints the device representation on the panel.|

### Public methods

|name                                                       |flags|description                                          |
|-----------------------------------------------------------|-----|-----------------------------------------------------|
|`constructor Create; override;`                            |Or   |Initialises the object and its device-specific state.|
|`destructor Destroy; override;`                            |Or   |Releases the object and its allocated resources.     |
|`procedure Reset; override;`                               |Or   |Resets the device state.                             |
|`function ReadPort(APort: Word): Byte; override;`          |Or   |Reads the selected virtual I/O port.                 |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or   |Writes the selected virtual I/O port.                |
|`function LoadState(AStream: TStream): Boolean; override;` |Or   |Loads the device state from a stream.                |
|`function SaveState(AStream: TStream): Boolean; override;` |Or   |Saves the device state to a stream.                  |
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
