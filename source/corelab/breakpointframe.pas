{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | breakpointframe.pas                                                      | }
{ | Template frame for Breakpoint Manager form                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit breakpointframe;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, StdCtrls;
type
  { TFrame1 }
  TFrame1 = class(TFrame)
    Button3:   TButton;
    CheckBox1: TCheckBox;
    Edit1:     TEdit;
    procedure Button3Click(Sender: TObject);
  private
  public
  end;

implementation

{$R *.lfm}

{ TFrame1 }

// DESTROY LINE
procedure TFrame1.Button3Click(Sender: TObject);
begin
  Free;
end;

end.

