# CoreLAB - Súgó

## 1. Bevezetés

A CoreLAB egy moduláris processzor-szimulációs keretrendszer. Átfogó grafikus környezetet biztosít számítógép-architektúrák konfigurálásához, teszteléséhez és szimulálásához dinamikusan betölthető bővítmények (pluginok) segítségével. A felhasználók különféle processzor-, memória- és I/O port modulokat tölthetnek be, csatlakoztathatják őket egy szimulált rendszerbuszhoz, és vezérelhetik a teljes végrehajtást. A keretrendszer lehetővé teszi a hardverkonfiguráció projektként történő mentését, és beépített szkriptmotorral rendelkezik az automatizált teszteléshez és működtetéshez.

### 1.1 Fő jellemzők

- Moduláris felépítés dinamikusan betölthető processzor-, memória- és I/O port bővítményekkel.
- Két elsődleges működési mód: Interaktív mód a kézi vezérléshez és Szkript mód az automatizált végrehajtáshoz.
- Projektkezelés a teljes szimulációs munkakörnyezetek létrehozásához, betöltéséhez és mentéséhez (`.clprj`).
- Fejlett hibakereső és megfigyelő eszközök: Module Explorer, Breakpoint Manager, RegViewer és HexViewer.
- Integrált naplózó ablakok: BusLogger, RunLogger és IntLogger.
- Beépített szkriptszerkesztő (Script Editor) és szkriptkonzol (Script Console) az egyedi `.clsce` szkriptekhez.
- Teljes szimulációvezérlés: futtatás, léptetés, leállítás, modulok visszaállítása (reset), és nem maszkolható megszakítások (NMI) kiváltása.
- Memóriatartalom betöltésének és mentésének lehetősége bináris (`.bin`) vagy Intel HEX (`.hex`) formátumokban.
- Mozgatható, átméretezhető és átnevezhető interaktív panelek a támogatott I/O eszközökhöz.

## 2. Rendszerkövetelmények

Az alkalmazás FreeBSD, Linux és Windows operációs rendszereken használható.
