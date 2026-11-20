CoreLAB is also a functional 8-bit microprocessor and microcontroller simulator.
It is not a traditional closed emulator, but a  scriptable environment for
studying the operation and low-level programming of classic architectures.

Don't expect miracles from it, though—it is not suited for running large programs.
Its purpose is learning: executing your own short programs slowly or step by step,
while observing data flow and internal events.

Programs can only be written in machine code, where - if nothing else is
available - _you are the assembler_ yourself.

**Key features:**

* **Modular architecture:** Build a custom virtual hardware environment with
  dynamically loadable CPUs, memories, and peripherals.
* **Custom module development:** Write a custom processor or device module, or
  even a completely custom virtual CPU. You can use any programming language
  capable of creating `.so` or `.dll` files.
* **Modern automation:** Control the simulation from the command line, write
  tests, and automate using the built-in scripting language.
* **Built-in diagnostics:** Real-time register and memory inspection,
  step-by-step execution, and bus logging.

**Supported processors:** 

* Intel 4004 Harvard architecture 4 bit microprocessor (1971) - [opcode pages](opcode-pages/cpu_4004.pdf).
* Intel 4040 Harvard architecture 4 bit microprocessor (1974) - [opcode pages](opcode-pages/cpu_4040.pdf).
* Intel 8008 Neumann architecture 8 bit microprocessor (1972) - [opcode pages](opcode-pages/cpu_8008.pdf).
* Intel 8080 Neumann architecture 8 bit microprocessor (1974) - [opcode pages](opcode-pages/cpu_8080.pdf).
* Intel 8085 Neumann architecture 8 bit microprocessor (1976) - [opcode pages](opcode-pages/cpu_8085.pdf).
* Zilog Z80 Neumann architecture 8 bit microprocessor (1976) - [opcode pages](opcode-pages/cpu_z80.pdf){:target="_blank"}.

![CoreLAB](corelab.png)

The full documentation, module descriptions, and source code are available on
the project's [GitHub page](https://github.com/pozsarzs/corelab).

Download the latest pre-compiled binaries and installers:
[GitHub Releases](https://github.com/pozsarzs/corelab/releases).

Copyright (C) 2026 Zsolt Pozsár - License: EUPL v1.2
