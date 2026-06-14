## I/O plugins

|name                   |dir|GUI|description                                                |
|-----------------------|---|---|-----------------------------------------------------------|
|ioport_null            |I/O| - |NULL port                                                  |
|ioport_standard        |I/O| + |standard port                                              |
|                       |   |   |                                                           |
|ioport_bell            | O | - |BELL device                                                |
|                       |   |   |                                                           |
|ioport_realcom         |I/O| - |redirect to real COM port                                  |
|ioport_realprn         | O | - |redirect to real PRN port                                  |
|ioport_realraw         |I/O| - |redirect to real I/O port                                  |
|                       |   |   |                                                           |
|ioport_terminal        |I/O| + |minimal text terminal                                      |
|                       |   |   |                                                           |
|ioport_button8         | I | + |8-button input                                             |
|ioport_button16hexbcd  | I | + |4x4 button matrix with BCD output                          |
|ioport_button16matrix  | I | + |4x4 button matrix                                          |
|ioport_button64matrix  | I | + |8x8 button matrix                                          |
|ioport_buttonmatrix    | I | + |resizable button matrix                                    |
|                       |   |   |                                                           |
|ioport_switch8         | I | + |8-switch input                                             |
|ioport_switch16hexbcd  | I | + |4x4 switch matrix with BCD output                          |
|ioport_switch16matrix  | I | + |4x4 switch matrix                                          |
|ioport_switch64matrix  | I | + |8x8 switch matrix                                          |
|ioport_switchmatrix    | I | + |resizable switch matrix                                    |
|                       |   |   |                                                           |
|ioport_led8            | O | + |8 pcs. LED                                                 |
|ioport_led64matrix     | O | + |8x8 LED matrix                                             |
|ioport_ledmatrix       | O | + |resizable LED matrix                                       |
|                       |   |   |                                                           |
|ioport_disp17seg       | O | + |1 pc. 7 segments display with segment input                |
|ioport_disp27segmux    | O | + |2 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp47segmux    | O | + |4 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp87segmux    | O | + |8 pcs. multiplexed 7 segments display with segment input   |
|                       |   |   |                                                           |
|ioport_disp17segbcd    | O | + |1 pc. 7 segments display with BCD input                    |
|ioport_disp27segmuxbcd | O | + |2 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp47segmuxbcd | O | + |4 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp87segmuxbcd | O | + |8 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp27segmuxdbcd| O | + |2 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp47segmuxdbcd| O | + |4 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp87segmuxdbcd| O | + |8 pcs. multiplexed 7 segments display with double BCD input|
|                       |   |   |                                                           |
|ioport_disp1hexbcd     | O | + |1 pc. hexa display with BCD input                          |
|ioport_disp2hexmuxbcd  | O | + |2 pcs. multiplexed hexa display with BCD input             |
|ioport_disp4hexmuxbcd  | O | + |4 pcs. multiplexed hexa display with BCD input             |
|ioport_disp8hexmuxbcd  | O | + |8 pcs. multiplexed hexa display with BCD input             |
|ioport_disp2hexmuxdbcd | O | + |2 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp4hexmuxdbcd | O | + |4 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp8hexmuxdbcd | O | + |8 pcs. multiplexed hexa display with double BCD input      |
