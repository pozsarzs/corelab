# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TMemory a core_memory modulból

A `TMemory` a CoreLAB keretrendszer alapmemória-komponense. Bájt címezhető memóriatárolást biztosít
konfigurálható címtérmérettel, RAM/ROM
üzemmóddal, engedélyezési állapottal, példányazonosítással és adatfolyam-alapú állapot
mentéssel.

### TMemoryMode

A `TMemoryMode` a memória működési módját határozza meg:

|érték  |leírás                                                    |
|-------|----------------------------------------------------------|
|`mmRAM`|A memória tartalma akkor írható, ha a memória engedélyezett.|
|`mmROM`|A memória tartalma a `WriteMemory` metóduson keresztül csak olvasható.      |

### TMemoryModeHelper

|name                             |description                                                      |
|---------------------------------|-----------------------------------------------------------------|
|`ToString`                       |Az aktuális `TMemoryMode` értéket a felsorolás nevévé alakítja.|
|`FromString(const Value: string)`|A felsorolás nevét RTTI segítségével `TMemoryMode` értékké alakítja.|

### TSemanticVersion

A `TSemanticVersion` a modul verzióját három egész számú összetevőként tárolja.

|field  |type     |description          |
|-------|---------|---------------------|
|`Major`|`Integer`|Főverziószám.|
|`Minor`|`Integer`|Alverziószám.|
|`Patch`|`Integer`|Javítóverziószám.|

### TSemanticVersionHelper

|name                               |description                                                                                             |
|-----------------------------------|--------------------------------------------------------------------------------------------------------|
|`ToString`                         |A verziót `Major.Minor.Patch` formátumban jeleníti meg.                                                             |
|`Compare(AOther: TSemanticVersion)`|Összehasonlítja a másik verziót az aktuális verzióval. Újabb, azonos vagy régebbi verzió esetén `-1`, `0`, illetve `1` értéket ad vissza.|

### Védett mezők

|name               |type              |description                                  |default                                 |
|-------------------|------------------|---------------------------------------------|----------------------------------------|
|`FAddressRangeSize`|`DWord`           |A címezhető memóriacellák száma.          |`1024`                                  |
|`FBaseAddress`     |`DWord`           |Báziscím.                                |`0`                                     |
|`FDescription`     |`PChar`           |A modul rövid leírása.                    |`Standard memory with 8 bit data width.`|
|`FEnabled`         |`Boolean`         |Engedélyezi a memóriaelérést a sínről való leválasztás nélkül.|`False`                                 |
|`FMemoryMode`      |`TMemoryMode`     |RAM vagy ROM működési mód.                   |`mmRAM`                                 |
|`FMemCells`        |`array of Byte`   |Belső, bájtonként címezhető memóriatároló.    |1024 bytes initially                    |
|`FModname`         |`PChar`           |Modulnév.                                 |`RAM/ROM`                               |
|`FVersion`         |`TSemanticVersion`|Modulverzió.                              |`0.1.0`                                 |

### Védett metódusok

|name                                                       |description                                                                                                               |
|-----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
|`procedure SetFAddressRangeSize(AAddressRangeSize: DWord);`|Beállítja a címtér méretét, és átméretezi a memóriatömböt. A `16` alatti értékeket figyelmen kívül hagyja; a maximális méret `2^24` bájt.|

### Nyilvános metódusok

|name                                                                  |flags|description                                                                                                                        |
|----------------------------------------------------------------------|-----|-----------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                                 |Vi   |Inicializál egy 1024 bájtos RAM-modult, letiltja, beállítja a moduladatait, és törli a memória tartalmát.                |
|`destructor Destroy;`                                                 |Or   |Megsemmisíti a memóriaobjektumot.                                                                                                        |
|`procedure Reset;`                                                    |Vi   |Az összes lefoglalt memóriacellát nullával tölti fel.                                                                                        |
|`function ReadMemory(AAddress: DWord): Byte;`                         |Vi   |Engedélyezett állapotban és a beállított címtartományon belül visszaadja a megadott címen található bájtot. Egyébként `0` értéket ad vissza.                     |
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`               |Vi   |Bájtot ír, ha a memória engedélyezett, `mmRAM` módban van, és a cím a beállított tartományba esik.                                                       |
|`function LoadState(AStream: TStream): Boolean;`                      |Vi   |Betölti az engedélyezési állapotot, a memóriamódot, a címtartomány méretét és a memória tartalmát egy adatfolyamból. Olvasási kivétel esetén `False` értéket ad vissza.|
|`function SaveState(AStream: TStream): Boolean;`                      |Vi   |Elmenti az engedélyezési állapotot, a memóriamódot, a címtartomány méretét és a memória tartalmát.                                                          |
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`|Vi   |Az aktuális adatfolyam-pozíciótól kezdve `ACount` bájtot tölt a memóriába, ha a memória engedélyezett, és a memória- valamint az adatfolyamhatárok érvényesek.        |
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`  |Vi   |Az engedélyezett memória `ACount` bájtját az aktuális adatfolyam-pozícióra írja, ha a memóriatartomány érvényes.                         |

### Nyilvános tulajdonságok

|name              |type              |access    |description                          |
|------------------|------------------|----------|-------------------------------------|
|`AddressRangeSize`|`DWord`           |read/write|A beállított memóriacímtér mérete.|
|`BaseAddress`     |`DWord`           |read/write|Globális kezdőcím.                |
|`Description`     |`PChar`           |read      |A modul rövid leírása.            |
|`Enabled`         |`Boolean`         |read/write|Engedélyezi vagy letiltja a memóriaelérést.   |
|`MemoryMode`      |`TMemoryMode`     |read/write|Kiválasztja a RAM vagy ROM működési módot.        |
|`ModName`         |`PChar`           |read      |Modulnév.                         |
|`Version`         |`TSemanticVersion`|read      |Modulverzió.                      |
