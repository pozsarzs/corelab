{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmproperties.pas                                                        | }
{ | Modul properties form                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmproperties;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ValEdit;
type
  { TForm15 }
  TForm15 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    ValueListEditor1: TValueListEditor;
  private
  public
  end;
var
  Form15: TForm15;

implementation

{$R *.lfm}

end.

