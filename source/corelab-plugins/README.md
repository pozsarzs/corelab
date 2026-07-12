# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Plugins

|filename                 |base, parent      |class           |description            |
|-------------------------|------------------|----------------|-----------------------|
|cpu_8080.pas             |TCPU              |T8080CPU        |Virtual Intel 8080 uP  |
|ioport_bell.pas          |TIOPort           |TBELLPort       |System bell device     |
|ioport_null.pas          |TGIOPort          |TNULLPort       |NULL device            |
|ioport_standard.pas      |TGIOPort          |TStandardPort   |Standard I/O port      |
|ioport_button8.pas       |TGIOPort          |TButton8Port    |8-button device        |
|ioport_button16bcd.pas   |TGIOPort          |TButton16BCDPort|1 from 16 button device|
|ioport_button16mux.pas   |TGIOPort          |TButton16MUXPort|16-button device       |
|ioport_switch8.pas       |TGIOPort          |TSwitch8Port    |8-switch device        |
|ioport_switch16bcd.pas   |TGIOPort          |TSwitch16BCDPort|1 from 16 switch device|
|ioport_switch16mux.pas   |TGIOPort          |TSwitch16MUXPort|16-switch device       |
|ioport_disp17seg.pas     |TGIOPort, TDisplay|TDisp17seg      |1-digit 7s display     |
|ioport_disp27segmux.pas  |TGIOPort, TDisplay|TDisp27segMUX   |2-digit 7s display     |
|ioport_disp47segmux.pas  |TGIOPort, TDisplay|TDisp47segMUX   |4-digit 7s display     |
|ioport_disp87segmux.pas  |TGIOPort, TDisplay|TDisp87segMUX   |8-digit 7s display     |
|ioport_disp1hexbcd.pas   |TGIOPort, TDisplay|TDisp1HexBCD    |1-digit hexa display   |
|ioport_disp2hexmuxbcd.pas|TGIOPort, TDisplay|TDisp2HexMUXBCD |2-digit hexa display   |
|ioport_disp4hexmuxbcd.pas|TGIOPort, TDisplay|TDisp4HexMUXBCD |4-digit hexa display   |
|ioport_disp8hexmuxbcd.pas|TGIOPort, TDisplay|TDisp8HexMUXBCD |8-digit hexa display   |
|memory_standard.pas      |TMemory           |TStandardMemory |standard RAM/ROM       |
