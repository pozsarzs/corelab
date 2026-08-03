> [!NOTE]
> This documentation does not include fields and methods created by the IDE.
>

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TForm1 from TForm class in frmMain unit

(...)

### UML diagram

![Class diagram](../diagrams/_png/clioport.png "CLIOPort class diagram")

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

### Own data types

|name              |type                                                    |description                               |
|------------------|--------------------------------------------------------|------------------------------------------|
|TPluginAttributes |record                                                  |                                          |
|.PFilename:       |string                                                  |Filename of the module                    |
|.PAddressRangeSize|Byte                                                    |Address range size                        |
|.PDataInMode      |TLineMode                                               |Decoding input data lines                 |
|.PDataInNegation  |Boolean                                                 |Negation of databit (port -> CPU)         |
|.PDataOutMode     |TLineMode                                               |Decoding output data lines                |
|.PDataOutNegation |Boolean                                                 |Negation of databit (CPU -> port)         |
|.PDescription     |string                                                  |Short description                         |
|.PEnabled         |Boolean                                                 |Enable port without detach from bus       |
|.PHasPanel        |Boolean                                                 |Does the implementation have a GUI?       |
|.PLatchedOutput   |Boolean                                                 |Latched output                            |
|.PModname         |string                                                  |Module name                               |
|.PReadBackOutput  |Boolean                                                 |Output port with read-back capability     |
|.PSelMode         |TLineMode                                               |Decoding matrix selector lines            |
|.PSelNegation     |Boolean                                                 |Negation of matrix selector bits          |
|TOpDirection      |(opPlugin2Var, opVar2List, opList2Var, opVar2Plugin)    |Direction pairs for data moving procedures|
|TCreatePortFunc   |function: TIOPort                                       |                                          |
|TDestroyPortProc  |procedure(Port: TIOPort)                                |                                          |
|TCreatePanelProc  |procedure(Port: TIOPort)                                |                                          |
|TShowPanelProc    |procedure(Port: TIOPort)                                |                                          |
|THidePanelProc    |procedure(Port: TIOPort)                                |                                          |
|TFreePanelProc    |procedure(Port: TIOPort)                                |                                          |
|TMovePanelProc    |function(Port: TIOPort; Left, Top: Integer): Boolean    |                                          |
|TRenamePanelProc  |procedure(Port: TIOPort; Caption: PChar)                |                                          |
|TResizePanelProc  |function(Port: TIOPort; Width, Height: Integer): Boolean|                                          |

### Private fields

|name            |type             |flags|description                    |default|
|----------------|-----------------|:---:|-------------------------------|-------|
|CreatePort      |TCreatePortFunc  |     |                               |       |
|DestroyPort     |TDestroyPortProc |     |                               |       |
|CurrentPort     |TIOPort          |     |Created object of TIOPort class|       |
|CreatePanel     |TCreatePanelProc |     |                               |       |
|ShowPanel       |TShowPanelProc   |     |                               |       |
|HidePanel       |THidePanelProc   |     |                               |       |
|FreePanel       |TFreePanelProc   |     |                               |       |
|MovePanel       |TMovePanelProc   |     |                               |       |
|RenamePanel     |TRenamePanelProc |     |                               |       |
|ResizePanel     |TResizePanelProc |     |                               |       |
|LibHandle       |TLibHandle       |     |Handle of the loaded module    |       |
|LoadedPlugin    |TPluginAttributes|     |Properties of the loaded module|       |
|FIgnoreHelp     |Boolean          |     |                               |       |
|FLoadCounter    |Integer          |     |                               |       |
|FEXEDirectory   |string           |     |                               |       |
|FPluginDirectory|string           |     |                               |       |
|FSystemLanguage |string           |     |                               |       |
|FUserDirectory  |string           |     |                               |       |

### Private methods

|name                                                     |flags|description|
|---------------------------------------------------------|:---:|-----------| 
|`procedure ImpExpProperties(aDirection: TOpDirection);`  |     |           |
|`procedure RefreshProperties(aDirection: TOpDirection);` |     |           |
|`procedure SetIgnoreHelp(aIgnoreHelp: Boolean);`         |     |           |
|`procedure SetPluginDirectory(aPluginDirectory: string);`|     |           |

### Public properties

|name           |type   |flags |description                          |default|
|---------------|-------|:----:|-------------------------------------|-------|
|IgnoreHelp     |Boolean|Re, Wr|= FIgnoreHelp/SetIgnoreHelp          |       |
|EXEDirectory   |string |Re    |= FEXEDirectory                      |       |
|PluginDirectory|string |Re, Wr|= FPluginDirectory/SetPluginDirectory|       |
|SystemLanguage |string |Re    |= FSystemLanguage                    |       |
|UserDirectory  |string |Re    |= FUserDirectory                     |       |
