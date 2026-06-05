> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
>

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="Icon"
  src="desktop/corelab-48.png">

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## I. Introduction and Project Goals

The CoreLAB project is a functional CPU, microprocessor, and microcontroller
simulator born from a fusion of academic research, technical passion, and
historical preservation. The project was initiated with several key objectives
in mind:

* **A Tribute to the Pioneers (Hardware and Human):** The project serves as a
    respectful nod to the early eras of computing architecture and the brilliant
    minds who designed them. By keeping the logic of these foundational
    processors alive, it preserves the digital heritage that paved the way for
    modern computing.
* **Learning Machine Code Programming:** It provides an accessible, hands-on
    educational platform to study low-level programming on classic architectures
    (such as the i40xx, i80xx, or TMS1000). Many of these physical chips are now
    rare, expensive, or completely obsolete, making software simulation the only
    viable way to experience them.
* **Academic Research (University Thesis):** The development of this simulator
    and its modular plugin system forms the core framework of my university
    thesis, exploring dynamic software architectures and instructional simulation
    methodologies.
* **Functional Execution over Full Emulation:** Unlike comprehensive emulators,
    the goal of CoreLAB is **not** to replicate entire vintage computer systems,
    run historical operating systems, or simulate cycle-accurate hardware quirks.
    Instead, it focuses strictly on the clean, functional execution of
    instructions, making the code's logic transparent and easy to analyze.
* **A Playground for System Design and Modeling:**  Beyond a simple educational
    tool, the project serves as a practical application of advanced system
    design and hardware modeling concepts. It provides a platform to explore
    how complex, real-world physical systems - such as buses, registers, memory
    layouts, and I/O lines—can be accurately modeled, decoupled, and reconfigured
    dynamically in software using modern software engineering patterns.
* **Bridging Vintage Logic with Modern Automation:** A key innovation of the
    project is wrapping these classic CPU architectures into a modern, scriptable
    environment. By allowing users to dynamically build topologies, manipulate
    registers, and automate tests via a command-line shell, it applies modern
    DevOps and debugging workflows to the foundational hardware of the past.

## II. Features

|Features                  |Specification / Description                                                      |
|--------------------------|---------------------------------------------------------------------------------|
|**Project Type**          |Functional CPU/uP/MCU simulator                                                  |
|**actual version**        |v0.1                                                                             |
|**licence**               |EUPL v1.2                                                                        |
|**language**              |en                                                                               |
|**architecture**          |amd64, armhf, x86_64                                                             |
|**operation system**      |FreeBSD, Linux, Windows                                                          |
|**user interface**        |Graphical User Interface (GUI) with scriptable command-line control              |
|**running modes**         |Normal or interpreter                                                            |
|**Simulation Type**       |Instruction-level operation (not cycle-accurate)                                 |
|**Supported Architecture**|Neumann and Harvard architectures                                                |
|**Supported Processors**  |Word-based CPUs up to 64-bit, 4–16 bit uPs and 4–8 bit, simple MCUs              |
|**Simulation Environment**|Configurable memory space and virtual I/O ports                                  |
|**Peripherals**           |Simple, built-in virtual peripherals                                             |
|**Modular Architecture**  |Dynamically loadable CPUs, peripherals, and devices                              |
|**RunLogger**             |Real-time output of address, machine code, and mnemonic                          |
|**Dump**                  |Displaying memory and register contents, with export to binary or Intel HEX files|
|**Logging**               |Runtime log exportable to file                                                   |
|**Debug Features**        |Breakpoints, memory monitoring, single-stepping, and commentable memory addresses|
|**Program Loading**       |Via keyboard entry, virtual system monitor, or from binary/Intel HEX files       |
|**State Saving**          |Saving and restoring CPU and full environment state                              |

## III. Screenshots

(...)

## IV. Used external libraries and programs

 - _Convert - Bin/Oct/Dec/Hex number converter_  
   Unit for Turbo Pascal v3.0  
   Public Domain, Copyright (C) 1993 Tom Wellige  
 - _LHelp v2021-02-12 CHM help viewer_  
   Application  
   GNU GPL v2.0 or later, Copyright (C) 2005-2014 Andrew Haines, Lazarus contributors  

## V. About the program

### Projects  

In the program, you can create projects for easier management of settings and
data. The name of the current project is shown in the prompt. The project
directory will be created in the user's home directory. If only filename is
specified during file operations (without path), this directory will be the
source/destination directory.

### ???

(...)

## VI. Implemented commands  

