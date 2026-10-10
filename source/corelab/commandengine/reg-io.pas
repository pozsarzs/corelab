{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-io.pas                                                               | }
{ | Commands of I/O port menu                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRIO',
                                'Instantiate a I/O port or device module.',
                                [csCommandLine, csScript],
                                'CRIO library instancename',
                                2,
                                @Form1.IOCreateOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DSIO',
                                'Destroy I/O port or device module.',
                                [csCommandLine, csScript],
                                'DSIO instancename',
                                1,
                                @Form1.IODestroyOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RSIO',
                                'Reset I/O port or device module.',
                                [csCommandLine, csScript],
                                'RSIO instancename',
                                1,
                                @Form1.IOResetOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ENIO',
                                'Enable I/O port or device module.',
                                [csCommandLine, csScript],
                                'ENIO instancename',
                                1,
                                @Form1.IOEnableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DIIO',
                                'Disable I/O port or device module.',
                                [csCommandLine, csScript],
                                'DIIO instancename',
                                1,
                                @Form1.IODisableOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('ATIO',
                                'Attach I/O port or device module to bus.',
                                [csCommandLine, csScript],
                                'ATIO instancename',
                                1,
                                @Form1.IOAttachToBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('DTIO',
                                'Detach I/O port or device module from bus.',
                                [csCommandLine, csScript],
                                'DTIO instancename',
                                1,
                                @Form1.IODetachFromBusOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RWIO',
                                'Show read/write window',
                                [csCommandLine],
                                'RWIO instancename',
                                1,
                                @Form1.IOReadWriteOperation,
                                False,
                                [omInteractive]));

RegisterCommand(TCommand.Create('CFIO',
                                'Configure I/O port module.',
                                [csCommandLine, csScript],
                                'CFIO instancename.property value',
                                2,
                                @Form1.IOConfigureOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('MVIO',
                                'Set position of I/O device panel.',
                                [csCommandLine, csScript],
                                'MVIO instancename left-top',
                                2,
                                @Form1.IOMovePanelOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SZIO',
                                'Set size of I/O device panel.',
                                [csCommandLine, csScript],
                                'SZIO instancename width-height',
                                2,
                                @Form1.IOResizePanelOperation,
                                True,
                                [omInteractive, omScript]));
