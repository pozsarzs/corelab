{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-m.pas                                                                | }
{ | Commands of Memory menu                                                  | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRME',
                                'Instantiate a memory module.',
                                [csCommandLine, csScript],
                                'CRME library instancename',
                                2,
                                @Form1.MCreateOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DSME',
                                'Destroy memory module.',
                                [csCommandLine, csScript],
                                'DSME instancename',
                                1,
                                @Form1.MDestroyOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RSME',
                                'Reset memory module.',
                                [csCommandLine, csScript],
                                'RSME instancename',
                                1,
                                @Form1.MResetOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ENME',
                                'Enable memory module.',
                                [csCommandLine, csScript],
                                'ENME instancename',
                                1,
                                @Form1.MEnableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DIME',
                                'Disable memory module.',
                                [csCommandLine, csScript],
                                'DIME instancename',
                                1,
                                @Form1.MDisableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ATME',
                                'Attach memory module to bus.',
                                [csCommandLine, csScript],
                                'ATME instancename',
                                1,
                                @Form1.MAttachToBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DTME',
                                'Detach memory module from bus.',
                                [csCommandLine, csScript],
                                'DTME instancename',
                                1,
                                @Form1.MDetachFromBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('LDME',
                                'Load memory content from file',
                                [csCommandLine, csScript],
                                'LDME instancename filename',
                                2,
                                @Form1.MLoadMemoryContentOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SVME',
                                'Save memory content to file',
                                [csCommandLine, csScript],
                                'SVME filename instancename',
                                2,
                                @Form1.MSaveMemoryContentOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('EDME',
                                'Show examine/deposit window',
                                [csCommandLine],
                                'EDME instancename',
                                1,
                                @Form1.MExamineDepositOperation,
                                False,
                                [omInteractive]));

RegisterCommand(TCommand.Create('CFME',
                                'Configure memory module.',
                                [csCommandLine, csScript],
                                'CFME instancename.property value',
                                2,
                                @Form1.MConfigureOperation,
                                False,
                                [omInteractive, omScript]));