|command  |category           |description                                             |
|--------:|:-----------------:|:-------------------------------------------------------|
|`abs`    |Arithmetic         |Calculate absolute value                                |
|`add`    |Arithmetic         |Perform addition                                        |
|`and`    |Logic              |Bitwise / Logical AND operation                         |
|`attach` |Object Management  |Connect a hardware module to a bus or CPU               |
|`cls`    |Environment Control|Clear the command line screen                           |
|`conv`   |Arithmetic         |Convert numbers between BIN, DEC, HEX, and OCT formats  |
|`create` |Object Management  |Instantiate a hardware module, variable, or array       |
|`dec`    |Arithmetic         |Decrement an integer value                              |
|`destroy`|Object Management  |Delete an object and free its memory                    |
|`detach` |Object Management  |Disconnect a module from the bus                        |
|`div`    |Arithmetic         |Perform floating-point division                         |
|`dump`   |Diagnostics        |Print raw internal content (registers, memory bytes)    |
|`exit`   |Environment Control|Terminate the shell or simulation environment           |
|`for`    |Program Flow       |Loop iteration statement                                |
|`goto`   |Program Flow       |Jump to a defined label                                 |
|`idiv`   |Arithmetic         |Perform integer division                                |
|`if`     |Program Flow       |Conditional branch statement                            |
|`imod`   |Arithmetic         |Calculate modulus (remainder of integer division)       |
|`inc`    |Arithmetic         |Increment an integer value                              |
|`info`   |Diagnostics        |Display metadata and general status of an object        |
|`input`  |Diagnostics        |Read user input into a variable                         |
|`inrange`|Logic              |Check if a value falls within a specified range         |
|`label`  |Program Flow       |Define a target marker for goto commands                |
|`let`    |Data Management    |Assign a value to a variable, array element, or register|
|`load`   |File I/O           |Load a project, script, or memory image from file       |
|`mul`    |Arithmetic         |Perform multiplication                                  |
|`not`    |Logic              |Bitwise / Logical NOT operation                         |
|`or`     |Logic              |Bitwise / Logical OR operation                          |
|`pause`  |Simulation         |Pause execution for debugging or timing simulation      |
|`print`  |Diagnostics        |Output a message or value to the console                |
|`reset`  |Environment Control|Reset an object to its default initial state            |
|`rnd`    |Arithmetic         |Generate a random integer                               |
|`run`    |Simulation         |Start the execution of the loaded script or simulation  |
|`save`   |File I/O           |Save the current project or script to disk              |
|`shl`    |Logic              |Bitwise / Logical bit shift to the left                 |
|`show`   |Object Management  |List all existing objects and the current topology      |
|`shr`    |Logic              |Bitwise / Logical bit shift to the right                |
|`sub`    |Arithmetic         |Perform subtraction                                     |
|`swp`    |Data Management    |Swap the values of two targets                          |
|`ver`    |Environment Control|Display version and build information                   |
|`xor`    |Logic              |Bitwise / Logical XOR operation                         |

## VII. Predefined constants  

|name    |value                                                     |
|:-------|:---------------------------------------------------------|
|$?      |exit value of the commands                                |
|$ARGx   |OS command line arguments (interpreter mode)              |
|$ARGCNT |number of the OS command line arguments (interpreter mode)|
|$HOME   |user's home directory                                     |
|$PRJDIR |directory of the actual project                           |
|$PRJNAME|name of the actual project                                |

## VIII. Documentation and Help  

CoreLAB features built-in help and comprehensive documentation, accessible
through the following channels:

- Command-line assistance: Type the help command in the terminal to directly
  access usage guides and command references.
- Graphical Help: Under the Help menu in the graphical interface, you can find
  visual guides regarding the software's operation and supported CPU
  architectures.
- Source code documentation: Detailed developer assistance and documentation
  for the source code are available in the document folder.
- Additionally, you can view the manual page from *nix shell (_man modshell_) or
  _modshell.txt_ on other systems.  

## IX. Contributing  

If you find any bugs, please report them! I am also happy to accept pull
requests from anyone. You can use the GitHub issue tracker to report bugs, ask
questions, or suggest new features. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
for details.  

## X. Links  

 - [Homepage] https://www.pozsarzs.hu/60_myprogcom/corelab/  
 - [GitHub repository](https://github.com/pozsarzs/corelab)  
 - [Project webpage on Github](https://pozsarzs.github.io/corelab)  

### Source packages  

|name                                                                                 |version|
|-------------------------------------------------------------------------------------|:-----:|
|[main.zip](https://github.com/pozsarzs/corelab/archive/refs/heads/main.zip)          |latest |
|[corelab-0.1.tar.gz](https://www.pozsarzs.hu/60_myprogcom/package/corelab-0.1.tar.gz)|v0.1   |

### Binaries and installer packages for several OS and architecture

Not all test versions have binary or installation packages.
To download, visit [CoreLAB's webpage](https://www.pozsarzs.hu/60_myprogcom/corelab/).
