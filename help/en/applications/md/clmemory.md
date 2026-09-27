# CLMemory – Help

## 1. Introduction

CLMemory is a graphical application for testing memory plugins in the CoreLAB framework. It allows you to load a memory plugin, view and modify some of its properties, and read from and write to memory locations. The plugin's state can be saved to a file and loaded from a file.

### 1.1 Main Features

- Search for memory plugins in a specified directory.
- Load and replace plugins.
- Display the properties of the loaded plugin.
- Set the memory size, enabled state, and memory mode.
- Read a byte from a memory address.
- Write a byte to a memory address.
- Save and load the plugin's state.

### 2. System Requirements

The application can be used on FreeBSD, Linux, and Windows operating systems.

## 3. User Interface

### 3.1 Main Window

The main window consists of the following sections:

- **Plugin directory field:** specifies the directory containing memory plugins.
- **File list:** lists the memory plugins found in the directory. The list displays the file name, size, and type.
- **Property list:** displays the data and configurable properties of the loaded plugin.
- **Memory table:** used to enter and display the memory address being examined and the hexadecimal value of the data.
- **Status bar:** displays the load count, the selected file name, and brief feedback about operations.

### 3.2 Property List

The property list displays the data and configuration values of the loaded plugin.

| Property | Description |
|---|---|
| Filename | The file name of the loaded plugin. |
| Modname | The name of the plugin. |
| Description | The plugin description. |
| Enabled | Indicates whether the memory plugin is enabled. |
| MemoryMode | The memory operating mode. |
| AddressRangeSize | The size of the memory address range. |

The value of `AddressRangeSize` can be between 16 bytes and 16 MB.

### 3.3 Memory Table

The memory table handles two values:

- **Address:** the memory address to be examined, in hexadecimal format.
- **Data:** the byte value at the memory address, in hexadecimal format.

An 8-bit value can be entered in the data field. Both the address and the data use hexadecimal format.

## 4. Using the Application

### 4.1 Selecting the Plugin Directory

1. Select the **Select plugin directory** command, or use the browse button next to the directory field.
2. Select the directory containing the memory plugins.
3. The file list is refreshed and displays the recognized plugin files.

The **Refresh plugin list** command rereads the contents of the current directory.

### 4.2 Loading or Replacing a Plugin

1. Select the required plugin file in the file list.
2. Execute the **Load/change plugin** command.
3. When loading is successful, the property list is refreshed, and the fields and operations used to examine memory become enabled.

When a new plugin is loaded, the previous instance is freed.

### 4.3 Reading Memory

1. Enter the address in hexadecimal format in the **Address** field.
2. Select the **Read a byte** command.
3. The program reads the contents of the specified address.
4. The byte read is displayed in the **Data** field.

If the address is outside the memory address range, the status bar displays a warning.

### 4.4 Writing to Memory

1. Enter the address in the **Address** field.
2. Enter the byte value to be written in the **Data** field.
3. Select the **Write a byte** command.
4. The program calls the plugin's write operation and then displays feedback in the status bar.

The program indicates if the address is outside the address range or if the memory is in ROM mode.

### 4.5 Loading the Plugin State

1. Select the **Load status** command.
2. Select a previously saved file.
3. The program passes the state data to the plugin.
4. After a successful load, the property list is refreshed.

### 4.6 Saving the Plugin State

1. Select the **Save status** command.
2. Specify the destination file.
3. The program retrieves the plugin's state data and saves it to the selected file.

## 5. Menu Commands

### 5.1 File

- Select plugin directory
- Usual places
- Refresh plugin list
- Load/change plugin
- Restart application
- Exit

According to the source, the **Usual places** submenu may contain the following paths, if they exist:

- `./`
- `/usr/lib/corelab/`
- `/usr/local/lib/corelab/`
- `./plugins/`
- `~/.local/lib/corelab/`

### 5.2 Memory

- Examine (Read one byte from the specified memory address.)
- Deposit (Write one byte to the specified memory address.)
- Load status
- Save status

### 5.3 Help

- Help
- About

## 6. Settings

The application does not have a general settings dialog.

## 7. Troubleshooting

| Error | Possible Cause / Action |
|---|---|
| The specified directory does not exist. | Check the plugin directory path. |
| The plugin cannot be loaded. | Check the file and the error reported by the loader. |
| The file is not a CoreLAB memory plugin. | Select a plugin that provides the required memory entry points. |
| Invalid hexadecimal data. | Only hexadecimal values can be entered. |
| The specified memory size is outside the permitted range. | The memory size must be between 16 bytes and 16 MiB. |
| The address is outside the address range. | Check the specified address and the memory size. |
| The memory is read-only. | In ROM mode, writing does not modify the memory. |
| The help file or help viewer is missing. | Check that the help file and `lhelp` are available. |
| The plugin state cannot be read or written. | Check the selected plugin and the file. |

## 8. Appendix

### 8.1 File Formats

| Extension / Pattern | Purpose |
|---|---|
| `memory_*.dll` | Windows memory plugin. |
| `libmemory_*.so` | Linux/Unix memory plugin. |
| `*.clpst` | CoreLAB plugin state file. |

### 8.2 Keyboard Shortcuts

| Shortcut | Description |
|:-:|---|
| Ctrl-D | Select plugin directory |
| Ctrl-E | Read a byte |
| Ctrl-P | Write a byte |

### 8.3 Glossary

- **Memory plugin:** a dynamically loaded module that implements memory operations.
- **AddressRangeSize:** the size of the range of memory addresses handled by the plugin.
- **MemoryMode:** the memory operating mode, such as ROM or RAM, depending on the modes supported by the plugin.
- **State file:** a `.clpst` file used to save and restore the plugin's state.

### 8.4 Version History

- **v0.1.0:** First version.
