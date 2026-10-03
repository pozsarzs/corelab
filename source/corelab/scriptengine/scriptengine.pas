{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | scriptengine.pas                                                         | }
{ | Script interpreter engine class                                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit scriptengine;
{$MODE OBJFPC}{$H+}
interface
uses
  SysUtils, Classes, Variants, command, commandengine, scriptruntime,
  frmscriptconsole, uactcontext;
type
  // type of read/write functions
  TReadFunc = function(AAddress: DWord): Byte of object;
  TWriteProc = procedure(AAddress: DWord; AValue: Byte) of object;
  { TScriptEngine }
  TScriptEngine = class(TCommandEngine)
  private
    function ChkRegName(var ARegName: string; ARepr: Boolean): Boolean;
    function ChkVarByte(var AVariant: Variant): Boolean;
    function ChkVarInt(var AVariant: Variant): Boolean;
    function ChkVarStr(var AVariant: Variant): Boolean;
  protected
    // access
    procedure CmdRDIO(AActionContext: TActionContext);
    procedure CmdWRIO(AActionContext: TActionContext);
    procedure CmdRDME(AActionContext: TActionContext);
    procedure CmdWRME(AActionContext: TActionContext);
    procedure CmdLDRG(AActionContext: TActionContext);
    procedure CmdSWAP(AActionContext: TActionContext);
    // arithmetic
    procedure CmdADD(AActionContext: TActionContext);
    procedure CmdSUB(AActionContext: TActionContext);
    procedure CmdMUL(AActionContext: TActionContext);
    procedure CmdINC(AActionContext: TActionContext);
    procedure CmdDEC(AActionContext: TActionContext);
    // control
    procedure CmdCOMP(AActionContext: TActionContext);
    procedure CmdINRG(AActionContext: TActionContext);
    procedure CmdJPEQ(AActionContext: TActionContext);
    procedure CmdJPZR(AActionContext: TActionContext);
    procedure CmdJPGE(AActionContext: TActionContext);
    procedure CmdJPGT(AActionContext: TActionContext);
    procedure CmdJPLE(AActionContext: TActionContext);
    procedure CmdJPLT(AActionContext: TActionContext);
    procedure CmdJPNE(AActionContext: TActionContext);
    procedure CmdJPNZ(AActionContext: TActionContext);
    procedure CmdCALL(AActionContext: TActionContext);
    procedure CmdRTRN(AActionContext: TActionContext);
    // logic
    procedure CmdAND(AActionContext: TActionContext);
    procedure CmdOR(AActionContext: TActionContext);
    procedure CmdXOR(AActionContext: TActionContext);
    procedure CmdNOT(AActionContext: TActionContext);
    procedure CmdSHL(AActionContext: TActionContext);
    procedure CmdSHR(AActionContext: TActionContext);
    procedure CmdBIT(AActionContext: TActionContext);
    // other
    procedure CmdCONV(AActionContext: TActionContext);
    procedure CmdPRNT(AActionContext: TActionContext);
    procedure CmdWAIT(AActionContext: TActionContext);
    procedure CmdEND(AActionContext: TActionContext);
    procedure CmdEXIT(AActionContext: TActionContext);
  public
    FScriptRuntime: TScriptRuntime;                       // runtime environment
    FReadPortFunc: TReadFunc;                 // read port function from outside
    FReadMemoryFunc: TReadFunc;             // read memory function from outside
    FWritePortProc: TWriteProc;             // write port procedure from outside
    FWriteMemoryProc: TWriteProc;         // write memory procedure from outside
    constructor Create; override;
    destructor Destroy; override;
    function ExecuteLine(const ALine: string): Integer; override;
  end;

implementation

{ TScriptEngine }

// ---- PRIVATE METHODS ----

// CHECK REGISTER NAME
function TScriptEngine.ChkRegName(var ARegName: string; ARepr: Boolean): Boolean;
const
  NL = 2;
  NP = 'R';
begin
  Result := False;
  if ARepr then
  begin
    if (Length(ARegName) = NL + 1) then
      if (ARegName[1] + ARegName[2] = '$' + NP) then Result := True;
  end else
  begin
    if (Length(ARegName) = NL) then
      if (ARegName[1] + ARegName[2] = NP) then Result := True;
  end;
end;

// CHECK VARIANT VALUE
function TScriptEngine.ChkVarByte(var AVariant: Variant): Boolean;
begin
  Result := False;
  if (VarType(AVariant) in [varByte, varShortInt, varWord, varSmallint,
    varLongWord, varInteger, varInt64, varQWord]) then
    if (AVariant >= 0) and (AVariant <= High(Byte)) then Result := True;
end;

// CHECK VARIANT VALUE
function TScriptEngine.ChkVarInt(var AVariant: Variant): Boolean;
begin
  Result := False;
  if (VarType(AVariant) in [varByte, varShortInt, varWord, varSmallint,
    varLongWord, varInteger, varInt64, varQWord]) then
    if (AVariant >= 0) and (AVariant <= High(DWord)) then Result := True;
end;

// CHECK VARIANT VALUE
function TScriptEngine.ChkVarStr(var AVariant: Variant): Boolean;
begin
  Result := False;
  if (VarType(AVariant) in [varString]) then Result := True;
end;

// ---- PROTECTED METHODS ----

{$I cmd-access.pas}
{$I cmd-arithmetic.pas}
{$I cmd-control.pas}
{$I cmd-logic.pas}
{$I cmd-other.pas}

// ---- PUBLIC METHODS ----

// CREATE TSCRIPTENGINE INSTANCE
constructor TScriptEngine.Create;
begin
  inherited Create;
  FScriptRuntime := TScriptRuntime.Create;
  // commands
  with FRegistry do
  begin
    {$I reg-access.pas}
    {$I reg-arithmetic.pas}
    {$I reg-control.pas}
    {$I reg-logic.pas}
    {$I reg-other.pas}
  end;
end;

// DESTROY TSCRIPTENGINE INSTANCE
destructor TScriptEngine.Destroy;
begin
  inherited Destroy;
end;

// EXECUTE COMMAND WITH PARAMETERS
function TScriptEngine.ExecuteLine(const ALine: string): Integer;
begin
// if HasError then Exit;                              // command run error
end;

end.
