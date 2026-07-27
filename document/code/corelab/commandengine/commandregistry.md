# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandRegistry base class in CommandRegistry unit

TCommandRegistry is a base class that registers CoreLAB commands, which maps the
names of the commands to the classes that implement them (TCommandClass) in a
dictionary (TCommandDict).

### UML diagram

![Class diagram](../diagrams/_png/commandengine.png "CoreLAB CommandEngine class diagram")

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

|name         |type                                         |description                                    |
|-------------|---------------------------------------------|-----------------------------------------------|
|TCommandClass|class of TCommand                            |Class-reference type for registration          |
|TCommandDict |specialize TDictionary<string, TCommandClass>|Dictionary with command name and class elements|

### Protected fields

|name     |type        |C|description                         |default|
|---------|------------|-|------------------------------------|-------|
|FCommands|TCommandDict| |Dictionary of commands (name, class)|       |

### Public methods

|name                                                                                    |flags|description                                                               |
|----------------------------------------------------------------------------------------|:---:|--------------------------------------------------------------------------|
|`constructor Create;`                                                                   |Vi   |Sets the initial values for the new object                                |
|`destructor Destroy;`                                                                   |Vi   |Frees the object's resources                                              |
|`function TryGetCommand(const AName: string; var ACommandClass: TCommandClass): Boolean`|Vi   |Attempts to retrieve a registered command class by its name               |
|`procedure RegisterCommand(const AName: string; ACommandClass: TCommandClass);`         |Or   |Adds a new command name and its associated class reference to the registry|
