# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPort implementations

This document summarizes concrete I/O port and device and application (single
port buttons, switches, LEDs and displays, terminal) implementations based on the
TIOPort abstract base class, and shows how to export modules as dynamic link
libraries (DLL/SO).

### Exported functions and procedures

|name                                                           |exported name           |description             |call |
|---------------------------------------------------------------|------------------------|------------------------|-----|
|`function CreatePort: TIOPort;`                                |_ioport_create_         |Create TIOPort instance |cdecl|
|`procedure CreatePanel(Port: TIOPort);`                        |_ioport_createpanel_    |Create UI panel         |cdecl|
|`procedure DestroyPort(Port: TIOPort);`                        |_ioport_destroy_        |Destroy TIOPort instance|cdecl|
|`procedure FreePanel;`                                         |_ioport_freepanel_      |Destroy UI panel        |cdecl|
|`procedure HidePanel;`                                         |_ioport_hidepanel_      |Hide UI panel           |cdecl|
|`procedure SetSizePosPanel(Left, Top, Width, Height: Integer);`|_ioport_setsizepospanel_|Move and resize UI panel|cdecl|
|`procedure ShowPanel;`                                         |_ioport_showpanel_      |Show UI panel           |cdecl|

### Libraries (.so/.dll) with available features

|name               | class       |dir|GUI|p01234|m012|e0123456|description                                                    |
|-------------------|-------------|---|---|-----:|---:|-------:|---------------------------------------------------------------|
|ioport_null        |TNULLPort    |I/O| - | +++++| +++| ++-----|NULL port                                                      |
|ioport_standard    |TStandardPort|I/O| + | +++++| +++| +++++++|standard port                                                  |
|ioport_bell        |TBELLPort    | O | - | +++++| +++| ++-----|BELL device                                                    |
|ioport_realcom     |TRealCOM     |I/O| - | +++++| +++| ++-----|redirect to real COM port                                      |
|ioport_realprn     |TRealPRN     | O | - | +++++| +++| ++-----|redirect to real PRN port                                      |
|ioport_realraw     |TRealRaw     |I/O| - | +++++| +++| ++-----|redirect to real I/O port                                      |
|ioport_terminal    |TMiniTerminal|I/O| + | +++++| +++| +++++++|minimal text terminal                                          |
|ioport_button8     |TButton8     | I | + | +++++| +++| +++++++|8-button input                                                 |
|ioport_button16bcd |TButton16BCD | I | + | +++++| +++| +++++++|4x4 button matrix with BCD output                              |
|ioport_button16mux |TButton16Mux | I | + | +++++| +++| +++++++|4x4 button matrix                                              |
|ioport_switch8     |TSwitch8     | I | + | +++++| +++| +++++++|8-switch input                                                 |
|ioport_switch16bcd |TSwitch16BCD | I | + | +++++| +++| +++++++|4x4 switch matrix                                              |
|ioport_switch16mux |TSwitch16Mux | I | + | +++++| +++| +++++++|4x4 switch matrix with BCD output                              |
|ioport_led8        |TLED8        | O | + | +++++| +++| +++++++|8 LED with direct and BCD input                                |
|ioport_led16matrix |TLED16Matrix | O | + | +++++| +++| +++++++|4x4 LED matrix with direct and BCD input                       |
|ioport_led64matrix |TLED64Matrix | O | + | +++++| +++| +++++++|8x8 LED matrix with direct and BCD input                       |
|ioport_disp17seg   |TDisp17seg   | O | + | +++++| +++| +++++++|1-digit 7-segment display with direct and BCD input            |
|ioport_disp27segmux|TDisp27segMux| O | + | +++++| +++| +++++++|2-digit multiplexed 7-segment display with direct and BCD input|
|ioport_disp47segmux|TDisp47segMux| O | + | +++++| +++| +++++++|4-digit multiplexed 7-segment display with direct and BCD input|
|ioport_disp87segmux|TDisp87segMux| O | + | +++++| +++| +++++++|8-digit multiplexed 7-segment display with direct and BCD input|
|ioport_disp1hex    |TDisp1Hex    | O | + | +++++| +++| +++++++|1-digit hexadecimal display with BCD input                     |
|ioport_disp2hexmux |TDisp2HexMux | O | + | +++++| +++| +++++++|2-digit multiplexed hexadecimal display with BCD input         |
|ioport_disp4hexmux |TDisp4HexMux | O | + | +++++| +++| +++++++|4-digit multiplexed hexadecimal display with BCD input         |
|ioport_disp8hexmux |TDisp8HexMux | O | + | +++++| +++| +++++++|8-digit multiplexed hexadecimal display with BCD input         |

**Note**:  

|col|type    |name            |
|--:|--------|----------------|
|p0 |property|AddressRangeSize|
|1  |property|Description     |
|2  |property|Enabled         |
|3  |property|ModName         |
|4  |property|PortMode        |
|m0 |method  |ReadPort        |
|1  |method  |Reset           |
|2  |method  |WritePort       |
|e0 |export  |CreatePort      |
|1  |export  |DestroyPort     |
|2  |export  |CreatePanel     |
|3  |export  |FreePanel       |
|4  |export  |HidePanel       |
|5  |export  |SetSizePosPanel |
|6  |export  |ShowPanel       |
