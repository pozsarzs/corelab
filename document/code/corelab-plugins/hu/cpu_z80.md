# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TZ80CPU a TCPU osztályból a cpu_z80 egységben

A `TZ80CPU` a Zilog Z80 processzor megvalósítása a CoreLAB keretrendszerhez.
A `TCPU` osztályból származik, és megvalósítja a Z80 regiszterkészletét, a
flagkezelést, a reset műveletet, az állapot megőrzését, az utasításonkénti
végrehajtást, a megszakításkezelést és -jelentést, az aktuális utasítás
jelentését, valamint a regiszterek elérését.

### CPU-konfiguráció

A konstruktor az örökölt `TCPU` tulajdonságait a következőképpen állítja be:

|elem                             |érték                      |
|---------------------------------|---------------------------|
|Modul neve                       |`Z80`                      |
|Leírás                           |`Zilog Z80 microprocessor` |
|Architektúra                     |`arNeumann`                |
|Címszélesség                     |16                         |
|Bájtsorrend                      |`enLittle`                 |
|Maximális memória-cím            |`$FFFF`                    |
|Maximális kód-cím                |`$FFFF`                    |
|Maximális I/O-port cím           |`$00FF`                    |
|Külön I/O-busz                   |`True`                     |
|Alapértelmezett órajel-frekvencia|2500000 Hz (2,5 MHz)       |

### Reset állapot

A `Reset` letiltja a végrehajtást, törli a várakozási és függőben lévő
megszakítási állapotot, nullázza a végrehajtási számlálókat, törli a teljes
`TZ80Registers` rekordot, és a veremmutatót `$FFFF` értékre állítja.

|regiszter/állapot  |érték               |
|-------------------|--------------------|
|`PC`               |`$0000`             |
|`SP`               |`$FFFF`             |
|`Running`          |`False`             |
|`Halted`           |`False`             |
|`InterruptEnabled` |`False`             |
|`FIRQPending`      |minden elem `False` |
|`FNMIPending`      |`False`             |
|`TotalCycles`      |`0`                 |
|`TotalInstructions`|`0`                 |

A teljes regiszterrekord törlődik, ezért a fő és alternatív regiszterkészlet,
az indexregiszterek, az `I` és az `R` kezdetben nulla. A metódus kiváltja az
örökölt `ceReset` eseményt.

A forrás nem állítja vissza kifejezetten az `FInterruptMode` és
`FInterruptEnabled2` mezőket. Ezek nem részei a `TZ80Registers` rekordnak.

### Utasítás-végrehajtás

A `Step` a következő műveleteket végzi el:

1. Azonnal leáll, ha a CPU le van tiltva (`FEnabled = False`).
2. Meghívja a `CheckInterrupts` metódust; a végrehajtás azonnal leáll, ha egy megszakítás elfogadásra kerül.
3. Azonnal leáll, ha a CPU várakozó (halt) állapotban van.
4. Inicializálja az utolsó utasítás címét, ciklusszámát, prefixszámát és operandusszámát.
5. Beolvassa a bájtokat a rendszerbuszról az aktuális `PC` címről, és minden beolvasás után növeli a `PC` értékét.
6. Felismeri az ismétlődő `DD` és `FD` prefixbájtokat, mindegyikhez négy ciklust rendel, és kiválasztja a megfelelő prefixmódot.
7. A végső opkódot és a kiválasztott prefixet átadja a `RunOpCode` metódusnak.
8. Hozzáadja az utasítás ciklusszámát a `FTotalCycles` értékéhez.
9. Kiváltja a `ceInstructionBoundary` eseményt.
10. Növeli a `FTotalInstructions` értékét.

A `RunOpCode` a prefixmód alapján hét beillesztett mikrokódforrás egyikére
irányítja a végrehajtást: prefix nélküli, `CB`, `DD`, `ED`, `FD`, `DDCB` vagy
`FDCB`. A rendelkezésre álló `Step` megvalósítás kifejezetten a `DD` és `FD`
prefixeket fogyasztja el; a többi prefixsorozat kezelése a beillesztett
mikrokódtól függ.

