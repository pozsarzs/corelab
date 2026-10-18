# CoreLAB - Súgó

## 5. Menüparancsok

A menüsor hozzáférést biztosít a projektek kezeléséhez, a modulok konfigurálásához és a szimuláció vezérléséhez szükséges összes funkcióhoz.

### 5.1 Fájl (File)

- **Váltás interaktív módba (Switch to interactive mode):** Átkapcsolja az alkalmazást interaktív módba, lehetővé téve a modulok kézi kezelését és a szimuláció vezérlését.
- **Váltás szkript módba (Switch to script mode):** Átkapcsolja az alkalmazást szkript módba az automatizált végrehajtáshoz `.clsce` szkripteken keresztül.
- **Új projekt (New project):** Létrehoz egy új, üres szimulációs munkaterületet.
- **Projekt betöltése... (Load project...):** Betölt egy meglévő CoreLAB projektfájlt (`.clprj`).
- **Projekt mentése (Save project):** Menti az aktuális projektkonfigurációt.
- **Projekt mentése másként... (Save project as...):** Az aktuális projektkonfigurációt egy újonnan megadott fájlba menti.
- **Munkakönyvtár megváltoztatása (Change work directory):** Beállítja az alapértelmezett munkakönyvtárat a fájlműveletekhez.
- **Beállítások... (Settings...):** Megnyitja az általános beállítások párbeszédpanelt a felhasználói felület színeinek és egyéb elrendezési beállításainak konfigurálásához.
- **Alkalmazás újraindítása (Restart application):** Újraindítja a CoreLAB alkalmazást.
- **Kilépés (Exit):** Bezárja az alkalmazást, és visszatér az operációs rendszerhez.

### 5.2 Nézet (View)

- **Modulfelfedező megjelenítése... (Show Module Explorer...):** Megnyit egy fa-nézetű ablakot az összes példányosított CPU, memória és I/O modul kezeléséhez.
- **Töréspontkezelő megjelenítése... (Show Breakpoint Manager...):** Megnyit egy ablakot a végrehajtási töréspontok kezeléséhez.
- **BusLogger megjelenítése... (Show BusLogger...):** Megnyitja a BusLogger-t a rendszerbuszon történő olvasási és írásási műveletek figyeléséhez.
- **RunLogger megjelenítése... (Show RunLogger...):** Megnyitja a RunLogger-t a CPU utasítások valós idejű végrehajtásának figyeléséhez.
- **IntLogger megjelenítése... (Show IntLogger...):** Megnyitja az IntLogger-t a hardveres megszakításkérések megtekintéséhez.
- **RegViewer megjelenítése... (Show RegViewer...):** Megnyitja a RegViewer-t egy adott processzor belső regisztereinek és jelzőinek (flag) vizsgálatához.
- **HexViewer megjelenítése... (Show HexViewer...):** Megnyitja a HexViewer-t egy adott memóriamodul adattartalmának vizsgálatához.
- **Szkriptszerkesztő megjelenítése... (Show ScriptEditor...):** Megnyitja a beépített szövegszerkesztőt az automatizálási szkriptek írásához és módosításához.
- **Szkriptkonzol megjelenítése... (Show ScriptConsole...):** Megnyitja a konzolt, amely a szkriptparancsok által generált szöveges kimeneteket jeleníti meg.
- **I/O panel átnevezése... (Rename I/O panel...):** Lehetővé teszi egy kiválasztott I/O eszköz interaktív grafikus paneljének átnevezését.
- **I/O panel mozgatása/átméretezése... (Move/resize I/O panel...):** Lehetővé teszi egy I/O eszköz interaktív panelje pozíciójának és méretének módosítását.
- **I/O panel megjelenítése... (Show I/O panel...):** Megjeleníti a kiválasztott I/O eszköz interaktív grafikus paneljét.

### 5.3 Processzor (Processor)

- **Létrehozás... (Create...):** Példányosít és betölt egy új processzormodult az elérhető bővítmények közül.
- **Megsemmisítés... (Destroy...):** Megsemmisíti és eltávolítja a kiválasztott processzormodult.
- **Visszaállítás... (Reset...):** Visszaállítja a kiválasztott processzort a kezdeti hardveres állapotára.
- **Engedélyezés... (Enable...):** Engedélyezi a kiválasztott processzormodult.
- **Letiltás... (Disable...):** Letiltja a kiválasztott processzormodult.
- **Csatlakoztatás a buszhoz... (Attach to bus...):** Csatlakoztatja a processzormodult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról... (Detach from bus...):** Leválasztja a processzormodult a rendszerbuszról.
- **Tulajdonságok... (Properties...):** Megnyitja a konfigurációs ablakot a kiválasztott processzor tulajdonságainak szerkesztéséhez.

