{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-control.pas                                                          | }
{ | Control commands                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ COMP INRG JUMP JPZE JPNZ JPCA JPNC CALL RTRN }

RegisterCommand(TCommand.Create('COMP',
                                'Compare target with value by subtraction.',
                                [csScript],
                                'COMP value',
                                1,
                                @CmdCOMP,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('INRG',
                                'Check if value is between min and max.',
                                [csScript],
                                'INRG min max',
                                2,
                                @CmdINRG,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JUMP',
                                'Jump to the specified label.',
                                [csScript],
                                'JUMP label',
                                1,
                                @CmdJUMP,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPZE',
                                'Jump to the specified label, based on the result of the previous intruction.',
                                [csScript],
                                'JPZE label',
                                1,
                                @CmdJPZE,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPNZ',
                                'Jump to the specified label, based on the result of the previous intruction.',
                                [csScript],
                                'JPNZ label',
                                1,
                                @CmdJPNZ,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPCA',
                                'Jump to the specified label, based on the result of the previous intruction.',
                                [csScript],
                                'JPCA label',
                                1,
                                @CmdJPCA,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPNC',
                                'Jump to the specified label, based on the result of the previous intruction.',
                                [csScript],
                                'JPNC label',
                                1,
                                @CmdJPNC,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('CALL',
                                'Call subroutine.',
                                [csScript],
                                'CALL label',
                                1,
                                @CmdCALL,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('RTRN',
                                'Return from subroutine.',
                                [csScript],
                                'RTRN',
                                0,
                                @CmdRTRN,
                                True,
                                [omScript]));

