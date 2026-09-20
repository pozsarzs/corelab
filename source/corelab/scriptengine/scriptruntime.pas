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

{ |registers|description                |access|
  |:-------:|:--------------------------|:----:|
  |R0-9     |general register           | R/W  | 
  |RA       |work register (accumulator)| R/W  | 
  |RB       |work directory             | RO   | 
  |RC       |script instruction counter | RO   | 
  |RD       |CPU instruction counter    | RO   | 
  |RE       |random byte                | RO   | 
  |RF       |flags                      | RO   | }
  
unit scriptruntime;
{$MODE OBJFPC}{$H+}
interface
uses
  SysUtils, Classes;
type
  { TScriptRuntime }
  TScriptRuntime = class
  protected
    FRegsGen: array['0'..'9'] of string;
    FRegsSys: array['A'..'F'] of string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetFlag(const ARegName: Char): Boolean;
    function GetRegister(ARegName: Char; var ATarget: string): Boolean; overload;
    function GetRegister(ARegName: Char; var ATarget: Integer): Boolean; overload;
    procedure ClearFlags;
    procedure ResetAll;
    procedure SetFlag(const ARegName: Char; AState: Boolean);
    function SetRegister(ARegName: Char; AValue: string; AForce: Boolean): Boolean; overload;
    function SetRegister(ARegName: Char; AValue: Integer; AForce: Boolean): Boolean; overload;
  end;
const
  FlagNames:         string[8] = '??????CZ';
  FRegsGenWriteable: array['0'..'9'] of Boolean = (true, true, true, true,
                                                  true, true, true, true,
                                                  true, true);
  FRegsSysWriteable: array['A'..'F'] of Boolean = (true, false, false, false,
                                                  false, false);

implementation

{ TScriptRuntime }

// CREATE TSCRIPTRUNTIME INSTANCE
constructor TScriptRuntime.Create;
begin
  inherited Create;
  ResetAll;
end;

// DESTROY TSCRIPTRUNTIME INSTANCE
destructor TScriptRuntime.Destroy;
begin
  inherited Destroy;
end;

// GET FLAG
function TScriptRuntime.GetFlag(const ARegName: Char): Boolean;
var
  i, bit:   Integer;
  s:        string;
  FlagsVal: Integer;
begin
  Result := False;
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
  if GetRegister('F', s) then
  begin
    FlagsVal := StrToIntDef(s, 0); 
    Result := (FlagsVal and (1 shl bit)) <> 0; 
  end;
end;

// GET REGISTER CONTENT
function TScriptRuntime.GetRegister(ARegName: Char; var ATarget: string): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c = 'E' then FRegsSys['E'] := IntToStr(Random(256));
  if c < 'A' then ATarget := FRegsGen[c] else ATarget := FRegsSys[c];
  Result := True;
end;

function TScriptRuntime.GetRegister(ARegName: Char; var ATarget: Integer): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c = 'E' then FRegsSys['E'] := IntToStr(Random(256));
  try
    if c < 'A'
      then ATarget := StrToInt(FRegsGen[c])
      else ATarget := StrToInt(FRegsSys[c]);
  except
    ATarget := 0;
    Exit;
  end;
  Result := True;
end;

// RESET ALL FLAGS
procedure TScriptRuntime.ClearFlags;
begin
  FRegsSys['F'] := '0';
end;

// RESET ALL REGISTER
procedure TScriptRuntime.ResetAll;
var
  c: Char;
begin
  // R0-9
  for c:='0' to '9' do FRegsGen[c] := '';
  // RA-F
  for c:='A' to 'B' do FRegsSys[c] := '';
  for c:='C' to 'F' do FRegsSys[c] := '0';
end;

// SET FLAG
procedure TScriptRuntime.SetFlag(const ARegName: Char; AState: Boolean);
var
  i, bit:   Integer;
  s:        string;
  FlagsVal: Integer;
begin
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
  if not GetRegister('F', s) then s := '0';
  FlagsVal := StrToIntDef(s, 0);
  if AState
    then FlagsVal := FlagsVal or (1 shl bit)
    else FlagsVal := FlagsVal and not (1 shl bit);
  SetRegister('F', IntToStr(FlagsVal), True);
end;

// SET REGISTER CONTENT
function TScriptRuntime.SetRegister(ARegName: Char; AValue: string; AForce: Boolean): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c = 'E' then Exit else
  begin
    if c < 'A' then
    begin
      if AForce or FRegsGenWriteable[c] then FRegsGen[c] := AValue;
    end else
    begin
      if AForce or FRegsSysWriteable[c] then FRegsSys[c] := AValue;
    end;
  end;
  Result := True;
end;

function TScriptRuntime.SetRegister(ARegName: Char; AValue: Integer; AForce: Boolean): Boolean;
var
  c: Char;
begin
  Result := False;
  c := UpCase(ARegName);
  if not (c in ['0'..'9', 'A'..'F']) then Exit;
  if c = 'E' then Exit else
  begin
    if c < 'A' then
    begin
      if AForce or FRegsGenWriteable[c] then FRegsGen[c] := IntToStr(AValue);
    end else
    begin
      if AForce or FRegsSysWriteable[c] then FRegsSys[c] := IntToStr(AValue);
    end;
  end;
  Result := True;
end;

initialization
  Randomize;

end.
