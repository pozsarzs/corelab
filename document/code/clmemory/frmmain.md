# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TForm1 from TForm class in frmmain unit

`TForm1` is the main form of the CoreLAB standard-memory plugin manager.
It discovers memory plugins, loads the selected shared library, creates its
`TMemory` instance, displays and edits its properties, provides direct memory
read/write operations, and saves or restores plugin state.

### Types

#### TPluginAttributes

`TPluginAttributes` stores the properties of the loaded memory plugin.

|field              |type       |description                            |
|-------------------|-----------|---------------------------------------|
|`PFilename`        |string     |Filename of the module.                |
|`PAddressRangeSize`|DWord      |Configured memory address range.       |
|`PBaseAddress`     |DWord      |Base address.                          |
|`PDescription`     |string     |Short module description.              |
|`PEnabled`         |Boolean    |Enables or disables memory access.     |
|`PMemoryMode`      |TMemoryMode|Memory operation mode, e.g. RAM or ROM.|
|`PModname`         |string     |Module name.                           |

#### TOpDirection

|value         |description                                         |
|--------------|----------------------------------------------------|
|`opPlugin2Var`|Imports plugin properties into `LoadedPlugin`.      |
|`opVar2List`  |Copies `LoadedPlugin` values to the property editor.|
|`opList2Var`  |Reads edited values into `LoadedPlugin`.            |
|`opVar2Plugin`|Writes editable values to the plugin.               |

### Plugin entry-point types

|type                |signature                                                       |purpose                           |
|--------------------|----------------------------------------------------------------|----------------------------------|
|`TCreateMemoryFunc` |`function: TMemory; CALLTYPE`                                   |Creates a memory-plugin instance. |
|`TDestroyMemoryProc`|`procedure(Memory: TMemory); CALLTYPE`                          |Destroys a memory-plugin instance.|
|`TLoadStateProc`    |`function(Memory: TMemory; AStream: TStream): Boolean; CALLTYPE`|Loads plugin state.               |
|`TSaveStateProc`    |`function(Memory: TMemory; AStream: TStream): Boolean; CALLTYPE`|Saves plugin state.               |

### Published components

The form contains the following published controls and actions.

|name              |type            |role                                 |
|------------------|----------------|-------------------------------------|
|`ActionList1`     |TActionList     |Stores application actions.          |
|`MainMenu1`       |TMainMenu       |Main application menu.               |
|`ToolBar1`        |TToolBar        |Toolbar for common actions.          |
|`DirectoryEdit1`  |TDirectoryEdit  |Selects the plugin directory.        |
|`ShellListView1`  |TShellListView  |Lists available memory plugins.      |
|`ValueListEditor1`|TValueListEditor|Displays plugin properties.          |
|`ValueListEditor2`|TValueListEditor|Edits memory address and data values.|
|`StatusBar1`      |TStatusBar      |Displays plugin and operation status.|
|`Timer1`          |TTimer          |Clears temporary status messages.    |
|`OpenDialog1`     |TOpenDialog     |Selects a plugin status file to load.|
|`SaveDialog1`     |TSaveDialog     |Selects a plugin status file to save.|
|`CHMHelpDatabase1`|TCHMHelpDatabase|Configures CHM help.                 |
|`LHelpConnector1` |TLHelpConnector |Connects the LHelp viewer.           |

### Private fields

|name              |type              |description                                  |
|------------------|------------------|---------------------------------------------|
|`CurrentMemory`   |TMemory           |Currently instantiated memory plugin.        |
|`LibHandle`       |TLibHandle        |Handle of the loaded shared library.         |
|`LoadedPlugin`    |TPluginAttributes |Cached plugin properties.                    |
|`CreateMemory`    |TCreateMemoryFunc |Pointer to `memory_create`.                  |
|`DestroyMemory`   |TDestroyMemoryProc|Pointer to `memory_destroy`.                 |
|`LoadState`       |TLoadStateProc    |Pointer to `memory_loadstate`.               |
|`SaveState`       |TSaveStateProc    |Pointer to `memory_savestate`.               |
|`FIgnoreHelp`     |Boolean           |Suppresses the help system when true.        |
|`FLoadCounter`    |Integer           |Counts successfully created plugin instances.|
|`FEXEDirectory`   |string            |Application executable directory.            |
|`FPluginDirectory`|string            |Current plugin directory.                    |
|`FSystemLanguage` |string            |Detected system language.                    |
|`FUserDirectory`  |string            |Current user directory.                      |

