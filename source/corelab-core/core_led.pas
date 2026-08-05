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
interface
uses
  Classes, Graphics;
type
  // LED color and color group types
  TColorGroup = (clRetroGreen, clRetroRed, clRetroYellow);
  TLEDColors = record
    Glow:     TColor;
    OnColor:  TColor;
    OffColor: TColor;
  end;
  // LED base class
  TLED = class
  protected  
    FModname:     PChar;                                          // Module name
    FDescription: PChar;                                    // Short description
    FEnabled:     Boolean;                                  // Enable displaying
    FBuffer:      TBitmap;                                    // Internal buffer
    FBGColor:     TColor;                     // Background color around the LED
    FColor:       TLEDColors;                                       // LED color
    FIsOn:        Boolean;                                          // LED state
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure Reset; virtual;
    procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor); virtual; abstract;
    procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer); virtual; abstract;
    procedure SetBGColor(ABGColor: TColor); virtual;
    procedure SetColor(AColor: TLEDColors); virtual;
    procedure SetOn(AStatus: Boolean); virtual;
    property ModName: PChar read FModname;
    property Description: PChar read FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Color: TLEDColors read FColor write SetColor;
    property BGColor: TColor read FBGColor write SetBGColor;
    property IsOn: Boolean read FIsOn write SetOn;
  end;
const 
  // LED colors and color groups
  RETRO_COLORS: array[TColorGroup] of TLEDColors = (
    // clRetroGreen
    (Glow: $0088FF88; OnColor: $0000D000; OffColor: $00156515),
    // clRetroRed
    (Glow: $008888FF; OnColor: $000000D0; OffColor: $00000075),
    // clRetroYellow
    (Glow: $0088FFFF; OnColor: $0000D0D0; OffColor: $00146666)
  );

implementation

// ---- PUBLIC METHODS ----

// CREATE TLED INSTANCE
constructor TLED.Create;
begin
  FBuffer := TBitmap.Create;
end;

// DESTROY TLED INSTANCE
destructor TLED.Destroy;
begin
  FBuffer.Free;
  FBuffer := Nil;
end;

// RESET DISPLAY
procedure TLED.Reset;
begin
  FIsOn := false;
  DrawToBuffer(FIsOn, FColor, FBGColor);
end;

// SET LED COLOR
procedure TLED.SetColor(AColor: TLEDColors);
begin
  FColor := AColor;
  DrawToBuffer(FIsOn, FColor, FBGColor);
end;

// SET BACKGROUND COLOR
procedure TLED.SetBGColor(ABGColor: TColor);
begin
  FBGColor := ABGColor;
  DrawToBuffer(FIsOn, FColor, FBGColor);
end;

// SET LED STATUS
procedure TLED.SetOn(AStatus: Boolean);
begin
  FIsOn := AStatus;
  DrawToBuffer(FIsOn, FColor, FBGColor);
end;

end.
