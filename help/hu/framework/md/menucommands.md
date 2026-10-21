# CoreLAB - Súgó

## 5. Menüparancsok

A menüsor hozzáférést biztosít a projektek kezeléséhez, a modulok konfigurálásához és a szimuláció vezérléséhez szükséges összes funkcióhoz.

### 5.1 Fájl

- **Váltás interaktív módba:** Átkapcsolja az alkalmazást interaktív módba, lehetővé téve a modulok kézi kezelését és a szimuláció vezérlését.
- **Váltás szkript módba:** Átkapcsolja az alkalmazást szkript módba az automatizált végrehajtáshoz `.clsce` szkripteken keresztül.
- **Új projekt:** Létrehoz egy új, üres szimulációs munkaterületet.
- **Projekt betöltése...:** Betölt egy meglévő CoreLAB projektfájlt (`.clprj`).
- **Projekt mentése:** Menti az aktuális projektkonfigurációt.
- **Projekt mentése másként...:** Az aktuális projektkonfigurációt egy újonnan megadott fájlba menti.
- **Munkakönyvtár megváltoztatása:** Beállítja az alapértelmezett munkakönyvtárat a fájlműveletekhez.
- **Beállítások...:** Megnyitja az általános beállítások párbeszédpanelt a felhasználói felület színeinek és egyéb elrendezési beállításainak konfigurálásához.
- **Alkalmazás újraindítása:** Újraindítja a CoreLAB alkalmazást.
- **Kilépés:** Bezárja az alkalmazást, és visszatér az operációs rendszerhez.

### 5.2 Nézet

- **Module Explorer megjelenítése...:** Megnyit egy fa-nézetű ablakot az összes példányosított CPU, memória és I/O modul kezeléséhez.
- **Breakpoint Manager megjelenítése...:** Megnyit egy ablakot a végrehajtási töréspontok kezeléséhez.
- **BusLogger megjelenítése...:** Megnyitja a BusLogger-t a rendszerbuszon történő olvasási és írásási műveletek figyeléséhez.
- **RunLogger megjelenítése...:** Megnyitja a RunLogger-t a CPU utasítások valós idejű végrehajtásának figyeléséhez.
- **IntLogger megjelenítése...:** Megnyitja az IntLogger-t a hardveres megszakításkérések megtekintéséhez.
- **RegViewer megjelenítése...:** Megnyitja a RegViewer-t egy adott processzor belső regisztereinek és jelzőinek (flag) vizsgálatához.
- **HexViewer megjelenítése...:** Megnyitja a HexViewer-t egy adott memóriamodul adattartalmának vizsgálatához.
- **Szkriptszerkesztő megjelenítése...:** Megnyitja a beépített szövegszerkesztőt az automatizálási szkriptek írásához és módosításához.
- **Szkriptkonzol megjelenítése...:** Megnyitja a konzolt, amely a szkriptparancsok által generált szöveges kimeneteket jeleníti meg.
- **I/O panel átnevezése...:** Lehetővé teszi egy kiválasztott I/O eszköz interaktív grafikus paneljének átnevezését.
- **I/O panel mozgatása/átméretezése...:** Lehetővé teszi egy I/O eszköz interaktív panelje pozíciójának és méretének módosítását.
- **I/O panel megjelenítése...:** Megjeleníti a kiválasztott I/O eszköz interaktív grafikus paneljét.

### 5.3 Processzor

- **Létrehozás...:** Példányosít és betölt egy új processzormodult az elérhető bővítmények közül.
- **Megsemmisítés...:** Megsemmisíti és eltávolítja a kiválasztott processzormodult.
- **Visszaállítás...:** Visszaállítja a kiválasztott processzort a kezdeti hardveres állapotára.
- **Engedélyezés...:** Engedélyezi a kiválasztott processzormodult.
- **Letiltás...:** Letiltja a kiválasztott processzormodult.
- **Csatlakoztatás a buszhoz...:** Csatlakoztatja a processzormodult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról...:** Leválasztja a processzormodult a rendszerbuszról.
- **Tulajdonságok...:** Megnyitja a konfigurációs ablakot a kiválasztott processzor tulajdonságainak szerkesztéséhez.

