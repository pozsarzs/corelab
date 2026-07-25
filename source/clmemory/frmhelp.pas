{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmabout.pas                                                             | }
{ | Help form                                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmhelp;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, IpHtml, Ipfilebroker;
type
  { TForm3 }
  TForm3 = class(TForm)
    Button1: TButton;
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;
var
  Form3: TForm3;

implementation

{$R *.lfm}
{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
end;

end.

