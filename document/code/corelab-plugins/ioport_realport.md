# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TREALPort from TIOPort class in ioport_realport unit

Redirect to a real I/O port.

### I/O behaviour

|port |description                                                      |
|-----|-----------------------------------------------------------------|
|APort|Reads from or writes to the corresponding real hardware I/O port.|

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

|name      |type   |description                        |default|
|----------|-------|-----------------------------------|-------|
|`InpOut32`|THandle|Device-specific state or GUI object|       |
|`Inp32`   |TInp32 |Device-specific state or GUI object|       |
|`Out32`   |TOut32 |Device-specific state or GUI object|       |

### Private methods

|name                                           |flags|description                                           |
|-----------------------------------------------|-----|------------------------------------------------------|
|`function LoadIODLL(ALibDir: string): Boolean;`|     |Loads the platform-specific real-I/O access library.  |
|`function UnLoadIODLL: Boolean;`               |     |Unloads the platform-specific real-I/O access library.|

### Protected methods

|name                                                                    |flags|description                                  |
|------------------------------------------------------------------------|-----|---------------------------------------------|
|`function ReadByteFromIOPort(AAddress: Word; var AData: Byte): Boolean;`|     |Reads one byte from a real hardware I/O port.|
|`function WriteByteToIOPort(AAddress: Word; AData: Byte): Boolean;`     |     |Writes one byte to a real hardware I/O port. |

### Public methods

|name                                                       |flags|description                                          |
|-----------------------------------------------------------|-----|-----------------------------------------------------|
|`constructor Create; override;`                            |Or   |Initialises the object and its device-specific state.|
|`destructor Destroy; override;`                            |Or   |Releases the object and its allocated resources.     |
|`procedure Reset; override;`                               |Or   |Resets the device state.                             |
|`function ReadPort(APort: Word): Byte; override;`          |Or   |Reads the selected virtual I/O port.                 |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or   |Writes the selected virtual I/O port.                |

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
