# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm3 Panel Caption Form in frmcaption unit

`TForm3` is a dialog form used to enter or edit the caption of a plugin GUI panel. The value is exposed through the `PanelCaption` property.

### Private methods

|name|description|
|---|---|
|`function GetCaption: string;`|Returns the text currently entered in the caption edit control.|
|`procedure SetCaption(Title: string);`|Sets the text of the caption edit control.|

### Public properties

|name|type|description|
|---|---|---|
|`PanelCaption`|`string`|Reads or writes the panel caption through `GetCaption` and `SetCaption`.|

### Event handler methods

|name|description|
|---|---|
|`procedure Edit1EditingDone(Sender: TObject);`|Activates `Button1` when editing of the caption field is completed.|

### Global variable

|name|type|description|
|---|---|---|
|`Form3`|`TForm3`|Global instance of the panel-caption form.|
