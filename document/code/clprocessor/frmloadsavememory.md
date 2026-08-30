# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm7 Load/save memory parameter form in frmloadsavememory unit

`TForm7` selects the memory range and bank used by the memory-content load and
save operations. It supports Neumann and Harvard architectures and calculates
the end address from the start address and selected range length.

### Private fields

|name           |type         |description                         |
|---------------|-------------|------------------------------------|
|`FAddressFrom` |DWord        |Start address of the selected range.|
|`FAddressTo`   |DWord        |End address of the selected range.  |
|`FArchitecture`|TArchitecture|Selected CPU architecture.          |
|`FBank`        |Byte         |Selected memory bank.               |
|`FDirection`   |Boolean      |Operation direction: load or save.  |
|`FMemSize`     |DWord        |Size of emulated memory.            |

### Private methods

|name              |description                                                          |
|------------------|---------------------------------------------------------------------|
|`SetFArchitecture`|Sets the architecture and enables the bank selector for Harvard mode.|
|`SetFMemSize`     |Sets the memory size when greater than zero.                         |
|`SetFDirection`   |Sets load/save mode, button caption and form caption.                |
|`UpdateDifference`|Updates the end address from the start address and range length.     |

### Public properties

|name          |type         |description                          |
|--------------|-------------|-------------------------------------|
|`AddressFrom` |DWord        |Selected start address.              |
|`AddressTo`   |DWord        |Selected end address.                |
|`Architecture`|TArchitecture|Selected CPU architecture.           |
|`Bank`        |Byte         |Selected memory bank.                |
|`Direction`   |Boolean      |Load (`True`) or save (`False`) mode.|
|`MemSize`     |DWord        |Size of emulated memory.             |

### Event handler methods

|name                    |description                                                        |
|------------------------|-------------------------------------------------------------------|
|`Button1Click`          |Cancels the operation without setting the public range fields.     |
|`Button5Click`          |Validates the selected range, selects the bank and closes the form.|
|`EditButton1ButtonClick`|Sets the start address to zero and updates the end address.        |
|`EditButton1EditingDone`|Validates and formats the start address.                           |
|`EditButton2ButtonClick`|Sets the end address to zero and updates the range.                |
|`EditButton2EditingDone`|Validates and formats the end address.                             |
|`FormCreate`            |Initializes load mode, Neumann architecture and a 1 kB memory size.|
|`SpinEdit1Change`       |Calculates the end address from the start address and range length.|

### Global variable

|name   |type  |description                                     |
|-------|------|------------------------------------------------|
|`Form7`|TForm7|Global instance of the load/save parameter form.|
