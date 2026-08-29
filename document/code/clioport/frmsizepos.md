# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm4 Panel Size and Position Form in frmsizepos unit

`TForm4` is a dialog form used to enter the size and position of a plugin GUI
panel. Four integer properties expose the values of the corresponding spin-edit
controls.

### Private methods

|name                                       |description                                                      |
|-------------------------------------------|-----------------------------------------------------------------|
|`function GetHeightValue: integer;`        |Returns the panel height from the first spin-edit control.       |
|`function GetWidthValue: integer;`         |Returns the panel width from the second spin-edit control.       |
|`function GetLeftValue: integer;`          |Returns the panel left position from the third spin-edit control.|
|`function GetTopValue: integer;`           |Returns the panel top position from the fourth spin-edit control.|
|`procedure SetHeightValue(Value: integer);`|Sets the panel height in the first spin-edit control.            |
|`procedure SetWidthValue(Value: integer);` |Sets the panel width in the second spin-edit control.            |
|`procedure SetLeftValue(Value: integer);`  |Sets the panel left position in the third spin-edit control.     |
|`procedure SetTopValue(Value: integer);`   |Sets the panel top position in the fourth spin-edit control.     |

### Public properties

|name         |type     |description                             |
|-------------|---------|----------------------------------------|
|`PanelLeft`  |`integer`|Reads or writes the panel left position.|
|`PanelHeight`|`integer`|Reads or writes the panel height.       |
|`PanelTop`   |`integer`|Reads or writes the panel top position. |
|`PanelWidth` |`integer`|Reads or writes the panel width.        |

### Global variable

|name   |type    |description                                         |
|-------|--------|----------------------------------------------------|
|`Form4`|`TForm4`|Global instance of the panel size and position form.|
