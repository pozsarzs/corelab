{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | scriptruntime.pas                                                        | }
{ | Script runtime environment class                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Registers are 'variant' type.

  |registers|description                |access|possible types|
  |:-------:|:--------------------------|:----:|:------------:|
  |R0-9     |general register           | R/W  | dword string |
  |RA       |work register (accumulator)| R/W  | dword,string |
  |RB       |work directory             | RO   | string       |
  |RC       |script instruction counter | RO   | dword        |
  |RD       |CPU instruction counter    | RO   | dword        |
  |RE       |random byte                | RO   | byte         |
  |RF       |Flags (000000CZ)           | RO   | byte         |

  |flag|name    |description        |
  |:--:|--------|-------------------|
  | C  |Carry   |Overflow or carry. |
  | Z  |Zero    |The result is zero.| }
  
unit scriptruntime;
{$MODE OBJFPC}{$H+}
interface
uses
  SysUtils, Classes, Variants;
type
  { TScriptRuntime }
  TScriptRuntime = class
  protected
    FGenRegs: array['0'..'9'] of Variant;
    FSysRegs: array['A'..'F'] of Variant;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ClearFlags;
    function GetFlag(const ARegName: Char; var ATarget: Boolean): Boolean;
    function SetFlag(const ARegName: Char; AState: Boolean): Boolean;
    procedure ClearRegisters;
    function GetRegister(ARegName: Char; var ATarget: Variant): Boolean;
    function SetRegister(ARegName: Char; AValue: Variant; AForce: Boolean): Boolean;
  end;
const
  FlagNames:         string[8] = '000000CZ';
  FGenRegsWriteable: array['0'..'9'] of Boolean = (true, true, true, true,
                                                  true, true, true, true,
                                                  true, true);
  FSysRegsWriteable: array['A'..'F'] of Boolean = (true, false, false, false,
                                                  false, false);

implementation

{ TScriptRuntime }

// CREATE TSCRIPTRUNTIME INSTANCE
constructor TScriptRuntime.Create;
begin
  inherited Create;
  ClearRegisters;
end;

// DESTROY TSCRIPTRUNTIME INSTANCE
destructor TScriptRuntime.Destroy;
begin
  inherited Destroy;
end;

// RESET ALL FLAGS
procedure TScriptRuntime.ClearFlags;
begin
  FSysRegs['F'] := 0;
end;

// GET FLAG
function TScriptRuntime.GetFlag(const ARegName: Char; var ATarget: Boolean): Boolean;
var
  i, bit:   Integer;
  v:        Variant;
begin
  Result := False;
  if ARegName = '0' then Exit;
  bit := -1;
  // search flag
  for i := 1 to 8 do
  begin
    if FlagNames[i] = UpCase(ARegName) then
    begin
      bit := 8 - i;
      Break;
    end;
  end;
  // no such flag
  if bit < 0 then Exit;
  // return with flag status
  if GetRegister('F', v) then
    if VarType(v) in [varByte] then
    begin
      ATarget := (v and (1 shl bit)) <> 0;
      Result := True;
    end;
end;

// SET FLAG
function TScriptRuntime.SetFlag(const ARegName: Char; AState: Boolean): Boolean;
var
  i, bit:   Integer;
  v:        Variant;
begin
  Result := False;
  if ARegName = '0' then Exit;
  bit := -1;
  // search flag
  for i := 1 to 8 do
  begin
    if FlagNames[i] = UpCase(ARegName) then
    begin
      bit := 8 - i;
      Break;
    end;
  end;
  // no such flag
  if bit < 0 then Exit;
  // set flag status
  if GetRegister('F', v) then
    if VarType(v) in [varByte] then
    begin
      if AState
        then v := v or (1 shl bit)
        else v := v and not (1 shl bit);
        if SetRegister('F', Byte(v), True) then Result := True;
    end;
end;

// RESET ALL REGISTER
procedure TScriptRuntime.ClearRegisters;
var
  c: Char;
begin
  // R0-9
  for c:='0' to '9' do FGenRegs[c] := '';
  // RA-F
  for c:='A' to 'B' do FSysRegs[c] := '';
  for c:='C' to 'F' do FSysRegs[c] := 0;
end;

// GET REGISTER CONTENT
function TScriptRuntime.GetRegister(ARegName: Char; var ATarget: Variant): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c = 'E' then FSysRegs['E'] := Random(256);
  if c < 'A' then ATarget := FGenRegs[c] else ATarget := FSysRegs[c];
  Result := True;
end;

// SET REGISTER CONTENT
function TScriptRuntime.SetRegister(ARegName: Char; AValue: Variant; AForce: Boolean): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c <> 'E' then
  begin
    if c < 'A' then
    begin
      if AForce or FGenRegsWriteable[c] then FGenRegs[c] := AValue;
    end else
    begin
      if AForce or FSysRegsWriteable[c] then FSysRegs[c] := AValue;
    end;
  end;
  Result := True;
end;

initialization
  Randomize;

end.
