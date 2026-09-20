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
  SysUtils, Classes, commandengine;
type
  { TScriptEngine }
  TScriptEngine = class(TCommandEngine)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TScriptEngine }

// CREATE TSCRIPTENGINE INSTANCE
constructor TScriptEngine.Create;
begin
  inherited Create;
  // commands
  with FRegistry do
  begin

    { $I cmd-aritmetic.pas}
    { $I cmd-logic.pas}
    { $I cmd-access.pas}
    { $I cmd-control.pas}
    { $I cmd-other.pas}
//      if HasError then Exit;                              // command run error

  end;
end;

// DESTROY TSCRIPTENGINE INSTANCE
destructor TScriptEngine.Destroy;
begin
  inherited Destroy;
end;

end.
