# CLIOPort – Help

## 1. Introduction

CLIOPort is a graphical application for testing I/O port plugins in the CoreLAB framework. It allows you to select and load an I/O port plugin, view its properties, and read from and write to its ports at byte level. The control window of plugins that have a panel can also be displayed.

### 1.1 Main Features

- Search for I/O port plugins in a specified directory.
- Load and replace plugins.
- Display the properties of the loaded plugin.
- Read and write bytes to the plugin's ports.
- Save the plugin's state to a file and load it from a file.
- Display the plugin's own window and modify its window properties.

### 2. System Requirements

The application can be used on FreeBSD, Linux, and Windows operating systems.

## 3. User Interface

### 3.1 Main Window

The main window consists of the following sections:

- **Plugin directory field:** specifies the directory to search.
- **File list:** lists the I/O port plugins found in the directory. The list displays the file name, size, and type.
- **Property list:** displays the data and configuration properties of the loaded plugin.
- **Port table:** displays the plugin's port addresses and their hexadecimal data.
- **Status bar:** displays the load count, the selected file name, and brief feedback about the current operation.

### 3.2 Property List

The property list displays the characteristics of the loaded plugin.

| Property | Description |
|---|---|
| Filename | The file name of the loaded plugin. |
| Modname | The name of the plugin. |
| Description | The plugin description. |
| Int. vector (Hex) | The interrupt vector in hexadecimal format. |
| HasPanel | Indicates whether the plugin has its own window. |
| Enabled | Indicates whether the plugin is enabled. |
| AddressRangeSize | The number of port addresses handled by the plugin. |
| LatchedOutput | Indicates whether the output operates in latched mode. |
| ReadBackOutput | Indicates whether the output can be read back. |
| DataInMode | The mode of the data input lines. |
| DataInNegation | Inversion of the data input lines. |
| DataOutMode | The mode of the data output lines. |
| DataOutNegation | Inversion of the data output lines. |
| SelMode | The mode of the select signal. |
| SelNegation | Inversion of the select signal. |

Configuration values are modified through the plugin's own functionality.

### 3.3 Port Table

The port table displays one row for each port handled. The first column contains the offset relative to the base address (`BA+0`, `BA+1`, ...), while the second column contains the data in hexadecimal format. An 8-bit hexadecimal value between `00` and `FF` can be entered in the data field.

## 4. Using the Application

### 4.1 Selecting the Plugin Directory

1. Select the **Select plugin directory** menu item, or use the browse button next to the directory field.
2. Select the directory containing the plugins.
3. The file list is refreshed and displays the recognized plugin files.

The **Refresh plugin list** command rereads the contents of the current directory.

### 4.2 Loading or Replacing a Plugin

1. Select the required plugin file in the file list.
2. Execute the **Load/change plugin** command.
3. When loading is successful, the property list and port table are populated.
4. If the plugin has its own panel, the application creates and displays it. When a new plugin is loaded, the previously loaded plugin instance and, if present, its own window are freed.

### 4.3 Reading a Port

1. Select the required row in the port table.
2. Select the **Read a Byte** command.
3. The program reads the value of the selected port.
4. The result is displayed in hexadecimal format in the port table; the status bar provides brief feedback.

### 4.4 Writing to a Port

1. Select the required row in the port table.
2. Enter the data in the **Data (Hex)** column.
3. The program performs the write operation when editing the data field is finished.
4. The value must be an 8-bit hexadecimal number (`00`–`FF`).

### 4.5 Saving the Plugin State

1. Select the **Save status** command.
2. Specify the destination file.
3. The program saves the state data provided by the plugin to the selected file.

### 4.6 Loading the Plugin State

1. Select the **Load status** command.
2. Select a previously saved file.
3. The program passes the state data to the plugin and then refreshes the property list.

### 4.7 Managing the Plugin's Own Window

For plugins that have their own window, the following operations are available:

- Display the plugin window.
- Change the window title.
- Set the window size and position.

## 5. Menu Commands

### 5.1 File

- Select plugin directory
- Usual places
- Refresh plugin List
- Load/change plugin
- Restart application
- Exit

The **Usual places** submenu may contain the following paths, if they exist:

- `./`
- `/usr/lib/corelab/`
- `/usr/local/lib/corelab/`
- `./plugins/`
- `~/.local/lib/corelab/`

### 5.2 View

- show plugin window
- set plugin window caption
- set plugin window size/position

### 5.3 I/O Port

- Read a byte
- Write a byte
- Load status
- Save status

### 5.4 Help

- Help
- About

## 6. Settings

The application does not have a general settings dialog.

## 7. Troubleshooting

The program displays error messages in the following cases:

| Error | Possible Cause / Action |
|---|---|
| The specified directory does not exist. | Check the plugin directory path. |
| The plugin cannot be loaded. | Check the file and the error reported by the loader. |
| The file is not a CoreLAB I/O port plugin. | Select a plugin that provides the required I/O port entry points. |
| The help file is missing. | Check that `corelab_<language>.chm` or `corelab_en.chm` is available. |
| The help viewer is missing. | Check that `lhelp` is available to the program. |
| Invalid hexadecimal data. | Only an 8-bit hexadecimal value between `00` and `FF` can be entered. |
| The plugin state cannot be read or written. | Check the selected plugin and the file. |

## 8. Appendix

### 8.1 File Formats

| Extension / Pattern | Purpose |
|---|---|
| `ioport_*.dll` | Windows I/O port plugin. |
| `libioport_*.so` | Linux/Unix I/O port plugin. |
| `*.clpst` | CoreLAB plugin state file. |

### 8.2 Keyboard Shortcuts

| Shortcut | Description |
|:-:|---|
| Ctrl-D | Select plugin directory |
| Ctrl-R | Read byte |
| Ctrl-W | Write byte |

### 8.3 Glossary

- **I/O port:** an input/output address accessible through the plugin.
- **Plugin:** a dynamically loaded module that implements I/O port functionality.
- **BA:** the base address notation used in the port table; rows show offsets relative to it.

### 8.4 Version History

- **v0.1.0:** First version.
