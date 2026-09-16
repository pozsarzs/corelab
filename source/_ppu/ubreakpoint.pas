{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ubreakpoint.pas                                                          | }
{ | Breakpoint class                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit ubreakpoint;
{$MODE OBJFPC} {$H+} {$MACRO ON}
interface
uses Generics.Collections;
type
  TBreakpoint = class
  private
    FAddress: DWord;
    FEnabled: Boolean;
  public
    property Address: DWord read FAddress write FAddress;
    property Enabled: Boolean read FEnabled write FEnabled;
    constructor Create;
  end;
  // breakpoint list type
  TBreakpointList = specialize TObjectList<TBreakpoint>;

implementation

// CREATE TACTIONCONTEXT INSTANCE
constructor TBreakpoint.Create;
begin
  inherited Create;
  FAddress := 0;
  FEnabled := False;
end;

end.

