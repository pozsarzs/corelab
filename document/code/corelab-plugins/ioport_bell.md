# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TBELLPort from TIOPort class in ioport_bell unit

It rings at a value greater than zero.

### I/O behaviour

|port|description|

|---|---|

|0|Read returns `00h`; writing a value greater than zero calls `Beep`. Other ports return `FFh`.|

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


### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create; override;`|Or|Initialises the object and its device-specific state.|
|`destructor Destroy; override;`|Or|Releases the object and its allocated resources.|
|`procedure Reset;  override;`|Or|Resets the device state.|
|`function ReadPort(APort: Word): Byte; override;`|Or|Reads the selected virtual I/O port.|
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or|Writes the selected virtual I/O port.|

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
