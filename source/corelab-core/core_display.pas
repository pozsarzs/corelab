{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_display.pas                                                         | }
{ | Display abstraction module                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_display;
{$mode objfpc}{$H+}
interface
type
  // Abstract base display class
  TDisplay = class
  protected
    FModname: PChar;                                              // Module name
    FDescription: PChar;                                    // Short description
    FEnabled: boolean;                    // Enable port without detach from bus
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure Paint; virtual; abstract;
    procedure Reset; virtual; abstract;
    // Public properties
    property ModName: PChar read FModname;
    property Description: PChar read FDescription;
    property Enabled: boolean read FEnabled write FEnabled;
  end;
    
implementation

// Create TDisplay instance
constructor TDisplay.Create;
begin
  inherited Create;
end;

// Destroy TDisplay instance
destructor TDisplay.Destroy;
begin
  inherited Destroy;
end;

end.