### Public properties

|name             |type   |access    |description                                         |
|-----------------|-------|----------|----------------------------------------------------|
|`IgnoreHelp`     |Boolean|read/write|Controls help-system configuration.                 |
|`EXEDirectory`   |string |read      |Application executable directory.                   |
|`PluginDirectory`|string |read/write|Changes the plugin directory and refreshes the list.|
|`SystemLanguage` |string |read      |Detected system language.                           |
|`UserDirectory`  |string |read      |Current user directory.                             |

### Private methods

|name                |description                                                         |
|--------------------|--------------------------------------------------------------------|
|`ImpExpProperties`  |Transfers properties between the plugin, internal record and editor.|
|`RefreshProperties` |Synchronizes the property record and property editor.               |
|`SetIgnoreHelp`     |Configures CHM/LHelp and enables or disables help.                  |
|`SetPluginDirectory`|Stores the directory, updates the selector and refreshes plugins.   |

### Event handlers

|name                           |description                                                                          |
|-------------------------------|-------------------------------------------------------------------------------------|
|`AboutExecute`                 |Shows the About dialog.                                                              |
|`FormCreate`                   |Initializes state, controls, directories and the plugin list.                        |
|`FormDestroy`                  |Destroys the plugin instance and unloads the library.                                |
|`HelpExecute`                  |Opens `html/clmemory.htm` through the help system.                                   |
|`LoadChangePluginExecute`      |Unloads the previous plugin, loads the selected library and creates the new instance.|
|`LoadStatusExecute`            |Loads plugin state from a `.clpst` file.                                             |
|`MenuItem14Click`              |Selects the directory stored in menu item 14.                                        |
|`MenuItem15Click`              |Selects menu item 15's directory if it exists.                                       |
|`MenuItem16Click`              |Selects menu item 16's directory if it exists.                                       |
|`MenuItem17Click`              |Selects the configured directory if it exists.                                       |
|`MenuItem18Click`              |Selects menu item 18's directory if it exists.                                       |
|`QuitExecute`                  |Terminates the application.                                                          |
|`ExamineExecute`               |Reads memory at the entered hexadecimal address.                                     |
|`RefreshPluginListExecute`     |Refreshes the memory-plugin file list.                                               |
|`RestartApplicationExecute`    |Starts a new application instance and terminates the current one.                    |
|`SaveStatusExecute`            |Saves plugin state to a `.clpst` file.                                               |
|`SelectPluginDirectoryExecute` |Opens the directory selection dialog.                                                |
|`Timer1Timer`                  |Clears the temporary status message.                                                 |
|`ValueListEditor1DrawCell`     |Draws read-only property names in a distinct style.                                  |
|`ValueListEditor1EditingDone`  |Applies edited property values to the plugin.                                        |
|`ValueListEditor1ValidateEntry`|Validates the memory address-range size.                                             |
|`ValueListEditor2ValidateEntry`|Validates and normalizes hexadecimal address/data input.                             |
|`DepositExecute`               |Writes the entered value to memory and reports errors.                               |

### Global variable

|name   |type  |description                      |
|-------|------|---------------------------------|
|`Form1`|TForm1|Global instance of the main form.|

### Plugin loading interface

The main form resolves the following exported plugin entry points from the
loaded shared library:

|exported name     |purpose                            |
|------------------|-----------------------------------|
|`memory_create`   |Create the `TMemory` plugin object.|
|`memory_destroy`  |Destroy the plugin object.         |
|`memory_loadstate`|Load plugin state from a stream.   |
|`memory_savestate`|Save plugin state to a stream.     |
