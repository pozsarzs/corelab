# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm1 Main Form in frmmain unit

`TForm1` is the main CLProcessor application form. It manages processor plugins,
the emulated memory and I/O devices, processor registers, execution control,
memory-content operations, the HexViewer and RunLogger windows, and processor
state files.

### Constants

|name           |value|description                                |
|---------------|-----|-------------------------------------------|
|`MEM_SIZE`     |1024 |Size of each emulated memory bank in bytes.|
|`IOADD_CONSOLE`|$A0  |I/O address of the ASCII console.          |
|`IVECT_CONSOLE`|$CF  |Default console interrupt vector.          |
|`IOADD_STDPORT`|$B0  |I/O address of the standard I/O port.      |

### Types

#### `TPluginAttributes`

|name               |type         |description                             |
|-------------------|-------------|----------------------------------------|
|`PFilename`        |string       |Filename of the loaded module.          |
|`PDescription`     |string       |Short module description.               |
|`PEnabled`         |Boolean      |Enables or disables the processor.      |
|`PInstanceID`      |Integer      |Module instance identifier.             |
|`PModname`         |string       |Module name.                            |
|`PAddressWidth`    |Byte         |Processor address bus width in bits.    |
|`PArchitecture`    |TArchitecture|Processor memory architecture.          |
|`PEndianness`      |TEndianness  |Processor byte order.                   |
|`PMaxCodeAddress`  |DWord        |Highest code memory address.            |
|`PMaxIOPortAddress`|DWord        |Highest I/O port address.               |
|`PMaxMemAddress`   |DWord        |Highest data memory address.            |
|`PHasSeparateIOBus`|Boolean      |Indicates separate memory and I/O buses.|

#### `TOpDirection`

|value         |description                                       |
|--------------|--------------------------------------------------|
|`opPlugin2Var`|Transfer plugin properties to internal variables. |
|`opVar2List`  |Transfer internal properties to the property list.|
|`opList2Var`  |Transfer edited list values to internal variables.|
|`opVar2Plugin`|Transfer internal properties to the plugin.       |

#### Plugin entry-point procedural types

|name                   |signature                                                       |description                            |
|-----------------------|----------------------------------------------------------------|---------------------------------------|
|`TCreateProcessorFunc` |`function: TCPU; CALLTYPE`                                      |Creates the processor plugin instance. |
|`TDestroyProcessorProc`|`procedure(Processor: TCPU); CALLTYPE`                          |Destroys the processor plugin instance.|
|`TLoadStateProc`       |`function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE`|Loads processor state.                 |
|`TSaveStateProc`       |`function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE`|Saves processor state.                 |

#### `TTestSysBus`

`TTestSysBus` implements the `ISysBus` interface used by the test environment.

|method       |description                            |
|-------------|---------------------------------------|
|`ReadMemory` |Reads a byte from emulated memory.     |
|`WriteMemory`|Writes a byte to emulated memory.      |
|`ReadPort`   |Reads a byte from an emulated I/O port.|
|`WritePort`  |Writes a byte to an emulated I/O port. |

### Private fields

|name              |type                        |description                                     |
|------------------|----------------------------|------------------------------------------------|
|`CurrentProcessor`|TCPU                        |Currently instantiated processor plugin.        |
|`LibHandle`       |TLibHandle                  |Handle of the loaded processor library.         |
|`LoadedPlugin`    |TPluginAttributes           |Cached processor properties.                    |
|`FTestSysBus`     |ISysBus                     |Test system bus interface.                      |
|`CreateProcessor` |TCreateProcessorFunc        |Pointer to `cpu_create`.                        |
|`DestroyProcessor`|TDestroyProcessorProc       |Pointer to `cpu_destroy`.                       |
|`LoadState`       |TLoadStateProc              |Pointer to `cpu_loadstate`.                     |
|`SaveState`       |TSaveStateProc              |Pointer to `cpu_savestate`.                     |
|`RegNames`        |array of PChar              |Imported register names.                        |
|`RegValues`       |array of Word               |Imported register values.                       |
|`RegSize`         |array of Byte               |Register sizes in nibbles.                      |
|`RegCount`        |Byte                        |Number of imported registers.                   |
|`FIgnoreHelp`     |Boolean                     |Controls help handling.                         |
|`FLoadCounter`    |Integer                     |Number of successfully loaded processor plugins.|
|`FEXEDirectory`   |string                      |Application executable directory.               |
|`FPluginDirectory`|string                      |Processor plugin directory.                     |
|`FSystemLanguage` |string                      |Detected system language.                       |
|`FUserDirectory`  |string                      |User directory.                                 |
|`FSendIOIntReq`   |Boolean                     |Enables interrupt requests from I/O devices.    |
|`FPortIntVector`  |Byte                        |Interrupt vector used by the console.           |
|`FPortConsole`    |TConsole                    |Created ASCII console object.                   |
|`FPortStandard`   |TStandardPort               |Created standard I/O port object.               |
|`FPortConsoleCap` |string                      |ASCII console panel caption.                    |
|`FPortStandardCap`|string                      |Standard port panel caption.                    |
|`FMemory`         |array[0..1, 0..1023] of Byte|Two 1 kB emulated memory banks.                 |

### Private methods

