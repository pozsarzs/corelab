# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## IODemo8080 example program

How to works program:  
* It initializes the stack pointer and enables interrupts.
* It prints a welcome message to the console.
* It runs a continuous loop polling the console port (80h). If the 'q' character
  is received, it halts the CPU.
* It handles two hardware interrupts:
* **RST 1 (Keyboard):** Reads input from port 81h, outputs it to the display
  port (90h), and prints a notification.
* **RST 2 (Console):** Reads input from port 80h and prints a notification.

How to works control script:  
* Opens the internal logger windows (RunLogger, IntLogger).
* Creates, configures, and attaches I/O modules to the system bus: a console on port 80, a keyboard on port 81, and a display on port 90.
* Sets the interrupt vectors (note: the keyboard's 08 interrupt is accidentally assigned to the console due to a typo: `CFIO Console.IntVector 08`).
* Creates a 1024-byte RAM module at address 0, loads the `demo8080.hex` program, and attaches it to the bus.
* Creates and attaches an 8080 processor module.
* Enables all modules and starts the simulation.
* Disables, detaches, and destroys the modules after the execution finishes.
