# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TSysBus from core_sysbus unit

`TSysBus` is the system-bus base implementation connecting a CPU to code memory, data memory, and an I/O-port device. It implements the `ICPUBus` interface defined by `core_cpu`.

The bus can operate with separate code and data memories (Harvard architecture) or with one memory object attached to both sides (Neumann architecture).

### Protected fields

|name |type |description |initial value|
|-----|-----|-------------|-------------|
|`FCodeMemory`|`TMemory`|Connected code-memory module|`nil`|
|`FDataMemory`|`TMemory`|Connected data-memory module|`nil`|
|`FIOPorts`|`TIOPort`|Connected I/O-port module|`nil`|

### Public methods

|name |flags|description|
|-----|:---:|------------|
|`constructor Create;`|Vi|Initialize all bus connections to `nil`|
|`destructor Destroy;`|Vi|Destroy the bus object|
|`function CodeRead(AAddress: UInt64): Byte;`|Vi|Read code memory; returns `$FF` when no code memory is attached|
|`function IORead(APort: UInt64): Byte;`|Vi|Read an I/O port; returns `$FF` when no I/O device is attached|
|`function MemRead(AAddress: UInt64): Byte;`|Vi|Read data memory; returns `$FF` when no data memory is attached|
|`procedure CodeWrite(AAddress: UInt64; AValue: Byte);`|Vi|Write code memory when a code-memory module is attached|
|`procedure IOWrite(APort: UInt64; AValue: Byte);`|Vi|Write an I/O port when an I/O module is attached|
|`procedure MemWrite(AAddress: UInt64; AValue: Byte);`|Vi|Write data memory when a data-memory module is attached|
|`procedure AttachCodeMemory(AMemory: TMemory);`|Vi|Attach a code-memory module|
|`procedure AttachDataMemory(AMemory: TMemory);`|Vi|Attach a data-memory module|
|`procedure AttachIOPorts(APorts: TIOPort);`|Vi|Attach an I/O-port module|
|`procedure AttachMemory(AMemory: TMemory);`|Vi|Attach one memory module as both code and data memory|
|`procedure Reset;`|Vi|Reset all attached hardware components|

### Public properties

|name |type |access|description|
|-----|-----|:----:|-----------|
|`CodeMemory`|`TMemory`|Re|Connected code memory|
|`DataMemory`|`TMemory`|Re|Connected data memory|
|`IOPorts`|`TIOPort`|Re|Connected I/O-port module|

### Bus connection modes

`AttachMemory` assigns the same `TMemory` instance to both `CodeMemory` and `DataMemory`.

`AttachCodeMemory` and `AttachDataMemory` allow the two memory sides to be connected independently. `AttachIOPorts` connects the I/O-port device.

### Reset behavior

`Reset` resets the attached code memory. It then resets the data memory only when it is attached and is a different object from the code memory. Finally, it resets the attached I/O-port module.

The bus does not own or free the attached hardware objects.