A forrás csatlakoztatott `FBus` buszt igényel az utasítások beolvasásához.
A memória- és I/O-műveleteket a mikrokódban használt buszhívások végzik.

### Flagkezelés

Az `UpdateFlags` a Z80 `F` flagregiszterét a megadott eredmény, a régi érték,
az operandus és két módparaméter alapján frissíti.

|flag |jelentés                                                            |
|-----|--------------------------------------------------------------------|
|`S`  |Előjel, a 8 bites eredmény 7. bitjéből                              |
|`Z`  |Nulla, akkor van beállítva, ha a 8 bites eredmény nulla             |
|`Y`  |Nem dokumentált flagbit (5. bit), az eredmény 5. bitjéből           |
|`H`  |Félátvitel, a 4. bit és az operandusok alapján számítva             |
|`X`  |Nem dokumentált flagbit (3. bit), az eredmény 3. bitjéből           |
|`P/V`|Paritás vagy túlcsordulás, a `P` paraméter választása szerint       |
|`N`  |Összeadás/kivonás jelzőbit, akkor áll be, ha az `N` paraméter `True`|
|`C`  |Átvitel, a 16 bites eredmény 8. bitjéből                            |

Ha `P = True`, a `P/V` bit páros paritás esetén áll be. Egyébként a metódus
aritmetikai túlcsordulást számít: `N = True` esetén kivonási, egyébként
összeadási szabályok szerint. Az `N` paraméter a kivonásjelző bitet is vezérli.

### Megszakítás-kezelés

A `CheckInterrupts` először a nem maszkolható megszakítást ellenőrzi. Ha az
`FNMIPending` be van állítva, törli a függőben lévő jelzőt, kilépteti a CPU-t
a várakozó állapotból, meghívja a `DoInterrupt(ceInterrupt, imNMI)` metódust,
és jelzi, hogy megszakítás elfogadásra került.

Ezután növekvő indexsorrendben ellenőrzi az `FIRQPending` elemeit. Maszkolható
megszakítás csak akkor fogadható el, ha a megfelelő függőben lévő jelző és az
`FInterruptEnabled` is be van állítva. A kiválasztott jelző törlődik, a CPU
kilép a várakozó állapotból, majd a `DoInterrupt` az elem indexével mint
módparaméterrel fut le. Egy ellenőrzés során legfeljebb egy megszakítás fogadható el.

A `DoInterrupt` először meghívja az örökölt megszakításkezelőt. Maszkolható
megszakítás esetén törli az `FInterruptEnabled` és az `FInterruptEnabled2`
mezőket, majd a verembe menti az aktuális `PC` értékét: először a magas,
majd az alacsony bájtot.

- **NMI:** a `PC` értékét `$0066`-ra állítja, 11 ciklust ad hozzá, majd visszatér.
- **IM 0:** a megadott vektort csak RST kódolás esetén fogadja el
  (`FIRQVector[AMode] >= $C0` és az alsó három bit `$07`). Az újraindítási cím:
  `((FIRQVector[AMode] shr 3) and $07) * 8`; a metódus 13 ciklust ad hozzá.
- **IM 1:** a `PC` értékét `$0038`-ra állítja, és 13 ciklust ad hozzá.
- **IM 2:** az `I` regiszterből képzi a vektortáblacím magas bájtját, a
  megszakítási vektorból pedig az alacsony bájtot. Az új `PC` értékét erről a
  címről, little-endian szóként olvassa be, és 19 ciklust ad hozzá.

A megszakítási módot az `FInterruptMode` tárolja. A forrás az
`imINT_IM0`, `imINT_IM1`, `imINT_IM2` és `imNMI` konstansokat használja,
amelyek értéke rendre 0, 1, 2 és 255.

Az `NMI` metódus letiltott CPU esetén nem végez műveletet. Egyébként beállítja
az `FNMIPending` jelzőt, az `FInterruptEnabled` értékét elmenti az
`FInterruptEnabled2` mezőbe, letiltja a maszkolható megszakításokat, és
kiváltja a `ceInterrupt` eseményt.

