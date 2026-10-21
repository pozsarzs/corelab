# CoreLAB - Súgó

## 9. Függelék

### 9.1 Fájlformátumok

| Kiterjesztés / Minta | Cél |
|---|---|
| `*.bin` | Általános bináris fájl. |
| `*.clprj` | CoreLAB projektfájl. |
| `*.clpst` | CoreLAB bővítmény (plugin) állapotfájl. |
| `*.clsce` | CoreLAB scriptembly (szkript) fájl. |
| `*.clsht` | CoreLAB pillanatkép fájl. |
| `*.hex` | Intel hexa fájl. |
| `*.log` | Általános naplófájl. |

### 9.2 Gyorsbillentyűk

| Gyorsbillentyű | Leírás |
|:-:|---|
| Ctrl-1 | Váltás interaktív módba |
| Ctrl-2 | Váltás szkript módba |
| Ctrl-N | Új projekt |
| Ctrl-O | Projekt betöltése... |
| Ctrl-S | Projekt mentése |
| Ctrl-D | Munkakönyvtár megváltoztatása |
| Ctrl-P | Beállítások... |
| F11 | Modulfelfedező megjelenítése... |
| Ctrl-B | Töréspontkezelő megjelenítése... |
| Ctrl-B | BusLogger megjelenítése... |
| Ctrl-R | RunLogger megjelenítése... |
| Ctrl-I | IntLogger megjelenítése... |
| Shift-F4 | Szkriptszerkesztő megjelenítése... |
| Shift-F12 | Szkriptkonzol megjelenítése... |
| F9 | Futtatás |
| F8 | Léptetés |
| F10 | Leállítás |
| F2 | Pillanatkép készítése |
| F3 | Pillanatkép visszaállítása... |
| Ctrl-Shift-N | Új szkript |
| Ctrl-Shift-O | Szkript betöltése... |
| Ctrl-Shift-S | Szkript mentése |
| Shift-F9 | Szkript futtatása |
| Shift-F8 | Szkript léptetése |
| Shift-F10 | Szkript leállítása |
| F1 | Súgó |

*Megjegyzés: A menüparancsok gyorsan elérhetők a szabványos `Alt` billentyűkombinációkkal is (pl. Alt-F a Fájl menühöz). A további gyorsbillentyűk az operációs rendszertől függhetnek.*

### 9.3 Szójegyzék

- **CoreLAB:** Moduláris processzor-szimulációs keretrendszer, amelyet klasszikus 8 bites mikroprocesszorok és mikrokontrollerek funkcionális szimulációjára terveztek.
- **Modul/Bővítmény (Plugin):** Dinamikusan betölthető szoftverkomponens, amely egy virtuális CPU-t, memóriablokkot vagy I/O eszközt (pl. virtuális LED-mátrixot, kapcsolómátrixot) képvisel.
- **Scriptembly:** A CoreLAB által használt egyedi szkriptnyelv (`.clsce` fájlok) a tesztelés automatizálására, topológiák felépítésére és a regiszterek parancssori felületen keresztüli manipulálására.
- **Rendszerbusz (SysBus):** Virtuális kommunikációs busz, amely összeköti a példányosított processzor-, memória- és I/O modulokat, lehetővé téve az adatcserét.
- **Pillanatkép (Snapshot):** A szimuláció elmentett végrehajtási állapota (`.clsht` fájl), amely később visszaállítható.
- **Module Explorer:** Beépített grafikus eszköz az aktív modulpéldányok hierarchikus listájának kezelésére és megtekintésére.

### 9.4 Külső szerkesztők és szintaxiskiemelés

Bár a CoreLAB tartalmaz egy beépített SzkriptSzerkesztőt, lehet, hogy a `.clsce` (Scriptembly) fájlokat inkább a kedvenc külső szövegszerkesztődben szeretnéd megírni. Az olvashatóság javítása érdekében a CoreLAB csomag szintaxiskiemelő definíciós fájlokat biztosít számos népszerű szerkesztőhöz.
A saját szerkesztődhöz tartozó szintaxiskiemelő fájl telepítéséhez kövesd az alábbi utasításokat:

| Szerkesztő | Fájl | Telepítési útvonal / Módszer |
| --- | --- | --- |
| **GTKSourceView*** | `corelab.lang` | Másold a `~/.local/share/gtksourceview-?/language-specs/` mappába |
| **MCEdit** | `Syntax` / `corelab.syntax` | Szúrd be a `Syntax` tartalmát a `~/.local/share/mc/Syntax` tetejére, majd másold a `corelab.syntax` fájlt a `~/.local/share/mc/Syntax/` mappába |
| **Micro** | `corelab.yaml` | Másold a `~/.config/micro/syntax/` mappába |
| **Nano** | `corelab.nanorc` | Másold a `/usr/share/nano/` mappába |
| **Notepad++** | `corelab.xml` | Másold a `%USERPROFILE%\AppData\Roaming\Notepad++\userDefineLangs\` mappába |
| **(Neo)Vim** | `corelab.vim` / `scripts.vim` | Másold a `corelab.vim` fájlt a `~/.config/vim/syntax/` mappába, és szúrd be a `scripts.vim` tartalmát a `~/.config/vim/scripts.vim` fájlba |
| **Visual Studio Code** | `corelab-script` kiterjesztés | Másold a könyvtárat a `~/.vscode/extensions/` mappába, VAGY telepítsd a `.vsix` fájlt az alkalmazásból |

**Megjegyzések:**

* ***GTKSourceView:** A GtkSourceView-t használó alkalmazások közé tartozik a Builder, a Geany, a Gedit, a Mousepad, a Pluma és a Scribes. Vedd figyelembe, hogy a pontos célkönyvtár az adott alkalmazástól és operációs rendszertől függően változhat.
* **VSCode Marketplace:** A Visual Studio Code kiterjesztés közvetlenül a Marketplace-ről is telepíthető a következő URL-címen: [CoreLAB Script Extension](https://marketplace.visualstudio.com/items?itemName=pozsarzs.corelab-script)

### 9.5 Verziótörténet

- **v0.1.0:** Első fejlesztői tesztkiadás. Funkcionális processzor-szimulátor keretrendszer szkriptmotorral, bővítménytámogatással és alapvető diagnosztikai eszközökkel.
