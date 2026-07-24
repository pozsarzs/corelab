# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TGIOPort class

The TGIOPort class complements the TIOPort parent class with properties and
methods that can handle the graphical interface of the port or device.

### Protected fields

|name         |type   |C|description                 |default|
|-------------|-------|-|----------------------------|:-----:|
|FPanelForm   |TForm  | |GUI panel for port or device|       |
|FPanelCaption|PChar  | |Panel caption               |'MyIO' |
|FPanelHeight |Integer| |Panel height                |100    |
|FPanelLeft   |Integer| |Panel left position         |16     |
|FPanelTop    |Integer| |Panel top position          |16     |
|FPanelWidth  |Integer| |Panel width                 |100    |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name        |type   |R|W|description    |default|
|------------|-------|-|-|---------------|:-----:|
|PanelCaption|PChar  |x| |= FPanelCaption|       |
|PanelHeight |integer|x| |= FPanelHeight |       |
|PanelLeft   |integer|x| |= FPanelLeft   |       |
|PanelTop    |integer|x| |= FPanelTop    |       |
|PanelWidth  |integer|x| |= FPanelWidth  |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                    |V|A|O|description                               |
|--------------------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                                   |x| | |Sets the initial values for the new object|
|`destructor Destroy;`                                   | | |x|Frees the object's resources              |
|`function MovePanel(Left, Top: Integer): Boolean;`      |x| | |Move panel                                |
|`function ResizePanel(Width, Height: Integer): Boolean;`|x| | |Resize panel                              |
|`procedure CreatePanel;`                                |x|x| |Create panel                              |
|`procedure FreePanel;`                                  |x| | |Destroy panel                             |
|`procedure HidePanel;`                                  |x| | |Hide panel                                |
|`procedure RenamePanel(Caption: PChar);`                |x| | |Rename panel                              |
|`procedure ShowPanel;`                                  |x| | |Show panel                                |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
