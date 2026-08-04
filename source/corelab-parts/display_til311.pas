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

{ LEDs' coordinates on 94x104 size TBitmap object: 

    | A B C D E F G H |   A     B     C     D     E     F     G     H
  --+-----------------+------------------------------------------------
  0 |     * * * *     |             37;05 51;05 65;05 79;05
  1 |     *     *     |             36;19             78;19
  2 |     *     *     |             35;33             77;33
  3 |     * * * *     |             34;47 48;47 62;47 76;47
  4 |     *     *     |             33;61             75;61
  5 |     *     *     |             32;75             74;75
  6 | *   * * * *   * | 03;91       31;89 45;89 59;89 73;89      101;91
}

unit display_til311;
{$MODE OBJFPC}{$H+}
interface
uses
  Graphics, core_display;
type
  // TIL311 display class
  TDisplayTIL311 = class(TDisplay)
  protected
    procedure DrawDot(AStatus: Boolean; Ax, Ay: Byte);
    const CHARMAP_TIL311: array[0..15, 0..6] of Byte = (
      { '0' } (%0110, %1001, %1001, %1001, %1001, %1001, %0110),
      { '1' } (%0001, %0001, %0001, %0001, %0001, %0001, %0001),
      { '2' } (%1110, %0001, %0001, %0110, %1000, %1000, %1111),
      { '3' } (%1110, %0001, %0001, %0110, %0001, %0001, %1110),
      { '4' } (%1000, %1001, %1001, %1111, %0001, %0001, %0001),
      { '5' } (%1111, %1000, %1000, %1110, %0001, %0001, %1110),
      { '6' } (%0110, %1000, %1000, %1110, %1001, %1001, %0110),
      { '7' } (%1111, %0001, %0001, %0001, %0001, %0001, %0001),
      { '8' } (%0110, %1001, %1001, %0110, %1001, %1001, %0110),
      { '9' } (%0110, %1001, %1001, %0111, %0001, %0001, %0110),
      { 'A' } (%0110, %1001, %1001, %1111, %1001, %1001, %1001),
      { 'B' } (%1110, %1001, %1001, %1110, %1001, %1001, %1110),
      { 'C' } (%0111, %1000, %1000, %1000, %1000, %1000, %0111),
      { 'D' } (%1110, %1001, %1001, %1001, %1001, %1001, %1110),
      { 'E' } (%1111, %1000, %1000, %1110, %1000, %1000, %1111),
      { 'F' } (%1111, %1000, %1000, %1110, %1000, %1000, %1000)
    );
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure DrawToBuffer(AInputData: TDisplayedData); override;
    procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer); override;
  end;
var
  FrameX: Byte = 14;
  FrameY: Byte = 28;
    
implementation

// ---- PROTECTED METHODS ----

// DRAW A DOT
procedure TDisplayTIL311.DrawDot(AStatus: Boolean; Ax, Ay: Byte);
begin
  Ax := Ax + FrameX div 2;
  Ay := Ay + FrameY div 2;
  if AStatus then
  begin
    FBuffer.Canvas.Brush.Color := RETRO_RED_ON;
    FBuffer.Canvas.Pen.Color := RETRO_RED_GLOW;
  end else
  begin
    FBuffer.Canvas.Brush.Color := RETRO_RED_OFF;
    FBuffer.Canvas.Pen.Color := RETRO_RED_OFF;
  end;
  FBuffer.Canvas.Ellipse(Ax - 3, Ay - 3, Ax + 4, Ay + 4);
end;

// ---- PUBLIC METHODS ----

// CREATE TDISPLAYTIL311 INSTANCE
constructor TDisplayTIL311.Create;
begin
  inherited Create;
  FModname := 'TIL311';
  FDescription := 'Texas Instruments TIL311 LED display (1972)';
  FBuffer.Width := 104 + FrameX;
  FBuffer.Height := 94 + FrameY;
  Reset;
end;

// DESTROY TDISPLAYTIL311 INSTANCE
destructor TDisplayTIL311.Destroy;
begin
  inherited Destroy;
end;

// DRAW DISPLAYED DATA TO INTERNAL BUFFER
procedure TDisplayTIL311.DrawToBuffer(AInputData: TDisplayedData);
var
  b, Bit, Line: Byte;
begin
  // background
  FBuffer.Canvas.Brush.Color := RETRO_RED_BG;
  FBuffer.Canvas.FillRect(0, 0, FBuffer.Width, FBuffer.Height);
  if AInputData.Blank then exit;
  // sign
  for b := 0 to 6 do
  begin
    Line := CHARMAP_TIL311[AInputData.Value, b];
    for Bit := 0 to 3 do
      if not(((b = 1) or (b = 2) or (b = 4) or (b = 5)) and
             ((Bit = 1) or (Bit = 2))) then
        DrawDot(((Line and (1 shl Bit)) <> 0), 79 - (Bit * 14) - b, 5 + (b * 14));
  end;
  // decimal points
  DrawDot(AInputData.LeftDot, 3, 91);
  DrawDot(AInputData.RightDot, 101, 91);
end;

// DRAWING TO CANVAS OF THE TARGET OBJECT
procedure TDisplayTIL311.RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);
begin
  ATargetCanvas.Draw(Ax, Ay, FBuffer);
end;

end.
