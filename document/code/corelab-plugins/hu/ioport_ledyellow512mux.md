# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TLEDYellow512MUX a TGIOPort osztályból, a ioport_ledyellow512mux modul

Válaszd ki az oszlopot, majd írd ki a sor állapotát.

### I/O-működés

|port|leírás                                                                                                                  |
|----|------------------------------------------------------------------------------------------------------------------------|
|0   |A kiírt bájt minden bitje a kiválasztott oszlop egy-egy LED-jét vezérli; a `FDataInNegation` megfordíthatja a bemenetet.|
|1   |Kiválasztja a LED-oszlopot; az index 0 és az utolsó oszlop indexe közötti érték lehet.                                  |

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

### Privát mezők

|név     |típus                 |leírás                                                  |alapérték|
|--------|----------------------|--------------------------------------------------------|---------|
|`FValue`|array[0..MAXX] of Byte|Eszközspecifikus állapot vagy grafikus felületi objektum|0        |

### Védett mezők

|név        |típus                                |leírás                                                  |alapérték|
|-----------|-------------------------------------|--------------------------------------------------------|---------|
|`FPanel`   |TPanel                               |Eszközspecifikus állapot vagy grafikus felületi objektum|nil      |
|`FPaintBox`|TPaintBox                            |Eszközspecifikus állapot vagy grafikus felületi objektum|nil      |
|`FLED`     |array[0..MAXX, 0..MAXY] of TLEDSquare|Eszközspecifikus állapot vagy grafikus felületi objektum|         |
|`FSelLine` |Byte                                 |Eszközspecifikus állapot vagy grafikus felületi objektum|0        |

### Védett metódusok

|név                                        |jelzők|leírás                                      |
|-------------------------------------------|------|--------------------------------------------|
|`procedure PaintBoxPaint(Sender: TObject);`|      |Megrajzolja az eszköz ábrázolását a panelen.|

### Nyilvános metódusok

|név                                                        |jelzők|leírás                                                       |
|-----------------------------------------------------------|------|-------------------------------------------------------------|
|`constructor Create; override;`                            |Or    |Inicializálja az objektumot és az eszközspecifikus állapotát.|
|`destructor Destroy; override;`                            |Or    |Felszabadítja az objektumot és a lefoglalt erőforrásait.     |
|`procedure Reset; override;`                               |Or    |Alaphelyzetbe állítja az eszköz állapotát.                   |
|`function ReadPort(APort: Word): Byte; override;`          |Or    |Kiolvassa a kiválasztott virtuális I/O-port értékét.         |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or    |Kiírja a kiválasztott virtuális I/O-port értékét.            |
|`function LoadState(AStream: TStream): Boolean; override;` |Or    |Betölti az eszköz állapotát egy adatfolyamból.               |
|`function SaveState(AStream: TStream): Boolean; override;` |Or    |Elmenti az eszköz állapotát egy adatfolyamba.                |
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
