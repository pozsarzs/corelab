{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-arithmetic.pas                                                       | }
{ | Arithmetic commands                                                      | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ ADD SUB MUL INC DEC }

RegisterCommand(TCommand.Create('ADD',
                                'Add value to target in-place.',
                                [csScript],
                                'ADD value',
                                1,
                                @CmdADD,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('SUB',
                                'Subtract value from target in-place.',
                                [csScript],
                                'SUB value',
                                1,
                                @CmdSUB,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('MUL',
                                'Multiply target by value in-place.',
                                [csScript],
                                'MUL value',
                                1,
                                @CmdMUL,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('INC',
                                'Increment integer target by 1 in-place.',
                                [csScript],
                                'INC',
                                0,
                                @CmdINC,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('DEC',
                                'Decrement integer target by 1 in-place.',
                                [csScript],
                                'DEC',
                                0,
                                @CmdDEC,
                                True,
                                [omScript]));

