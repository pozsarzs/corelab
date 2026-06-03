# CoreLAB

## Source code

### System bus abstraction module

**Class:** TBus  
**Type:** non-visual component  
**File:** `core/core_bus.pas`  
**Target:** compiled into main executable  

|Type        |Name                         |Type/return value|Description                                                                    |
|:----------:|-----------------------------|:---------------:|-------------------------------------------------------------------------------|
|**Method**  |`constructor Create;`        |`virtual;`       |Creates the bus and initializes all hardware connections to `nil` by default.  |
|**Method**  |`function CodeRead;`         |`byte; virtual;` |Reads an instruction byte from program memory (Harvard architecture).          |
|**Method**  |`function IORead;`           |`byte; virtual;` |Reads a byte from a peripheral I/O port based on the absolute port address.    |
|**Method**  |`function MemRead;`          |`byte; virtual;` |Reads a data byte from the connected data memory based on an absolute address. |
|**Method**  |`procedure AttachCodeMemory;`|`virtual;`       |Connects a dedicated program memory module (Harvard architecture).             |
|**Method**  |`procedure AttachDataMemory;`|`virtual;`       |Connects a dedicated data memory module (Harvard architecture).                |
|**Method**  |`procedure AttachIOPorts;`   |`virtual;`       |Connects an I/O port controller peripheral to the bus.                         |
|**Method**  |`procedure AttachMemory;`    |`virtual;`       |Connects common memory (Neumann architecture).                                 |
|**Method**  |`procedure CodeWrite;`       |`virtual;`       |Writes a byte to program memory.                                               |
|**Method**  |`procedure IOWrite;`         |`virtual;`       |Writes a byte to a peripheral I/O port based on the absolute port address.     |
|**Method**  |`procedure MemWrite;`        |`virtual;`       |Writes a data byte to the connected data memory based on an absolute address.  |
|**Method**  |`procedure Reset;`           |`virtual;`       |Iterates through connected hardware and calls their respective `Reset` methods.|
|**Property**|`CodeMemory`                 |`TMemory`        |Reference to the currently assigned program memory module on the bus.          |
|**Property**|`DataMemory`                 |`TMemory`        |Reference to the currently assigned data memory module on the bus.             |
|**Property**|`IOPorts`                    |`TIOPort`        |Reference to the currently assigned I/O peripheral module on the bus.          |
