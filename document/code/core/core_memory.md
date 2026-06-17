<img align="left" style="float: left; margin: 0 10px 0 0;" alt="Icon"
  src="../../../desktop/48x48/apps/corelab.png">

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Source code

### Memory abstraction module

**Class:** TMemory  
**Type:** non-visual component  
**File:** `core/core_memory.pas`  
**Target:** compiled into main executable  

|Type        |Name                       |Type/return value         |Description                                                                                 |
|:----------:|---------------------------|:------------------------:|--------------------------------------------------------------------------------------------|
|**Method**  |`constructor Create;`      |`virtual;`                |Sets the memory size, calculates `MaxRelAddress`, and initializes protection flags.         |
|**Method**  |`function ReadByte;`       |`byte; virtual; abstract;`|Reads a byte based on the module's internal, relative address.                              |
|**Method**  |`procedure LoadFromStream;`|`virtual; abstract;`      |Loads binary data from a stream starting at the specified relative target address.          |
|**Method**  |`procedure Reset;`         |`virtual; abstract;`      |Resets memory content (e.g., clearing or setting to default values).                        |
|**Method**  |`procedure SaveToStream;`  |`virtual; abstract;`      |Saves a specific length of memory area to a stream starting from the given relative address.|
|**Method**  |`procedure WriteByte;`     |`virtual; abstract;`      |Writes a byte to the module's internal, relative address (if the block is not read-only).   |
|**Property**|`MaxRelAddress`            |`qword`                   |The highest valid internal relative address of the memory module (`Size - 1`).              |
|**Property**|`ReadOnly`                 |`boolean`                 |If `true`, the memory block acts as ROM, and `WriteByte` operations are disabled.           |
|**Property**|`Size`                     |`qword`                   |The total size of the memory block in bytes.                                                |
