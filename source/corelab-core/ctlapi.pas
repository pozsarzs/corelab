{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ctlapi.pas                                                               | }
{ | Control API module                                                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit ctlapi;
{$MODE OBJFPC}{$H+}
interface
uses
  CMem;
type
  // ICtlAPI (TSupervisor -> TCPU)
  ICtlAPI = interface
    ['{D7A29B3C-1F5E-46A8-B2C4-9D3E8F5A7B1C}']
    // Implemented only in TCPU class
    procedure SetRegister(const RegName: PChar; AValue: QWord);
    function  GetRegister(const RegName: PChar): QWord;
    procedure Reset;
    procedure Run;
    procedure Step;
    procedure Stop;
    function  GetCurrentInstruction: PChar;
    procedure IRQ;
    procedure NMI;
    function  CheckInterrupts: Boolean;
  end;

implementation

end.
