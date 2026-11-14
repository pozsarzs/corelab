# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCPU a core_cpu modulból

A `TCPU` absztrakt alaposztály a processzormegvalósítások számára. Meghatározza a közös
CPU-azonosítókat és architektúraadatokat, a sín konfigurációját, a futásidejű állapotot,
a végrehajtási statisztikákat, a megszakításkezelést és az eseményértesítést.

A processzorspecifikus regiszterelérést, alaphelyzetbe állítást, lépésenkénti végrehajtást,
az aktuális utasítás lekérdezését és az állapot mentését a leszármazott CPU-osztályok
valósítják meg. A sínhez csatlakoztatás szintén absztrakt metódus, amelyet a leszármazott
osztálynak kell megvalósítania.

### Kapcsolódó típusok

|név                     |típus         |leírás                                            |
|------------------------|--------------|--------------------------------------------------|
|`TProcessorDestroyEvent`|procedure type|Visszahívás a CPU-példány megsemmisítésekor.      |
|`TArchitecture`         |enumeration   |CPU-memóriaarchitektúra.                          |
|`TEndianness`           |enumeration   |CPU-bájtsorrend.                                  |
|`TCPUEvent`             |enumeration   |Általános CPU-események.                          |
|`TCPUEventHandler`      |procedure type|CPU-esemény visszahívási eljárása.                |
|`TSemanticVersion`      |record        |Fő-, al- és javítóverzió adatai.                  |
|`TLastInstruction`      |record        |Az utoljára végrehajtott utasítás dekódolt adatai.|
|`TLogRec`               |record        |Az utolsóutasítás-napló adatai.                   |
|`TIntLogRec`            |record        |A megszakításnapló adatai.                        |
|`TBusType`              |enumeration   |A `core_bus` modulban deklarált rendszersíntípus. |

### Rekordmezők

#### TSemanticVersion

|mező    |típus    |leírás           |
|--------|---------|-----------------|
|`Major` |`Integer`|Főverziószám.    |
|`Minor` |`Integer`|Alverziószám.    |
|`Patch` |`Integer`|Javítóverziószám.|

#### TLastInstruction

|mező        |típus                |leírás                  |
|------------|---------------------|------------------------|
|`Address`   |`Word`               |Az utasítás címe.       |
|`Opcode`    |`Byte`               |Az opkód bájtja.        |
|`NumPrefix` |`Byte`               |Az előtagok száma.      |
|`Prefixes`  |`array[1..2] of Word`|Az előtagok értékei.    |
|`NumOperand`|`Byte`               |Az operandusok száma.   |
|`Operands`  |`array[1..2] of Word`|Az operandusok értékei. |
|`Mnemonic`  |`string[32]`         |Utasításmnemonik.       |
|`Cycles`    |`Byte`               |Az utasítás ciklusszáma.|

#### TLogRec

|mező         |típus       |leírás                      |
|-------------|------------|----------------------------|
|`InstCount`  |`Integer`   |Utasításszámláló.           |
|`Address`    |`string[32]`|Az utasítás címe szövegként.|
|`OpCode`     |`string[32]`|Az opkód szövegként.        |
|`Mnemonic`   |`string[32]`|Utasításmnemonik.           |
|`Cycles`     |`Byte`      |Az utasítás ciklusszáma.    |
|`TotalCycles`|`QWord`     |Az összes ciklus száma.     |

#### TIntLogRec

|mező    |típus       |leírás                            |
|--------|------------|----------------------------------|
|`Sender`|`string[32]`|A megszakítás forrása.            |
|`Vector`|`string[32]`|A megszakításvektor szövegként.   |
|`Status`|`string[32]`|A megszakítás állapota szövegként.|
|`Flag`  |`string[32]`|Megszakításjelző-információ.      |

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

A `TBusType` a `core_bus` modulban van deklarálva. A keretrendszerben használt
értékei: `btStandard` és `btMCS4`.

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

