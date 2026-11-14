# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## T4002RAM a TMemory osztályból, a memory_4002ram modul

A `T4002RAM` a CoreLAB keretrendszer Intel 4002 RAM- és I/O-bővítménye.
A `TMemory` osztályból származik, és megvalósítja az `IMCS4Bus` interfészt.
A modul 80 darab négybites memóriacellát biztosít: négy, egyenként 16 karakteres
regisztert, valamint regiszterenként négy státuszkaraktert. Emellett egy
nég bites kimeneti portot is biztosít.

### Privát mezők

|név             |típus    |leírás                                                                       |
|----------------|---------|-----------------------------------------------------------------------------|
|`FChipID`       |`Byte`   |A chip azonosítója, amely az SRC vezérlőadat alapján választja ki az eszközt.|
|`FActiveReg`    |`Byte`   |A jelenleg kiválasztott RAM-regiszter a négy közül.                          |
|`FActiveChar`   |`Byte`   |A kiválasztott karakter az aktív regiszteren belül.                          |
|`FSelected`     |`Boolean`|Azt jelzi, hogy a chipet kiválasztotta-e a legutóbb fogadott SRC érték.      |
|`FTargetAddress`|`Word`   |A cél I/O-port íráskor használt címe.                                        |
|`FTargetPort`   |`TIOPort`|Az a cél I/O-port, amely a RAM négybites kimeneti adatát fogadja.            |

### Védett metódusok

|név                                                     |jelzők|leírás                                                                                                                                                                                 |
|--------------------------------------------------------|------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`SetFAddressRangeSize(AAddressRangeSize: DWord);`       |Or    |Felülírja a memóriaméret beállítóját. A memóriaméret rögzítetten 80 cella, és ennek megfelelően átméretezi a memóriacella-tömböt. A paraméter nem határozza meg a tényleges méretet.   |
|`SetFBaseAddress(ABaseAddress: DWord);`                 |Or    |Felülírja az alapcím beállítóját. `$0F00` értékig terjedő alapcím esetén a címet 80-nal osztva meghatározza a chipazonosítót, majd az alapcímet a megfelelő 80-as többszörösre állítja.|
|`SetFMemoryMode(AMemoryMode: TMemoryMode);`             |Or    |Felülírja a memóriaüzemmód beállítóját, és minden esetben `mmRAM` értéket állít be.                                                                                                    |
|`QueryInterface(constref iid: TGuid; out obj): LongInt;`|      |Az `IMCS4Bus` interfész lekérdezését valósítja meg.                                                                                                                                    |
|`_AddRef: LongInt;`                                     |      |`-1` értéket ad vissza; a referenciaszámlálás le van tiltva.                                                                                                                           |
|`_Release: LongInt;`                                    |      |`-1` értéket ad vissza; a referenciaszámlálás le van tiltva.                                                                                                                           |

### Nyilvános metódusok

|név                                         |jelzők|leírás                                                                                                                                                     |
|--------------------------------------------|------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                       |Or    |Létrehozza a 4002 RAM-objektumot, 80 cellára állítja a memóriaméretet, kiválasztja az MCS-4 busztípust és a RAM üzemmódot, beállítja a modul adatait, valamint alaphelyzetbe állítja a chipkiválasztást és a célport beállításait.|
|`SendSRC(AAddress: Byte);`                  |      |Fogadja a 8 bites SRC vezérlőértéket. A 7–6. bitek a chipazonosítót, az 5–4. bitek a RAM-regisztert, a 3–0. bitek pedig a karaktert választják ki.         |
|`ReadRAM: Byte;`                            |      |Visszaadja a kiválasztott négybites RAM-cellát, ha a chip ki van választva; egyébként nullát ad vissza.                                                    |
|`WriteRAM(AData: Byte);`                    |      |A megadott adat alsó négy bitjét beírja a kiválasztott RAM-cellába, ha a chip ki van választva.                                                            |
|`ReadRAMStatus(AIndex: Byte): Byte;`        |      |Kiolvassa az aktív regiszter négy státuszkarakterének egyikét. Nullát ad vissza, ha a chip nincs kiválasztva, vagy az index kívül esik a 0–3 tartományon.  |
|`WriteRAMStatus(AIndex: Byte; AData: Byte);`|      |A megadott adat alsó négy bitjét beírja az aktív regiszter egyik státuszkarakterébe, ha a chip ki van választva és az index a megengedett tartományba esik.|
|`WriteRAMIOPort(AData: Byte);`              |      |A megadott adat alsó négy bitjét kiírja a beállított cél I/O-port címére, ha a chip ki van választva és a célport hozzá van rendelve.                      |
|`ReadROM(AAddress: Word): Byte;`            |      |A RAM-modulban nem támogatott; mindig nullát ad vissza.                                                                                                    |
|`ReadROMIOPort: Byte;`                      |      |A RAM-modulban nem támogatott; mindig nullát ad vissza.                                                                                                    |
|`WriteROMIOPort(AData: Byte);`              |      |A RAM-modulban nem támogatott; nem hajt végre műveletet.                                                                                                   |

