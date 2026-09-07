# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt [pozsarzs@gmail.com](mailto:pozsarzs@gmail.com)

## Using Plugins

Accessing plugin methods goes through a strictly structured process from
exporting to the actual in-memory call.

### System Elements

|System Element   |Role                            |Task in the Process                                                                                |
|-----------------|--------------------------------|---------------------------------------------------------------------------------------------------|
|Plugin (DLL/SO)  |External module                 |Physically stores functions and publishes them to the operating system.                            |
|TMemPluginItem   |In-memory descriptor            |Stores the identifier of a loaded library (TLibHandle) and memory addresses (e.g., FCreate).       |
|FMemPluginDict   |Dictionary of available modules |Stores all loaded TMemPluginItem descriptors based on the filename (key).                          |
|Form16.PluginList|Visual selector                 |A visual list populated from the keys of *FMemPluginDict*, from which the user makes a selection.  |
|FMemInstanceDict |Dictionary of active instances  |Stores the actually running, instantiated memory modules with a unique name provided by the user.  |
|Form17.ModuleList|Visual selector                 |A visual list populated from the keys of *FMemInstanceDict*, from which the user makes a selection.|

### Execution Steps

1. ***Exporting*** (Plugin side): Methods written in the module must be
   explicitly published with a unique name (e.g., 'memory_create') so that they
   appear as callable, exported addresses for the framework.

```pascal
  function CreateMemory: TMemory; CALLTYPE; export;
  begin
    Result := TStandardMemory.Create;
  end;

  exports CreateMemory name 'memory_create';
```

2. ***Searching*** (Main program): The loader routine searches the folder for
   files with the appropriate prefix (e.g., memory_*.dll) and stores the results
   in a *TStringList* instance.

```pascal
  var LibList: TStringList;

  {...}

  LibList := FindAllFiles(ADirectory, 'memory_*.dll;memory_*.so', False);
```

3. ***Linking:*** With the LoadLibrary command, the program loads the external
   file into memory, which returns a unique identifier. The program stores this
   in the *FHandle* field of a new *TMemPluginItem* instance.

```pascal
  type
    // loaded plugin descriptor
    TMemPluginItem = class
      FHandle: TLibHandle;
      FCreate: TMemoryCreateFunc;
      destructor Destroy; override;
    end;
  var
    MemPluginItem: TMemPluginItem;
    
  {...}
  
  MemPluginItem := TMemPluginItem.Create;
  MemPluginItem.FHandle := LoadLibrary(LibList.Strings[i]);
```

4. ***Extracting addresses and assignment***: Based on the received library
   identifier and the exported name, the *GetProcedureAddress* function locates
   the exact physical memory address of the method within the loaded module.
   The main program assigns the received memory address to the descriptor's
   procedure pointer field (the *TMemPluginItem.FCreate* variable) using
   typecasting.

```pascal
  type
    // Type of the function to extract
    TMemoryCreateFunc = function: TMemory; CALLTYPE;
    
  {...}
  
  Pointer(MemPluginItem.FCreate) := GetProcedureAddress(MemPluginItem.FHandle,
                                    'memory_create');
```

5. ***Adding to the directory***: The completed descriptor object is added to
   the *FMemPluginDict* dictionary, making it searchable by the plugin module's
   name later.

```pascal
  type
    // Type of the dictionary storing descriptors
    TMemPluginDict = specialize TObjectDictionary<string, TMemPluginItem>;
  var
    FMemPluginDict: TMemPluginDict;
    
  {...}
  
  FMemPluginDict.Add(ChangeFileExt(ExtractFileName(LibList.Strings[i]), ''),
    MemPluginItem);
```

7. ***Calling and instantiation***: When a decision is made in the selector
   window, the program retrieves the corresponding descriptor from the
   dictionary, checks for the presence of the address, and executes the pointer
   within it (e.g., *FCreate()*).

```pascal
  type
    TMemInfo = record
      Memory:     TMemory;
      ModuleName: string;
    end;
  var 
    MemInfo:     TMemInfo;
    SelectedKey: string;

  {...}

  if Assigned(FMemPluginDict[SelectedKey].FCreate) then
  begin
    MemInfo.Memory := FMemPluginDict[SelectedKey].FCreate();
    MemInfo.ModuleName := SelectedKey;
  end;
```

8. ***Registration***: The new memory instance created as the function's return
   value is added to the *FMemInstanceDict* dictionary, making it available to
   the rest of the simulation.

```pascal
  type
    // Type of the dictionary storing active memory instances
    TMemInstanceDict = specialize TObjectDictionary<string, TMemInfo>;
  var
    FMemInstanceDict: TMemInstanceDict;
    MemInfo:          TMemInfo;

  {...}

  FMemInstanceDict.Add(SelectedName, MemInfo);
```

9. ***Usage***: To execute runtime operations (e.g., the Reset function), the
   program builds a list for the selector window (Form17) from the keys of the
   dictionary containing the active instances (*FMemInstanceDict*). After
   selection, it retrieves the stored record based on the key and executes the
   desired method directly on the object instance within the record.

```pascal
  var
    MemInfo:     TMemInfo;
    SelectedKey: string;
    
  {...}
  
  MemInfo := FMemInstanceDict[SelectedKey];
  MemInfo.Memory.Reset;
```

10. ***Destruction***: When removing the instance, the object must be freed at
    the memory level by the plugin that created it. The program searches the
    *FMemPluginDict* dictionary for the relevant plugin descriptor based on
    the module name (ModuleName) stored in the retrieved *MemInfo* record.
    It calls its *FDestroy* procedure, passing the memory instance, and then
    permanently deletes the reference from the active instances dictionary using
    the *Remove* method.

```pascal
  var
    MemInfo:     TMemInfo;
    SelectedKey: string;
    
  {...}
  
  MemInfo := FMemoryInstanceDict[SelectedKey];
  FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
  FMemInstanceDict.Remove(SelectedKey);
```
