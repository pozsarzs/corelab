# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm3 HexViewer form in frmhexviewer unit

`TForm3` displays the emulated memory as a hexadecimal dump. Sixteen data bytes
are displayed per row together with the base address. In Harvard mode, the
memory bank can be selected. The viewer also provides text search.

### Private fields

|name                |type         |description                   |
|--------------------|-------------|------------------------------|
|`FAddressColor`     |TColor       |Color of the address column.  |
|`FDataColor`        |TColor       |Color of the data columns.    |
|`FLineSelectorColor`|TColor       |Color of the selected row.    |
|`FBGColorOddLines`  |TColor       |Background color of odd rows. |
|`FBGColorEvenLines` |TColor       |Background color of even rows.|
|`FArchitecture`     |TArchitecture|Selected CPU architecture.    |
|`FMemSize`          |DWord        |Size of emulated memory.      |

### Protected methods

|name                  |description                                             |
|----------------------|--------------------------------------------------------|
|`SetAddressColor`     |Sets the address-column color and redraws the grid.     |
|`SetDataColor`        |Sets the data-column color and redraws the grid.        |
|`SetLineSelectorColor`|Sets the selected-row color and redraws the grid.       |
|`SetBGColorEvenLines` |Sets the even-row background color and redraws the grid.|
|`SetBGColorOddLines`  |Sets the odd-row background color and redraws the grid. |
|`SetFArchitecture`    |Sets the architecture and controls the bank selector.   |
|`SetFMemSize`         |Sets the memory size when greater than zero.            |

### Public properties

|name               |type         |description               |
|-------------------|-------------|--------------------------|
|`Architecture`     |TArchitecture|Selected CPU architecture.|
|`AddressColor`     |TColor       |Address-column color.     |
|`DataColor`        |TColor       |Data-column color.        |
|`LineSelectorColor`|TColor       |Selected-row color.       |
|`BGColorOddLines`  |TColor       |Odd-row background color. |
|`BGColorEvenLines` |TColor       |Even-row background color.|
|`MemSize`          |DWord        |Size of emulated memory.  |

### Event handler methods

|name                    |description                                                   |
|------------------------|--------------------------------------------------------------|
|`Button1Click`          |Hides the HexViewer window.                                   |
|`DrawGrid1DrawCell`     |Draws memory addresses and byte values in the grid.           |
|`EditButton1ButtonClick`|Searches the dump for the entered text.                       |
|`FormActivate`          |Invalidates the form for redraw.                              |
|`FormCreate`            |Initializes colors, architecture and the 16-byte-per-row grid.|

### Global variable

|name   |type  |description                           |
|-------|------|--------------------------------------|
|`Form3`|TForm3|Global instance of the HexViewer form.|
