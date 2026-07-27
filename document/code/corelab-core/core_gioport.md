# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TGIOPort from TIOPort class in core_gioport unit

The TGIOPort class complements the TIOPort parent class with properties and
methods that can handle the graphical interface of the port or device.

### Abbreviations

- _Ab_: means 'abstract',
- _Co_: means 'constant',
- _Il_: means 'inline',
- _Ol_: means 'overload',
- _Or_: means 'override',
- _Re_: means 'read',
- _Ri_: means 'reintroduce',
- _St_: means 'static',
- _Vi_: means 'virtual',
- _Wr_: means 'write'.

### Protected fields

|name         |type   |flags|description                 |default|
|-------------|-------|:---:|----------------------------|-------|
|FPanelForm   |TForm  |     |GUI panel for port or device|       |
|FPanelCaption|PChar  |     |Panel caption               |'MyIO' |
|FPanelHeight |Integer|     |Panel height                |100    |
|FPanelLeft   |Integer|     |Panel left position         |16     |
|FPanelTop    |Integer|     |Panel top position          |16     |
|FPanelWidth  |Integer|     |Panel width                 |100    |

### Public properties

|name        |type   |flags|description    |default|
|------------|-------|:---:|---------------|-------|
|PanelCaption|PChar  |Re   |= FPanelCaption|       |
|PanelHeight |Integer|Re   |= FPanelHeight |       |
|PanelLeft   |Integer|Re   |= FPanelLeft   |       |
|PanelTop    |Integer|Re   |= FPanelTop    |       |
|PanelWidth  |Integer|Re   |= FPanelWidth  |       |

### Public methods

|name                                                    |flags |description                               |
|--------------------------------------------------------|:----:|------------------------------------------|
|`constructor Create;`                                   |Vi    |Sets the initial values for the new object|
|`destructor Destroy;`                                   |Or    |Frees the object's resources              |
|`function MovePanel(Left, Top: Integer): Boolean;`      |Vi    |Move panel                                |
|`function ResizePanel(Width, Height: Integer): Boolean;`|Vi    |Resize panel                              |
|`procedure CreatePanel;`                                |Vi, Ab|Create panel                              |
|`procedure FreePanel;`                                  |Vi    |Destroy panel                             |
|`procedure HidePanel;`                                  |Vi    |Hide panel                                |
|`procedure RenamePanel(Caption: PChar);`                |Vi    |Rename panel                              |
|`procedure ShowPanel;`                                  |Vi    |Show panel                                |