|name                |description                                                                              |
|--------------------|-----------------------------------------------------------------------------------------|
|`ImpExpProperties`  |Transfers processor properties between the plugin, internal data and the property editor.|
|`InterruptHandler`  |Handles an interrupt request generated by an I/O port.                                   |
|`RefreshProperties` |Synchronizes processor properties with the property editor.                              |
|`RefreshRegisters`  |Synchronizes processor register values with the register editor or CPU.                  |
|`SetIgnoreHelp`     |Configures help handling.                                                                |
|`SetPluginDirectory`|Sets the processor plugin directory and refreshes the plugin list.                       |

### Public methods and properties

|name             |description                                            |
|-----------------|-------------------------------------------------------|
|`GetMemoryCell`  |Returns a byte from a selected memory bank and address.|
|`SetMemoryCell`  |Stores a byte in a selected memory bank and address.   |
|`IgnoreHelp`     |Enables or disables help suppression.                  |
|`EXEDirectory`   |Returns the application executable directory.          |
|`PluginDirectory`|Returns or changes the processor plugin directory.     |
|`SystemLanguage` |Returns the detected system language.                  |
|`UserDirectory`  |Returns the current user directory.                    |

### Event handler methods

|name                              |description                                                                             |
|----------------------------------|----------------------------------------------------------------------------------------|
|`AboutExecute`                    |Shows the About dialog.                                                                 |
|`ASCIIConsoleExecute`             |Creates and shows the ASCII console and configures its interrupt callback.              |
|`ClearCodeMemoryExecute`          |Clears memory bank 0.                                                                   |
|`ClearDataMemoryExecute`          |Clears memory bank 1.                                                                   |
|`CPUEventHandler`                 |Adds the current instruction to the RunLogger at an instruction boundary.               |
|`Edit1EditingDone`                |Validates and stores the console interrupt vector.                                      |
|`ExamineDepositExecute`           |Opens the memory examine/deposit form.                                                  |
|`FormCreate`                      |Initializes the processor, memory, I/O devices, directories and auxiliary forms.        |
|`FormDestroy`                     |Stops execution, destroys the processor and I/O objects, and unloads the plugin library.|
|`HelpExecute`                     |Opens `html/clprocessor.htm`.                                                           |
|`IRQExecute`                      |Requests an IRQ using the configured I/O interrupt vector.                              |
|`LoadChangePluginExecute`         |Loads the selected processor plugin, resolves its entry points and creates its instance.|
|`LoadRegisterValuesFromCPUExecute`|Refreshes the register editor from the processor.                                       |
|`LoadStatusExecute`               |Loads processor state from a `.clpst` file.                                             |
|`MenuItem14Click`                 |Selects the plugin directory stored in menu item 14.                                    |
|`MenuItem15Click`                 |Selects the plugin directory stored in menu item 15.                                    |
|`MenuItem16Click`                 |Selects the plugin directory stored in menu item 16.                                    |
|`MenuItem17Click`                 |Selects the plugin directory stored in menu item 17.                                    |
|`MenuItem18Click`                 |Selects the plugin directory stored in menu item 18.                                    |
|`MenuItem38Click`                 |Enables or disables I/O interrupt requests.                                             |
|`NMIExecute`                      |Requests a non-maskable interrupt.                                                      |
|`QuitExecute`                     |Terminates the application.                                                             |
|`RefreshPluginListExecute`        |Refreshes the processor plugin list.                                                    |
|`ResetExecute`                    |Resets the processor and refreshes its registers.                                       |
|`ResetPortsExecute`               |Resets the created I/O devices.                                                         |
|`RestartApplicationExecute`       |Starts a new application instance and terminates the current one.                       |
|`RunExecute`                      |Starts processor execution through the execution timer.                                 |
|`SaveRegisterValuesToCPUExecute`  |Writes edited register values to the processor.                                         |
|`SaveStatusExecute`               |Saves processor state to a `.clpst` file.                                               |
|`SelectPluginDirectoryExecute`    |Selects the processor plugin directory.                                                 |
|`LoadMemoryContentExecute`        |Loads selected memory content from a binary or Intel HEX file.                          |
|`SaveMemoryContentExecute`        |Saves selected memory content as a binary or Intel HEX file.                            |
|`ShowHexViewerExecute`            |Shows the HexViewer for the current memory.                                             |
|`ShowRunLoggerExecute`            |Shows the RunLogger window.                                                             |
|`StandardPortExecute`             |Creates and shows the standard I/O port.                                                |
|`StepExecute`                     |Executes one processor step.                                                            |
|`StopExecute`                     |Stops processor execution.                                                              |
|`Timer1Timer`                     |Clears temporary status messages.                                                       |
|`Timer2Timer`                     |Performs repeated processor steps while Run mode is active.                             |
|`TrackBar1Change`                 |Changes the execution timer interval.                                                   |
|`ValueListEditor1DrawCell`        |Draws read-only processor property cells distinctly.                                    |
|`ValueListEditor1EditingDone`     |Applies edited processor properties.                                                    |
|`ValueListEditor2ValidateEntry`   |Validates edited register values.                                                       |

### Global variable

|name   |type  |description                      |
|-------|------|---------------------------------|
|`Form1`|TForm1|Global instance of the main form.|
