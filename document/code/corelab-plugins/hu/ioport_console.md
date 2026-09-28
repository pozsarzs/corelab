# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TConsole a TGIOPort osztályból, a ioport_console modul

Minimalista karakteres I/O-konzol pufferelt bemenettel.

### I/O-működés

|port|leírás                                                                                                                                                                         |
|----|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|0   |Olvasáskor visszaadja és eltávolítja a vételi puffer legrégebbi karakterét; íráskor egy karaktert fűz a konzol megjelenített tartalmához. A többi port `FFh` értéket ad vissza.|

### Rövidítések

- _Ab_: jelentése: absztrakt,
- _Co_: jelentése: konstans,
- _Il_: jelentése: inline,
- _Ol_: jelentése: túlterhelés,
- _Or_: jelentése: felüldefiniálás,
- _Re_: jelentése: olvasás,
- _Ri_: jelentése: újradefiniálás,
- _St_: jelentése: statikus,
- _Vi_: jelentése: virtuális,
- _Wr_: jelentése: írás.

### Védett mezők

|név         |típus     |leírás                                                  |alapérték|
|------------|----------|--------------------------------------------------------|---------|
|`FConFace`  |TMemo     |Eszközspecifikus állapot vagy grafikus felületi objektum|nil      |
|`FRxBuffer` |string    |Eszközspecifikus állapot vagy grafikus felületi objektum|''       |
|`FStatusBar`|TStatusBar|Eszközspecifikus állapot vagy grafikus felületi objektum|nil      |
|`FTimer`    |TTimer    |Eszközspecifikus állapot vagy grafikus felületi objektum|nil      |

### Védett metódusok

|név                                                          |jelzők|leírás                                                                        |
|-------------------------------------------------------------|------|------------------------------------------------------------------------------|
|`procedure FConFaceKeyPress(Sender: TObject; var Key: char);`|      |Puffereli a konzolon beérkezett karaktert, és megszakítási kérést kezdeményez.|
|`procedure FTimerOnTime(Sender: TObject);`                   |      |Törli a konzol ideiglenes állapotjelzőit.                                     |
|`procedure UpdateGauge;`                                     |      |Frissíti a konzol vételi pufferének kihasználtságát jelző elemet.             |
|`procedure RequestInterrupt; override;`                      |Or    |Meghívja a beállított megszakítás-visszahívást.                               |

### Nyilvános metódusok

|név                                                        |jelzők|leírás                                                       |
|-----------------------------------------------------------|------|-------------------------------------------------------------|
|`constructor Create; override;`                            |Or    |Inicializálja az objektumot és az eszközspecifikus állapotát.|
|`destructor Destroy; override;`                            |Or    |Felszabadítja az objektumot és a lefoglalt erőforrásait.     |
|`procedure Reset; override;`                               |Or    |Alaphelyzetbe állítja az eszköz állapotát.                   |
|`function ReadPort(APort: Word): Byte; override;`          |Or    |Kiolvassa a kiválasztott virtuális I/O-port értékét.         |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or    |Kiírja a kiválasztott virtuális I/O-port értékét.            |
|`procedure CreatePanel; override;`                         |Or    |Létrehozza a grafikus felhasználói felület paneljét.         |

### Exportált függvények és eljárások

**Hívási konvenció:**  

- Windows alatt: `stdcall`,
- Unix-szerű operációs rendszereken: `cdecl`.

|név                                                                                     |exportált név       |leírás                                                       |
|----------------------------------------------------------------------------------------|--------------------|-------------------------------------------------------------|
|`function CreatePort: TIOPort;`                                                         |ioport_create       |Új eszközobjektumot hoz létre.                               |
|`procedure DestroyPort(APort: TIOPort);`                                                |ioport_destroy      |Megsemmisíti az eszközobjektumot.                            |
|`procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte);`|ioport_setinthandler|Beállítja a megszakítás-visszahívást és a megszakításvektort.|
|`function LoadState(APort: TIOPort; AStream: TStream): Boolean;`                        |ioport_loadstate    |Betölti az eszköz állapotát egy adatfolyamból.               |
|`function SaveState(APort: TIOPort; AStream: TStream): Boolean;`                        |ioport_savestate    |Elmenti az eszköz állapotát egy adatfolyamba.                |
|`procedure CreatePanel(APort: TIOPort);`                                                |ioport_createpanel  |Létrehozza a grafikus felhasználói felület paneljét.         |
|`procedure FreePanel(APort: TIOPort);`                                                  |ioport_freepanel    |Megsemmisíti a grafikus felhasználói felület paneljét.       |
|`procedure ShowPanel(APort: TIOPort);`                                                  |ioport_showpanel    |Megjeleníti a grafikus felhasználói felület paneljét.        |
|`procedure HidePanel(APort: TIOPort);`                                                  |ioport_hidepanel    |Elrejti a grafikus felhasználói felület paneljét.            |
|`procedure RenamePanel(APort: TIOPort; ACaption: PChar);`                               |ioport_renamepanel  |Módosítja a grafikus panel feliratát.                        |
|`function ResizePanel(APort: TIOPort; AWidth, AHeight: Integer): Boolean;`              |ioport_resizepanel  |Átméretezi a grafikus panelt.                                |
|`function MovePanel(APort: TIOPort; ALeft, ATop: Integer): Boolean;`                    |ioport_movepanel    |Áthelyezi a grafikus panelt.                                 |