### 5.4 Memória

- **Létrehozás...:** Példányosít és betölt egy új memóriamodult.
- **Megsemmisítés...:** Megsemmisíti és eltávolítja a kiválasztott memóriamodult.
- **Visszaállítás...:** Visszaállítja a kiválasztott memóriamodult, törölve az ideiglenes állapotait.
- **Engedélyezés...:** Engedélyezi a kiválasztott memóriamodult.
- **Letiltás...:** Letiltja a kiválasztott memóriamodult.
- **Csatlakoztatás a buszhoz...:** Csatlakoztatja a memóriamodult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról...:** Leválasztja a memóriamodult a rendszerbuszról.
- **Tulajdonságok...:** Megnyitja a konfigurációs ablakot a kiválasztott memória tulajdonságainak szerkesztéséhez.
- **Memóriatartalom betöltése...:** Bináris (`.bin`) vagy Intel HEX (`.hex`) adatokat tölt be a memóriamodulba.
- **Memóriatartalom mentése...:** A memóriamodul tartalmát `.bin` vagy `.hex` fájlba menti.
- **Vizsgálat/módosítás...:** Megnyit egy eszközt az egyes bájtok adott memóriacímeken történő manuális olvasásához vagy írásához.

### 5.5 I/O port

- **Létrehozás...:** Példányosít és betölt egy új I/O portot vagy eszközmodult.
- **Megsemmisítés...:** Megsemmisíti és eltávolítja a kiválasztott I/O modult.
- **Visszaállítás...:** Visszaállítja a kiválasztott I/O modult a kezdeti állapotára.
- **Engedélyezés...:** Engedélyezi a kiválasztott I/O modult.
- **Letiltás...:** Letiltja a kiválasztott I/O modult.
- **Csatlakoztatás a buszhoz...:** Csatlakoztatja az I/O modult a szimulált rendszerbuszhoz.
- **Leválasztás a buszról...:** Leválasztja az I/O modult a rendszerbuszról.
- **Tulajdonságok...:** Megnyitja a konfigurációs ablakot a kiválasztott I/O port vagy eszköz tulajdonságainak szerkesztéséhez.
- **Olvasás/Írás...:** Megnyit egy eszközt a konkrét I/O portról történő manuális olvasáshoz, vagy az oda történő adatíráshoz.

### 5.6 Műveletek

- **Futtatás:** Elindítja a hardverszimuláció folyamatos végrehajtását.
- **Léptetés:** Végrehajt egyetlen processzorutasítás-lépést a szimulációban.
- **Leállítás:** Leállítja a futó szimulációt.
- **NMI:** Egy nem maszkolható megszakítást (Non-Maskable Interrupt) vált ki a csatlakoztatott processzoron.
- **Minden csatlakoztatott modul visszaállítása:** Globális visszaállítási (reset) jelet küld a rendszerbuszhoz csatlakoztatott összes CPU-nak, memóriamodulnak és I/O portnak.
- **Pillanatkép készítése:** Menti a szimuláció aktuális végrehajtási állapotát.
- **Pillanatkép visszaállítása...:** Visszaállít egy korábban mentett szimulációs végrehajtási állapotot.

### 5.7 Szkript

- **Új szkript:** Létrehoz egy új, üres szkriptet.
- **Szkript betöltése...:** Betölt egy meglévő szkriptfájlt (`.clsce`).
- **Szkript mentése:** Menti az aktuális szkriptet.
- **Szkript mentése másként...:** Az aktuális szkriptet egy új fájlba menti.
- **Szkript futtatása:** Automatikusan végrehajtja a betöltött szkriptet.
- **Szkript léptetése:** Lépésenként hajtja végre a szkriptet, ami hasznos az automatizálási logika hibakereséséhez (debugging).
- **Szkript leállítása:** Leállítja az éppen futó szkript végrehajtását.

### 5.8 Súgó

- **Súgó:** Megnyitja a CoreLAB Súgó adatbázisát.
- **Névjegy:** Információkat jelenít meg a CoreLAB keretrendszerről, a verziójáról és a szerzői jogi (copyright) részletekről.
