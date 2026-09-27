# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TIOPort a core_ioport modulból

A `TIOPort` absztrakt alaposztály az I/O-port eszközök megvalósításához. 
Meghatározza a közös címtartomány-, adatvonal-dekódolási, megszakításkezelési, állapotmentési
és modulazonosítási tulajdonságokat. A konkrét eszközöknek meg kell valósítaniuk az alaphelyzetbe állítást,
a port olvasását és a port írását.

### Kapcsolódó típusok

|name                |type          |description                                                      |
|--------------------|--------------|-----------------------------------------------------------------|
|`TLineMode`         |enumeration   |Adatvonal-dekódolási mód: `lmDirect` vagy `lmBCD`                   |
|`TInterruptCallback`|procedure type|Megszakítási visszahívás, amely a forrásportot és a megszakításvektort kapja meg|
|`TSemanticVersion`  |record        |Fő-, al- és javítóverzió adatai                      |

### Típussegédek

|name                             |description                                              |
|---------------------------------|---------------------------------------------------------|
|`TLineModeHelper.ToString`       |A vonalmódot a felsorolás nevévé alakítja             |
|`TLineModeHelper.FromString`     |A felsorolás nevét `TLineMode` értékké alakítja              |
|`TSemanticVersionHelper.ToString`|A verziót `Major.Minor.Patch` formátumban jeleníti meg                 |
|`TSemanticVersionHelper.Compare` |Összehasonlít két szemantikus verziót; `-1`, `0` vagy `1` értéket ad vissza|

### Védett mezők

|name               |type                |description                                         |initial value       |
|-------------------|--------------------|----------------------------------------------------|--------------------|
|`FAddressRangeSize`|`DWord`             |Címtartomány mérete                                  |`1`                 |
|`FBaseAddress`     |`DWord`             |Báziscím.                                       |`0`                 |
|`FDataInMode`      |`TLineMode`         |Bemeneti adatvonal dekódolási módja                       |`lmBCD`             |
|`FDataInNegation`  |`Boolean`           |Bemeneti adatbit negálása                             |`false`             |
|`FDataOutMode`     |`TLineMode`         |Kimeneti adatvonal dekódolási módja                      |`lmBCD`             |
|`FDataOutNegation` |`Boolean`           |Kimeneti adatbit negálása                            |`false`             |
|`FDescription`     |`PChar`             |Rövid leírás                                   |not initialized here|
|`FEnabled`         |`Boolean`           |A port engedélyezése a sínről való leválasztás nélkül   |`false`             |
|`FHasPanel`        |`Boolean`           |Jelzi, hogy a megvalósítás rendelkezik-e grafikus panellel|`false`             |
|`FIntVector`       |`Byte`              |Megszakításvektor                                    |`0`                 |
|`FLatchedOutput`   |`Boolean`           |Jelzi a reteszelt kimenet képességét/állapotát           |`false`             |
|`FModname`         |`PChar`             |Modulnév                                         |`MyIO`              |
|`FOnInterrupt`     |`TInterruptCallback`|Megszakítási visszahívás                                  |`nil`               |
|`FReadBackOutput`  |`Boolean`           |Jelzi a kimenet visszaolvasásának lehetőségét               |`false`             |
|`FSelMode`         |`TLineMode`         |Választóvonal dekódolási módja                         |`lmBCD`             |
|`FSelNegation`     |`Boolean`           |Választóbit negálása                               |`false`             |
|`FVersion`         |`TSemanticVersion`  |Modulverzió                                      |`0.1.0`             |

### Védett metódusok

|name                         |flags|description                                                                    |
|-----------------------------|-----|-------------------------------------------------------------------------------|
|`procedure RequestInterrupt;`|Vi   |Engedélyezett port esetén meghívja a megszakítási visszahívást a beállított vektorral|

A `RequestInterrupt` nem végez műveletet, ha az `Enabled` értéke nem `true`, vagy nincs hozzárendelve megszakítási visszahívás.

### Nyilvános metódusok

|name                                             |flags|description                                                                 |
|-------------------------------------------------|-----|----------------------------------------------------------------------------|
|`constructor Create;`                            |Vi   |Inicializálja az általános I/O-portbeállításokat                                         |
|`destructor Destroy;`                            |Or   |Megsemmisíti az I/O-port objektumot                                                 |
|`procedure Reset;`                               |Ab,Vi|Alaphelyzetbe állítja a konkrét I/O-eszközt; a megvalósítást egy leszármazott osztály biztosítja|
|`function ReadPort(APort: Word): Byte;`          |Ab,Vi|Egy bájtot olvas a konkrét I/O-portról                                        |
|`procedure WritePort(APort: Word; AValue: Byte);`|Ab,Vi|Egy bájtot ír a konkrét I/O-portra                                         |
|`function LoadState(AStream: TStream): Boolean;` |Vi   |Betölti az általános I/O-portállapotot egy adatfolyamból                                    |
|`function SaveState(AStream: TStream): Boolean;` |Vi   |Elmenti az általános I/O-portállapotot, ha a példány érvényes példányazonosítóval rendelkezik        |

### Nyilvános tulajdonságok

|name              |type                |access|description                               |
|------------------|--------------------|------|------------------------------------------|
|`AddressRangeSize`|`DWord`             |Re    |Címtartomány mérete                        |
|`BaseAddress`     |`DWord`             |Re/Wr |Globális kezdőcím                      |
|`DataInMode`      |`TLineMode`         |Re/Wr |Bemeneti adatvonal dekódolási módja             |
|`DataInNegation`  |`Boolean`           |Re/Wr |Bemeneti adatbit negálása                   |
|`DataOutMode`     |`TLineMode`         |Re/Wr |Kimeneti adatvonal dekódolási módja            |
|`DataOutNegation` |`Boolean`           |Re/Wr |Kimeneti adatbit negálása                  |
|`Description`     |`PChar`             |Re    |Rövid leírás                         |
|`Enabled`         |`Boolean`           |Re/Wr |A port engedélyezése                           |
|`HasPanel`        |`Boolean`           |Re    |Jelzi, hogy a megvalósítás rendelkezik-e grafikus panellel|
|`IntVector`       |`Byte`              |Re/Wr |Megszakításvektor                          |
|`LatchedOutput`   |`Boolean`           |Re    |Reteszelt kimenet tulajdonsága                   |
|`ModName`         |`PChar`             |Re    |Modulnév                               |
|`OnInterrupt`     |`TInterruptCallback`|Re/Wr |Megszakítási visszahívás                        |
|`ReadBackOutput`  |`Boolean`           |Re    |Kimenet-visszaolvasási tulajdonság                 |
|`SelMode`         |`TLineMode`         |Re/Wr |Választóvonal dekódolási módja               |
|`SelNegation`     |`Boolean`           |Re/Wr |Választóbit negálása                     |
|`Version`         |`TSemanticVersion`  |Re    |Modulverzió                            |
