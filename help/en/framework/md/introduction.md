# CoreLAB - Help

## 1. Introduction

CoreLAB is a Modular Processor Simulation Framework. It provides a comprehensive graphical environment for configuring, testing, and simulating computer architectures using dynamically loadable plugins. Users can load various processor, memory, and I/O port modules, attach them to a simulated system bus, and control the overall execution. The framework allows the hardware configuration to be saved as a project and features a built-in scripting engine for automated testing and operation.

### 1.1 Main Features

- Modular architecture with dynamically loadable processor, memory, and I/O port plugins.
- Two primary operation modes: Interactive mode for manual control and Script mode for automated execution.
- Project management to create, load, and save complete simulation workspaces (`.clprj`).
- Advanced debugging and monitoring tools: Module Explorer, Breakpoint Manager, RegViewer, and HexViewer.
- Integrated logging windows: BusLogger, RunLogger, and IntLogger.
- Built-in Script Editor and Script Console for custom `.clsce` scripts.
- Complete simulation control: run, step, stop, reset modules, and trigger non-maskable interrupts (NMI).
- Ability to load and save memory contents using binary (`.bin`) or Intel HEX (`.hex`) formats.
- Movable, resizable, and renameable interactive panels for supported I/O devices.

## 2. System Requirements

The application can be used on FreeBSD, Linux, and Windows operating systems.
