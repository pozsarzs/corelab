{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | sysbus.pas                                                               | }
{ | System bus module                                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit sysbus;
{$MODE OBJFPC}{$H+}
interface
uses
  CMem;
type
  // SysBus (TCPU -> device classes)
  ISysBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // Only memory device
    function ReadMemory(AAddress: DWord): QWord;
    procedure WriteMemory(AAddress: DWord; AValue: QWord);
    // Only i/o port device
    function ReadPort(APort: Word): Byte;
    procedure WritePort(APort: Word; AValue: Byte);
  end;

implementation

end.
