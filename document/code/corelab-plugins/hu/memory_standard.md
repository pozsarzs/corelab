# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TStandardMemory a TMemory osztályból, a memory_standard modul

A `TStandardMemory` a CoreLAB keretrendszer szabványos memóriabővítménye. A
`TMemory` osztályból származik, és legfeljebb 16 MB kapacitású RAM- vagy
ROM-üzemmódú memóriakomponenst biztosít.

### Védett mezők

A `TStandardMemory` nem deklarál további védett mezőket. A `TMemory` osztálytól
örökölt mezőket használja.

### Nyilvános metódusok

|név                  |jelzők|leírás                                                                                                                                                                                     |
|---------------------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`|Or   |Az örökölt konstruktor meghívásával létrehoz egy szabványos memóriaobjektumot, majd a modult `Standard memory` névvel és `Up to 16MB RAM/ROM` leírással állítja be, RAM üzemmódot választva.|
|`destructor Destroy;`|Or   |Az örökölt destruktor meghívásával megsemmisíti a szabványos memóriaobjektumot.                                                                                                             |

### Örökölt interfész

Az osztály a `TMemory` teljes memória-interfészét örökli, beleértve a következőket:

|tag               |leírás                                                      |
|------------------|------------------------------------------------------------|
|`AddressRangeSize`|Beállítható memóriacím-tartomány mérete.                    |
|`DataWidth`       |Beállítható memória-adatszélesség.                          |
|`Description`     |Modulleírás.                                                |
|`Enabled`         |Engedélyezi vagy letiltja a memóriaelérést.                 |
|`InstanceID`      |Modulpéldány-azonosító.                                     |
|`MemoryMode`      |Kiválasztja a RAM vagy ROM működést.                        |
|`ModName`         |Modulnév.                                                   |
|`Version`         |Modulverzió.                                                |
|`ReadMemory`      |Egy bájtot olvas a memóriából.                              |
|`WriteMemory`     |Bájtot ír, ha a memória engedélyezett és RAM módban működik.|
|`Reset`           |Törli a memória tartalmát.                                  |
|`LoadState`       |Betölti a memória állapotát egy adatfolyamból.              |
|`SaveState`       |Elmenti a memória állapotát egy adatfolyamba.               |
|`LoadFromStream`  |Adatblokkot tölt a memóriába.                               |
|`SaveToStream`    |Memóriaadat-blokkot ment adatfolyamba.                      |

### Exportált függvények

|exportált név     |függvény       |leírás                                                                                                                 |
|------------------|---------------|-----------------------------------------------------------------------------------------------------------------------|
|`memory_create`   |`CreateMemory` |Létrehoz és visszaad egy új `TStandardMemory` példányt.                                                                |
|`memory_destroy`  |`DestroyMemory`|Megsemmisíti a megadott memóriaobjektumot, ha az hozzá van rendelve.                                                   |
|`memory_loadstate`|`LoadState`    |Betölti a megadott memóriaobjektum állapotát egy adatfolyamból. `False` értéket ad vissza, ha a memóriaobjektum `nil`. |
|`memory_savestate`|`SaveState`    |Elmenti a megadott memóriaobjektum állapotát egy adatfolyamba. `False` értéket ad vissza, ha a memóriaobjektum `nil`.  |

### Modulbeállítások

|elem           |érték                                         |
|---------------|----------------------------------------------|
|Modulosztály   |`TStandardMemory`                             |
|Alaposztály    |`TMemory`                                     |
|Modulnév       |`RAM/ROM`                                     |
|Leírás         |`Szabványos memória 8 bites adatszélességgel.`|
|Kezdeti üzemmód|`mmRAM`                                       |
|Könyvtár       |`memory_standard`                             |