|név                 |típus                   |leírás                                             |alapérték          |
|--------------------|------------------------|---------------------------------------------------|-------------------|
|`FOnEvent`          |`TCPUEventHandler`      |CPU-esemény visszahívási eljárása.                 |`nil`              |
|`FModname`          |`PChar`                 |Modulnév.                                          |itt nincs beállítva|
|`FDescription`      |`PChar`                 |Rövid leírás.                                      |itt nincs beállítva|
|`FVersion`          |`TSemanticVersion`      |Modulverzió.                                       |`0.1.0`            |
|`FAddressWidth`     |`Byte`                  |A címsín szélessége bitekben.                      |itt nincs beállítva|
|`FArchitecture`     |`TArchitecture`         |CPU-architektúra.                                  |itt nincs beállítva|
|`FBusType`          |`TBusType`              |Rendszersíntípus.                                  |`btStandard`       |
|`FDefaultClockFreq` |`DWord`                 |Alapértelmezett órajel-frekvencia hertzben.        |`1000000`          |
|`FEnabled`          |`Boolean`               |A CPU engedélyezése leválasztás nélkül.            |`False`            |
|`FEndianness`       |`TEndianness`           |CPU-bájtsorrend.                                   |itt nincs beállítva|
|`FLastInstruction`  |`TLastInstruction`      |Az utoljára végrehajtott utasítás adatai.          |itt nincs beállítva|
|`FMaxCodeAddress`   |`DWord`                 |A kódmemória legmagasabb címe.                     |itt nincs beállítva|
|`FMaxIOPortAddress` |`DWord`                 |A legmagasabb I/O-portcím.                         |itt nincs beállítva|
|`FMaxMemAddress`    |`DWord`                 |Az adatmemória legmagasabb címe.                   |itt nincs beállítva|
|`FHasSeparateIOBus` |`Boolean`               |Jelzi, hogy a memória- és az I/O-sín különálló-e.  |itt nincs beállítva|
|`FRunning`          |`Boolean`               |A CPU végrehajtási állapota.                       |`False`            |
|`FHalted`           |`Boolean`               |A CPU HALT-állapota.                               |`False`            |
|`FInterruptEnabled` |`Boolean`               |A maszkolható megszakítások globális engedélyezője.|`False`            |
|`FIRQPending`       |`array[0..7] of Boolean`|A maszkolható megszakítások függőben lévő jelzői.  |mind `False`       |
|`FIRQVector`        |`array[0..7] of Byte`   |A nyolc IRQ-csatorna megszakításvektorai.          |mind `0`           |
|`FNMIPending`       |`Boolean`               |Függőben lévő nem maszkolható megszakítás.         |`False`            |
|`FTotalCycles`      |`QWord`                 |A CPU összes ciklusának száma.                     |`0`                |
|`FTotalInstructions`|`QWord`                 |A végrehajtott utasítások összesített száma.       |`0`                |
|`FOnDestroy`        |`TProcessorDestroyEvent`|CPU-megsemmisítési visszahívás.                    |itt nincs beállítva|
|`FRegPtr`           |`array of ^Word`        |Regisztermutatók a leszármazott CPU-osztályokhoz.  |üres               |

### Védett metódusok

|név                                                         |jelző|leírás                                                         |
|------------------------------------------------------------|-----|---------------------------------------------------------------|
|`procedure EmitEvent(AEvent: TCPUEvent);`                   |Vi   |Eseményt küld a regisztrált visszahívási eljárásnak.           |
|`procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0);`|Vi   |Az `EmitEvent` segítségével továbbítja a megszakítási eseményt.|

### Nyilvános metódusok

|név                                                         |jelző |leírás                                                                                                             |
|------------------------------------------------------------|------|-------------------------------------------------------------------------------------------------------------------|
|`function ConnectBus(const ABus: IInterface): Boolean;`     |Ab,Vi |Absztrakt síncsatlakoztatás; a leszármazott osztály valósítja meg.                                                 |
|`constructor Create;`                                       |Vi    |Inicializálja a futásidejű jelzőket, a megszakítási tömböket, a számlálókat, a síntípust, az órajelet és a verziót.|
|`destructor Destroy;`                                       |Or    |Meghívja az `OnDestroy` eseményt, ha hozzá van rendelve, majd megsemmisíti a példányt.                             |
|`function CheckInterrupts: Boolean;`                        |Vi    |Elfogad egy függőben lévő megszakítást, ha lehetséges.                                                             |
|`function GetCurrentInstruction: TLogRec;`                  |Ab,Vi |Visszaadja az aktuális utasítás naplóadatait; absztrakt.                                                           |
|`function GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec;`|Vi    |Visszaadja a megszakítás naplóadatait; az alaposztály csak a `Sender` mezőt üríti.                                 |
|`function GetRegister(const RegName: PChar): Word;`         |Ab,Vi |Kiolvassa a processzorregisztert; a leszármazott osztály valósítja meg.                                            |
|`function GetRegisterCount: Byte;`                          |Ab,Vi |Visszaadja a processzorregiszterek számát.                                                                         |
|`function GetRegisterName(AIndex: Byte): PChar;`            |Ab,Vi |Index alapján visszaadja a regiszter nevét.                                                                        |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |Ab,Vi |Index alapján visszaadja a regiszter méretét.                                                                      |
|`function LoadState(AStream: TStream): Boolean;`            |Ab,Vi |Betölti a processzor állapotát; a leszármazott osztály valósítja meg.                                              |
|`function SaveState(AStream: TStream): Boolean;`            |Ab,Vi |Elmenti a processzor állapotát; a leszármazott osztály valósítja meg.                                              |
|`procedure IRQ(AVector: Byte; AMode: Byte = 0);`            |Vi    |Beállítja a kiválasztott csatorna függő IRQ-jelzőjét és vektorát, majd `ceInterrupt` eseményt küld.                |
|`procedure NMI;`                                            |Vi    |Beállítja a függő NMI-jelzőt, majd `ceInterrupt` eseményt küld.                                                    |
|`procedure Reset;`                                          |Ab,Vi |Alaphelyzetbe állítja a processzort; a leszármazott osztály valósítja meg.                                         |
|`procedure Run;`                                            |Vi    |Beállítja a futási állapotot, ha a CPU engedélyezett.                                                              |
|`procedure SetRegister(const RegName: PChar; AValue: Word);`|Ab,Vi |Beállítja a processzorregisztert; a leszármazott osztály valósítja meg.                                            |
|`procedure Step;`                                           |Ab,Vi |Végrehajt egy processzorlépést; a leszármazott osztály valósítja meg.                                              |
|`procedure Stop;`                                           |Vi    |Törli a futási állapotot.                                                                                          |

