{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | display_til311.pas                                                       | }
{ | TIL311 display class                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit display_til311;
{$mode objfpc}{$H+}
interface
type
  // TIL311 display implementation
  TDisplayTIL311 = class(TDisplay)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Reset; override;
  end;
    
implementation

// Create TDisplay instance
constructor TDisplayTIL311.Create;
begin
  inherited Create;
end;

// Destroy TDisplay instance
destructor TDisplayTIL311.Destroy;
begin
  inherited Destroy;
end;

end.
