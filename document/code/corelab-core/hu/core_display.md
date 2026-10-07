# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TDisplay a core_display modulból

A `TDisplay` absztrakt alaposztály grafikus kijelzők megvalósításához.
A megjelenített BCD-értéket, a hét szegmens adatait, a két tizedespont állapotát
és az üres kijelző állapotát tárolja. A tényleges rajzolást és megjelenítést a leszármazott
osztályok valósítják meg.

### `TDisplayedData` rekord

|mező      |típus    |leírás                                        |
|----------|---------|----------------------------------------------|
|`Blank`   |`Boolean`|Üres kijelző állapota                         |
|`LeftDot` |`Boolean`|Bal oldali tizedespont állapota               |
|`RightDot`|`Boolean`|Jobb oldali tizedespont állapota              |
|`Segments`|`Byte`   |Hétszegmenses adat; a 0-6. bitek használatosak|
|`Value`   |`Byte`   |BCD-érték; a 0-3. bitek használatosak         |

### Védett mezők

|név             |típus           |leírás                      |
|----------------|----------------|----------------------------|
|`FModname`      |`PChar`         |Modulnév                    |
|`FDescription`  |`PChar`         |Rövid leírás                |
|`FEnabled`      |`Boolean`       |A megjelenítés engedélyezése|
|`FBuffer`       |`TBitmap`       |Belső rajzpuffer            |
|`FDisplayedData`|`TDisplayedData`|Aktuális kijelzőadat        |

### Védett konstansok

|név             |típus   |érték      |leírás                             |
|----------------|--------|-----------|-----------------------------------|
|`RETRO_RED_GLOW`|`TColor`|`$003333FF`|Retró vörös LED fényudvarának színe|
|`RETRO_RED_ON`  |`TColor`|`$000000FF`|Retró vörös aktív színe            |
|`RETRO_RED_OFF` |`TColor`|`$00000040`|Retró vörös inaktív színe          |
|`RETRO_RED_BG`  |`TColor`|`$00000015`|Retró vörös kijelző háttérszíne    |

### Nyilvános metódusok

|név                                                           |jelző|leírás                                                                                                         |
|--------------------------------------------------------------|-----|---------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                         |Vi   |Létrehozza a kijelzőt és a belső bitképpufferét                                                                |
|`destructor Destroy;`                                         |Vi   |Felszabadítja a belső bitképpuffert                                                                            |
|`procedure Reset;`                                            |Vi   |Törli az üres kijelző és a tizedespontok állapotát, valamint alaphelyzetbe állítja a szegmens- és értékadatokat|
|`procedure DrawToBuffer(AInputData: TDisplayedData);`         |Ab,Vi|A megadott kijelzőadatokat a belső pufferbe rajzolja; a megvalósítást egy leszármazott osztály biztosítja      |
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`|Ab,Vi|Megjeleníti a kijelzőt a célvásznon; a megvalósítást egy leszármazott osztály biztosítja                       |
|`procedure SetBlank(AStatus: Boolean);`                       |Vi   |Beállítja az üres kijelző állapotát, majd újrarajzol                                                           |
|`procedure SetLeftDot(AStatus: Boolean);`                     |Vi   |Beállítja a bal oldali tizedespont állapotát, majd újrarajzol                                                  |
|`procedure SetRightDot(AStatus: Boolean);`                    |Vi   |Beállítja a jobb oldali tizedespont állapotát, majd újrarajzol                                                 |
|`procedure SetSegments(AValue: Byte);`                        |Vi   |Beállítja a hétszegmenses adatot, majd újrarajzol                                                              |
|`procedure SetValue(AValue: Byte);`                           |Vi   |Beállítja a BCD-értéket az alsó négy bit felhasználásával, majd újrarajzol                                     |

### Nyilvános tulajdonságok

|név          |típus    |elérés|leírás                      |
|-------------|---------|------|----------------------------|
|`Modname`    |`PChar`  |Re    |Modulnév                    |
|`Description`|`PChar`  |Re    |Rövid leírás                |
|`Enabled`    |`Boolean`|Re/Wr |A megjelenítés engedélyezése|