### 5.4 Memória (Memory)

- **Létrehozás... (Create...):** Példányosít és betölt egy új memóriamodult.
- **Megsemmisítés... (Destroy...):** Megsemmisíti és eltávolítja a kiválasztott memóriamodult.
- **Visszaállítás... (Reset...):** Visszaállítja a kiválasztott memóriamodult, törölve az ideiglenes állapotait.
- **Engedélyezés... (Enable...):** Engedélyezi a kiválasztott memóriamodult.
- **Letiltás... (Disable...):** Letiltja a kiválasztott memóriamodult.
- **Csatlakoztatás a buszhoz... (Attach to bus...):** Csatlakoztatja a memóriamodult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról... (Detach from bus...):** Leválasztja a memóriamodult a rendszerbuszról.
- **Tulajdonságok... (Properties...):** Megnyitja a konfigurációs ablakot a kiválasztott memória tulajdonságainak szerkesztéséhez.
- **Memóriatartalom betöltése... (Load memory content...):** Bináris (`.bin`) vagy Intel HEX (`.hex`) adatokat tölt be a memóriamodulba.
- **Memóriatartalom mentése... (Save memory content...):** A memóriamodul tartalmát `.bin` vagy `.hex` fájlba menti.
- **Vizsgálat/módosítás... (Examine/deposit...):** Megnyit egy eszközt az egyes bájtok adott memóriacímeken történő manuális olvasásához vagy írásához.

### 5.5 I/O port

- **Létrehozás... (Create...):** Példányosít és betölt egy új I/O portot vagy eszközmodult.
- **Megsemmisítés... (Destroy...):** Megsemmisíti és eltávolítja a kiválasztott I/O modult.
- **Visszaállítás... (Reset...):** Visszaállítja a kiválasztott I/O modult a kezdeti állapotára.
- **Engedélyezés... (Enable...):** Engedélyezi a kiválasztott I/O modult.
- **Letiltás... (Disable...):** Letiltja a kiválasztott I/O modult.
- **Csatlakoztatás a buszhoz... (Attach to bus...):** Csatlakoztatja az I/O modult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról... (Detach from bus...):** Leválasztja az I/O modult a rendszerbuszról.
- **Tulajdonságok... (Properties...):** Megnyitja a konfigurációs ablakot a kiválasztott I/O port vagy eszköz tulajdonságainak szerkesztéséhez.
- **Olvasás/Írás... (Read/Write...):** Megnyit egy eszközt a konkrét I/O portról történő manuális olvasáshoz, vagy az oda történő adatíráshoz.

### 5.6 Műveletek (Operation)

- **Futtatás (Run):** Elindítja a hardverszimuláció folyamatos végrehajtását.
- **Léptetés (Step):** Végrehajt egyetlen processzorutasítás-lépést a szimulációban.
- **Leállítás (Stop):** Leállítja a futó szimulációt.
- **NMI:** Egy nem maszkolható megszakítást (Non-Maskable Interrupt) vált ki a csatlakoztatott processzoron.
- **Minden csatlakoztatott modul visszaállítása (Reset all attached module):** Globális visszaállítási (reset) jelet küld a rendszerbuszhoz csatlakoztatott összes CPU-nak, memóriamodulnak és I/O portnak.
- **Pillanatkép készítése (Make snapshot):** Menti a szimuláció aktuális végrehajtási állapotát.
- **Pillanatkép visszaállítása... (Restore snapshot...):** Visszaállít egy korábban mentett szimulációs végrehajtási állapotot.

### 5.7 Szkript (Script)

- **Új szkript (New script):** Létrehoz egy új, üres szkriptet.
- **Szkript betöltése... (Load script...):** Betölt egy meglévő szkriptfájlt (`.clsce`).
- **Szkript mentése (Save script):** Menti az aktuális szkriptet.
- **Szkript mentése másként... (Save script as...):** Az aktuális szkriptet egy új fájlba menti.
- **Szkript futtatása (Run script):** Automatikusan végrehajtja a betöltött szkriptet.
- **Szkript léptetése (Step script):** Lépésenként hajtja végre a szkriptet, ami hasznos az automatizálási logika hibakereséséhez (debugging).
- **Szkript leállítása (Stop script):** Leállítja az éppen futó szkript végrehajtását.

### 5.8 Súgó (Help)

- **Súgó (Help):** Megnyitja a CoreLAB Súgó adatbázisát.
- **Névjegy (About):** Információkat jelenít meg a CoreLAB keretrendszerről, a verziójáról és a szerzői jogi (copyright) részletekről.
