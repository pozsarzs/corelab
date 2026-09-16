# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm1 Main Form in frmmain unit

`TForm1` is the main CoreLAB application form. It selects the plugin directory,
loads IOPort plugins as shared libraries, manages plugin instances and optional
GUI panels, handles port I/O, interrupts and plugin state files.

### Types

#### `TPluginAttributes`

|name               |type       |description                    |
|-------------------|-----------|-------------------------------|
|`PFilename`        |`string`   |Plugin module filename.        |
|`PAddressRangeSize`|`Byte`     |Port address range size.       |
|`PBaseAddress`     |`Byte`     |Base address.                  |
|`PDataInMode`      |`TLineMode`|Input data-line decoding mode. |
|`PDataInNegation`  |`Boolean`  |Negates port-to-CPU data bits. |
|`PDataOutMode`     |`TLineMode`|Output data-line decoding mode.|
|`PDataOutNegation` |`Boolean`  |Negates CPU-to-port data bits. |
|`PDescription`     |`string`   |Short plugin description.      |
|`PEnabled`         |`Boolean`  |Enables or disables the port.  |
|`PHasPanel`        |`Boolean`  |Plugin provides a GUI panel.   |
|`PIntVector`       |`Byte`     |Plugin interrupt vector.       |
|`PLatchedOutput`   |`Boolean`  |Output is latched.             |
|`PModname`         |`string`   |Plugin module name.            |
|`PReadBackOutput`  |`Boolean`  |Output supports read-back.     |
|`PSelMode`         |`TLineMode`|Selector-line decoding mode.   |
|`PSelNegation`     |`Boolean`  |Negates selector bits.         |

#### `TOpDirection`

|value         |description                            |
|--------------|---------------------------------------|
|`opPlugin2Var`|Plugin properties → internal variables.|
|`opVar2List`  |Internal variables → property editor.  |
|`opList2Var`  |Property editor → internal variables.  |
|`opVar2Plugin`|Internal variables → plugin.           |

### Plugin entry-point procedural types

|name              |signature                                                                         |description                            |
|------------------|----------------------------------------------------------------------------------|---------------------------------------|
|`TCreatePortFunc` |`function: TIOPort; CALLTYPE`                                                     |Creates the plugin port.               |
|`TDestroyPortProc`|`procedure(Port: TIOPort); CALLTYPE`                                              |Destroys the plugin port.              |
|`TCreatePanelProc`|`procedure(Port: TIOPort); CALLTYPE`                                              |Creates the plugin panel.              |
|`TShowPanelProc`  |`procedure(Port: TIOPort); CALLTYPE`                                              |Shows the plugin panel.                |
|`THidePanelProc`  |`procedure(Port: TIOPort); CALLTYPE`                                              |Hides the plugin panel.                |
|`TFreePanelProc`  |`procedure(Port: TIOPort); CALLTYPE`                                              |Destroys the plugin panel.             |
|`TRenamePanelProc`|`procedure(Port: TIOPort; Caption: PChar); CALLTYPE`                              |Changes the panel caption.             |
|`TResizePanelProc`|`function(Port: TIOPort; Width, Height: Integer): Boolean; CALLTYPE`              |Resizes the plugin panel.              |
|`TMovePanelProc`  |`function(Port: TIOPort; Left, Top: Integer): Boolean; CALLTYPE`                  |Moves the plugin panel.                |
|`TSetIntHandler`  |`procedure(Port: TIOPort; IntProc: TInterruptCallback; IntVector: Byte); CALLTYPE`|Sets the interrupt callback and vector.|
|`TLoadStateProc`  |`function(Port: TIOPort; AStream: TStream): Boolean; CALLTYPE`                    |Loads plugin state from a stream.      |
|`TSaveStateProc`  |`function(Port: TIOPort; AStream: TStream): Boolean; CALLTYPE`                    |Saves plugin state to a stream.        |

### Published components

The form contains the following published controls and actions.

