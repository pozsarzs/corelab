{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-other.pas                                                            | }
{ | Other commands                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ CONV PRNT WAIT END EXIT }

RegisterCommand(TCommand.Create('CONV',
                                'Convert number in different numeral systems in-place.',
                                [csScript],
                                'CONV base',
                                1,
                                @CmdCONV,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('PRNT',
                                'Write text to console.',
                                [csScript],
                                'PRNT "text"',
                                1,
                                @CmdPRNT,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('WAIT',
                                'Wait specified ms.',
                                [csScript],
                                'WAIT ms',
                                1,
                                @CmdWAIT,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('END',
                                'End of script.',
                                [csScript],
                                'END',
                                0,
                                @CmdEND,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('EXIT',
                                'Terminate the script.',
                                [csScript],
                                'EXIT',
                                0,
                                @CmdEXIT,
                                True,
                                [omScript]));

