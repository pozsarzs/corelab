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
                                csScriptOnly,
                                'CONV base',
                                1,
                                @CmdCONV,
                                True));

RegisterCommand(TCommand.Create('PRNT',
                                'Write text to console.',
                                csScriptOnly,
                                'PRNT "text"',
                                1,
                                @CmdPRNT,
                                True));

RegisterCommand(TCommand.Create('WAIT',
                                'Wait specified ms.',
                                csScriptOnly,
                                'WAIT ms',
                                1,
                                @CmdWAIT,
                                True));

RegisterCommand(TCommand.Create('END',
                                'End of script.',
                                csScriptOnly,
                                'END',
                                0,
                                @CmdEND,
                                True));

RegisterCommand(TCommand.Create('EXIT',
                                'Terminate the script.',
                                csScriptOnly,
                                'EXIT',
                                0,
                                @CmdEXIT,
                                True));

