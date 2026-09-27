# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TGIOPort a core_gioport modulból

A `TGIOPort` a `TIOPort` osztályból származó absztrakt grafikus I/O-port osztály. 
Lazarus `TForm` alapú panelt ad hozzá, és biztosítja a panel élettartamának,
láthatóságának, feliratának, pozíciójának, méretének és állapotmentésének kezelését.

A leszármazott osztályoknak meg kell valósítaniuk a `CreatePanel` metódust.

### Privát mezők

|name           |type    |description                           |
|---------------|--------|--------------------------------------|
|`SPanelCaption`|`String`|A panel feliratának belső tárolója|

### Védett mezők

|name           |type     |description         |initial value|
|---------------|---------|--------------------|-------------|
|`FPanelForm`   |`TForm`  |Grafikus panelűrlap|`nil`        |
|`FPanelCaption`|`PChar`  |Panel felirata       |`MyIO`       |
|`FPanelHeight` |`Integer`|Panel magassága        |`0`          |
|`FPanelLeft`   |`Integer`|Panel bal oldali pozíciója |`0`          |
|`FPanelTop`    |`Integer`|Panel felső pozíciója  |`0`          |
|`FPanelWidth`  |`Integer`|Panel szélessége         |`0`          |

### Nyilvános metódusok

|name                                                      |flags|description                                                        |
|----------------------------------------------------------|-----|-------------------------------------------------------------------|
|`constructor Create;`                                     |Or   |Inicializálja a panel feliratát, pozícióját és méretét                       |
|`destructor Destroy;`                                     |     |Felszabadítja a panelt, és megsemmisíti az objektumot                              |
|`procedure CreatePanel;`                                  |Ab,Vi|Létrehozza a megvalósításspecifikus grafikus panelt                       |
|`procedure FreePanel;`                                    |Vi   |Felszabadítja a panel űrlapját, ha létezik                                   |
|`procedure ShowPanel;`                                    |Vi   |Megjeleníti a panelt, ha létezik                                        |
|`procedure HidePanel;`                                    |Vi   |Elrejti a panelt, ha létezik                                        |
|`procedure RenamePanel(ACaption: PChar);`                 |Vi   |Módosítja a tárolt feliratot és az űrlap feliratát                     |
|`function MovePanel(ALeft, ATop: Integer): Boolean;`      |Vi   |Beállítja a panel pozícióját, ha mindkét koordináta nem negatív          |
|`function ResizePanel(AWidth, AHeight: Integer): Boolean;`|Vi   |Beállítja a panel méretét, ha mindkét méret nem negatív               |
|`function LoadState(AStream: TStream): Boolean;`          |Or   |Betölti az örökölt I/O-portállapotot, valamint a panel feliratát, méretét és pozícióját|
|`function SaveState(AStream: TStream): Boolean;`          |Or   |Elmenti az örökölt I/O-portállapotot, valamint a panel feliratát, méretét és pozícióját|

### Nyilvános tulajdonságok

|name          |type     |access|description                |
|--------------|---------|------|---------------------------|
|`PanelCaption`|`PChar`  |Re    |A panel aktuális felirata      |
|`PanelHeight` |`Integer`|Re    |A panel aktuális magassága       |
|`PanelLeft`   |`Integer`|Re    |A panel aktuális bal oldali pozíciója|
|`PanelTop`    |`Integer`|Re    |A panel aktuális felső pozíciója |
|`PanelWidth`  |`Integer`|Re    |A panel aktuális szélessége        |
