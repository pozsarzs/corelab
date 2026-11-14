# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## T4001ROM a TMemory osztályból, a memory_4001rom modul

A `T4001ROM` a CoreLAB keretrendszer Intel 4001 ROM- és I/O-chipbővítménye.

A `TMemory` osztályból származik, és megvalósítja az `IMCS4Bus` interfészt. A
komponens 256 bájtos ROM-területet és egy 4 bites I/O-port elérését biztosítja.

### Privát és védett mezők

|név             |láthatóság|leírás                                                     |
|----------------|----------|-----------------------------------------------------------|
|`FChipID`       |Privát    |Az alapcímből meghatározott chipazonosító.                 |
|`FSelected`     |Privát    |Jelzi, hogy az utolsó SRC parancs kiválasztotta-e a chipet.|
|`FTargetAddress`|Privát    |A csatlakoztatott I/O-port elérésekor használt cím.        |
|`FTargetPort`   |Privát    |A célként használt `TIOPort` példány referenciája.         |

### Védett metódusok

|név                                                     |leírás                                                                                                                                            |
|--------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
|`SetFAddressRangeSize(AAddressRangeSize: DWord);`       |Felülírja az örökölt beállítót, és 256 bájtra rögzíti a memóriaméretet, majd ennek megfelelően átméretezi az `FMemCells` tömböt.                  |
|`SetFBaseAddress(ABaseAddress: DWord);`                 |Legfeljebb `$0F00` alapcím esetén 256-tal osztva meghatározza a chipazonosítót, majd az alapcímet a megfelelő 256 bájtos blokk kezdetére igazítja.|
|`SetFMemoryMode(AMemoryMode: TMemoryMode);`             |Felülírja az örökölt beállítót, és ROM üzemmódot kényszerít ki.                                                                                   |
|`QueryInterface(constref iid: TGuid; out obj): LongInt;`|A kért interfészazonosító egyezése esetén biztosítja az `IMCS4Bus` interfészt.                                                                    |
|`_AddRef: LongInt;`                                     |`-1` értéket ad vissza; az interfész referencia-számlálása le van tiltva.                                                                         |
|`_Release: LongInt;`                                    |`-1` értéket ad vissza; az interfész referencia-számlálása le van tiltva.                                                                         |

### Nyilvános metódusok

|név                                         |jelzők|leírás                                                                                                                                                                                                 |
|--------------------------------------------|-----|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                       |Or   |Meghívja az ősosztály konstruktorát, 256 bájtra állítja a címtartományt, kiválasztja az MCS-4 busztípust és a ROM üzemmódot, valamint inicializálja a modul adatait és a belső kiválasztási/portmezőket.|
|`SendSRC(AAddress: Byte);`                  |     |Fogadja a 8 bites SRC vezérlőértéket, és a chip kiválasztottságát az `AAddress shr 4` és a chipazonosító összehasonlításával állítja be.                                                                |
|`ReadRAM: Byte;`                            |     |A RAM-művelet nem támogatott; mindig `0` értéket ad vissza.                                                                                                                                             |
|`WriteRAM(AData: Byte);`                    |     |A RAM-művelet nem támogatott; nem végez műveletet.                                                                                                                                                      |
|`ReadRAMStatus(AIndex: Byte): Byte;`        |     |A RAM-állapot olvasása nem támogatott; mindig `0` értéket ad vissza.                                                                                                                                    |
|`WriteRAMStatus(AIndex: Byte; AData: Byte);`|     |A RAM-állapot írása nem támogatott; nem végez műveletet.                                                                                                                                                |
|`WriteRAMIOPort(AData: Byte);`              |     |A RAM I/O-művelet nem támogatott; nem végez műveletet.                                                                                                                                                  |
|`ReadROM(AAddress: Word): Byte;`            |     |Bájtot olvas a ROM-ból az örökölt `ReadMemory` metódus meghívásával.                                                                                                                                    |
|`ReadROMIOPort: Byte;`                      |     |Kiválasztott chip és hozzárendelt célport esetén beolvassa a port értékét, és annak alsó 4 bitjét adja vissza; egyébként `0`-t ad.                                                                      |
|`WriteROMIOPort(AData: Byte);`              |     |Kiválasztott chip és hozzárendelt célport esetén az adat alsó 4 bitjét kiírja a célportra.                                                                                                              |

### Nyilvános tulajdonságok

|tulajdonság    |elérés          |leírás                                             |
|---------------|----------------|---------------------------------------------------|
|`ChipID`       |Csak olvasható  |Az alapcímből meghatározott chipazonosító.         |
|`TargetAddress`|Olvasható/írható|A cél I/O-port eléréséhez használt cím.            |
|`TargetPort`   |Olvasható/írható|Az I/O-műveletekhez használt cél `TIOPort` példány.|

### Örökölt interfész

Az osztály a `TMemory` memória-interfészét örökli, beleértve a következőket:

|tag               |leírás                                                                    |
|------------------|--------------------------------------------------------------------------|
|`AddressRangeSize`|Memóriacím-tartomány mérete; ez a megvalósítás 256 bájtra rögzíti.        |
|`DataWidth`       |Memória-adatszélesség.                                                    |
|`Description`     |Modulleírás.                                                              |
|`Enabled`         |Engedélyezi vagy letiltja a memóriaelérést.                               |
|`InstanceID`      |Modulpéldány-azonosító.                                                   |
|`MemoryMode`      |RAM vagy ROM üzemmód; ez a megvalósítás ROM módot kényszerít ki.          |
|`ModName`         |Modulnév.                                                                 |
|`Version`         |Modulverzió.                                                              |
|`ReadMemory`      |Bájtot olvas a memóriából.                                                |
|`WriteMemory`     |Bájtot ír az örökölt memória-megvalósítás és az aktuális üzemmód szerint. |
|`Reset`           |Az örökölt megvalósítás szerint alaphelyzetbe állítja a memóriakomponenst.|
|`LoadState`       |Betölti a memória állapotát egy adatfolyamból.                            |
|`SaveState`       |Elmenti a memória állapotát egy adatfolyamba.                             |
|`LoadFromStream`  |Adatblokkot tölt a memóriába.                                             |
|`SaveToStream`    |Memóriaadat-blokkot ment adatfolyamba.                                    |

A `T4001ROM` az `IMCS4Bus` interfészt is megvalósítja az MCS-4 buszhoz való
csatlakozáshoz. Az interfészhez tartozó metódusokat a `QueryInterface`,
`_AddRef` és `_Release` implementációi biztosítják.

### Exportált függvények és eljárások

|exportált név           |függvény/eljárás|leírás                                                                                                                |
|------------------------|----------------|----------------------------------------------------------------------------------------------------------------------|
|`memory_create`         |`CreateMemory`  |Létrehoz és `TMemory` referenciaként visszaad egy új `T4001ROM` példányt.                                             |
|`memory_destroy`        |`DestroyMemory` |Megsemmisíti a megadott memóriaobjektumot, ha az hozzá van rendelve.                                                  |
|`memory_loadstate`      |`LoadState`     |Betölti a megadott memóriaobjektum állapotát egy adatfolyamból. `False` értéket ad vissza, ha a memóriaobjektum `nil`.|
|`memory_savestate`      |`SaveState`     |Elmenti a megadott memóriaobjektum állapotát egy adatfolyamba. `False` értéket ad vissza, ha a memóriaobjektum `nil`. |
|`memory_set_target_port`|`SetTargetPort` |`T4001ROM` példány esetén hozzárendeli a cél `TIOPort` példányt és az I/O-műveletekhez használt címet.                |
