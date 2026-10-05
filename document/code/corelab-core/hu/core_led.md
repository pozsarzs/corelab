# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TLED a core_led modulból

A `TLED` absztrakt alaposztály grafikus LED-megvalósításokhoz. Tárolja
a LED állapotát, színkészletét, háttérszínét és egy belső bitképpuffert.
A leszármazott osztályok valósítják meg a LED pufferbe rajzolását és a
célvászonra történő megjelenítését.

### Kapcsolódó típusok

|név          |típus      |leírás                                                                |
|-------------|-----------|----------------------------------------------------------------------|
|`TColorGroup`|enumeration|Retró LED-színcsoportok: `clRetroGreen`, `clRetroRed`, `clRetroYellow`|
|`TLEDColors` |record     |A fényudvar, valamint az aktív és inaktív LED színeit tartalmazza     |

### `TLEDColors` rekord

|mező      |típus   |leírás              |
|----------|--------|--------------------|
|`Glow`    |`TColor`|Fényudvar színe     |
|`OnColor` |`TColor`|Bekapcsolt LED színe|
|`OffColor`|`TColor`|Kikapcsolt LED színe|

### `RETRO_COLORS`

A `RETRO_COLORS` előre meghatározott `TLEDColors` értékeket biztosít a `TColorGroup` három eleméhez.

|csoport        |Glow       |OnColor    |OffColor   |
|---------------|-----------|-----------|-----------|
|`clRetroGreen` |`$0088FF88`|`$0000D000`|`$00156515`|
|`clRetroRed`   |`$008888FF`|`$000000D0`|`$00000075`|
|`clRetroYellow`|`$0088FFFF`|`$0000D0D0`|`$00146666`|

### Védett mezők

|név           |típus       |leírás                      |
|--------------|------------|----------------------------|
|`FModname`    |`PChar`     |Module név                  |
|`FDescription`|`PChar`     |Rövid leírás                |
|`FEnabled`    |`Boolean`   |A megjelenítés engedélyezése|
|`FBuffer`     |`TBitmap`   |Belső rajzpuffer            |
|`FBGColor`    |`TColor`    |A LED körüli háttérszín     |
|`FColor`      |`TLEDColors`|Aktuális LED-színkészlet    |
|`FIsOn`       |`Boolean`   |A LED aktuális állapota     |

### Nyilvános metódusok

|név                                                                            |jelző|leírás                                                                                 |
|-------------------------------------------------------------------------------|-----|---------------------------------------------------------------------------------------|
|`constructor Create;`                                                          |Vi   |Létrehozza a belső bitképpuffert                                                       |
|`destructor Destroy;`                                                          |Vi   |Felszabadítja a belső bitképpuffert                                                    |
|`procedure Reset;`                                                             |Vi   |Kikapcsolja a LED-et, majd újrarajzolja                                                |
|`procedure DrawToBuffer(AIsOn: Boolean; AColor: TLEDColors; ABGColor: TColor);`|Ab,Vi|A LED-et a belső pufferbe rajzolja; a megvalósítást egy leszármazott osztály biztosítja|
|`procedure RenderTo(ATargetCanvas: TCanvas; Ax, Ay: Integer);`                 |Ab,Vi|Megjeleníti a LED-et a célvásznon; a megvalósítást egy leszármazott osztály biztosítja |
|`procedure SetBGColor(ABGColor: TColor);`                                      |Vi   |Beállítja a háttérszínt, majd újrarajzol                                               |
|`procedure SetColor(AColor: TLEDColors);`                                      |Vi   |Beállítja a LED színkészletét, majd újrarajzol                                         |
|`procedure SetOn(AStatus: Boolean);`                                           |Vi   |Beállítja a LED állapotát, majd újrarajzol                                             |

### Nyilvános tulajdonságok

|név          |típus       |elérés|leírás                                                    |
|-------------|------------|------|----------------------------------------------------------|
|`Modname `   |`PChar`     |Re    |Module név                                                |
|`Description`|`PChar`     |Re    |Short leírás                                              |
|`Enabled`    |`Boolean`   |Re/Wr |A megjelenítés engedélyezése                              |
|`Color`      |`TLEDColors`|Re/Wr |A LED aktuális színei; íráskor a `SetColor` hívódik meg   |
|`BGColor`    |`TColor`    |Re/Wr |Az aktuális háttérszín; íráskor a `SetBGColor` hívódik meg|
|`IsOn`       |`Boolean`   |Re/Wr |A LED aktuális állapota; íráskor a `SetOn` hívódik meg    |
