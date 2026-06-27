{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmmain;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ValEdit, ExtCtrls, EditBtn, ShellCtrls, DynLibs, core_memory;
type
  TPluginAttributes = record
    PFilename: string;                                 // Filename of the module
    PModname: string;                                             // Module name
    PDescription: string;                                   // Short description
    PAddressRangeSize: byte;                               // Address range size
    PEnabled: boolean;                    // Enable port without detach from bus
    PMemoryMode: TMemoryMode;                           // Memory operation mode
  end;
  // port
  TCreateMemoryFunc = function: TMemory; cdecl;
  TDestroyMemoryProc = procedure(Memory: TMemory); cdecl;
  { TForm1 }
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DirectoryEdit1: TDirectoryEdit;
    Panel1: TPanel;
    ShellListView1: TShellListView;
    Splitter1: TSplitter;
    ValueListEditor1: TValueListEditor;
    ValueListEditor2: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    // port
    CreateMemory: TCreateMemoryFunc;
    DestroyMemory: TDestroyMemoryProc;
    CurrentMemory: TMemory;                   // created object of TMemory class
    // module
    LibHandle: TLibHandle;                        // handle of the loaded module
    LoadedPlugin: TPluginAttributes;          // properties of the loaded module
  public
  end;
var
  Form1: TForm1;
const
  ER = 'ERROR: ';
  MemoryModeNames: array[TMemoryMode] of string = ('Read only', 'Read/write');

implementation

{$R *.lfm}
{ TForm1 }

// Refresh plugin list
procedure TForm1.Button4Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ShellListView1.Mask := 'ioport_*.dll';
  {$ELSE}
    ShellListView1.Mask := 'libioport_*.so';
  {$ENDIF}
  try
    ShellListView1.Root := DirectoryEdit1.Directory;
    Button3.Enabled := true;
  except
    ShowMessage(ER + 'There is not such directory!');
    ShellListView1.Root := '.';
    Button3.Enabled := false;
  end;
end;

// Select plugin
procedure TForm1.Button3Click(Sender: TObject);
var
  b: byte;
  SelectedFile: string;
begin
  if ShellListView1.Selected <> nil then
  begin
    SelectedFile := ShellListView1.GetPathFromItem(ShellListView1.Selected);
    // remove previous loaded module
    // port
    if Assigned(CurrentMemory) then
    begin
      DestroyMemory(CurrentMemory);
      CurrentMemory := nil;
    end;
    // module
    if LibHandle <> NilHandle then
    begin
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      CreateMemory := nil;
      DestroyMemory := nil;
    end;
    // load module
    LibHandle := LoadLibrary(SelectedFile);
    if LibHandle = NilHandle then
    begin
      ShowMessage(ER + 'Cannot load this module: ' + SelectedFile);
      exit;
    end;
    // search exported function and instantiation
    Pointer(CreateMemory) := GetProcedureAddress(LibHandle, 'ioport_create');
    Pointer(DestroyMemory) := GetProcedureAddress(LibHandle, 'ioport_destroy');
    if (Assigned(CreateMemory)) and (Assigned(DestroyMemory)) then
    begin
      CurrentMemory := CreateMemory();
      with LoadedPlugin do
      begin
        // get properties
        PFilename := SelectedFile;
        if Assigned(CurrentMemory.Modname)
          then PModname := string(CurrentMemory.Modname)
          else PModname := '';
        if Assigned(CurrentMemory.Description)
          then PDescription := string(CurrentMemory.Description)
          else PDescription := '';
        PAddressRangeSize := CurrentMemory.AddressRangeSize;
        PEnabled := CurrentMemory.Enabled;
        PMemoryMode := CurrentMemory.MemoryMode;
      end;
      // show properties
      with ValueListEditor1 do
      begin
        Clear;
        InsertRow('Filename', LoadedPlugin.PFilename,true);
        InsertRow('Modname',  LoadedPlugin.PModname, true);
        InsertRow('Description', LoadedPlugin.PDescription, true);
        InsertRow('AddressRangeSize', LoadedPlugin.PAddressRangeSize.ToString, true);
        InsertRow('Enabled', BoolToStr(LoadedPlugin.PEnabled, 'Yes', 'No'), true);
        InsertRow('MemoryMode', MemoryModeNames[LoadedPlugin.PMemoryMode], true);
        AutoSizeColumn(0);
      end;
      // preset address/data table
      ValueListEditor2.Clear;
      for b := 0 to LoadedPlugin.PAddressRangeSize - 1 do
      begin
        ValueListEditor2.InsertRow('BA+' + b.ToString, '', true);
        ValueListEditor2.Cells[1,b + 1] := '0';
      end;
      if LoadedPlugin.PMemoryMode = pmReadOnly
        then Button2.Enabled := false
        else Button2.Enabled := true;
      ValueListEditor2.Enabled := true;
      Form1.Caption := Application.Title + ' - ' + ShellListView1.Selected.Caption;
    end else
    begin
      ShowMessage(ER + 'It is not a CoreLAB Memory module!');
      ValueListEditor1.Clear;
      ValueListEditor2.Clear;
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      ValueListEditor2.Enabled := false;
      Button1.Enabled := false;
      Button2.Enabled := false;
    end;
  end;
end;

// Read data from port
procedure TForm1.Button1Click(Sender: TObject);
var
  InAddr, InData: byte;
begin
  InAddr := ValueListEditor2.Row - 1;
  if Assigned(CurrentMemory) then
  begin
    CurrentMemory.Enabled := True;
    InData := CurrentMemory.ReadMemory(InAddr);
    ShowMessage(IntToHex(InData, 2) + 'H read from port ' + IntToHex(InAddr, 2) + 'H.');
  end;
  ValueListEditor2.Cells[1, ValueListEditor2.Row] := IntToHex(InData, 2);
end;

// Write data to port
procedure TForm1.Button2Click(Sender: TObject);
var
  OutAddr, OutData: integer;
begin
  OutAddr := ValueListEditor2.Row - 1;
  OutData := 0;
  if TryStrToInt('$' + ValueListEditor2.Cells[1, ValueListEditor2.Row], OutData) then
  begin
    if Assigned(CurrentMemory) then
    begin
      CurrentMemory.Enabled := True;
      CurrentMemory.WriteMemory(OutAddr, OutData);
      ShowMessage('The ' + IntToHex(OutData, 2) + 'H is written to port ' + IntToHex(OutAddr, 2) + 'H.');
    end;
  end;
end;

// Close application
procedure TForm1.Button5Click(Sender: TObject);
begin
  Form1.Close;
end;

// OnCreate event
procedure TForm1.FormCreate(Sender: TObject);
begin
  CreateMemory := nil;
  CurrentMemory := nil;
  CreateMemory := nil;
  DestroyMemory := nil;
  LibHandle := NilHandle;
  Form1.Caption := Application.Title;
  ValueListEditor2.Cells[0,1] := 'BA+0';
  ValueListEditor2.Cells[1,1] := '0';
  ValueListEditor2.Enabled := false;
  Button1.Enabled := false;
  Button2.Enabled := false;
  Button3.Enabled := false;
  Button4.Click;
end;

// OnDestroy event
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // memory
  if Assigned(CurrentMemory) then
  begin
    DestroyMemory(CurrentMemory);
    CurrentMemory := nil;
  end;
  // module
  if LibHandle <> NilHandle then
  begin
    LibHandle := NilHandle;
    CreateMemory := nil;
    DestroyMemory := nil;
  end;
end;

end.
