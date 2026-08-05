{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | led_round.pas                                                            | }
{ | Round LED class                                                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit led_round;
{$MODE OBJFPC}{$H+}
interface
uses
  Graphics, core_led;
type
  // TLEDRound display class
  TLEDRound = class(TLED)
  protected
  public
    constructor Create; override;
    procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);override;
    procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer); override;
  end;
var
  FrameX: Byte = 6; 
  FrameY: Byte = 6;
    
implementation

// ---- PUBLIC METHODS ----

// CREATE TLEDROUND INSTANCE
constructor TLEDRound.Create;
begin
  inherited Create;
  FModname := 'Round LED';
  FDescription := 'Red, green or yellow color round LED';
  FBuffer.Width := 14 + FrameX;
  FBuffer.Height := 14 + FrameY;
  Reset;
end;

// DRAW DISPLAYED DATA TO INTERNAL BUFFER
procedure TLEDRound.DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);
var
  cx, cy: Byte;
begin
  // center
  cx := FBuffer.Width div 2;
  cy := FBuffer.Height div 2;
  // background
  FBuffer.Canvas.Pen.Width := 1;
  FBuffer.Canvas.Pen.Color := clBlack;
  FBuffer.Canvas.Brush.Color := ABGColor;
  FBuffer.Canvas.FillRect(0, 0, FBuffer.Width, FBuffer.Height);
  // state
  if AIsOn then
  begin
    // - on
    FBuffer.Canvas.Brush.Color := AColor.OnColor;
    FBuffer.Canvas.Ellipse(cx - 7, cy - 7, cx + 7, cy + 7);
    // - glow
    FBuffer.Canvas.Pen.Color := AColor.Glow;
    FBuffer.Canvas.Brush.Color := AColor.Glow;
    FBuffer.Canvas.Ellipse(cx - 3, cy - 3, cx + 3, cy + 3);
    // - reflection
    FBuffer.Canvas.Pen.Color := clWhite;
    FBuffer.Canvas.Ellipse(cx - 3, cy - 3, cx - 1, cy - 1);
  end else
  begin
    // - off
    FBuffer.Canvas.Brush.Color := AColor.OffColor;
    FBuffer.Canvas.Ellipse(cx - 7, cy - 7, cx + 7, cy + 7);
    // - reflection
    FBuffer.Canvas.Pen.Color := clSilver;
    FBuffer.Canvas.Ellipse(cx - 3, cy - 3, cx - 1, cy - 1);
  end;
end;

// DRAWING TO CANVAS OF THE TARGET OBJECT
procedure TLEDRound.RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);
begin
  ATargetCanvas.Draw(Ax, Ay, FBuffer);
end;

end.