A `GetCurrentInterrupt(AMode)` a kiválasztott vektort két hexadecimális
számjeggyel adja vissza. A `Flag` mező értéke `EI`, ha az
`FInterruptEnabled` be van állítva, egyébként `DI`. A `Status` mező értéke
`Pending`, ha az `FIRQPending[AMode]` be van állítva; egyébként üres.
A `Sender` mező üres.

### Aktuális utasítás információi

A `GetCurrentInstruction` egy `TLogRec` értéket ad vissza, amely a következőket tartalmazza:

1. az utasítások teljes számát;
2. az utasítás címét négy hexadecimális számjeggyel;
3. az opkódot két hexadecimális számjeggyel, amelyet legfeljebb két rögzített operandusbájt követ;
4. a mnemonikot: ha `%` karaktert tartalmaz, egy vagy két operandussal formázza, egyébként a hexadecimális operandusértékeket fűzi hozzá;
5. az utolsó utasítás ciklusszámát;
6. az összesített ciklusszámot.

A metódus az opkódot és a rögzített operandusokat a
`FLastInstruction` rekordból formázza. A pontos mnemonik és operandustartalom
a beillesztett mikrokódtól függ.

### Regiszterelérés

A `GetRegister` és `SetRegister` a regiszterneveket a kis- és nagybetűk
figyelmen kívül hagyásával hasonlítja össze az `UpperCase` segítségével.

|regiszter|szélesség |olvasható|írható|
|---------|----------|---------|------|
|`A`      |8 bit     |Igen     |Igen  |
|`B`      |8 bit     |Igen     |Igen  |
|`C`      |8 bit     |Igen     |Igen  |
|`D`      |8 bit     |Igen     |Igen  |
|`E`      |8 bit     |Igen     |Igen  |
|`H`      |8 bit     |Igen     |Igen  |
|`L`      |8 bit     |Igen     |Igen  |
|`F`      |8 bit     |Igen     |Igen  |
|`PC`     |16 bit    |Igen     |Igen  |
|`SP`     |16 bit    |Igen     |Igen  |
|`IX`     |16 bit    |Igen     |Igen  |
|`IY`     |16 bit    |Igen     |Igen  |
|`I`      |8 bit     |Igen     |Igen  |
|`R`      |8 bit     |Igen     |Igen  |

A nyolcbites regiszterek értéke `$FF`, a 16 bites regisztereké `$FFFF`
maszkolással kerül beállításra.

A `case` utasításban nem kezelt nevek nem okoznak változást a `SetRegister`
metódusban, a `GetRegister` pedig `0` értéket ad vissza.

### Nyilvános regiszterfelsorolás

A nyilvános regiszterfelsorolás tizennégy bejegyzést tartalmaz:

|index|név|méret     |
|-----|----|---------|
|0    |`A` |2 nibbles|
|1    |`B` |2 nibbles|
|2    |`C` |2 nibbles|
|3    |`D` |2 nibbles|
|4    |`E` |2 nibbles|
|5    |`H` |2 nibbles|
|6    |`L` |2 nibbles|
|7    |`F` |2 nibbles|
|8    |`PC`|4 nibbles|
|9    |`SP`|4 nibbles|
|10   |`IX`|4 nibbles|
|11   |`IY`|4 nibbles|
|12   |`I` |2 nibbles|
|13   |`R` |2 nibbles|

A `GetRegisterCount` a `PubRegNames` bejegyzéseinek számát adja vissza.
A `GetRegisterName` érvényes index esetén visszaadja a regiszter nevét,
egyébként `nil` értéket. A `GetRegisterSize` a megfelelő méretet adja vissza
nibble-ben, érvénytelen index esetén pedig `0` értéket.

### TZ80Registers

A `TZ80Registers` variánsrekord a 16 bites regiszterpárok és az egyedi
8 bites összetevők elérését is biztosítja.

|16 bites regiszter|8 bites reprezentáció|
|------------------|---------------------|
|`BC`              |`B`, `C`             |
|`DE`              |`D`, `E`             |
|`HL`              |`H`, `L`             |
|`AF`              |`A`, `F`             |
|`BC_`             |`B_`, `C_`           |
|`DE_`             |`D_`, `E_`           |
|`HL_`             |`H_`, `L_`           |
|`AF_`             |`A_`, `F_`           |
|`PC`              |`PCH`, `PCL`         |
|`SP`              |`SPH`, `SPL`         |
|`IX`              |`IXH`, `IXL`         |
|`IY`              |`IYH`, `IYL`         |

