# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU a core_cpu modulból

A `TCPU` absztrakt alaposztály a processzormegvalósítások számára. Meghatározza a közös
CPU-azonosítókat és architektúraadatokat, a futásidejű állapotot, a végrehajtási statisztikákat,
a megszakításkezelést, az eseményértesítést és a külső `ISysBus` interfészhez való kapcsolódást.

A processzorspecifikus regiszterelérést, alaphelyzetbe állítást, lépésenkénti végrehajtást,
az aktuális utasítás lekérdezését és az állapot mentését a leszármazott
CPU-osztályok valósítják meg.

### Kapcsolódó típusok

|name              |type          |description                                     |
|------------------|--------------|------------------------------------------------|
|`TArchitecture`   |enumeration   |CPU-memóriaarchitektúra.                        |
|`TEndianness`     |enumeration   |CPU-bájtsorrend.                                 |
|`TCPUEvent`       |enumeration   |Általános CPU-események.                             |
|`TCPUEventHandler`|procedure type|CPU-esemény visszahívási eljárása.                             |
|`TSemanticVersion`|record        |Fő-, al- és javítóverzió adatai.     |
|`TLogRec`         |record        |Az utoljára végrehajtott utasítás adatai.|
|`TIntLogRec`      |record        |Az utolsó megszakításkérés adatai.   |

### Felsorolási értékek

#### TArchitecture

|value      |description              |
|-----------|-------------------------|
|`arHarvard`|Harvard-architektúra.    |
|`arNeumann`|Neumann-architektúra.|

#### TEndianness

|value     |description              |
|----------|-------------------------|
|`enLittle`|Little-endian bájtsorrend.|
|`enBig`   |Big-endian bájtsorrend.   |

#### TCPUEvent

|value                  |description                |
|-----------------------|---------------------------|
|`ceInstructionBoundary`|Utasításhatár-esemény.|
|`ceInterrupt`          |Megszakítási esemény.           |
|`ceHalt`               |CPU leállítási eseménye.            |
|`ceReset`              |CPU alaphelyzetbe állítási eseménye.           |

### Típussegédek

|name                             |description                                            |
|---------------------------------|-------------------------------------------------------|
|`TArchitectureHelper.ToString`   |Az architektúraértéket a felsorolás nevévé alakítja.|
|`TArchitectureHelper.FromString` |A nevet RTTI segítségével `TArchitecture` értékké alakítja.         |
|`TEndiannessHelper.ToString`     |A bájtsorrend értékét a felsorolás nevévé alakítja.  |
|`TEndiannessHelper.FromString`   |A nevet RTTI segítségével `TEndianness` értékké alakítja.           |
|`TCPUEventHelper.ToString`       |A CPU-esemény értékét a felsorolás nevévé alakítja.    |
|`TCPUEventHelper.FromString`     |A nevet RTTI segítségével `TCPUEvent` értékké alakítja.             |
|`TSemanticVersionHelper.ToString`|A verziót `Major.Minor.Patch` formátumban jeleníti meg.              |
|`TSemanticVersionHelper.Compare` |Összehasonlít két verziót, és `-1`, `0` vagy `1` értéket ad vissza.    |

### Védett mezők

|name               |type              |description                               |initial value  |
|-------------------|------------------|------------------------------------------|---------------|
|`FBus`             |`ISysBus`         |Csatlakoztatott külső rendszersín.                   |`nil`          |
|`FOnEvent`         |`TCPUEventHandler`|CPU-esemény visszahívási eljárása.                       |`nil`          |
|`FModname`         |`PChar`           |Modulnév.                              |not initialized|
|`FDescription`     |`PChar`           |Rövid leírás.                        |not initialized|
|`FVersion`         |`TSemanticVersion`|Modulverzió.                           |`0.1.0`        |
|`FAddressWidth`    |`Byte`            |A címsín szélessége bitekben.                |not initialized|
|`FArchitecture`    |`TArchitecture`   |CPU-architektúra.                         |not initialized|
|`FEnabled`         |`Boolean`         |A CPU engedélyezése a rendszersínről való leválasztás nélkül.       |`False`        |
|`FEndianness`      |`TEndianness`     |CPU-bájtsorrend.                           |not initialized|
|`FMaxCodeAddress`  |`DWord`           |A kódmemória legmagasabb címe.              |not initialized|
|`FMaxIOPortAddress`|`DWord`           |A legmagasabb I/O-portcím.                 |not initialized|
|`FMaxMemAddress`   |`DWord`           |Az adatmemória legmagasabb címe.              |not initialized|
|`FHasSeparateIOBus`|`Boolean`         |Jelzi, hogy a memória- és az I/O-sín különálló-e.  |not initialized|
|`FRunning`         |`Boolean`         |A CPU végrehajtási állapota.                      |`False`        |
|`FHalted`          |`Boolean`         |A CPU HALT-állapota.                           |`False`        |
|`FInterruptEnabled`|`Boolean`         |A maszkolható megszakítások globális engedélyezőjelzője.    |`False`        |
|`FIRQPending`      |`Boolean`         |Függőben lévő maszkolható megszakítás.               |`False`        |
|`FIRQVector`       |`Byte`            |Fogadott megszakításvektor.                |`0`            |
|`FNMIPending`      |`Boolean`         |Függőben lévő nem maszkolható megszakítás.           |`False`        |
|`FCycles`          |`QWord`           |A CPU összes ciklusának száma.                         |`0`            |
|`FInstructions`    |`QWord`           |A végrehajtott utasítások összesített száma.              |`0`            |
|`FRegPtr`          |`array of ^Word`  |Regisztermutatók a leszármazott CPU-osztályokhoz.|empty          |

