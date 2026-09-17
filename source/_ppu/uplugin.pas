{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uplugin.pas                                                              | }
{ | Plugin handler procedures and functions                                  | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uplugin;
{$MODE OBJFPC} {$H+} {$MACRO ON}
{$I define.pas}
interface
uses
  Classes, FileUtil, StrUtils, SysUtils, Generics.Collections, dynlibs, core_cpu,
  core_memory, core_ioport;
type
  // procedural types pointing to the plugin entry point
  TIOPortCreateFunc = function: TIOPort; CALLTYPE;
  TIOPortDestroyProc = procedure(AIOPort: TIOPort); CALLTYPE;
  TIOPortLoadStateFunc = function(AIOPort: TIOPort; AStream: TStream): Boolean; CALLTYPE;
  TIOPortSaveStateFunc = function(AIOPort: TIOPort; AStream: TStream): Boolean; CALLTYPE;
  TIOPortCreatePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortShowPanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortHidePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortFreePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortRenamePanelProc = procedure(APort: TIOPort; Caption: PChar); CALLTYPE;
  TIOPortResizePanelFunc = function(APort: TIOPort; Width, Height: Integer): Boolean; CALLTYPE;
  TIOPortMovePanelFunc = function(APort: TIOPort; Left, Top: Integer): Boolean; CALLTYPE;
  TIOPortSetIntHandlerProc = procedure(APort: TIOPort; IntProc: TInterruptCallback; IntVector: Byte); CALLTYPE;
  TMemoryCreateFunc = function: TMemory; CALLTYPE;
  TMemoryDestroyProc = procedure(AMemory: TMemory); CALLTYPE;
  TMemoryLoadStateFunc = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  TMemorySaveStateFunc = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  TProcessorCreateFunc = function: TCPU; CALLTYPE;
  TProcessorDestroyProc = procedure(Processor: TCPU); CALLTYPE;
  TProcessorLoadStateFunc = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  TProcessorSaveStateFunc = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  // loaded processor plugin modules
  TProcPluginItem = class
    FHandle:    TLibHandle;
    FCreate:    TProcessorCreateFunc;
    FDestroy:   TProcessorDestroyProc;
    FLoadState: TProcessorLoadStateFunc;
    FSaveState: TProcessorSaveStateFunc;
    destructor Destroy; override;
  end;
  // loaded memory plugin modules
  TMemPluginItem = class
    FHandle:    TLibHandle;
    FCreate:    TMemoryCreateFunc;
    FDestroy:   TMemoryDestroyProc;
    FLoadState: TMemoryLoadStateFunc;
    FSaveState: TMemorySaveStateFunc;
    destructor Destroy; override;
  end;
  // loaded i/o port plugin modules
  TPortPluginItem = class
    FHandle:        TLibHandle;
    FCreate:        TIOPortCreateFunc;
    FDestroy:       TIOPortDestroyProc;
    FLoadState:     TIOPortLoadStateFunc;
    FSaveState:     TIOPortSaveStateFunc;
    FCreatePanel:   TIOPortCreatePanelProc;
    FShowPanel:     TIOPortShowPanelProc;
    FHidePanel:     TIOPortHidePanelProc;
    FFreePanel:     TIOPortFreePanelProc;
    FRenamePanel:   TIOPortRenamePanelProc;
    FResizePanel:   TIOPortResizePanelFunc;
    FMovePanel:     TIOPortMovePanelFunc;
    FSetIntHandler: TIOPortSetIntHandlerProc;
    destructor Destroy; override;
  end;
  // plugin dictionary types
  TProcPluginDict = specialize TObjectDictionary<string, TProcPluginItem>;
  TMemPluginDict = specialize TObjectDictionary<string, TMemPluginItem>;
  TPortPluginDict = specialize TObjectDictionary<string, TPortPluginItem>;
var
  FProcPluginDict: TProcPluginDict;                  // loaded processor plugins
  FMemPluginDict:  TMemPluginDict;                      // loaded memory plugins
  FPortPluginDict: TPortPluginDict;                   // loaded i/o port plugins

function LoadAllPlugins(ADirectory: string): Integer;
function UnLoadAllPlugins: Boolean;

implementation

// DESTROY PROCESSOR DICTIONARY ITEM
destructor TProcPluginItem.Destroy;
begin
  if FHandle <> NilHandle then UnloadLibrary(FHandle);
  inherited Destroy;
end;

// DESTROY MEMORY DICTIONARY ITEM
destructor TMemPluginItem.Destroy;
begin
  if FHandle <> NilHandle then UnloadLibrary(FHandle);
  inherited Destroy;
end;

// DESTROY I/O PORT DICTIONARY ITEM
destructor TPortPluginItem.Destroy;
begin
  if FHandle <> NilHandle then UnloadLibrary(FHandle);
  inherited Destroy;
end;

// LOAD ALL PLUGIN
function LoadAllPlugins(ADirectory: string): Integer;
var
  i:              Integer;
  LibList:        TStringList;
  LibName:        string;
  ProcPluginItem: TProcPluginItem;
  MemPluginItem:  TMemPluginItem;
  PortPluginItem: TPortPluginItem;
begin
  Result := 0;
  LibList := FindAllFiles(ADirectory, '*.dll;*.so', False);
  LibList.Sort;
  try
    if LibList.Count = 0 then Result := -1 else
    begin
      // create dictionaries
      FProcPluginDict := TProcPluginDict.Create([doOwnsValues]);
      FMemPluginDict := TMemPluginDict.Create([doOwnsValues]);
      FPortPluginDict := TPortPluginDict.Create([doOwnsValues]);
      // add records
      for i := 0 to LibList.Count - 1 do
      begin
        // cpu_*.*
        if ContainsText(LibList.Strings[i], 'cpu_') then
        begin
          ProcPluginItem := TProcPluginItem.Create;
          ProcPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
          if ProcPluginItem.FHandle <> NilHandle then
          begin
            Pointer(ProcPluginItem.FCreate) :=
              GetProcedureAddress(ProcPluginItem.FHandle, 'cpu_create');
            Pointer(ProcPluginItem.FDestroy) :=
              GetProcedureAddress(ProcPluginItem.FHandle, 'cpu_destroy');
            Pointer(ProcPluginItem.FLoadState) :=
              GetProcedureAddress(ProcPluginItem.FHandle, 'cpu_loadstate');
            Pointer(ProcPluginItem.FSaveState) :=
              GetProcedureAddress(ProcPluginItem.FHandle, 'cpu_savestate');
            LibName := ChangeFileExt(ExtractFileName(LibList.Strings[i]), '');
            if LibName.StartsWith('lib', True)
              then LibName := Copy(LibName, 4, Length(LibName));
            FProcPluginDict.Add(LibName, ProcPluginItem);
            Inc(Result);
          end else ProcPluginItem.Free;
        end;
        // ioport_*.*
        if ContainsText(LibList.Strings[i], 'ioport_') then
        begin
          PortPluginItem := TPortPluginItem.Create;
          PortPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
          if PortPluginItem.FHandle <> NilHandle then
          begin
            // get exported methods address
            Pointer(PortPluginItem.FCreate) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_create');
            Pointer(PortPluginItem.FDestroy) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_destroy');
            Pointer(PortPluginItem.FLoadState) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_loadstate');
            Pointer(PortPluginItem.FSaveState) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_savestate');
            Pointer(PortPluginItem.FCreatePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_createpanel');
            Pointer(PortPluginItem.FFreePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_freepanel');
            Pointer(PortPluginItem.FShowPanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_showpanel');
            Pointer(PortPluginItem.FHidePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_hidepanel');
            Pointer(PortPluginItem.FRenamePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_renamepanel');
            Pointer(PortPluginItem.FResizePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_resizepanel');
            Pointer(PortPluginItem.FMovePanel) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_movepanel');
            Pointer(PortPluginItem.FSetIntHandler) :=
              GetProcedureAddress(PortPluginItem.FHandle, 'ioport_setinthandler');
            LibName := ChangeFileExt(ExtractFileName(LibList.Strings[i]), '');
            if LibName.StartsWith('lib', True)
              then LibName := Copy(LibName, 4, Length(LibName));
            FPortPluginDict.Add(LibName, PortPluginItem);
            Inc(Result);
          end else PortPluginItem.Free;
        end;
        // memory_*.*
        if ContainsText(LibList.Strings[i], 'memory_') then
        begin
          MemPluginItem := TMemPluginItem.Create;
          MemPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
          if MemPluginItem.FHandle <> NilHandle then
          begin
            Pointer(MemPluginItem.FCreate) :=
              GetProcedureAddress(MemPluginItem.FHandle, 'memory_create');
            Pointer(MemPluginItem.FDestroy) :=
              GetProcedureAddress(MemPluginItem.FHandle, 'memory_destroy');
            Pointer(MemPluginItem.FLoadState) :=
              GetProcedureAddress(MemPluginItem.FHandle, 'memory_loadstate');
            Pointer(MemPluginItem.FSaveState) :=
              GetProcedureAddress(MemPluginItem.FHandle, 'memory_savestate');
            LibName := ChangeFileExt(ExtractFileName(LibList.Strings[i]), '');
            if LibName.StartsWith('lib', True)
              then LibName := Copy(LibName, 4, Length(LibName));
            FMemPluginDict.Add(LibName, MemPluginItem);
            Inc(Result);
          end else MemPluginItem.Free;
        end;
      end;
    end;
  finally
    LibList.Free;
  end;
end;

// UNLOAD ALL PLUGIN
function UnLoadAllPlugins: Boolean;
begin
  FreeAndNil(FPortPluginDict);
  FreeAndNil(FMemPluginDict);
  FreeAndNil(FProcPluginDict);
  Result := True;
end;

end.

