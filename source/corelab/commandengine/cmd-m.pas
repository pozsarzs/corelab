{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-m.pas                                                                | }
{ | Commands of Memory menu                                                  | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRME',
                                'Instantiate a memory module.',
                                csEverywhere,
                                'CRME library instancename',
                                2,
                                @Form1.MCreateOperation,
                                False));

RegisterCommand(TCommand.Create('DSME',
                                'Destroy memory module.',
                                csEverywhere,
                                'DSME instancename',
                                1,
                                @Form1.MDestroyOperation,
                                False));

RegisterCommand(TCommand.Create('RSME',
                                'Reset memory module.',
                                csEverywhere,
                                'RSME instancename',
                                1,
                                @Form1.MResetOperation,
                                False));

RegisterCommand(TCommand.Create('ENME',
                                'Enable memory module.',
                                csEverywhere,
                                'ENME instancename',
                                1,
                                @Form1.MEnableOperation,
                                False));

RegisterCommand(TCommand.Create('DIME',
                                'Disable memory module.',
                                csEverywhere,
                                'DIME instancename',
                                1,
                                @Form1.MDisableOperation,
                                False));

RegisterCommand(TCommand.Create('ATME',
                                'Attach memory module to bus.',
                                csEverywhere,
                                'ATME instancename',
                                1,
                                @Form1.MAttachToBusOperation,
                                False));

RegisterCommand(TCommand.Create('DTME',
                                'Detach memory module from bus.',
                                csEverywhere,
                                'DTME instancename',
                                1,
                                @Form1.MDetachFromBusOperation,
                                False));

RegisterCommand(TCommand.Create('LDME',
                                'Load memory content from file',
                                csEverywhere,
                                'LDME instancename filename',
                                2,
                                @Form1.MLoadMemoryContentOperation,
                                False));

RegisterCommand(TCommand.Create('SVME',
                                'Save memory content to file',
                                csEverywhere,
                                'SVME filename instancename',
                                2,
                                @Form1.MSaveMemoryContentOperation,
                                True));

RegisterCommand(TCommand.Create('EDME',
                                'Show examine/deposit window',
                                csInteractiveOnly,
                                'EDME instancename',
                                1,
                                @Form1.MExamineDepositOperation,
                                False));

RegisterCommand(TCommand.Create('CFME',
                                'Configure memory module.',
                                csEverywhere,
                                'CFME instancename.property value',
                                2,
                                @Form1.MConfigureOperation,
                                False));