|name                         |type              |description                     |
|-----------------------------|------------------|--------------------------------|
|`About`                      |`TAction`         |About command.                  |
|`LoadStatus`                 |`TAction`         |Load plugin state command.      |
|`OpenDialog1`                |`TOpenDialog`     |State-file open dialog.         |
|`SaveDialog1`                |`TSaveDialog`     |State-file save dialog.         |
|`SaveStatus`                 |`TAction`         |Save plugin state command.      |
|`ActionList1`                |`TActionList`     |Action collection.              |
|`CHMHelpDatabase1`           |`TCHMHelpDatabase`|CHM help database.              |
|`DirectoryEdit1`             |`TDirectoryEdit`  |Plugin directory selector.      |
|`Help`                       |`TAction`         |Help command.                   |
|`ImageList1`                 |`TImageList`      |Image list.                     |
|`LHelpConnector1`            |`TLHelpConnector` |LHelp connector.                |
|`LoadChangePlugin`           |`TAction`         |Load/change plugin command.     |
|`MainMenu1`                  |`TMainMenu`       |Main menu.                      |
|`Panel1`                     |`TPanel`          |Main form panel.                |
|`Quit`                       |`TAction`         |Quit command.                   |
|`ReadAByte`                  |`TAction`         |Read-byte command.              |
|`RefreshPluginList`          |`TAction`         |Refresh plugin list command.    |
|`RestartApplication`         |`TAction`         |Restart command.                |
|`SelectPluginDirectory`      |`TAction`         |Select directory command.       |
|`SetPluginWindowCaption`     |`TAction`         |Set panel caption command.      |
|`SetPluginWindowSizePosition`|`TAction`         |Set panel size/position command.|
|`ShellListView1`             |`TShellListView`  |Plugin file list.               |
|`ShowPluginWindow`           |`TAction`         |Show plugin panel command.      |
|`Splitter1`                  |`TSplitter`       |Panel splitter.                 |
|`StatusBar1`                 |`TStatusBar`      |Status display.                 |
|`Timer1`                     |`TTimer`          |Temporary status-message timer. |
|`ToolBar1`                   |`TToolBar`        |Toolbar.                        |
|`ToolButton1` … `ToolButton7`|`TToolButton`     |Toolbar buttons.                |
|`ValueListEditor1`           |`TValueListEditor`|Plugin property editor.         |
|`ValueListEditor2`           |`TValueListEditor`|Port address/data editor.       |
|`WriteAByte`                 |`TAction`         |Write-byte command.             |

### Private fields

|name              |type               |description                          |
|------------------|-------------------|-------------------------------------|
|`CurrentPort`     |`TIOPort`          |Currently instantiated plugin object.|
|`LibHandle`       |`TLibHandle`       |Handle of the loaded module.         |
|`LoadedPlugin`    |`TPluginAttributes`|Properties of the loaded plugin.     |
|`CreatePort`      |`TCreatePortFunc`  |Plugin port creation entry point.    |
|`DestroyPort`     |`TDestroyPortProc` |Plugin port destruction entry point. |
|`CreatePanel`     |`TCreatePanelProc` |Panel creation entry point.          |
|`ShowPanel`       |`TShowPanelProc`   |Panel display entry point.           |
|`HidePanel`       |`THidePanelProc`   |Panel hiding entry point.            |
|`FreePanel`       |`TFreePanelProc`   |Panel destruction entry point.       |
|`RenamePanel`     |`TRenamePanelProc` |Panel caption entry point.           |
|`ResizePanel`     |`TResizePanelProc` |Panel resize entry point.            |
|`MovePanel`       |`TMovePanelProc`   |Panel move entry point.              |
|`SetIntHandler`   |`TSetIntHandler`   |Interrupt-handler entry point.       |
|`LoadState`       |`TLoadStateProc`   |State-load entry point.              |
|`SaveState`       |`TSaveStateProc`   |State-save entry point.              |
|`FIgnoreHelp`     |`Boolean`          |Suppresses help handling.            |
|`FLoadCounter`    |`Integer`          |Counts successfully loaded plugins.  |
|`FEXEDirectory`   |`string`           |Application executable directory.    |
|`FPluginDirectory`|`string`           |Current plugin directory.            |
|`FSystemLanguage` |`string`           |Detected system language.            |
|`FUserDirectory`  |`string`           |Current user directory.              |

### Private methods

|name                                             |description                                                    |
|-------------------------------------------------|---------------------------------------------------------------|
|`ImpExpProperties(Direction: TOpDirection)`      |Imports plugin properties or exports writable properties.      |
|`InterruptHandler(Sender: TIOPort; Vector: Byte)`|Displays the received interrupt vector in the status bar.      |
|`RefreshProperties(Direction: TOpDirection)`     |Transfers properties between variables and the property editor.|
|`SetIgnoreHelp(AIgnoreHelp: Boolean)`            |Sets the help-suppression state and configures the help system.|
|`SetPluginDirectory(APluginDirectory: string)`   |Sets the plugin directory and refreshes the plugin list.       |

