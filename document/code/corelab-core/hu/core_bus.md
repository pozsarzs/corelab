# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## Buszinterfészek és típusok a core_bus modulból

A `core_bus` modul a CoreLAB keretrendszerben a CPU-k, a memóriák és az I/O-
eszközök összekapcsolásához használt busztípusokat és interfészeket deklarálja.
Két buszinterfészt határoz meg: az `IStandardBus` interfészt a szabványos
memória- és I/O-port-eléréshez, valamint az `IMCS4Bus` interfészt az Intel
MCS-4 család RAM- és ROM-eszközeihez.

### Rekordtípusok

|név         |mezők                   |leírás                                     |
|------------|------------------------|-------------------------------------------|
|`TBusLogRec`|`Operation: string[31]` |A busznaplózó által rögzített művelet neve.|
|            |`Device: string[31]`    |A műveletben részt vevő eszköz.            |
|            |`Address: string[31]`   |A művelet során használt cím.              |
|            |`RelAddress: string[31]`|A művelet során használt relatív cím.      |
|            |`Data: string[31]`      |A művelethez tartozó adat.                 |
|            |`Status: string[31]`    |A művelethez tartozó állapotinformáció.    |

A `TBusLogRec` a forráskód megjegyzése szerint a `BusLogger` által használt,
utolsó buszműveletet tároló rekord.

### Busztípus

A `TBusType` a rendszersín típusát azonosítja:

|érték       |leírás                 |
|------------|-----------------------|
|`btStandard`|Szabványos rendszersín.|
|`btMCS4`    |Intel MCS-4 busz.      |

### TBusTypeHelper

A `TBusTypeHelper` típussegéd a `TBusType` felsoroláshoz ad szöveges
konverziós metódusokat.

|név                                                  |leírás                                                                                                                                                                                                    |
|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`function ToString: string;`                         |Az aktuális felsorolási értéket szöveges alakra alakítja a `WriteStr` segítségével.                                                                                                                       |
|`function FromString(const Value: string): TBusType;`|A megadott szöveget `TBusType` értékké alakítja a `GetEnumValue` és a `TypeInfo(TBusType)` használatával. Példánymetódusként van deklarálva; a megvalósítás a konverzióhoz a `Value` paramétert használja.|

### IStandardBus interfész

Az `IStandardBus` a szabványos busz bájtszélességű memória- és I/O-port-elérési
műveleteit határozza meg.

|név                                                    |leírás                                       |
|-------------------------------------------------------|---------------------------------------------|
|`function ReadMemory(AAddress: DWord): Byte;`          |Egy bájtot olvas a megadott memóriacímről.   |
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`|Egy bájtot ír a megadott memóriacímre.       |
|`function ReadPort(APort: DWord): Byte;`               |Egy bájtot olvas a megadott I/O-port címéről.|
|`procedure WritePort(APort: DWord; AValue: Byte);`     |Egy bájtot ír a megadott I/O-port címére.    |

Interfész-GUID:

`{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}`

### IMCS4Bus interfész

Az `IMCS4Bus` az Intel MCS-4 család memóriáihoz és I/O-eszközeihez szükséges
műveleteket határozza meg.

|név                                                   |leírás                                                        |
|------------------------------------------------------|--------------------------------------------------------------|
|`procedure SendSRC(AAddress: Byte);`                  |Elküldi a közös SRC címzési/vezérlőértéket.                   |
|`function ReadRAM: Byte;`                             |Adatot olvas a kiválasztott RAM-helyről.                      |
|`procedure WriteRAM(AData: Byte);`                    |Adatot ír a kiválasztott RAM-helyre.                          |
|`function ReadRAMStatus(AIndex: Byte): Byte;`         |Kiolvassa az `AIndex` által kiválasztott RAM-státuszkaraktert.|
|`procedure WriteRAMStatus(AIndex: Byte; AData: Byte);`|Beírja az `AIndex` által kiválasztott RAM-státuszkaraktert.   |
|`procedure WriteRAMIOPort(AData: Byte);`              |Adatot ír a RAM-eszköz I/O-portjára.                          |
|`function ReadROM(AAddress: Word): Byte;`             |Adatot olvas a megadott ROM-címről.                           |
|`function ReadROMIOPort: Byte;`                       |Adatot olvas a ROM-eszköz I/O-portjáról.                      |
|`procedure WriteROMIOPort(AData: Byte);`              |Adatot ír a ROM-eszköz I/O-portjára.                          |

Interfész-GUID:

`{923A5391-77FD-41FB-B935-046D62F45C18}`

### A modul tartalma és hatóköre

A `core_bus` modul a buszhoz kapcsolódó rekordot, felsorolást, típussegédet és
interfészeket deklarálja. Konkrét buszosztályt nem tartalmaz, és a memória-,
illetve I/O-műveleteket sem valósítja meg. Az `IStandardBus` és az `IMCS4Bus`
interfészek megvalósítását a keretrendszer más eszköz- vagy buszosztályai
biztosítják.