### Megszakításkezelés

Az alaposztály nyolc, `0` és `7` közötti indexű maszkolható megszakítási csatornát
kezel. Az `IRQ(AVector, AMode)` eltárolja a vektort, és beállítja a kiválasztott
csatorna függő megszakításjelzőjét. A `CheckInterrupts` először az NMI-t vizsgálja.
Ha nincs függő NMI, növekvő indexsorrendben ellenőrzi a maszkolható csatornákat,
és a globális megszakításengedélyezés esetén az első függő IRQ-t fogadja el.
Elfogadáskor törli a függő jelzőt és a CPU HALT-állapotát, meghívja a
`DoInterrupt` metódust, majd `True` értékkel tér vissza. Egy hívás legfeljebb
egy megszakítást fogad el.

Az `IRQ` és az `NMI` nem végez műveletet, ha a CPU le van tiltva. Az alaposztály
`DoInterrupt` metódusa csak a megadott CPU-eseményt továbbítja; az `AMode`
paramétert ott más célra nem használja.

### Nyilvános tulajdonságok

|név                |típus                   |elérés|leírás                                            |
|-------------------|------------------------|------|--------------------------------------------------|
|`AddressWidth`     |`Byte`                  |Re    |A címsín szélessége bitekben.                     |
|`Architecture`     |`TArchitecture`         |Re    |CPU-architektúra.                                 |
|`BusType`          |`TBusType`              |Re    |Rendszersíntípus.                                 |
|`DefaultClockFreq` |`DWord`                 |Re    |Alapértelmezett órajel-frekvencia hertzben.       |
|`TotalCycles`      |`QWord`                 |Re    |A CPU-ciklusok összesített számlálója.            |
|`Description`      |`PChar`                 |Re    |Rövid modul-leírás.                               |
|`Enabled`          |`Boolean`               |Re/Wr |Engedélyezi vagy letiltja a CPU működését.        |
|`Endianness`       |`TEndianness`           |Re    |CPU-bájtsorrend.                                  |
|`Halted`           |`Boolean`               |Re    |A CPU aktuális HALT-állapota.                     |
|`HasSeparateIOBus` |`Boolean`               |Re    |Jelzi, hogy a memória- és az I/O-sín különálló-e. |
|`TotalInstructions`|`QWord`                 |Re    |A végrehajtott utasítások összesített száma.      |
|`InterruptEnabled` |`Boolean`               |Re    |A maszkolható megszakítások globális állapota.    |
|`MaxCodeAddress`   |`DWord`                 |Re    |A kódmemória legmagasabb címe.                    |
|`MaxIOPortAddress` |`DWord`                 |Re    |A legmagasabb I/O-portcím.                        |
|`MaxMemAddress`    |`DWord`                 |Re    |Az adatmemória legmagasabb címe.                  |
|`Modname`          |`PChar`                 |Re    |Modulnév.                                         |
|`OnEvent`          |`TCPUEventHandler`      |Re/Wr |CPU-esemény visszahívási eljárása.                |
|`Running`          |`Boolean`               |Re    |Az aktuális végrehajtási állapot.                 |
|`Version`          |`TSemanticVersion`      |Re    |Modulverzió.                                      |
|`OnDestroy`        |`TProcessorDestroyEvent`|Re/Wr |A példány megsemmisítésekor meghívott visszahívás.|
