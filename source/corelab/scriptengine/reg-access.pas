{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-access.pas                                                           | }
{ | Data access commands                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ DEPO EXAM SWAP }

RegisterCommand(TCommand.Create('DEPO',
                                'Deposit a value directly into memory, register or bus address.',
                                csScriptOnly,
                                'DEPO address value',
                                2,
                                @CmdDEPO,
                                True));

RegisterCommand(TCommand.Create('EXAM',
                                'Examine a value from memory, register or bus address into a variable.',
                                csScriptOnly,
                                'EXAM address',
                                1,
                                @CmdEXAM,
                                True));

RegisterCommand(TCommand.Create('SWAP',
                                'Swap the values of two registers.',
                                csScriptOnly,
                                'SWAP register register',
                                2,
                                @CmdSWAP,
                                True));
