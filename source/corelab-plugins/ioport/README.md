## I/O plugins

|name                    |dir|GUI|description                                                |
|------------------------|---|---|-----------------------------------------------------------|
|ioport_null             |I/O| - |NULL port                                                  |
|ioport_standard         |I/O| + |standard port                                              |
|                        |   |   |                                                           |
|ioport_bell             | O | - |BELL device                                                |
|                        |   |   |                                                           |
|ioport_realcom          |I/O| - |redirect to real COM port                                  |
|ioport_realprn          | O | - |redirect to real PRN port                                  |
|ioport_realraw          |I/O| - |redirect to real I/O port                                  |
|                        |   |   |                                                           |
|ioport_terminal         |I/O| + |minimal text terminal                                      |
|                        |   |   |                                                           |
|ioport_button8          | I | + |8-button input                                             |
|ioport_button16_hexbcd  | I | + |4x4 button matrix with BCD output                          |
|ioport_button16_matrix  | I | + |4x4 button matrix                                          |
|ioport_button64_matrix  | I | + |8x8 button matrix                                          |
|ioport_button_matrix    | I | + |resizable button matrix                                    |
|                        |   |   |                                                           |
|ioport_switch8          | I | + |8-switch input                                             |
|ioport_switch64_matrix  | I | + |8x8 switch matrix                                          |
|ioport_switch_matrix    | I | + |resizable switch matrix                                    |
|                        |   |   |                                                           |
|ioport_led8             | O | + |8 pcs. LED                                                 |
|ioport_led64_matrix     | O | + |8x8 LED matrix                                             |
|ioport_led_matrix       | O | + |resizable LED matrix                                       |
|                        |   |   |                                                           |
|ioport_disp1_7seg       | O | + |1 pc. 7 segments display with segment input                |
|ioport_disp2_7segmux    | O | + |2 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp4_7segmux    | O | + |4 pcs. multiplexed 7 segments display with segment input   |
|ioport_disp8_7segmux    | O | + |8 pcs. multiplexed 7 segments display with segment input   |
|                        |   |   |                                                           |
|ioport_disp1_7segbcd    | O | + |1 pc. 7 segments display with BCD input                    |
|ioport_disp2_7segmuxbcd | O | + |2 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp4_7segmuxbcd | O | + |4 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp8_7segmuxbcd | O | + |8 pcs. multiplexed 7 segments display with BCD input       |
|ioport_disp2_7segmuxdbcd| O | + |2 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp4_7segmuxdbcd| O | + |4 pcs. multiplexed 7 segments display with double BCD input|
|ioport_disp8_7segmuxdbcd| O | + |8 pcs. multiplexed 7 segments display with double BCD input|
|                        |   |   |                                                           |
|ioport_disp1_hexbcd     | O | + |1 pc. hexa display with BCD input                          |
|ioport_disp2_hexmuxbcd  | O | + |2 pcs. multiplexed hexa display with BCD input             |
|ioport_disp4_hexmuxbcd  | O | + |4 pcs. multiplexed hexa display with BCD input             |
|ioport_disp8_hexmuxbcd  | O | + |8 pcs. multiplexed hexa display with BCD input             |
|ioport_disp2_hexmuxdbcd | O | + |2 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp4_hexmuxdbcd | O | + |4 pcs. multiplexed hexa display with double BCD input      |
|ioport_disp8_hexmuxdbcd | O | + |8 pcs. multiplexed hexa display with double BCD input      |
