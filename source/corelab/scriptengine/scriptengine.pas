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
  SysUtils, Classes, command, commandengine, scriptruntime, uactcontext;
type
  { TScriptEngine }
  TScriptEngine = class(TCommandEngine)
  public
    FScriptRuntime: TScriptRuntime;
  private
    procedure CmdADD(AActionContext: TActionContext);
    procedure CmdAND(AActionContext: TActionContext);
    procedure CmdBIT(AActionContext: TActionContext);
    procedure CmdCALL(AActionContext: TActionContext);
    procedure CmdCOMP(AActionContext: TActionContext);
    procedure CmdCONV(AActionContext: TActionContext);
    procedure CmdDEC(AActionContext: TActionContext);
    procedure CmdDEPO(AActionContext: TActionContext);
    procedure CmdEND(AActionContext: TActionContext);
    procedure CmdEXAM(AActionContext: TActionContext);
    procedure CmdEXIT(AActionContext: TActionContext);
    procedure CmdINC(AActionContext: TActionContext);
    procedure CmdINRG(AActionContext: TActionContext);
    procedure CmdJPEQ(AActionContext: TActionContext);
    procedure CmdJPGE(AActionContext: TActionContext);
    procedure CmdJPGT(AActionContext: TActionContext);
    procedure CmdJPLE(AActionContext: TActionContext);
    procedure CmdJPLT(AActionContext: TActionContext);
    procedure CmdJPNE(AActionContext: TActionContext);
    procedure CmdJPNZ(AActionContext: TActionContext);
    procedure CmdJPZR(AActionContext: TActionContext);
    procedure CmdMUL(AActionContext: TActionContext);
    procedure CmdNOT(AActionContext: TActionContext);
    procedure CmdOR(AActionContext: TActionContext);
    procedure CmdPRNT(AActionContext: TActionContext);
    procedure CmdRTRN(AActionContext: TActionContext);
    procedure CmdSHL(AActionContext: TActionContext);
    procedure CmdSHR(AActionContext: TActionContext);
    procedure CmdSUB(AActionContext: TActionContext);
    procedure CmdSWAP(AActionContext: TActionContext);
    procedure CmdWAIT(AActionContext: TActionContext);
    procedure CmdXOR(AActionContext: TActionContext);
  protected
  public
    //FScriptRuntime: TScriptRuntime;
    constructor Create; override;
    destructor Destroy; override;
    function ExecuteLine(const ALine: string): Integer; override;
  end;

implementation

{ TScriptEngine }

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

{$I cmd-access.pas}
{$I cmd-arithmetic.pas}
{$I cmd-control.pas}
{$I cmd-logic.pas}
{$I cmd-other.pas}

 // EXECUTE COMMAND WITH PARAMETERS
function TScriptEngine.ExecuteLine(const ALine: string): Integer;
begin
// if HasError then Exit;                              // command run error
end;

// DESTROY TSCRIPTENGINE INSTANCE
destructor TScriptEngine.Destroy;
begin
  inherited Destroy;
end;

end.
