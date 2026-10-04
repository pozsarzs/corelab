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
                                [csScript],
                                'AND value',
                                1,
                                @CmdAND,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('OR',
                                'Bitwise/logical OR in-place.',
                                [csScript],
                                'OR value',
                                1,
                                @CmdOR,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('XOR',
                                'Bitwise/logical XOR in-place.',
                                [csScript],
                                'XOR value',
                                1,
                                @CmdXOR,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('NOT',
                                'Bitwise/logical NOT in-place.',
                                [csScript],
                                'NOT',
                                0,
                                @CmdNOT,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('SHL',
                                'Shift target bits left by count in-place.',
                                [csScript],
                                'SHL count',
                                1,
                                @CmdSHL,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('SHR',
                                'Shift target bits right by count in-place.',
                                [csScript],
                                'SHR count',
                                1,
                                @CmdSHR,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('BIT',
                                'Check the specified bit.',
                                [csScript],
                                'BIT index',
                                1,
                                @CmdBIT,
                                True,
                                [omScript]));

