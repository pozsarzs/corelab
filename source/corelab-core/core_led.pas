{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_led.pas                                                             | }
{ | LED abstraction module                                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_led;
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  Classes, Graphics;
type
  // Color group
  TColorGroup = (cgRetroGreen, clRetroRed, clRetroYellow);
  TColorGroupHelper = type helper for TColorGroup
    function ToString: string;
    function FromString(const AValue: string): TColorGroup;
  end;
  // LED base class
  TLED = class
  protected  
    FModname:     PChar;                                          // Module name
    FDescription: PChar;                                    // Short description
    FEnabled:     Boolean;                                  // Enable displaying
    FBuffer:      TBitmap;                                    // Internal buffer
    FIsOn:        Boolean;                                        // LED's state
    FColor:       TColorGroup;
    // Retro red display colors
    const RETRO_RED_GLOW:    TColor = $003333FF;
    const RETRO_RED_ON:      TColor = $000000FF;
    const RETRO_RED_OFF:     TColor = $00000040;
    const RETRO_RED_BG:      TColor = $00000015;
    const RETRO_GREEN_GLOW:  TColor = $0033FF33;
    const RETRO_GREEN_ON:    TColor = $0000FF00;
    const RETRO_GREEN_OFF:   TColor = $00004000;
    const RETRO_GREEN_BG:    TColor = $00001500;
    const RETRO_YELLOW_GLOW: TColor = $0033FFFF;
    const RETRO_YELLOW_ON:   TColor = $0000FFFF;
    const RETRO_YELLOW_OFF:  TColor = $00004040;
    const RETRO_YELLOW_BG:   TColor = $00001515;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure DrawToBuffer(InputData: TDisplayedData); virtual; abstract;
    procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer); virtual; abstract;
    procedure Reset; virtual;
    procedure SetColor(Color: TColorGroup;); virtual;
    procedure SetOn(Status: Boolean); virtual;
    property Description: PChar read FDescription;
    property Color: TColorGroup; read FColor write SetColor;
    property Enabled: Boolean read FEnabled write FEnabled;
    property ModName: PChar read FModname;
  end;
    
implementation

// HELPER FOR OWN TYPES
function TColorGroupHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TColorGroupHelper.FromString(const AValue: string): TColorGroup;
begin
  Result := TColorGroupHelper(GetEnumValue(TypeInfo(TColorGroup), AValue));
end;

// CREATE TLED INSTANCE
constructor TLED.Create;
begin
  inherited Create;
  FBuffer := TBitmap.Create;
end;

// DESTROY TLED INSTANCE
destructor TLED.Destroy;
begin
  FBuffer.Free;
  FBuffer := Nil;
  inherited Destroy;
end;

// RESET DISPLAY
procedure TLED.Reset;
begin
  FIsOn := false;
  DrawToBuffer(FDisplayedData);
end;

procedure TLED.SetColor(Color: TColorGroup;); virtual;
begin

  DrawToBuffer(FDisplayedData);
end;

procedure TLED.SetOn(Status: Boolean); virtual;
begin

  DrawToBuffer(FDisplayedData);
end;

end.
