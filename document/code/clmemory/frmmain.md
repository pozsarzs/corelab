> [!NOTE]
> This documentation does not include fields and methods created by the IDE.
>

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TForm1 from TForm class in frmMain unit

(...)

### UML diagram

![Class diagram](../diagrams/_png/clmemory.png "CLMemory class diagram")

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
|.PDescription     |string                                                  |Short description                         |
|.PEnabled         |Boolean                                                 |Enable port without detach from bus       |
|.PModname         |string                                                  |Module name                               |
|TOpDirection      |(opPlugin2Var, opVar2List, opList2Var, opVar2Plugin)    |Direction pairs for data moving procedures|
|TCreatePortFunc   |function: TIOPort                                       |                                          |
|TDestroyPortProc  |procedure(Port: TIOPort)                                |                                          |

### Private fields

|name            |type             |flags|description                    |default|
|----------------|-----------------|:---:|-------------------------------|-------|
|CreatePort      |TCreatePortFunc  |     |                               |       |
|DestroyPort     |TDestroyPortProc |     |                               |       |
|CurrentPort     |TIOPort          |     |Created object of TIOPort class|       |
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
|`procedure ImpExpProperties(Direction: TOpDirection);`   |     |           |
|`procedure RefreshProperties(Direction: TOpDirection);`  |     |           |
|`procedure SetIgnoreHelp(AIgnoreHelp: Boolean);`         |     |           |
|`procedure SetPluginDirectory(APluginDirectory: string);`|     |           |

### Public properties

|name           |type   |flags |description                            |default|
|---------------|-------|:----:|---------------------------------------|-------|
|IgnoreHelp     |Boolean|Re, Wr|= FIgnoreHelp / SetIgnoreHelp          |       |
|EXEDirectory   |string |Re    |= FEXEDirectory                        |       |
|PluginDirectory|string |Re, Wr|= FPluginDirectory / SetPluginDirectory|       |
|SystemLanguage |string |Re    |= FSystemLanguage                      |       |
|UserDirectory  |string |Re    |= FUserDirectory                       |       |