### Public properties

|name             |type                                                   |description                       |
|-----------------|-------------------------------------------------------|----------------------------------|
|`IgnoreHelp`     |`Boolean read FIgnoreHelp write SetIgnoreHelp`         |Controls help suppression.        |
|`EXEDirectory`   |`string read FEXEDirectory`                            |Application executable directory. |
|`PluginDirectory`|`string read FPluginDirectory write SetPluginDirectory`|Gets or sets the plugin directory.|
|`SystemLanguage` |`string read FSystemLanguage`                          |Detected system language.         |
|`UserDirectory`  |`string read FUserDirectory`                           |Current user directory.           |

### Event handler methods

|name                                |description                                                                                   |
|------------------------------------|----------------------------------------------------------------------------------------------|
|`AboutExecute`                      |Shows the About dialog.                                                                       |
|`FormCreate`                        |Initializes plugin state, directories, controls and the plugin list.                          |
|`FormDestroy`                       |Releases the panel and port, unloads the library and clears entry points.                     |
|`HelpExecute`                       |Opens `html/clioport.htm` through the help system.                                            |
|`LoadChangePluginExecute`           |Loads the selected shared library, resolves entry points, creates the port and optional panel.|
|`LoadStatusExecute`                 |Loads plugin state from a file.                                                               |
|`MenuItem14Click`                   |Sets the plugin directory from MenuItem14's caption.                                          |
|`MenuItem15Click`                   |Sets the directory if it exists; otherwise disables the item.                                 |
|`MenuItem16Click`                   |Sets the directory if it exists; otherwise disables the item.                                 |
|`MenuItem17Click`                   |Sets the directory using MenuItem18's caption if that directory exists.                       |
|`MenuItem18Click`                   |Sets the directory if it exists; otherwise disables the item.                                 |
|`QuitExecute`                       |Terminates the application.                                                                   |
|`ReadAByteExecute`                  |Reads the selected port byte and updates the status bar and data list.                        |
|`RefreshPluginListExecute`          |Refreshes the plugin file list using the platform-specific library mask.                      |
|`RestartApplicationExecute`         |Starts a new application instance, then terminates the current one.                           |
|`SaveStatusExecute`                 |Saves plugin state to a file.                                                                 |
|`SelectPluginDirectoryExecute`      |Opens the plugin-directory selector.                                                          |
|`SetPluginWindowCaptionExecute`     |Edits and applies the plugin panel caption.                                                   |
|`SetPluginWindowSizePositionExecute`|Edits and applies panel size and position.                                                    |
|`ShowPluginWindowExecute`           |Shows the plugin panel when available.                                                        |
|`Timer1Timer`                       |Clears the temporary status message.                                                          |
|`ValueListEditor1DrawCell`          |Draws read-only property cells in a disabled-style appearance.                                |
|`ValueListEditor1EditingDone`       |Transfers edited properties to the plugin.                                                    |
|`ValueListEditor2EditingDone`       |Writes the selected byte value to the port.                                                   |
|`ValueListEditor2ValidateEntry`     |Validates and normalizes hexadecimal byte input.                                              |
|`WriteAByteExecute`                 |Writes the selected byte to the plugin port.                                                  |

### Global variable

|name   |type    |description                      |
|-------|--------|---------------------------------|
|`Form1`|`TForm1`|Global instance of the main form.|

### Plugin loading interface

The main form resolves the following exported plugin entry points from the
loaded shared library:

|exported name         |purpose                                      |
|----------------------|---------------------------------------------|
|`ioport_create`       |Create the plugin port object.               |
|`ioport_destroy`      |Destroy the plugin port object.              |
|`ioport_createpanel`  |Create the plugin GUI panel.                 |
|`ioport_freepanel`    |Destroy the plugin GUI panel.                |
|`ioport_showpanel`    |Show the plugin GUI panel.                   |
|`ioport_hidepanel`    |Hide the plugin GUI panel.                   |
|`ioport_renamepanel`  |Change the plugin GUI panel caption.         |
|`ioport_resizepanel`  |Resize the plugin GUI panel.                 |
|`ioport_movepanel`    |Move the plugin GUI panel.                   |
|`ioport_setinthandler`|Set the plugin interrupt callback and vector.|
|`ioport_loadstate`    |Load plugin state from a stream.             |
|`ioport_savestate`    |Save plugin state to a stream.               |
