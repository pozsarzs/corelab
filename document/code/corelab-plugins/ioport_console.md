# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TConsole from TGIOPort class in ioport_console unit

Minimalist character I/O console with buffered input.

### I/O behaviour

|port|description|

|---|---|

|0|Read returns and removes the oldest character from the receive buffer; write appends a character to the console display. Other ports return `FFh`.|

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

|name|type|description|default|
|---|---|---|---|
|`FConFace`|TMemo|Device-specific state or GUI object|nil|
|`FRxBuffer`|string|Device-specific state or GUI object|''|
|`FStatusBar`|TStatusBar|Device-specific state or GUI object|nil|
|`FTimer`|TTimer|Device-specific state or GUI object|nil|

### Protected methods

|name|flags|description|
|---|:---:|---|
|`procedure FConFaceKeyPress(Sender: TObject; var Key: char);`||Buffers a received console character and requests an interrupt.|
|`procedure FTimerOnTime(Sender: TObject);`||Clears the temporary console status indicators.|
|`procedure UpdateGauge;`||Updates the console receive-buffer usage indicator.|
|`procedure RequestInterrupt; override;`|Or|Requests the configured interrupt callback.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create; override;`|Or|Initialises the object and its device-specific state.|
|`destructor Destroy; override;`|Or|Releases the object and its allocated resources.|
|`procedure Reset; override;`|Or|Resets the device state.|
|`function ReadPort(APort: Word): Byte; override;`|Or|Reads the selected virtual I/O port.|
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or|Writes the selected virtual I/O port.|
|`procedure CreatePanel; override;`|Or|Creates the graphical user-interface panel.|

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name|exported name|description|
|---|---|---|
|`function CreatePort: TIOPort;`|ioport_create|Create a new device object.|
|`procedure DestroyPort(APort: TIOPort);`|ioport_destroy|Destroy the device object.|
|`procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte);`|ioport_setinthandler|Set the interrupt callback and interrupt vector.|
|`function LoadState(APort: TIOPort; AStream: TStream): Boolean;`|ioport_loadstate|Load the device state from a stream.|
|`function SaveState(APort: TIOPort; AStream: TStream): Boolean;`|ioport_savestate|Save the device state to a stream.|
|`procedure CreatePanel(APort: TIOPort);`|ioport_createpanel|Create the graphical user-interface panel.|
|`procedure FreePanel(APort: TIOPort);`|ioport_freepanel|Destroy the graphical user-interface panel.|
|`procedure ShowPanel(APort: TIOPort);`|ioport_showpanel|Show the graphical user-interface panel.|
|`procedure HidePanel(APort: TIOPort);`|ioport_hidepanel|Hide the graphical user-interface panel.|
|`procedure RenamePanel(APort: TIOPort; ACaption: PChar);`|ioport_renamepanel|Change the GUI panel caption.|
|`function ResizePanel(APort: TIOPort; AWidth, AHeight: Integer): Boolean;`|ioport_resizepanel|Resize the GUI panel.|
|`function MovePanel(APort: TIOPort; ALeft, ATop: Integer): Boolean;`|ioport_movepanel|Move the GUI panel.|
