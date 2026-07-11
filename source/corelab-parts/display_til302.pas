{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | display_til302.pas                                                       | }
{ | TIL302 display class                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit display_til302;
{$MODE OBJFPC}{$H+}
interface
uses
  Graphics, core_display;
type
  // TIL302 display class
  TDisplayTIL302 = class(TDisplay)
  protected
    procedure DrawDot(Status: Boolean; x, y: Byte);
    procedure DrawLine(Status: Boolean; x1, y1, x2, y2: Byte);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure DrawToBuffer(InputData: TDisplayedData); override;
    procedure RenderTo(TargetCanvas: TCanvas; x, y: Integer); override;
  end;
var
  FrameX: Byte = 14;
  FrameY: Byte = 28;
    
implementation

// CREATE TDISPLAYTIL302 INSTANCE
constructor TDisplayTIL302.Create;
begin
  inherited Create;
  FModname := 'TIL302';
  FDescription := 'Texas Instruments TIL302 LED display (1971)';
  FBuffer.Width := 104 + FrameX;
  FBuffer.Height := 94 + FrameY;
  Reset;
end;

// DESTROY TDISPLATIL302Y INSTANCE
destructor TDisplayTIL302.Destroy;
begin
  inherited Destroy;
end;

// DRAW A DOT
procedure TDisplayTIL302.DrawDot(Status: Boolean; x, y: Byte);
begin
  x := x + FrameX div 2;
  y := y + FrameY div 2;
  if Status then
  begin
    FBuffer.Canvas.Brush.Color := RETRO_RED_ON;
    FBuffer.Canvas.Pen.Color := RETRO_RED_GLOW;
  end else
  begin
    FBuffer.Canvas.Brush.Color := RETRO_RED_OFF;
    FBuffer.Canvas.Pen.Color := RETRO_RED_OFF;
  end;
  FBuffer.Canvas.Ellipse(x - 2, y - 2, x + 2, y + 2);
end;

// DRAW LINE
procedure TDisplayTIL302.DrawLine(Status: Boolean; x1, y1, x2, y2: Byte);
var
  cx, cy: Double;
  d: Double;                                                // length of segment
  dx, dy: Integer;                // different between segment's end coordinates
  dx_seg, dy_seg, dx_gap, dy_gap: Double;                        // x, y movings 
  i: Integer;
  l1: Double;                                                     // size of gap
  l2: Double;                                                   // size of stick
  n: Integer;                                                  // number of gaps
begin
  x1 := x1 + FrameX div 2;
  y1 := y1 + FrameY div 2;
  x2 := x2 + FrameX div 2;
  y2 := y2 + FrameY div 2;
  if Status then
  begin
    FBuffer.Canvas.Pen.Color := RETRO_RED_ON;
    FBuffer.Canvas.Pen.Width := 4;
    l1 := 5.0;                                              // 5 pixels size gap
    dx := x2 - x1;
    dy := y2 - y1;
    d := Sqrt(dx * dx + dy * dy);                            // thank Pythagoras
    // vertical segment: 3 gaps, horisontal segment: 4 gaps
    if y1 = y2 then n := 4 else n := 3;
    if d > ((n - 1) * l1) then
    begin
      // if segment's length better than n pcs. gaps length:
      l2 := (d - (n - 1) * l1) / n ;
      dx_seg := (dx * l2) / d;
      dy_seg := (dy * l2) / d;
      dx_gap := (dx * l1) / d;
      dy_gap := (dy * l1) / d;
      cx := x1;
      cy := y1;
      // drawing segment to internal buffer
      for i := 1 to n do
      begin
        FBuffer.Canvas.Line(Round(cx), Round(cy), Round(cx + dx_seg), Round(cy + dy_seg));
        // next position
        cx := cx + dx_seg + dx_gap;
        cy := cy + dy_seg + dy_gap;
      end;
    end
    else
    begin
      // non-dashed segment
      FBuffer.Canvas.Line(x1, y1, x2, y2);
    end;
  end;
end;

// DRAW DISPLAYED DATA TO INTERNAL BUFFER
procedure TDisplayTIL302.DrawToBuffer(InputData: TDisplayedData);
begin
  // background
  FBuffer.Canvas.Brush.Color := RETRO_RED_BG;
  FBuffer.Canvas.FillRect(0, 0, FBuffer.Width, FBuffer.Height);
  if InputData.Blank then exit;
  // segments
  DrawLine((InputData.Segments and $01 = $01), 43, 05, 85, 05);
  DrawLine((InputData.Segments and $02 = $02), 85, 05, 79, 47);
  DrawLine((InputData.Segments and $04 = $04), 79, 47, 73, 89);
  DrawLine((InputData.Segments and $08 = $08), 31, 89, 73, 89);
  DrawLine((InputData.Segments and $10 = $10), 31, 89, 37, 47);
  DrawLine((InputData.Segments and $20 = $20), 37, 47, 43, 05);
  DrawLine((InputData.Segments and $40 = $40), 37, 47, 79, 47);
  // decimal points
  DrawDot(InputData.LeftDot, 3, 91);
  DrawDot(InputData.RightDot, 101, 91);
end;

// DRAWING TO CANVAS OF THE TARGET OBJECT
procedure TDisplayTIL302.RenderTo(TargetCanvas: TCanvas; x, y: Integer);
begin
  TargetCanvas.Draw(x, y, FBuffer);
end;

end.
