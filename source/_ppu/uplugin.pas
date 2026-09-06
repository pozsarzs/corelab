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
  // loaded processor plugin modules
  TProcPluginItem = class
    FHandle: TLibHandle;
    // egyéb eljárásmutatók ide jönnek majd
    destructor Destroy; override;
  end;
  // loaded memory plugin modules
  TMemPluginItem = class
    FHandle: TLibHandle;
    // egyéb eljárásmutatók ide jönnek majd
    destructor Destroy; override;
  end;
  // loaded i/o port plugin modules
  TPortPluginItem = class
    FHandle: TLibHandle;
    // egyéb eljárásmutatók ide jönnek majd
    destructor Destroy; override;
  end;
  // loaded plugin dictionaries
  TProcPluginDict = specialize TObjectDictionary<string, TProcPluginItem>;
  TMemPluginDict = specialize TObjectDictionary<string, TMemPluginItem>;
  TPortPluginDict = specialize TObjectDictionary<string, TPortPluginItem>;
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
var
  FProcPluginDict: TProcPluginDict;
  FMemPluginDict:  TMemPluginDict;
  FPortPluginDict: TPortPluginDict;

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
            FProcPluginDict.Add(ChangeFileExt(ExtractFileName(LibList.Strings[i]), ''), ProcPluginItem);
            Inc(Result);
          end else ProcPluginItem.Free;
        end;
        // memory_*.*
        if ContainsText(LibList.Strings[i], 'memory_') then
        begin
          MemPluginItem := TMemPluginItem.Create;
          MemPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
          if MemPluginItem.FHandle <> NilHandle then
          begin
            FMemPluginDict.Add(ChangeFileExt(ExtractFileName(LibList.Strings[i]), ''), MemPluginItem);
            Inc(Result);
          end else MemPluginItem.Free;
        end;
        // ioport_*.*
        if ContainsText(LibList.Strings[i], 'ioport_') then
        begin
          PortPluginItem := TPortPluginItem.Create;
          PortPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
          if PortPluginItem.FHandle <> NilHandle then
          begin
            FPortPluginDict.Add(ChangeFileExt(ExtractFileName(LibList.Strings[i]), ''), PortPluginItem);
            Inc(Result);
          end else PortPluginItem.Free;
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

