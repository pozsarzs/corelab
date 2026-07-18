{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandcontext.pas                                                       | }
{ | Command context class                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandcontext;
{$MODE OBJFPC}{$H+}
interface
uses
  Generics.Collections;
type
  // Data storing type
  TContextValue = record
    RawValue:   string;
    IsReadOnly: Boolean;
  end;
  // Abstract command context class
  TCommandContext = class
  protected
    FVariables: specialize TDictionary<string, TContextValue>;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function DeleteVariable(const AName: string): Boolean; virtual;
    function TryGetValue(const AName: string; out AValue: string): Boolean; virtual;
    function IsReadOnly(const AName: string): Boolean; virtual;
    function SetValue(const AName, AValue: string; AReadOnly: Boolean = False): Boolean; virtual;
    procedure Clear; virtual;
   end;

implementation

// CREATE TCOMMANDCONTEXT INSTANCE
constructor TCommandContext.Create;
begin
  inherited Create;
end;

// DESTROY TCOMMANDCONTEXT INSTANCE
destructor TCommandContext.Destroy;
begin
  inherited Destroy;
end;

function TCommandContext.DeleteVariable(const AName: string): Boolean;
begin
end;

function TCommandContext.TryGetValue(const AName: string; out AValue: string): Boolean;
begin
end;

function TCommandContext.IsReadOnly(const AName: string): Boolean;
begin
end;

function TCommandContext.SetValue(const AName, AValue: string; AReadOnly: Boolean = False): Boolean;
begin
end;

procedure TCommandContext.Clear;
begin
end;

begin
end.
