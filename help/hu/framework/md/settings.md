# CoreLAB - Súgó

## 7. Beállítások

A Beállítások párbeszédpanel lehetővé teszi az alkalmazás vizuális megjelenésének testreszabását. A program automatikusan menti az összes ablak méretét és pozícióját, valamint a belső naplózók (loggers) és nézegetők (viewers) oszlopszélességeit. Ezeket a konfigurációkat egy INI fájl tárolja a felhasználói profil könyvtárában.

### 7.1 Konfigurálható színek

Saját igényei szerint módosíthatja több belső modul háttér- és betűszínét:

- **SysConsole:** Általános háttér- és betűszínek.
- **ScriptConsole:** Általános háttér- és betűszínek.
- **ScriptEditor:** Háttér, betűtípus és a sorszámozás sávjának betűszínei. Emellett be- és kikapcsolható a sorszámok és a szintaxiskiemelés láthatósága.
- **HexViewer:** A cím (address), az adat (data), a sorkiválasztó (line selector) és a váltakozó (páros/páratlan) sorok hátterének színei.
- **RunLogger:** Az utasításszám, cím, opkód (opcode), mnemonik, ciklusok, összes ciklus, sorkiválasztó és a váltakozó sorok hátterének színei.
- **BusLogger:** A művelet, eszköz, abszolút cím, relatív cím, adat, állapot, sorkiválasztó és a váltakozó sorok hátterének színei.
- **IntLogger:** A küldő, megszakításvektor, állapot, jelzők (flags), sorkiválasztó és a váltakozó sorok hátterének színei.

Ezen színbeállítások módosításai azonnal érvénybe lépnek, amint a Beállítások párbeszédpanelt az OK gombbal bezárja.

### 7.2 Automatikusan mentett tulajdonságok

Az alkalmazás kilépéskor automatikusan megjegyzi a munkaterület elrendezését és állapotát, így nem kell minden egyes indításkor manuálisan elrendezni az ablakokat. A következő tulajdonságok kerülnek mentésre:

- **Főablak (Main Window):** Pozíció (felső, bal), méret (szélesség, magasság) és az elválasztó (splitter) pozíciója.
- **Belső ablakok:** A BreakPoint Manager, HexViewer, IntLogger, Module Explorer, Module Properties, RegViewer, RunLogger, ScriptConsole, ScriptEditor és a SysConsole pozíciója és mérete.
- **Táblázatoszlopok:** Az egyes oszlopok szélessége a BusLogger, IntLogger, Module Explorer, Module Properties, RegViewer és RunLogger modulokban.
- **Láthatóság:** A Module Explorer ablak nyitott/zárt állapota.

### 7.3 Konfigurációs fájl helye

Az alkalmazás a beállításokat egy `corelab.ini` fájlban tárolja. Ennek helye az operációs rendszertől függ:

- **Windows:** `<FelhasználóiKönyvtár>\Appdata\Local\corelab\corelab.ini`
- **Linux / FreeBSD:** `<FelhasználóiKönyvtár>/.config/corelab/corelab.ini`

Ha a konfigurációs fájl hiányzik vagy nem tölthető be, az alkalmazás az alapértelmezett értékeket használja.
