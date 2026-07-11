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
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, Graphics;
type
  // Displayed value with decimal points and blank status
  TDisplayedData = record
    Blank:    Boolean;
    LeftDot:  Boolean;
    RightDot: Boolean;
    Segments: Byte; { bits 0-6 }
    Value:    Byte; { bits 0-3 }
  end;
  // Display base class
  TDisplay = class
  protected  
    FModname:             PChar;                                  // Module name
    FDescription:         PChar;                            // Short description
    FEnabled:             Boolean;                          // Enable displaying
    FBuffer:              TBitmap;                            // Internal buffer
    FDisplayedData:       TDisplayedData; // Displayed value, dots, and segments
    // Retro red display colors
    const RETRO_RED_GLOW: TColor = $003333FF;
    const RETRO_RED_ON:   TColor = $000000FF;
    const RETRO_RED_OFF:  TColor = $00000040;
    const RETRO_RED_BG:   TColor = $00000015;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure DrawToBuffer(InputData: TDisplayedData); virtual; abstract;
    procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer); virtual; abstract;
    procedure Reset; virtual;
    procedure SetBlank(Status: Boolean); virtual;
    procedure SetLeftDot(Status: Boolean); virtual;
    procedure SetRightDot(Status: Boolean); virtual;
    procedure SetSegments(Value: Byte); virtual;
    procedure SetValue(Value: Byte); virtual;
    property Description: PChar read FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property ModName: PChar read FModname;
  end;
    
implementation

// CREATE TDISPLAY INSTANCE
constructor TDisplay.Create;
begin
  inherited Create;
  FBuffer := TBitmap.Create;
end;

// DESTROY TDISPLAY INSTANCE
destructor TDisplay.Destroy;
begin
  Buffer.Free;
  Buffer := Nil;
  inherited Destroy;
end;

// RESET DISPLAY
procedure TDisplay.Reset;
begin
  with DisplayedData do
  begin
    Blank := False;
    RightDot := False;
    LeftDot := False;
    Segments := 0;
    Value := 0;
  end;
  DrawToBuffer(DisplayedData);
end;

// BLANK DISPLAY
procedure TDisplay.SetBlank(Status: Boolean);
begin
  DisplayedData.Blank := Status;
  DrawToBuffer(DisplayedData);
end;

// SET LEFT DECIMAL POINT STATUS
procedure TDisplay.SetLeftDot(Status: Boolean);
begin
  DisplayedData.LeftDot := Status;
  DrawToBuffer(DisplayedData);
end;

// SET RIGHT DECIMAL POINT STATUS
procedure TDisplay.SetRightDot(Status: Boolean);
begin
  DisplayedData.RightDot := Status;
  DrawToBuffer(DisplayedData);
end;

// SET INPUT BCD VALUE
procedure TDisplay.SetValue(Value: Byte);
begin
  DisplayedData.Value := Value and $0F;
  DrawToBuffer(DisplayedData);
end;

// SET INPUT SEGMENT DATA
procedure TDisplay.SetSegments(Value: Byte);
begin
  DisplayedData.Segments := Value;
  DrawToBuffer(DisplayedData);
end;

end.
