{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-p.pas                                                                | }
{ | Commands of Processor menu                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRPU',
                                'Instantiate a processor module.',
                                [csCommandLine, csScript],
                                'CRPU library instancename',
                                2,
                                @Form1.PCreateOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DSPU',
                                'Destroy processor module.',
                                [csCommandLine, csScript],
                                'DSPU instancename',
                                1,
                                @Form1.PDestroyOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RSPU',
                                'Reset processor module.',
                                [csCommandLine, csScript],
                                'RSPU instancename',
                                1,
                                @Form1.PResetOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ENPU',
                                'Enable processor module.',
                                [csCommandLine, csScript],
                                'ENPU instancename',
                                1,
                                @Form1.PEnableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DIPU',
                                'Disable processor module.',
                                [csCommandLine, csScript],
                                'DIPU instancename',
                                1,
                                @Form1.PDisableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ATPU',
                                'Attach processor module to bus.',
                                [csCommandLine, csScript],
                                'ATPU instancename',
                                1,
                                @Form1.PAttachToBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DTPU',
                                'Detach processor module from bus.',
                                [csCommandLine, csScript],
                                'DTPU instancename',
                                1,
                                @Form1.PDetachFromBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('CFPU',
                                'Configure processor module.',
                                [csCommandLine, csScript],
                                'CFPU instancename.property value',
                                2,
                                @Form1.PConfigureOperation,
                                False,
                                [omInteractive, omScript]));

