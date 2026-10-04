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

{ COMP INRG JPEQ JPZR JPGE JPGT JPLE JPLT JPNE JPNZ CALL RTRN }

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

RegisterCommand(TCommand.Create('JPEQ',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPEQ label',
                                1,
                                @CmdJPEQ,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPZR',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPZR label',
                                1,
                                @CmdJPZR,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPGE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPGE label',
                                1,
                                @CmdJPGE,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPGT',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPGT label',
                                1,
                                @CmdJPGT,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPLE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPLE label',
                                1,
                                @CmdJPLE,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPLT',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPLT label',
                                1,
                                @CmdJPLT,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPNE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPNE label',
                                1,
                                @CmdJPNE,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('JPNZ',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                [csScript],
                                'JPNZ label',
                                1,
                                @CmdJPNZ,
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

