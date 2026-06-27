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
uses
  Classes, Graphics;
type
  // Displayed value with decimal points and blank status
  TDisplayedData = record
    Blank: boolean;
    LeftDot: boolean;
    RightDot: boolean;
    Segments: byte; { bits 0-6 }
    Value: byte; { bits 0-3 }
  end;
  // Abstract base display class
  TDisplay = class
  protected  
    FModname: PChar;                                              // Module name
    FDescription: PChar;                                    // Short description
    FEnabled: boolean;                                      // Enable displaying
    FBuffer: TBitmap;                                         // Internal buffer
    FDisplayedData: TDisplayedData;       // Displayed value, dots, and segments
    const RETRO_RED_GLOW: TColor = $003333FF;        // Retro red display colors
    const RETRO_RED_ON:   TColor = $000000FF;
    const RETRO_RED_OFF:  TColor = $00000040;
    const RETRO_RED_BG:   TColor = $00000015;
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure DrawToBuffer(InputData: TDisplayedData); virtual; abstract;
    procedure RenderTo(TargetCanvas: TCanvas; x, y: integer); virtual; abstract;
    procedure Reset; virtual;
    procedure SetBlank(Status: boolean); virtual;
    procedure SetLeftDot(Status: boolean); virtual;
    procedure SetRightDot(Status: boolean); virtual;
    procedure SetSegments(Value: byte); virtual;
    procedure SetValue(Value: byte); virtual;
    // Public properties
    property Description: PChar read FDescription;
    property Enabled: boolean read FEnabled write FEnabled;
    property ModName: PChar read FModname;
  end;
    
implementation

// Create TDisplay instance
constructor TDisplay.Create;
begin
  inherited Create;
  FBuffer := TBitmap.Create;
end;

// Destroy TDisplay instance
destructor TDisplay.Destroy;
begin
  Buffer.Free;
  Buffer := nil;
  inherited Destroy;
end;

// Reset display
procedure TDisplay.Reset;
begin
  with DisplayedData do
  begin
    Blank := false;
    RightDot := false;
    LeftDot := false;
    Segments := 0;
    Value := 0;
  end;
  DrawToBuffer(DisplayedData);
end;

// Blank display
procedure TDisplay.SetBlank(Status: boolean);
begin
  DisplayedData.Blank := Status;
  DrawToBuffer(DisplayedData);
end;

// Set left decimal point status
procedure TDisplay.SetLeftDot(Status: boolean);
begin
  DisplayedData.LeftDot := Status;
  DrawToBuffer(DisplayedData);
end;

// Set right decimal point status
procedure TDisplay.SetRightDot(Status: boolean);
begin
  DisplayedData.RightDot := Status;
  DrawToBuffer(DisplayedData);
end;

// Set input BCD value
procedure TDisplay.SetValue(Value: byte);
begin
  DisplayedData.Value := Value and $0F;
  DrawToBuffer(DisplayedData);
end;

// Set input segment data
procedure TDisplay.SetSegments(Value: byte);
begin
  DisplayedData.Segments := Value;
  DrawToBuffer(DisplayedData);
end;

end.
