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
                                csScriptOnly,
                                'COMP value',
                                1,
                                @CmdCOMP,
                                True));

RegisterCommand(TCommand.Create('INRG',
                                'Check if value is between min and max.',
                                csScriptOnly,
                                'INRG min max',
                                2,
                                @CmdINRG,
                                True));

RegisterCommand(TCommand.Create('JPEQ',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPEQ label',
                                1,
                                @CmdJPEQ,
                                True));

RegisterCommand(TCommand.Create('JPZR',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPZR label',
                                1,
                                @CmdJPZR,
                                True));

RegisterCommand(TCommand.Create('JPGE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPGE label',
                                1,
                                @CmdJPGE,
                                True));

RegisterCommand(TCommand.Create('JPGT',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPGT label',
                                1,
                                @CmdJPGT,
                                True));

RegisterCommand(TCommand.Create('JPLE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPLE label',
                                1,
                                @CmdJPLE,
                                True));

RegisterCommand(TCommand.Create('JPLT',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPLT label',
                                1,
                                @CmdJPLT,
                                True));

RegisterCommand(TCommand.Create('JPNE',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPNE label',
                                1,
                                @CmdJPNE,
                                True));

RegisterCommand(TCommand.Create('JPNZ',
                                'Jump to the specified label, based on the result of the previous CMP.',
                                csScriptOnly,
                                'JPNZ label',
                                1,
                                @CmdJPNZ,
                                True));

RegisterCommand(TCommand.Create('CALL',
                                'Call subroutine.',
                                csScriptOnly,
                                'CALL label',
                                1,
                                @CmdCALL,
                                True));

RegisterCommand(TCommand.Create('RTRN',
                                'Return from subroutine.',
                                csScriptOnly,
                                'RTRN',
                                0,
                                @CmdRTRN,
                                True));

