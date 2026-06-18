# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPorts implementations

### Exported functions

|name           |exported name           |note|
|---------------|------------------------|----|
|CreatePort     |_ioport_create_         |    |
|DestroyPort    |_ioport_destroy_        |    |
|CreatePanel    |_ioport_createpanel_    |*   |
|FreePanel      |_ioport_freepanel_      |*   |
|HidePanel      |_ioport_hidepanel_      |*   |
|SetSizePosPanel|_ioport_setsizepospanel_|*   |
|ShowPanel      |_ioport_showpanel_      |*   |

**Note:** Items marked with an asterisk are only available in the visual component.  

### Libraries (.so/.dll)

|name                    |dir|GUI|description                                                |
|------------------------|---|---|-----------------------------------------------------------|
|ioport_null             |I/O| - |NULL port                                                  |
|ioport_standard         |I/O| + |standard port                                              |
|ioport_bell             | O | - |BELL device                                                |
|ioport_realcom          |I/O| - |redirect to real COM port                                  |
|ioport_realprn          | O | - |redirect to real PRN port                                  |
|ioport_realraw          |I/O| - |redirect to real I/O port                                  |
|ioport_terminal         |I/O| + |minimal text terminal                                      |
|ioport_button8          | I | + |8-button input                                             |
|ioport_button16hexbcd   | I | + |4x4 button matrix with BCD output                          |
|ioport_button16mtxbinsel| I | + |4x4 button matrix with binary select                       |
|ioport_button16mtx      | I | + |4x4 button matrix with bit select                          |
|ioport_button8          | I | + |8-button input                                             |
|ioport_button16hexbcd   | I | + |4x4 button matrix with BCD output                          |
|ioport_button16mtxbinsel| I | + |4x4 button matrix with binary select                       |
|ioport_button16mtx      | I | + |4x4 button matrix with bit select                          |
|ioport_led8             | O | + |8 pcs. LED                                                 |
|ioport_led16matrix      | O | + |4x4 LED matrix                                             |
|ioport_led64matrix      | O | + |8x8 LED matrix                                             |
|ioport_disp17seg        | O | + |1 pc. 7 segments display with segment input                |
|ioport_disp27segmux     | O | + |2 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp47segmux     | O | + |4 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp87segmux     | O | + |8 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp17segbcd     | O | + |1 pc. 7 segments display with BCD input                    |
|ioport_disp27segmuxbcd  | O | + |2 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp47segmuxbcd  | O | + |4 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp87segmuxbcd  | O | + |8 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp27segmuxdbcd | O | + |2 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp47segmuxdbcd | O | + |4 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp87segmuxdbcd | O | + |8 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp1hexbcd      | O | + |1 pc. hexa display with BCD input                          |
|ioport_disp2hexmuxbcd   | O | + |2 pcs. multiplexed hexa display with BCD input             |
|ioport_disp4hexmuxbcd   | O | + |4 pcs. multiplexed hexa display with BCD input             |
|ioport_disp8hexmuxbcd   | O | + |8 pcs. multiplexed hexa display with BCD input             |
|ioport_disp2hexmuxdbcd  | O | + |2 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp4hexmuxdbcd  | O | + |4 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp8hexmuxdbcd  | O | + |8 pcs. multiplexed hexa display with double BCD input      |
