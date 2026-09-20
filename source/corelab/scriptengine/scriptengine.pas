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
  SysUtils, Classes, commandengine, scriptruntime;
type
  { TScriptEngine }
  TScriptEngine = class(TCommandEngine)
  protected
  public
    FScriptRuntime: TScriptRuntime;
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
    {$I cmd-arithmetic.pas}
    {$I cmd-logic.pas}
    {$I cmd-access.pas}
    {$I cmd-control.pas}
    {$I cmd-other.pas}
  end;
end;

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
