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

|név               |típus         |leírás                                          |
|------------------|--------------|------------------------------------------------|
|`TArchitecture`   |enumeration   |CPU-memóriaarchitektúra.                        |
|`TEndianness`     |enumeration   |CPU-bájtsorrend.                                |
|`TCPUEvent`       |enumeration   |Általános CPU-események.                        |
|`TCPUEventHandler`|procedure type|CPU-esemény visszahívási eljárása.              |
|`TSemanticVersion`|record        |Fő-, al- és javítóverzió adatai.                |
|`TLastInstruction`|record        |Az utoljára végrehajtott utasítás               |
|`TLogRec`         |record        |Az utoljára végrehajtott utasítás adatai.       |
|`TIntLogRec`      |record        |Az utolsó megszakításkérés adatai.              |

### Felsorolási értékek

#### TArchitecture

|érték      |leírás               |
|-----------|---------------------|
|`arHarvard`|Harvard-architektúra.|
|`arNeumann`|Neumann-architektúra.|

#### TEndianness

|érték     |leírás                    |
|----------|--------------------------|
|`enLittle`|Little-endian bájtsorrend.|
|`enBig`   |Big-endian bájtsorrend.   |

#### TCPUEvent

|érték                  |leírás                              |
|-----------------------|------------------------------------|
|`ceInstructionBoundary`|Utasításhatár-esemény.              |
|`ceInterrupt`          |Megszakítási esemény.               |
|`ceHalt`               |CPU leállítási eseménye.            |
|`ceReset`              |CPU alaphelyzetbe állítási eseménye.|

### Típussegédek

|név                              |leírás                                                             |
|---------------------------------|-------------------------------------------------------------------|
|`TArchitectureHelper.ToString`   |Az architektúraértéket a felsorolás nevévé alakítja.               |
|`TArchitectureHelper.FromString` |A nevet RTTI segítségével `TArchitecture` értékké alakítja.        |
|`TEndiannessHelper.ToString`     |A bájtsorrend értékét a felsorolás nevévé alakítja.                |
|`TEndiannessHelper.FromString`   |A nevet RTTI segítségével `TEndianness` értékké alakítja.          |
|`TCPUEventHelper.ToString`       |A CPU-esemény értékét a felsorolás nevévé alakítja.                |
|`TCPUEventHelper.FromString`     |A nevet RTTI segítségével `TCPUEvent` értékké alakítja.            |
|`TSemanticVersionHelper.ToString`|A verziót `Major.Minor.Patch` formátumban jeleníti meg.            |
|`TSemanticVersionHelper.Compare` |Összehasonlít két verziót, és `-1`, `0` vagy `1` értéket ad vissza.|

### Védett mezők

|név                 |típus             |leírás                                                  |alapérték|
|--------------------|------------------|--------------------------------------------------------|---------|
|`FBus`              |`ISysBus`         |Csatlakoztatott külső rendszersín.                      |`nil`    |
|`FOnEvent`          |`TCPUEventHandler`|CPU-esemény visszahívási eljárása.                      |`nil`    |
|`FModname`          |`PChar`           |Modulnév.                                               |         |
|`FDescription`      |`PChar`           |Rövid leírás.                                           |         |
|`FVersion`          |`TSemanticVersion`|Modulverzió.                                            |`0.1.0`  |
|`FAddressWidth`     |`Byte`            |A címsín szélessége bitekben.                           |         |
|`FArchitecture`     |`TArchitecture`   |CPU-architektúra.                                       |         |
|`FEnabled`          |`Boolean`         |A CPU engedélyezése.                                    |`False`  |
|`FEndianness`       |`TEndianness`     |CPU-bájtsorrend.                                        |         |
|`FMaxCodeAddress`   |`DWord`           |A kódmemória legmagasabb címe.                          |         |
|`FMaxIOPortAddress` |`DWord`           |A legmagasabb I/O-portcím.                              |         |
|`FMaxMemAddress`    |`DWord`           |Az adatmemória legmagasabb címe.                        |         |
|`FHasSeparateIOBus` |`Boolean`         |Jelzi, hogy a memória- és az I/O-sín különálló-e.       |         |
|`FRunning`          |`Boolean`         |A CPU végrehajtási állapota.                            |`False`  |
|`FHalted`           |`Boolean`         |A CPU HALT-állapota.                                    |`False`  |
|`FInterruptEnabled` |`Boolean`         |A maszkolható megszakítások globális engedélyezőjelzője.|`False`  |
|`FIRQPending`       |`Boolean`         |Függőben lévő maszkolható megszakítás.                  |`False`  |
|`FIRQVector`        |`Byte`            |Fogadott megszakításvektor.                             |`0`      |
|`FNMIPending`       |`Boolean`         |Függőben lévő nem maszkolható megszakítás.              |`False`  |
|`FTotalCycles`      |`QWord`           |A CPU összes ciklusának száma.                          |`0`      |
|`FTotalInstructions`|`QWord`           |A végrehajtott utasítások összesített száma.            |`0`      |
|`FRegPtr`           |`array of ^Word`  |Regisztermutatók a leszármazott CPU-osztályokhoz.       |         |

### Védett metódusok

