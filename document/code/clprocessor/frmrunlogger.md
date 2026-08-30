# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm4 RunLogger form in frmrunlogger unit

`TForm4` records processor instruction-boundary events and displays them in a
four-column log. The log is stored in a ring buffer with a maximum capacity of
1024 records. Records can be searched and saved as a text log file.

### Constants

|name     |type   |description                         |
|---------|-------|------------------------------------|
|`MAX_LOG`|Integer|Maximum number of log records: 1024.|

### Private fields

|name                |type            |description                           |
|--------------------|----------------|--------------------------------------|
|`FInstCountColor`   |TColor          |Instruction-counter column color.     |
|`FAddressColor`     |TColor          |Address-column color.                 |
|`FOpCodeColor`      |TColor          |Opcode-column color.                  |
|`FMnemonicColor`    |TColor          |Mnemonic-column color.                |
|`FLineSelectorColor`|TColor          |Selected-row color.                   |
|`FBGColorOddLines`  |TColor          |Odd-row background color.             |
|`FBGColorEvenLines` |TColor          |Even-row background color.            |
|`FRecordCount`      |Integer         |Number of valid records in the buffer.|
|`FRingBuffer`       |array of TLogRec|Ring-buffer storage.                  |
|`FWriteMarker`      |Integer         |Next buffer position for writing.     |

### Private methods

|name         |description                                            |
|-------------|-------------------------------------------------------|
|`ResetBuffer`|Clears all log records and resets buffer indices.      |
|`ReadBuffer` |Returns a logical record from the ring buffer.         |
|`WriteBuffer`|Appends a record and advances the ring-buffer position.|

### Protected methods

|name                  |description                               |
|----------------------|------------------------------------------|
|`SetInstCountColor`   |Sets the instruction-counter column color.|
|`SetAddressColor`     |Sets the address-column color.            |
|`SetOpCodeColor`      |Sets the opcode-column color.             |
|`SetMnemonicColor`    |Sets the mnemonic-column color.           |
|`SetLineSelectorColor`|Sets the selected-row color.              |
|`SetBGColorEvenLines` |Sets the even-row background color.       |
|`SetBGColorOddLines`  |Sets the odd-row background color.        |

### Public methods and properties

|name               |description                           |
|-------------------|--------------------------------------|
|`AppendRecord`     |Adds an instruction record to the log.|
|`InstCountColor`   |Instruction-counter column color.     |
|`AddressColor`     |Address-column color.                 |
|`OpCodeColor`      |Opcode-column color.                  |
|`MnemonicColor`    |Mnemonic-column color.                |
|`LineSelectorColor`|Selected-row color.                   |
|`BGColorOddLines`  |Odd-row background color.             |
|`BGColorEvenLines` |Even-row background color.            |

### Event handler methods

|name                    |description                                            |
|------------------------|-------------------------------------------------------|
|`Button1Click`          |Hides the RunLogger window.                            |
|`Button2Click`          |Clears the log buffer.                                 |
|`Button3Click`          |Saves the log as a text `.log` file.                   |
|`DrawGrid1DrawCell`     |Draws log records in the grid.                         |
|`EditButton1ButtonClick`|Searches forward in the log for the entered text.      |
|`FormActivate`          |Invalidates the form for redraw.                       |
|`FormCreate`            |Initializes colors, buffer and grid columns.           |
|`FormShow`              |Updates the grid row count to the current record count.|

### Global variable

|name   |type  |description                           |
|-------|------|--------------------------------------|
|`Form4`|TForm4|Global instance of the RunLogger form.|
