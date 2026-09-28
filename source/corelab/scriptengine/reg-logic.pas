{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-logic.pas                                                            | }
{ | Logic commands                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ AND OR XOR NOT SHL SHR BIT }

RegisterCommand(TCommand.Create('AND',
                                'Bitwise/logical AND in-place.',
                                csScriptOnly,
                                'AND value',
                                1,
                                @CmdAND,
                                True));

RegisterCommand(TCommand.Create('OR',
                                'Bitwise/logical OR in-place.',
                                csScriptOnly,
                                'OR value',
                                1,
                                @CmdOR,
                                True));

RegisterCommand(TCommand.Create('XOR',
                                'Bitwise/logical XOR in-place.',
                                csScriptOnly,
                                'XOR value',
                                1,
                                @CmdXOR,
                                True));

RegisterCommand(TCommand.Create('NOT',
                                'Bitwise/logical NOT in-place.',
                                csScriptOnly,
                                'NOT',
                                0,
                                @CmdNOT,
                                True));

RegisterCommand(TCommand.Create('SHL',
                                'Shift target bits left by count in-place.',
                                csScriptOnly,
                                'SHL count',
                                1,
                                @CmdSHL,
                                True));

RegisterCommand(TCommand.Create('SHR',
                                'Shift target bits right by count in-place.',
                                csScriptOnly,
                                'SHR count',
                                1,
                                @CmdSHR,
                                True));

RegisterCommand(TCommand.Create('BIT',
                                'Check the specified bit.',
                                csScriptOnly,
                                'BIT index',
                                1,
                                @CmdBIT,
                                True));
