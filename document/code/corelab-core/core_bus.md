# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TBus from core_bus unit

`TBus` is the system and service bus implementation class. It implements
`ISysBus`, `ISvcAPI` and `ICtlAPI` and provides the interface through which CPU,
memory and I/O devices can be attached to and accessed through a common bus.

The current source contains the bus structure and API implementation, but the
operational methods are currently stubs: device attachment, memory and port
access, service operations and CPU control operations do not yet perform their
intended actions.

### TBusDevice

`TBusDevice` describes one device entry associated with the bus.

|field         |type     |description                          |
|--------------|---------|-------------------------------------|
|`InstanceID`  |`Integer`|Device instance identifier.          |
|`BaseAddress` |`DWord`  |Base address assigned to the device. |
|`AddressRange`|`DWord`  |Address range assigned to the device.|
|`CPUDevice`   |`TCPU`   |CPU device reference.                |
|`MemoryDevice`|`TMemory`|Memory device reference.             |
|`IODevice`    |`TIOPort`|I/O port device reference.           |

### Private fields

|name      |type                 |description                                                  |
|----------|---------------------|-------------------------------------------------------------|
|`FDevices`|`array of TBusDevice`|List of devices attached to the bus.                         |
|`FNextID` |`Integer`            |Internal counter intended for assigning instance identifiers.|

### Public methods

|name                                                                                          |flags|description                                                                                              |
|----------------------------------------------------------------------------------------------|-----|---------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                                                         |Vi   |Creates the bus object. The current implementation only calls the inherited constructor.                 |
|`destructor Destroy;`                                                                         |Or   |Destroys the bus object by calling the inherited destructor.                                             |
|`function AttachCPU(ACPU: TCPU): Integer;`                                                    |Vi   |Attaches a CPU device. The current implementation always returns `0` and does not modify the device list.|
|`function AttachMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;`|Vi   |Attaches a memory device. The current implementation always returns `0` and performs no attachment.      |
|`function AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer;`|Vi   |Attaches an I/O-port device. The current implementation always returns `0` and performs no attachment.   |
|`function DetachCPU(InstanceID: Integer): Boolean;`                                           |Vi   |Detaches a CPU device. The current implementation always returns `False`.                                |
|`function DetachMemory(InstanceID: Integer): Boolean;`                                        |Vi   |Detaches a memory device. The current implementation always returns `False`.                             |
|`function DetachIOPorts(InstanceID: Integer): Boolean;`                                       |Vi   |Detaches an I/O-port device. The current implementation always returns `False`.                          |
|`function ReadMemory(AAddress: DWord): QWord;`                                                |Vi   |Reads memory through the system-bus API. The current implementation always returns `0`.                  |
|`procedure WriteMemory(AAddress: DWord; AValue: QWord);`                                      |Vi   |Writes memory through the system-bus API. The current implementation performs no operation.              |
|`function ReadPort(APort: Word): Byte;`                                                       |Vi   |Reads an I/O port. The current implementation does not assign a return value.                            |
|`procedure WritePort(APort: Word; AValue: Byte);`                                             |Vi   |Writes an I/O port. The current implementation performs no operation.                                    |
|`procedure Reset;`                                                                            |Vi   |Resets attached services. The current implementation performs no operation.                              |
|`function LoadState(AStream: TStream): Boolean;`                                              |Vi   |Loads bus state. The current implementation always returns `False`.                                      |
|`function SaveState(AStream: TStream): Boolean;`                                              |Vi   |Saves bus state. The current implementation always returns `False`.                                      |
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`                        |Vi   |Loads a memory block through the service API. The current implementation performs no operation.          |
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`                          |Vi   |Saves a memory block through the service API. The current implementation performs no operation.          |
|`procedure CreatePanel;`                                                                      |Vi   |Creates a service panel. The current implementation performs no operation.                               |
|`procedure FreePanel;`                                                                        |Vi   |Frees a service panel. The current implementation performs no operation.                                 |
|`procedure ShowPanel;`                                                                        |Vi   |Shows a service panel. The current implementation performs no operation.                                 |
|`procedure HidePanel;`                                                                        |Vi   |Hides a service panel. The current implementation performs no operation.                                 |
|`procedure RenamePanel(ACaption: PChar);`                                                     |Vi   |Renames a service panel. The current implementation performs no operation.                               |
|`function ResizePanel(AWidth, AHeight: Integer): Boolean;`                                    |Vi   |Resizes a service panel. The current implementation always returns `False`.                              |
|`function MovePanel(ALeft, ATop: Integer): Boolean;`                                          |Vi   |Moves a service panel. The current implementation always returns `False`.                                |
|`procedure SetRegister(const RegName: PChar; AValue: QWord);`                                 |Vi   |Sets a CPU register through the control API. The current implementation performs no operation.           |
|`function GetRegister(const RegName: PChar): QWord;`                                          |Vi   |Gets a CPU register value. The current implementation always returns `0`.                                |
|`procedure Run;`                                                                              |Vi   |Starts CPU execution through the control API. The current implementation performs no operation.          |
|`procedure Step;`                                                                             |Vi   |Executes one CPU step through the control API. The current implementation performs no operation.         |
|`procedure Stop;`                                                                             |Vi   |Stops CPU execution. The current implementation performs no operation.                                   |
|`function GetCurrentInstruction: PChar;`                                                      |Vi   |Returns the current CPU instruction text. The current implementation always returns `nil`.               |
|`procedure IRQ;`                                                                              |Vi   |Requests a maskable interrupt. The current implementation performs no operation.                         |
|`procedure NMI;`                                                                              |Vi   |Requests a non-maskable interrupt. The current implementation performs no operation.                     |
|`function CheckInterrupts: Boolean;`                                                          |Vi   |Checks pending interrupts. The current implementation always returns `False`.                            |

### Implemented interfaces

|interface|role                                                                  |
|---------|----------------------------------------------------------------------|
|`ISysBus`|Provides CPU-side memory and I/O access through the bus.              |
|`ISvcAPI`|Provides reset, state persistence, memory stream and panel operations.|
|`ICtlAPI`|Provides CPU register, execution and interrupt control operations.    |