### Nyilvános tulajdonságok

|név            |típus    |elérés        |leírás                                                          |
|---------------|---------|--------------|----------------------------------------------------------------|
|`ChipID`       |`Byte`   |csak olvasható|Visszaadja a chipazonosítót.                                    |
|`TargetAddress`|`Word`   |olvasás/írás  |Lekérdezi vagy beállítja a cél I/O-port írásakor használt címet.|
|`TargetPort`   |`TIOPort`|olvasás/írás  |Lekérdezi vagy beállítja a cél I/O-portot.                      |

### Örökölt interfész

Az osztály örökli a `TMemory` memória-interfészét, beleértve a következőket:

|tag               |leírás                                                                         |
|------------------|-------------------------------------------------------------------------------|
|`AddressRangeSize`|Beállítható memóriacím-tartomány-méret; ez a megvalósítás 80 cellára rögzíti.  |
|`DataWidth`       |Beállítható memória-adatszélesség.                                             |
|`Description`     |Modulleírás.                                                                   |
|`Enabled`         |Engedélyezi vagy letiltja a memóriaelérést.                                    |
|`InstanceID`      |Modulpéldány-azonosító.                                                        |
|`MemoryMode`      |Kiválasztja a RAM vagy ROM működést; ez a megvalósítás RAM módot kényszerít ki.|
|`ModName`         |Modulnév.                                                                      |
|`Version`         |Modulverzió.                                                                   |
|`ReadMemory`      |Egy bájtot olvas a memóriából.                                                 |
|`WriteMemory`     |Bájtot ír, ha a memória engedélyezett és RAM módban működik.                   |
|`Reset`           |Alaphelyzetbe állítja az örökölt memória-komponenst.                           |
|`LoadState`       |Betölti az örökölt memória állapotát egy adatfolyamból.                        |
|`SaveState`       |Elmenti az örökölt memória állapotát egy adatfolyamba.                         |
|`LoadFromStream`  |Adatblokkot tölt a memóriába.                                                  |
|`SaveToStream`    |Memóriaadat-blokkot ment adatfolyamba.                                         |

### Exportált függvények

|exportált név           |függvény       |leírás                                                                                                                |
|------------------------|---------------|----------------------------------------------------------------------------------------------------------------------|
|`memory_create`         |`CreateMemory` |Létrehoz és `TMemory` objektumként visszaad egy új `T4002RAM` példányt.                                               |
|`memory_destroy`        |`DestroyMemory`|Megsemmisíti a megadott memóriaobjektumot, ha az hozzá van rendelve.                                                  |
|`memory_loadstate`      |`LoadState`    |Betölti a megadott memóriaobjektum állapotát egy adatfolyamból. `False` értéket ad vissza, ha a memóriaobjektum `nil`.|
|`memory_savestate`      |`SaveState`    |Elmenti a megadott memóriaobjektum állapotát egy adatfolyamba. `False` értéket ad vissza, ha a memóriaobjektum `nil`. |
|`memory_set_target_port`|`SetTargetPort`|Beállítja a cél I/O-portot és annak címét, ha a megadott objektum `T4002RAM` példány.                                 |
