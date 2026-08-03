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
    procedure Reset; virtual;
    procedure DrawToBuffer(AInputData: TDisplayedData); virtual; abstract;
    procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer); virtual; abstract;
    procedure SetBlank(AStatus: Boolean); virtual;
    procedure SetLeftDot(AStatus: Boolean); virtual;
    procedure SetRightDot(AStatus: Boolean); virtual;
    procedure SetSegments(AValue: Byte); virtual;
    procedure SetValue(AValue: Byte); virtual;
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
  FBuffer.Free;
  FBuffer := Nil;
  inherited Destroy;
end;

// RESET DISPLAY
procedure TDisplay.Reset;
begin
  with FDisplayedData do
  begin
    Blank := False;
    RightDot := False;
    LeftDot := False;
    Segments := 0;
    Value := 0;
  end;
  DrawToBuffer(FDisplayedData);
end;

// BLANK DISPLAY
procedure TDisplay.SetBlank(AStatus: Boolean);
begin
  FDisplayedData.Blank := AStatus;
  DrawToBuffer(FDisplayedData);
end;

// SET LEFT DECIMAL POINT STATUS
procedure TDisplay.SetLeftDot(AStatus: Boolean);
begin
  FDisplayedData.LeftDot := AStatus;
  DrawToBuffer(FDisplayedData);
end;

// SET RIGHT DECIMAL POINT STATUS
procedure TDisplay.SetRightDot(AStatus: Boolean);
begin
  FDisplayedData.RightDot := AStatus;
  DrawToBuffer(FDisplayedData);
end;

// SET INPUT BCD VALUE
procedure TDisplay.SetValue(AValue: Byte);
begin
  FDisplayedData.Value := AValue and $0F;
  DrawToBuffer(FDisplayedData);
end;

// SET INPUT SEGMENT DATA
procedure TDisplay.SetSegments(AValue: Byte);
begin
  FDisplayedData.Segments := AValue;
  DrawToBuffer(FDisplayedData);
end;

end.
