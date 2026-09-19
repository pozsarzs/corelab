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

unit scriptruntime;
{$MODE OBJFPC}{$H+}
interface
uses
  SysUtils, Classes, commandengine, scriptruntime;
type
  { TScriptRuntime }
  TScriptRuntime = class
  protected
    FRegArray = array[0..15] of string;
  public
    constructor Create; virtual;
    destructor Destroy;
    function GetFlag(const ARegName: Char): Boolean;
    function GetRegister(const ARegName: Char): string;
    procedure ClearFlags;
    procedure IncrementPC;
    procedure Reset;
    procedure SetFlag(const ARegName: Char; AState: Boolean);
    procedure SetPC(AValue: integer);
    procedure SetRegister(const ARegName: Char; AValue: string);
  end;
const
  FReg = array[0..15] of Boolean = (...);
  FlagNames: string[8] = '??????CZ';

implementation

{ TScriptRuntime }

// CREATE TSCRIPTRUNTIME INSTANCE
constructor TScriptRuntime.Create;
begin
  inherited Create;
end;

// DESTROY TSCRIPTRUNTIME INSTANCE
destructor TScriptRuntime.Destroy;
begin
  inherited Destroy;
end;


function TScriptRuntime.GetFlag(const AFlagName: Char; var ATarget: Boolean): Boolean;
var
  b: Byte;
  rf: string;
  s: string;
begin
  result:=false;
  for b := 1 to 8 do
   if FlagNames[b] = AFlagName then Break;
  b := (8 - b);
  if getregister('f', s) then
  begin
    rf := TryStrToInt(s, 0);
    rf := rf shl b
    if rf = 1 then ATarget := true else ATarget := false;
    result := true;
  end;
end;



// GET FLAG STATUS
function TScriptRuntime.GetFlag(const AFlagName: Char): Boolean;
var
  b: Byte;
  rf: string;
begin
  for b := 1 to 8 do
   if FlagNames[b] = AFlagName then Break;
  b := (8 - b);
  rf := TryStrToInt(GetRegister('F'), 0);
  rf := rf and 2**b
  if rf = 1 then result := true else result := false;
end;

function GetRegister(ARegName: Char; var ATarget: string): Boolean;
var
  b: Byte;
begin
  Result := False;
  b := Ord(UpCase(ARegName));
  if (b < 48) or (b > 70) then Exit;
  if (b > 58) or (b < 65) then Exit;
  if b >= 65 then b := b - 55 else b := b - 48;
  ATarget := FReg[b];
  Result := True;
end;

function SetRegister(ARegName: Char; AValue: string): Boolean;
var
  b: Byte;
begin
  Result := False;
  b := Ord(UpCase(ARegName));
  if (b < 48) or (b > 70) then Exit;
  if (b > 58) or (b < 65) then Exit;
  if b >= 65 then b := b - 55 else b := b - 48;
  if FRegWritable[b] then
  begin
   FReg[b] := ATarget;
   Result := True;
  end;
end;





procedure ClearFlags;
procedure IncrementPC;
procedure Reset;
procedure SetFlag(const ARegName: Char; AState: Boolean);
procedure SetPC(AValue: integer);
procedure SetRegister(const ARegName: Char; AValue: string);





end.