A rekord tartalmazza továbbá az `I` 8 bites megszakításvektor-regisztert és
az `R` frissítőregisztert. Az alternatív regiszterkészletet az aláhúzásos
utótaggal ellátott regiszterpárok és bájtok képviselik.

### Belső regiszternevek és opkódprefixek

A belső regiszternév-táblák a következő indexelt operandusokat határozzák meg:

|index|`RegNames`|`XRegNames`|`YRegNames`|
|-----|----------|-----------|-----------|
|0    |`B`       |`B`        |`B`        |
|1    |`C`       |`C`        |`C`        |
|2    |`D`       |`D`        |`D`        |
|3    |`E`       |`E`        |`E`        |
|4    |`H`       |`IXH`      |`IYH`      |
|5    |`L`       |`IXL`      |`IYL`      |
|6    |`(HL)`    |`(IX)`     |`(IY)`     |
|7    |`A`       |`A`        |`A`        |

A prefixkonstansok a mikrokódforrás kiválasztására szolgálnak:

|konstans|érték|jelentés             |
|--------|-----|---------------------|
|`prNone`|0    |Prefix nélküli opkód |
|`prCB`  |1    |`CB` prefix          |
|`prDD`  |2    |`DD` prefix          |
|`prED`  |3    |`ED` prefix          |
|`prFD`  |4    |`FD` prefix          |
|`prDDCB`|5    |`DD CB` prefixsorozat|
|`prFDCB`|6    |`FD CB` prefixsorozat|

### Védett mezők és metódusok

|név                 |típus                  |leírás                                                                    |
|--------------------|-----------------------|--------------------------------------------------------------------------|
|`RegPointers`       |`array[0..7] of PByte` |Az utasítás-megvalósítás által használt 8 bites regiszterváltozók mutatói.|
|`FBus`              |`IStandardBus`         |Csatlakoztatott külső rendszerbusz.                                       |
|`FRegs`             |`TZ80Registers`        |A teljes Z80 regiszterkészlet.                                            |
|`FInterruptMode`    |`Byte`                 |A kiválasztott maszkolható megszakítási mód.                              |
|`FInterruptEnabled2`|`Boolean`              |Másodlagos megszakításengedélyezési állapot (`IFF2`).                     |

|metódus                                                                                                    |jelzők    |leírás                                                                                            |
|-----------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------------------------------------|
|`procedure UpdateFlags(Value16: Word; OldValue, ValueToAdd: Byte; N: Boolean = False; P: Boolean = False);`|          |Frissíti a Z80 flagregisztert, beleértve a paritás/túlcsordulás és az összeadás/kivonás kezelését.|
|`procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0); override;`                                     |`override`|Elvégzi az NMI és a maszkolható megszakítások kezelését a kiválasztott módban.                    |
|`procedure RunOpCode(AOC: Byte; APrefix: Byte = 0);`                                                       |          |A megfelelő beillesztett mikrokódforráshoz irányítja az opkód végrehajtását.                      |

### Állapot megőrzése

A `LoadState` a következő adatokat olvassa be ebben a sorrendben:

|sorrend|adat                |
|-------|--------------------|
|1      |`FEnabled`          |
|2      |`FRegs`             |
|3      |`FLastInstruction`  |
|4      |`FRunning`          |
|5      |`FHalted`           |
|6      |`FInterruptEnabled` |
|7      |`FInterruptEnabled2`|
|8      |`FInterruptMode`    |
|9      |`FIRQPending`       |
|10     |`FNMIPending`       |
|11     |`FTotalCycles`      |
|12     |`FTotalInstructions`|

Ha adatfolyam-kivétel történik, a `LoadState` `False` értéket ad vissza;
egyébként `True` értéket ad vissza.

A `SaveState` ugyanazokat az adatokat, ugyanebben a sorrendben írja ki, és
az írási műveletek befejezése után `True` értéket ad vissza.

### Nyilvános metódusok

