{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | projectengine.pas                                                        | }
{ | Project handler engine class                                             | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit projectengine;
{$MODE OBJFPC}{$H+}
interface
uses
  SysUtils, Classes, commandengine;
type
  { TProjectEngine }
  TProjectEngine = class(TCommandEngine)
  private
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ExecuteLine(const ALine: string): Integer; override;
  end;

implementation

{ TProjectEngine }

// ---- PRIVATE METHODS ----

// ---- PROTECTED METHODS ----

// ---- PUBLIC METHODS ----

// CREATE TSCRIPTENGINE INSTANCE
constructor TProjectEngine.Create;
begin
  inherited Create;
end;

// DESTROY TSCRIPTENGINE INSTANCE
destructor TProjectEngine.Destroy;
begin
  inherited Destroy;
end;

// EXECUTE COMMAND WITH PARAMETERS
function TProjectEngine.ExecuteLine(const ALine: string): Integer;
begin
  Result := 0;
end;

end.
