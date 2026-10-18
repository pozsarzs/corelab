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
- **Rendszerbusz (System Bus):** Virtuális kommunikációs busz, amely összeköti a példányosított processzor-, memória- és I/O modulokat, lehetővé téve az adatcserét.
- **Pillanatkép (Snapshot):** A szimuláció elmentett végrehajtási állapota (`.clsht` fájl), amely később visszaállítható.
- **Modulfelfedező (Module Explorer):** Beépített grafikus eszköz az aktív modulpéldányok hierarchikus listájának kezelésére és megtekintésére.

### 9.4 Verziótörténet

- **v0.1.0:** Első fejlesztői tesztkiadás. Funkcionális processzor-szimulátor keretrendszer szkriptmotorral, bővítménytámogatással és alapvető diagnosztikai eszközökkel.