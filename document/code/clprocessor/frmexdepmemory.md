# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm5 Examine/deposit form in frmexdepmemory unit

`TForm5` provides direct examination and modification of the emulated memory. It
accepts hexadecimal address and data values and supports Neumann and Harvard
memory architectures. In Harvard mode, the memory bank can be selected.

### Private fields

|name           |type         |description               |
|---------------|-------------|--------------------------|
|`FArchitecture`|TArchitecture|Selected CPU architecture.|
|`FMemSize`     |DWord        |Size of emulated memory.  |

### Protected methods

|name              |description                                                          |
|------------------|---------------------------------------------------------------------|
|`SetFArchitecture`|Sets the architecture and enables the bank selector for Harvard mode.|

### Public properties

|name          |type         |description               |
|--------------|-------------|--------------------------|
|`Architecture`|TArchitecture|Selected CPU architecture.|
|`MemSize`     |DWord        |Size of emulated memory.  |

### Event handler methods

|name                    |description                                             |
|------------------------|--------------------------------------------------------|
|`Button3Click`          |Reads a byte from the selected memory address.          |
|`Button4Click`          |Writes a byte to the selected memory address.           |
|`Button5Click`          |Closes the form.                                        |
|`EditButton1ButtonClick`|Sets the address field to zero.                         |
|`EditButton1EditingDone`|Validates and formats the hexadecimal address.          |
|`EditButton2ButtonClick`|Sets the data field to zero.                            |
|`EditButton2EditingDone`|Validates and formats the hexadecimal data.             |
|`FormCreate`            |Initializes Neumann architecture and a 1 kB memory size.|

### Global variable

|name   |type  |description                                 |
|-------|------|--------------------------------------------|
|`Form5`|TForm5|Global instance of the examine/deposit form.|
