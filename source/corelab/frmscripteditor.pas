unit frmscripteditor;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TForm6 = class(TForm)
  private

  public
    procedure ReLoad;

  end;
// ha OnShow, akkor buffer frissítés!
var
  Form6: TForm6;

implementation

{$R *.lfm}

procedure TForm6.ReLoad;
begin

end;

end.