### Védett metódusok

|name                                       |flags|description                            |
|-------------------------------------------|-----|---------------------------------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`  |Vi   |CPU-eseményt küld a gazdaalkalmazás visszahívási eljárásának.|
|`procedure DoInterrupt(AEvent: TCPUEvent);`|Vi   |Továbbítja az elfogadott megszakítási eseményt.|

### Nyilvános metódusok

|name                                                        |flags|description                                                  |
|------------------------------------------------------------|-----|-------------------------------------------------------------|
|`constructor Create;`                                       |Vi   |Inicializálja a CPU állapotát, a megszakításjelzőket, a számlálókat és a verziót.|
|`destructor Destroy;`                                       |Or   |Megsemmisíti a CPU-példányt.                                   |
|`function CheckInterrupts: Boolean;`                        |     |Szükség esetén elfogadja a függőben lévő megszakítást.                 |
|`function GetCurrentInstruction: TLogRec;`                  |Ab,Vi|Visszaadja az aktuális utasítás adatait.           |
|`function GetCurrentInterrupt: TIntLogRec;`                 |Ab,Vi|Visszaadja az aktuális megszakításkérés adatait.    |
|`function GetRegister(const RegName: PChar): Word;`         |Ab,Vi|Kiolvassa a processzorregisztert; a megvalósítást a leszármazott osztályok biztosítják.  |
|`function GetRegisterCount: Byte;`                          |Ab,Vi|Visszaadja a processzorregiszterek számát.                   |
|`function GetRegisterName(AIndex: Byte): PChar;`            |Ab,Vi|Index alapján visszaadja a regiszter nevét.                            |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |Ab,Vi|Index alapján visszaadja a regiszter méretét.                            |
|`function LoadState(AStream: TStream): Boolean;`            |Ab,Vi|Betölti a processzor állapotát; a megvalósítást a leszármazott osztályok biztosítják.       |
|`function SaveState(AStream: TStream): Boolean;`            |Ab,Vi|Elmenti a processzor állapotát; a megvalósítást a leszármazott osztályok biztosítják.       |
|`procedure ConnectBus(const Bus: ISysBus);`                 |Vi   |A CPU-t külső rendszersínhez csatlakoztatja.                  |
|`procedure IRQ(AVector: Byte);`                             |Vi   |Beállítja a függőben lévő IRQ-t, és eltárolja a vektorát.                  |
|`procedure NMI;`                                            |Vi   |Beállítja a függőben lévő nem maszkolható megszakítást.                     |
|`procedure Reset;`                                          |Ab,Vi|Alaphelyzetbe állítja a processzort; a megvalósítást a leszármazott osztályok biztosítják.        |
|`procedure Run;`                                            |Vi   |Elindítja a végrehajtást, ha a CPU engedélyezett.                    |
|`procedure SetRegister(const RegName: PChar; AValue: Word);`|Ab,Vi|Beállítja a processzorregisztert; a megvalósítást a leszármazott osztályok biztosítják.   |
|`procedure Step;`                                           |Ab,Vi|Végrehajt egy processzorlépést; a megvalósítást a leszármazott osztályok biztosítják. |
|`procedure Stop;`                                           |Vi   |Leállítja a CPU végrehajtását.                                         |

### Nyilvános tulajdonságok

|name              |type              |access    |description                               |
|------------------|------------------|----------|------------------------------------------|
|`AddressWidth`    |`Byte`            |read      |A címsín szélessége bitekben.                |
|`Architecture`    |`TArchitecture`   |read      |CPU-architektúra.                         |
|`Cycles`          |`QWord`           |read      |A CPU-ciklusok összesített számlálója.                  |
|`Description`     |`PChar`           |read      |Short module description.                 |
|`Enabled`         |`Boolean`         |read/write|Engedélyezi vagy letiltja a CPU működését.        |
|`Endianness`      |`TEndianness`     |read      |CPU-bájtsorrend.                           |
|`Halted`          |`Boolean`         |read      |A CPU aktuális HALT-állapota.                   |
|`HasSeparateIOBus`|`Boolean`         |read      |Jelzi, hogy a memória- és az I/O-sín különálló-e.|
|`Instructions`    |`QWord`           |read      |A végrehajtott utasítások összesített számlálója.       |
|`InterruptEnabled`|`Boolean`         |read      |A maszkolható megszakítások globális állapota.          |
|`MaxCodeAddress`  |`DWord`           |read      |A kódmemória legmagasabb címe.              |
|`MaxIOPortAddress`|`DWord`           |read      |A legmagasabb I/O-portcím.                 |
|`MaxMemAddress`   |`DWord`           |read      |Az adatmemória legmagasabb címe.              |
|`Modname`         |`PChar`           |read      |Modulnév.                              |
|`OnEvent`         |`TCPUEventHandler`|read/write|CPU-esemény visszahívási eljárása.                       |
|`Running`         |`Boolean`         |read      |Az aktuális végrehajtási állapot.                  |
|`Version`         |`TSemanticVersion`|read      |Modulverzió.                           |