|név                                        |jelző|leírás                                                       |
|-------------------------------------------|-----|-------------------------------------------------------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`  |Vi   |CPU-eseményt küld a gazdaalkalmazás visszahívási eljárásának.|
|`procedure DoInterrupt(AEvent: TCPUEvent);`|Vi   |Továbbítja az elfogadott megszakítási eseményt.              |

### Nyilvános metódusok

|név                                                         |jelző|leírás                                                                                    |
|------------------------------------------------------------|-----|------------------------------------------------------------------------------------------|
|`constructor Create;`                                       |Vi   |Inicializálja a CPU állapotát, a megszakításjelzőket, a számlálókat és a verziót.         |
|`destructor Destroy;`                                       |Or   |Megsemmisíti a CPU-példányt.                                                              |
|`function CheckInterrupts: Boolean;`                        |     |Szükség esetén elfogadja a függőben lévő megszakítást.                                    |
|`function GetCurrentInstruction: TLogRec;`                  |Ab,Vi|Visszaadja az aktuális utasítás adatait.                                                  |
|`function GetCurrentInterrupt: TIntLogRec;`                 |Ab,Vi|Visszaadja az aktuális megszakításkérés adatait.                                          |
|`function GetRegister(const Regnév : PChar): Word;`         |Ab,Vi|Kiolvassa a processzorregisztert; a megvalósítást a leszármazott osztályok biztosítják.   |
|`function GetRegisterCount: Byte;`                          |Ab,Vi|Visszaadja a processzorregiszterek számát.                                                |
|`function GetRegisternév (AIndex: Byte): PChar;`            |Ab,Vi|Index alapján visszaadja a regiszter nevét.                                               |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |Ab,Vi|Index alapján visszaadja a regiszter méretét.                                             |
|`function LoadState(AStream: TStream): Boolean;`            |Ab,Vi|Betölti a processzor állapotát; a megvalósítást a leszármazott osztályok biztosítják.     |
|`function SaveState(AStream: TStream): Boolean;`            |Ab,Vi|Elmenti a processzor állapotát; a megvalósítást a leszármazott osztályok biztosítják.     |
|`procedure ConnectBus(const Bus: ISysBus);`                 |Vi   |A CPU-t külső rendszersínhez csatlakoztatja.                                              |
|`procedure IRQ(AVector: Byte);`                             |Vi   |Beállítja a függőben lévő IRQ-t, és eltárolja a vektorát.                                 |
|`procedure NMI;`                                            |Vi   |Beállítja a függőben lévő nem maszkolható megszakítást.                                   |
|`procedure Reset;`                                          |Ab,Vi|Alaphelyzetbe állítja a processzort; a megvalósítást a leszármazott osztályok biztosítják.|
|`procedure Run;`                                            |Vi   |Elindítja a végrehajtást, ha a CPU engedélyezett.                                         |
|`procedure SetRegister(const Regnév : PChar; AValue: Word);`|Ab,Vi|Beállítja a processzorregisztert; a megvalósítást a leszármazott osztályok biztosítják.   |
|`procedure Step;`                                           |Ab,Vi|Végrehajt egy processzorlépést; a megvalósítást a leszármazott osztályok biztosítják.     |
|`procedure Stop;`                                           |Vi   |Leállítja a CPU végrehajtását.                                                            |

### Nyilvános tulajdonságok

|név                |típus             |elérés|leírás                                           |
|-------------------|------------------|------|-------------------------------------------------|
|`AddressWidth`     |`Byte`            |Re    |A címsín szélessége bitekben.                    |
|`Architecture`     |`TArchitecture`   |Re    |CPU-architektúra.                                |
|`Description`      |`PChar`           |Re    |Rövid module leírás.                             |
|`Enabled`          |`Boolean`         |Re/Wr |Engedélyezi vagy letiltja a CPU működését.       |
|`Endianness`       |`TEndianness`     |Re    |CPU-bájtsorrend.                                 |
|`Halted`           |`Boolean`         |Re    |A CPU aktuális HALT-állapota.                    |
|`HasSeparateIOBus` |`Boolean`         |Re    |Jelzi, hogy a memória- és az I/O-sín különálló-e.|
|`InterruptEnabled` |`Boolean`         |Re    |A maszkolható megszakítások globális állapota.   |
|`MaxCodeAddress`   |`DWord`           |Re    |A kódmemória legmagasabb címe.                   |
|`MaxIOPortAddress` |`DWord`           |Re    |A legmagasabb I/O-portcím.                       |
|`MaxMemAddress`    |`DWord`           |Re    |Az adatmemória legmagasabb címe.                 |
|`Modname`          |`PChar`           |Re    |Modulnév.                                        |
|`OnEvent`          |`TCPUEventHandler`|Re/Wr |CPU-esemény visszahívási eljárása.               |
|`Running`          |`Boolean`         |Re    |Az aktuális végrehajtási állapot.                |
|`TotalCycles`      |`QWord`           |Re    |A CPU-ciklusok összesített számlálója.           |
|`TotalInstructions`|`QWord`           |Re    |A végrehajtott utasítások összesített számlálója.|
|`Version`          |`TSemanticVersion`|Re    |Modulverzió.                                     |
