{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-io.pas                                                               | }
{ | Commands of I/O port menu                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRIO',
                                'Instantiate a I/O port or device module.',
                                csEverywhere,
                                'CRIO library instancename',
                                2,
                                @Form1.IOCreateOperation));

RegisterCommand(TCommand.Create('DSIO',
                                'Destroy I/O port or device module.',
                                csEverywhere,
                                'DSIO instancename',
                                1,
                                @Form1.IODestroyOperation));

RegisterCommand(TCommand.Create('RSIO',
                                'Reset I/O port or device module.',
                                csEverywhere,
                                'RSIO instancename',
                                1,
                                @Form1.IOResetOperation));

RegisterCommand(TCommand.Create('ENIO',
                                'Enable I/O port or device module.',
                                csEverywhere,
                                'ENIO instancename',
                                1,
                                @Form1.IOEnableOperation));

RegisterCommand(TCommand.Create('DIIO',
                                'Disable I/O port or device module.',
                                csEverywhere,
                                'DIIO instancename',
                                1,
                                @Form1.IODisableOperation));

RegisterCommand(TCommand.Create('ATIO',
                                'Attach I/O port or device module to bus.',
                                csEverywhere,
                                'ATIO instancename',
                                1,
                                @Form1.IOAttachToBusOperation));

RegisterCommand(TCommand.Create('DTIO',
                                'Detach I/O port or device module from bus.',
                                csEverywhere,
                                'DTIO instancename',
                                1,
                                @Form1.IODetachFromBusOperation));
