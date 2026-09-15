{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmregviewer.pas                                                         | }
{ | RegViewer form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmregviewer;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ValEdit, core_cpu, uconfig;
type
  { TForm11 }
  TForm11 = class(TForm)
    Bevel1:           TBevel;
    Button1:          TButton;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FProcInstance: TCPU;                                          // TCPU object
    procedure ProcInstanceDestroy(Sender: TCPU);      // Processor destroy event
    procedure SetFProcInstance(AProcInstance: TCPU);
  public
    property ProcInstance: TCPU write SetFProcInstance;
  end;
var
  Form11: TForm11;

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Cannot open processor modul.';
  MSG03 = 'Register';
  MSG04 = 'Value';

implementation

{$R *.lfm}
{ TForm11 }


{
// REFRESH REGISTER LIST
procedure TForm1.RefreshRegisters(Direction: TOpDirection);
var
  b: Byte;
begin
  if Assigned(CurrentProcessor) then
  begin
    // get number of registers
    RegCount := CurrentProcessor.GetRegisterCount;
    SetLength(RegNames, RegCount);
    SetLength(RegValues, RegCount);
    SetLength(RegSize, RegCount);
    // get registers' name
    for b := 0 to RegCount - 1 do
    begin
      RegNames[b] := CurrentProcessor.GetRegisterName(b);
      RegSize[b] := CurrentProcessor.GetRegisterSize(b);
    end;
    if Direction = opVar2List then
    begin
      with ValueListEditor2 do
      begin
        Col := 0;
        Row := 1;
        Clear;
        DefaultRowHeight := 20;
        Strings.BeginUpdate;
        for b := 0 to RegCount - 1 do
        begin
          // registers to array
          RegValues[b] := CurrentProcessor.GetRegister(RegNames[b]);
          // array to ValueListEditor2
          Strings.Add(StrPas(RegNames[b]) + '=' + IntToHex(RegValues[b], RegSize[b]));
        end;
        Strings.EndUpdate;
      end;
    end else
    begin
      for b := 0 to RegCount - 1 do
      begin
        // ValueListEditor2 to array
        RegValues[b] := StrToInt('$' + ValueListEditor2.Values[StrPas(RegNames[b])]);
        // array to registers
        CurrentProcessor.SetRegister(RegNames[b], RegValues[b]);
      end;
    end;
  end;
end;
}


// ---- PRIVATE METHODS ----

// PROCESSOR DESTROY EVENT
procedure TForm11.ProcInstanceDestroy(Sender: TCPU);
begin
  if Sender = FProcInstance then
  begin
    FProcInstance := nil;
    ShowMessage(MSG01 + MSG02);
    Hide;
  end;
end;

// SET INSTANCE
procedure TForm11.SetFProcInstance(AProcInstance: TCPU);
begin
  if not Assigned(AProcInstance) then
  begin
    ShowMessage(MSG01 + MSG02);
    Exit;
  end;
  FProcInstance := AProcInstance;
  FProcInstance.OnDestroy := @ProcInstanceDestroy;
end;

// ---- PUBLIC METHODS ----

// ---- EVENT HANDLER METHODS ----

// HIDE FORM
procedure TForm11.Button1Click(Sender: TObject);
begin
  Form11.Hide;
end;

// ACTIVATE FORM
procedure TForm11.FormActivate(Sender: TObject);
begin

end;

// CREATE FORM
procedure TForm11.FormCreate(Sender: TObject);
begin
  ValueListEditor1.TitleCaptions.Add(MSG01);
  ValueListEditor1.TitleCaptions.Add(MSG02);
end;

// SHOW FORM
procedure TForm11.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.ModuleExplorerConfig do
  begin
    Form11.Top := top;
    Form11.Left := left;
    Form11.Height := height;
    Form11.Width := width;
    ValueListEditor1.ColWidths[0] := column0_width;
  end;
end;

// CLOSE FORM
procedure TForm11.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store settings
  with uconfig.AppConfig.RegViewerConfig do
  begin
    top := Form11.Top;
    left := Form11.Left;
    height := Form11.Height;
    width := Form11.Width;
    column0_width := ValueListEditor1.ColWidths[0];
  end;
end;

end.

