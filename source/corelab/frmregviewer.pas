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
    Button2:          TButton;
    Button3:          TButton;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FProcInstance: TCPU;                                          // TCPU object
    FRegNames:     array of PChar;                    // imported register names
    FRegValues:    array of Word;                    // imported register values
    FRegSize:      array of Byte;                    // register size in nibbles
    FRegCount:     Byte;                          // number of the all registers
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

// ---- PRIVATE METHODS ----

// PROCESSOR DESTROY EVENT
procedure TForm11.ProcInstanceDestroy(Sender: TCPU);
begin
  if Sender = FProcInstance then
  begin
    FProcInstance := nil;
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

// ---- EVENT HANDLER METHODS ----

// HIDE FORM
procedure TForm11.Button1Click(Sender: TObject);
begin
  Form11.Hide;
end;

// PUT VALUES TO PROCESSOR
procedure TForm11.Button2Click(Sender: TObject);
var
  b: Byte;
begin
  for b := 0 to FRegCount - 1 do
  begin
    // ValueListEditor1 to array
    FRegValues[b] := StrToInt('$' + ValueListEditor1.Values[StrPas(FRegNames[b])]);
    // array to registers
    FProcInstance.SetRegister(FRegNames[b], FRegValues[b]);
  end;
end;

// GET VALUES FROM PROCESSOR
procedure TForm11.Button3Click(Sender: TObject);
var
  b: Byte;
begin
  with ValueListEditor1 do
  begin
    Col := 0;
    Row := 1;
    Clear;
    DefaultRowHeight := 20;
    Strings.BeginUpdate;
    for b := 0 to FRegCount - 1 do
    begin
      // registers to array
      FRegValues[b] := FProcInstance.GetRegister(FRegNames[b]);
      // array to ValueListEditor1
      Strings.Add(StrPas(FRegNames[b]) + '=' + IntToHex(FRegValues[b], FRegSize[b]));
    end;
    Strings.EndUpdate;
  end;
end;

// CREATE FORM
procedure TForm11.FormCreate(Sender: TObject);
begin
  ValueListEditor1.TitleCaptions.Add(MSG03);
  ValueListEditor1.TitleCaptions.Add(MSG04);
end;

// SHOW FORM
procedure TForm11.FormShow(Sender: TObject);
var
  b: Byte;
begin
  // retrieve settings
  with uconfig.AppConfig.RegViewerConfig do
  begin
    Form11.Top := top;
    Form11.Left := left;
    Form11.Height := height;
    Form11.Width := width;
    ValueListEditor1.ColWidths[0] := column0_width;
  end;
  if Assigned(FProcInstance) then
  begin
    // get number of registers
    FRegCount := FProcInstance.GetRegisterCount;
    SetLength(FRegNames, FRegCount);
    SetLength(FRegValues, FRegCount);
    SetLength(FRegSize, FRegCount);
    // get registers' name
    for b := 0 to FRegCount - 1 do
    begin
      FRegNames[b] := FProcInstance.GetRegisterName(b);
      FRegSize[b] := FProcInstance.GetRegisterSize(b);
    end;
  end;
  Button3Click(Sender);
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

