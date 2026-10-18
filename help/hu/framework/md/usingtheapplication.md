# CoreLAB - Súgó

## 4. Az alkalmazás használata

Bár a CoreLAB letisztult és intuitív grafikus felülettel rendelkezik, az alapvető munkafolyamatok megértése elengedhetetlen az első szimulált környezet felépítéséhez és futtatásához.

### 4.1 Szimulációs munkaterület felépítése

A CoreLAB moduláris felépítésre épül. Egy számítógépes rendszer szimulálásához példányosítania kell a szükséges összetevőket, és csatlakoztatnia kell őket a rendszerbuszhoz.

1. **Processzor létrehozása:** Lépjen a **Processzor > Létrehozás... (Processor > Create...)** menüpontra, válasszon ki egy CPU bővítményt (pl. `cpu_8080`), adjon a példánynak egy egyedi nevet, majd kattintson az OK gombra.
2. **Memória létrehozása:** Lépjen a **Memória > Létrehozás... (Memory > Create...)** menüpontra, válasszon ki egy memória bővítményt (pl. `memory_standard`), nevezze el, és állítsa be a méretét, valamint az alapcímét a **Tulajdonságok... (Properties...)** parancs segítségével.
3. **I/O eszközök létrehozása:** Ha a szimuláció bemenetet/kimenetet igényel, lépjen az **I/O port > Létrehozás... (I/O port > Create...)** menüpontra, válassza ki a kívánt perifériát (pl. kapcsolók, LED-ek vagy kijelzők), és nevezze el.
4. **Csatlakoztatás a buszhoz:** A modulok nem fognak kommunikálni, amíg nincsenek a rendszerbuszhoz csatlakoztatva. Használja a **Csatlakoztatás a buszhoz... (Attach to bus...)** parancsot külön-külön a CPU, a memória és az I/O modulokhoz.

### 4.2 Kód és adatok betöltése

A processzor elindítása előtt be kell töltenie egy végrehajtható programot a memóriába.
1. Győződjön meg arról, hogy a memóriamodul csatlakoztatva van a buszhoz.
2. Lépjen a **Memória > Memóriatartalom betöltése... (Memory > Load memory content...)** menüpontra.
3. Válassza ki a lefordított bináris (`.bin`) vagy Intel HEX (`.hex`) fájlt.
4. Adja meg a kezdőcímet, ha bináris fájlt tölt be (a HEX fájlok tartalmazzák a saját címtérképüket, így automatikusan a megfelelő helyekre töltődnek be).

### 4.3 A szimuláció futtatása

Miután a virtuális hardver felépült és a kód betöltődött a memóriába:
1. Lépjen a fő eszköztár **Műveletek (Operation)** lapjára.
2. Állítsa be a **Futtatási késleltetés (Run Delay)** legördülő menüt (pl. 1000 ms), hogy szabályozza a szimuláció végrehajtási sebességét. Ez erősen ajánlott a vizuális hibakereséshez.
3. Kattintson a **Futtatás (Run)** gombra a folyamatos végrehajtás elindításához, vagy használja a **Léptetés (Step)** gombot az utasítások egyenkénti végrehajtásához.
4. Használjon olyan vizuális eszközöket, mint a **RunLogger**, a **RegViewer** vagy a **BusLogger** a **Nézet (View)** menüből, hogy valós időben nyomon követhesse a végrehajtási logikát, a regisztereket és a busz forgalmát.

### 4.4 Projektek használata

Egy bonyolult hardverbeállítás manuális felépítése minden alkalommal fárasztó lehet.
- Miután konfigurálta a CPU-t, a memóriát és az I/O portokat, használja a **Fájl > Projekt mentése (File > Save project)** parancsot a környezet `.clprj` fájlként történő mentéséhez.
- Legközelebb egyszerűen használja a **Fájl > Projekt betöltése... (File > Load project...)** parancsot a teljes hardvertopológia és a modulok tulajdonságainak azonnali visszaállításához.

### 4.5 Munkavégzés szkriptekkel

Az automatizált teszteléshez és környezetépítéshez Interaktív módból Szkript módba válthat.
1. Lépjen a **Fájl > Váltás szkript módba (File > Switch to script mode)** menüpontra.
2. Nyissa meg a beépített szerkesztőt a **Nézet > Szkriptszerkesztő megjelenítése... (View > Show ScriptEditor...)** menüponton keresztül.
3. Írja meg vagy töltse be a `.clsce` (Scriptembly) parancsait a modulok automatikus példányosításához, a memória betöltéséhez, a regiszterek módosításához és a feltételek érvényesítéséhez.
4. Kattintson a **Szkript futtatása (Run script)** gombra a Szkript eszköztáron, és figyelje a szöveges kimenetet a **Szkriptkonzolban (ScriptConsole)**.
