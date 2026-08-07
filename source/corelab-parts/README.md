# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Virtual electronic parts

|filename          |base    |class         |description                                            |
|------------------|--------|--------------|-------------------------------------------------------|
|bcd7seg_7447.pas  |        |              |BCD to 7-segment decoding table with SN7447N-type signs|
|display_til302.pas|TDisplay|TDisplayTIL302|TIL302 display implementation                          |
|display_til311.pas|TDisplay|TDisplayTIL311|TIL311 display implementation                          |
|led_round.pas     |TLED    |TLEDRound     |Round LED implementation                               |
|led_square.pas    |TLED    |TLEDSquare    |Square LED implementation                              |

## Application examples

|filename             |description                                                  |
|---------------------|-------------------------------------------------------------|
|clock_til302.tar.gz  |Clock with virtual 7-segment TIL302 display and 7447 decoder |
|clock_til311.tar.gz  |Clock with virtual hexadecimal TIL311 display                |
|test_til302.tar.gz   |Test application with virtual TIL302 display and 7447 decoder|
|test_til311.tar.gz   |Test application with virtual hexadecimal TIL311 display     |
|test_roundled.tar.gz |Test application with a blinking LED                         |
|test_squareled.tar.gz|Test application with a blinking LED                         |



