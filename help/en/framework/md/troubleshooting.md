# CoreLAB - Help

## 8. Troubleshooting

The following table lists common error messages and warnings you might encounter while using CoreLAB, along with their possible causes and solutions.

| Error / Warning | Possible Cause / Action |
|---|---|
| Plugin directory does not exist. | Check the plugin directory path or ensure the default `library` folder exists. |
| Cannot load plugins from [path]. | The specified directory might be empty, or the plugin files are corrupted or incompatible. |
| Missing help file. / Missing help viewer. | Check that the `corelab_en.chm` (or localized) file and the `lhelp` viewer are available in your system path or application directory. |
| Cannot destroy attached module named '[name]'. | You must detach the module from the system bus before destroying it. |
| Cannot be used '[command]' in interactive/script mode. | The executed command is restricted to the other operation mode. Switch modes and try again. |
| Command '[command]' is not available while simulation is running. | Stop the simulation execution before using configuration or module management commands. |
| Module named '[name]' exists. | Module instance names must be unique. Choose a different name for the new module. |
| Module named '[name]' not exists. | Check the spelling of the instance name in your command or script. |
| Cannot create module named '[name]'. | The plugin might be missing or failed to initialize. Check the available loaded plugins. |
| Module named '[name]' has been already attached. | The module is already connected to the system bus. |
| Only one CPU connection is allowed. | CoreLAB currently supports attaching only one CPU module to the system bus at a time. |
| Cannot load/save memory content... | Check file permissions, ensure the file format (BIN/HEX) is correct, and verify checksums for Intel HEX files. |
| Property '[name]' is read only or not exists. | Check the property name spelling. Some properties cannot be modified manually. |
| Value '[value]' is bad. | Ensure the provided value is in the correct format (e.g., correct hexadecimal syntax or boolean values). |
| Cannot load/save project from [file]. | Ensure you have the necessary read/write permissions and the file is a valid `.clprj` format. |
| Cannot load/save script to [file]. | Check the file permissions and verify it is a valid `.clsce` script file. |
