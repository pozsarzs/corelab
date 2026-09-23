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
