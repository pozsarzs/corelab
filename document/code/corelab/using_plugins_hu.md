# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## A pluginok használata

A plugin metódusainak elérése egy szigorúan strukturált folyamaton megy
keresztül az exportálástól a tényleges memóriabeli hívásig.

### A rendszer elemei

|Rendszerelem     |Szerepkör               |Folyamatbeli feladat                                                                                       |
|-----------------|------------------------|-----------------------------------------------------------------------------------------------------------|
|Plugin (DLL/SO)  |Külső modul             |A funkciók fizikai tárolása és az operációs rendszer felé történő publikálása.                             |
|TMemPluginItem   |Memóriabeli leíró       |Tárolja egy betöltött könyvtár azonosítóját (TLibHandle) és a memóriacímeket (pl. FCreate).                |
|FMemPluginDict   |Elérhető modulok szótára|Fájlnév alapján (kulcs) tárolja az összes betöltött TMemPluginItem leírót.                                 |
|Form16.PluginList|Vizuális választó       |A _FMemPluginDict_ kulcsaiból feltöltött vizuális lista, amiből a felhasználó választ.                     |
|FMemInstanceDict |Aktív példányok szótára |A ténylegesen futó, már példányosított memóriamodulokat tárolja a felhasználó által megadott egyedi névvel.|
|Form17.ModuleList|Vizuális választó       |A _FMemInstanceDict_ kulcsaiból feltöltött vizuális lista, amiből a felhasználó választ.                   |

### A végrehajtás lépései

1. ***Exportálás*** (Plugin oldal): A modulban megírt metódust kifejezetten
   publikálni kell egy egyedi névvel (például 'memory_create'), hogy a
   keretrendszer számára hívható, exportált címként jelenjen meg.  

```pascal
  function CreateMemory: TMemory; CALLTYPE; export;
  begin
    Result := TStandardMemory.Create;
  end;

  exports CreateMemory name 'memory_create';
```   

2. ***Keresés*** (Főprogram): A betöltő rutin végignézi a mappát a megfelelő
   előtaggal rendelkező (pl. memory_*.dll) fájlok után, a találatokat egy
   *TStringList* példányban tárolja.

```pascal
  var LibList: TStringList;

  {...}

  LibList := FindAllFiles(ADirectory, 'memory_*.dll;memory_*.so', False);
```

3. ***Csatolás:*** A LoadLibrary paranccsal a program a memóriába tölti a külső
   fájlt, ami egy egyedi azonosítót ad vissza. Ezt a program eltárolja egy új
   *TMemPluginItem* példány *FHandle* mezőjében.  

```pascal
  type
    // betöltött plugin leírója
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

4. ***Címek kinyerése és a hozzárendelés***: A *GetProcedureAddress* függvény a
   kapott könyvtárazonosító és az exportált név alapján megkeresi a metódus
   pontos fizikai memóriacímét a betöltött modulban. A kapott memóriacímet a
   főprogram típuskényszerítéssel hozzárendeli a leíró eljárásmutató mezőjéhez
   (a *TMemPluginItem.FCreate* változóhoz).  

```pascal
  type
    // A kinyerendő függvény típusa
    TMemoryCreateFunc = function: TMemory; CALLTYPE;
    
  {...}
  
  Pointer(MemPluginItem.FCreate) := GetProcedureAddress(MemPluginItem.FHandle,
                                    'memory_create');
```

5. ***Címjegyzékbe vétel***: A kész leíró objektum bekerül a *FMemPluginDict*
   szótárba, így az a későbbiekben a plugin modul neve alapján kikereshető.  

```pascal
  type
    // A leírókat tároló szótár típusa
    TMemPluginDict = specialize TObjectDictionary<string, TMemPluginItem>;
  var
    FMemPluginDict: TMemPluginDict;
    
  {...}
  
  FMemPluginDict.Add(ChangeFileExt(ExtractFileName(LibList.Strings[i]), ''),
    MemPluginItem);
```

7. ***Hívás és példányosítás***: Amikor a kiválasztó ablakban megtörténik a
   döntés, a program kiveszi a névhez tartozó leírót a szótárból, leellenőrzi a
   cím meglétét, majd lefuttatja a benne lévő mutatót (pl. *FCreate()*).

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

8. ***Regisztráció***: A függvény visszatérési értékeként létrejött új
   memóriapéldány bekerül a *FMemInstanceDict* szótárba, ezzel elérhetővé válik
   a szimuláció többi része számára.

```pascal
  type
    // Az aktív memóriapéldányokat tároló szótár típusa
    TMemInstanceDict = specialize TObjectDictionary<string, TMemInfo>;
  var
    FMemInstanceDict: TMemInstanceDict;
    MemInfo:          TMemInfo;

  {...}

  FMemInstanceDict.Add(SelectedName, MemInfo);
```

9. ***Használat***: A futásidejű műveletek (például a Reset funkció)
   végrehajtásához a program az aktív példányokat tartalmazó szótár
   (*FMemInstanceDict*) kulcsaiból épít listát a kiválasztó ablak (Form17)
   számára. A kiválasztás után a kulcs alapján lekéri a tárolt rekordot, majd a
   kívánt metódust közvetlenül a rekordban lévő objektumpéldányon hajtja végre.

```pascal
  var
    MemInfo:     TMemInfo;
    SelectedKey: string;
    
  {...}
  
  MemInfo := FMemInstanceDict[SelectedKey];
  MemInfo.Memory.Reset;
```

10. ***Megszüntetés***: A példány eltávolításakor az objektumot a létrehozó
    pluginnak kell memóriaszinten felszabadítania. A program a lekérdezett
    *MemInfo* rekordban tárolt modulnév (ModuleName) alapján kikeresi a
    *FMemPluginDict* szótárból a vonatkozó plugin leírót. Meghívja annak
    *FDestroy* eljárását a memóriapéldány átadásával, majd a *Remove*
    metódussal véglegesen törli a hivatkozást az aktív példányok szótárából.

```pascal
  var
    MemInfo:     TMemInfo;
    SelectedKey: string;
    
  {...}
  
  MemInfo := FMemInstanceDict[SelectedKey];
  FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
  FMemInstanceDict.Remove(SelectedKey);
```
