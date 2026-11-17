* +----------------------------------------------------------------------------+
* | CoreLAB v0.1 - Modular Processor Simulation Framework                      |
* | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                       |
* | elmanco_4004.asm                                                           |
* | El Manco - assembly for 4004 processor                                     |
* +----------------------------------------------------------------------------+

* Required virtual environment
* ----------------------------
* cpu_4004
* memory_4001rom #0	256 Byte, ChipID: 0
* memory_4001rom #1	256 Byte, ChipID: 1
* memory_4001rom #2	256 Byte, ChipID: 2
* memory_4002ram #0	80 x 4 bit, ChipID: 0
* memory_4002ram #1	80 x 4 bit, ChipID: 1
* memory_4002ram #2	80 x 4 bit, ChipID: 2
* memory_4002ram #3	80 x 4 bit, ChipID: 3
* ioport_button4	connected to ROM #0 I/O port, target port: 0
* - 0:    start game
* - 3:    exit game
* ioport_button4	connected to ROM #1 I/O port, target port: 0
* - 0..3: stop reels
* ioport_disp4hexmuxbcd	connected to RAM #0-1 O port, target port: 0-1
* ioport_ledyellow4	connected to RAM #2 O port, target port: 0-1
* ioport_ledgreen4	connected to RAM #3 O port, target port: 0-1