|név                                                         |jelzők    |leírás                                                                                                                                                                                                      |
|------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                       |`override`|Létrehoz egy Zilog Z80 CPU-t, beállítja az architektúra-paramétereket és a regisztermutatókat, majd resetet hajt végre.                                                                                     |
|`function CheckInterrupts: Boolean;            `            |`override`|Ellenőrzi a függőben lévő NMI- és maszkolható megszakításokat, és hívásonként legfeljebb egyet fogad el.                                                                                                    |
|`procedure Reset;`                                          |`override`|Törli a regiszterkészletet, a végrehajtási és függőben lévő megszakítási állapotot, nullázza a számlálókat, a `PC` értékét `0`-ra, az `SP` értékét `$FFFF`-re állítja, és kiváltja a `ceReset` eseményt.    |
|`function ConnectBus(const ABus: IInterface): Boolean;`     |`override`|Csatlakoztatja a megadott interfészt, ha az támogatja az `IStandardBus` interfészt.                                                                                                                         |
|`function LoadState(AStream: TStream): Boolean;`            |`override`|Betölti az engedélyezési állapotot, a regiszterkészletet, az utolsó utasítás rekordját, a végrehajtási és megszakítási állapotot, valamint a számlálókat.                                                   |
|`function SaveState(AStream: TStream): Boolean;`            |`override`|Elmenti az engedélyezési állapotot, a regiszterkészletet, az utolsó utasítás rekordját, a végrehajtási és megszakítási állapotot, valamint a számlálókat.                                                   |
|`procedure NMI;`                                            |`override`|Függőben lévő nem maszkolható megszakítást állít be, az `IFF2` mezőbe menti a maszkolható megszakítás engedélyezési állapotát, letiltja a maszkolható megszakításokat, és kiváltja a `ceInterrupt` eseményt.|
|`procedure Step;`                                           |`override`|Beolvassa és végrehajtja az utasítást, kezeli a `DD`/`FD` prefixbájtokat, számlálja a ciklusokat, kiváltja az utasításhatár eseményt és növeli az utasításszámot.                                           |
|`function GetCurrentInstruction: TLogRec;`                  |`override`|Strukturált információt ad vissza a legutóbb végrehajtott utasításról.                                                                                                                                      |
|`function GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec;`|`override`|Visszaadja a kiválasztott megszakításvektort, a megszakítás-engedélyezési állapotot és a függőben lévő állapotot.                                                                                           |
|`function GetRegister(const RegName: PChar): Word;`         |`override`|Visszaadja a megadott nyilvános regiszter értékét.                                                                                                                                                          |
|`procedure SetRegister(const RegName: PChar; Value: Word);` |`override`|Beállítja a megadott nyilvános regisztert, a regiszterszélességnek megfelelő maszkolással.                                                                                                                  |
|`function GetRegisterCount: Byte;`                          |`override`|Visszaadja a nyilvánosan felsorolt regiszterek számát.                                                                                                                                                      |
|`function GetRegisterName(AIndex: Byte): PChar;`            |`override`|Érvényes index esetén visszaadja a nyilvános regiszter nevét.                                                                                                                                               |
|`function GetRegisterSize(AIndex: Byte): Byte;`             |`override`|Érvényes index esetén visszaadja a nyilvános regiszter méretét nibble-ben.                                                                                                                                  |

### Exportált plugininterfész

Az egység a `cpu_z80` dinamikus könyvtárként fordul, és négy plugin
belépési pontot exportál:

|exportált név  |függvény    |leírás                                                                                                      |
|---------------|------------|------------------------------------------------------------------------------------------------------------|
|`cpu_create`   |`CreateCPU` |Létrehoz és `TCPU` típusúként visszaad egy új `TZ80CPU` példányt.                                           |
|`cpu_destroy`  |`DestroyCPU`|Megsemmisíti a megadott CPU-példányt, ha az hozzá van rendelve.                                             |
|`cpu_loadstate`|`LoadState` |Állapotot tölt be a megadott `TCPU` referencián keresztül. `False` értéket ad vissza, ha a referencia `nil`.|
|`cpu_savestate`|`SaveState` |Állapotot ment a megadott `TCPU` referencián keresztül. `False` értéket ad vissza, ha a referencia `nil`.   |
