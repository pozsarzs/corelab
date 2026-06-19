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
{$mode objfpc}{$H+}
interface
uses
  Graphics, core_display;
type
  // TIL311 display implementation
  TDisplayTIL311 = class(TDisplay)
  protected
    const CHARMAP_TIL311: array[0..15, 0..6] of byte = (
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
    procedure DrawToBuffer(InputData: TDisplayedData); override;
    procedure RenderTo(TargetCanvas: TCanvas; x, y: integer); override;
  end;
    
implementation

// Create TDisplay instance
constructor TDisplayTIL311.Create;
begin
  inherited Create;
  FModname := 'TIL311';
  FDescription := 'Texas Instruments TIL311 LED display';
  Buffer.Width := 104 + 14;
  Buffer.Height := 94 + 28;
  Reset;
end;

// Destroy TDisplay instance
destructor TDisplayTIL311.Destroy;
begin
  inherited Destroy;
end;

// Draw displayed data to internal buffer
procedure TDisplayTIL311.DrawToBuffer(InputData: TDisplayedData);
var
  b, bit, line: byte;

// Draw a dot
procedure DrawDot(Status: boolean; x, y: byte);
begin
  x := x + 7;
  y := y + 14;
  if Status then
  begin
    Buffer.Canvas.Brush.Color := RETRO_RED_ON;
    Buffer.Canvas.Pen.Color := RETRO_RED_GLOW;
  end else
  begin
    Buffer.Canvas.Brush.Color := RETRO_RED_OFF;
    Buffer.Canvas.Pen.Color := RETRO_RED_OFF;
  end;
  Buffer.Canvas.Ellipse(x - 3, y - 3, x + 4, y + 4);
end;

begin
  // background
  Buffer.Canvas.Brush.Color := RETRO_RED_BG;
  Buffer.Canvas.FillRect(0, 0, Buffer.Width, Buffer.Height);
  if InputData.Blank then exit;
  // foreground
  for b := 0 to 6 do
  begin
    line := CHARMAP_TIL311[InputData.Value, b];
    for bit := 0 to 3 do
      DrawDot(((line and (1 shl bit)) <> 0), 79 - (bit * 14) - b, 5 + (b * 14));
  end;
end;

// Drawing to canvas of the target object
procedure TDisplayTIL311.RenderTo(TargetCanvas: TCanvas; x, y: integer);
begin
  TargetCanvas.Draw(x, y, Buffer);
end;

end.
