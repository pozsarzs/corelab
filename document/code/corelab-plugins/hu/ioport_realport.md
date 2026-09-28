# CoreLAB

**Moduláris processzorszimulációs keretrendszer**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TREALPort a TIOPort osztályból, a ioport_realport modul

Átirányítja a hozzáférést egy valódi I/O-portra.

### I/O-működés

|port |leírás                                                          |
|-----|----------------------------------------------------------------|
|APort|A megfelelő valódi hardveres I/O-portról olvas, illetve arra ír.|

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

|név       |típus  |leírás                                                               |alapérték|
|----------|-------|---------------------------------------------------------------------|---------|
|`InpOut32`|THandle|Eszközspecifikus állapot vagy grafikus felhasználói felületi objektum|         |
|`Inp32`   |TInp32 |Eszközspecifikus állapot vagy grafikus felhasználói felületi objektum|         |
|`Out32`   |TOut32 |Eszközspecifikus állapot vagy grafikus felhasználói felületi objektum|         |

### Privát metódusok

|név                                            |jelzők|leírás                                                                   |
|-----------------------------------------------|------|-------------------------------------------------------------------------|
|`function LoadIODLL(ALibDir: string): Boolean;`|      |Betölti a platformfüggő, valódi I/O-hozzáférést biztosító könyvtárat.    |
|`function UnLoadIODLL: Boolean;`               |      |Eltávolítja a platformfüggő, valódi I/O-hozzáférést biztosító könyvtárat.|

### Védett metódusok

|név                                                                     |jelzők|leírás                                          |
|------------------------------------------------------------------------|------|------------------------------------------------|
|`function ReadByteFromIOPort(AAddress: Word; var AData: Byte): Boolean;`|      |Egy bájtot olvas a valódi hardveres I/O-portról.|
|`function WriteByteToIOPort(AAddress: Word; AData: Byte): Boolean;`     |      |Egy bájtot ír a valódi hardveres I/O-portra.    |

### Nyilvános metódusok

|név                                                        |jelzők|leírás                                                       |
|-----------------------------------------------------------|------|-------------------------------------------------------------|
|`constructor Create; override;`                            |Or    |Inicializálja az objektumot és az eszközspecifikus állapotát.|
|`destructor Destroy; override;`                            |Or    |Felszabadítja az objektumot és a lefoglalt erőforrásait.     |
|`procedure Reset; override;`                               |Or    |Alaphelyzetbe állítja az eszköz állapotát.                   |
|`function ReadPort(APort: Word): Byte; override;`          |Or    |Kiolvassa a kiválasztott virtuális I/O-port értékét.         |
|`procedure WritePort(APort: Word; AValue: Byte); override;`|Or    |Kiírja a kiválasztott virtuális I/O-port értékét.            |

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
