# CoreLAB - Súgó

## 3. Felhasználói felület

### 3.1 Főablak

A CoreLAB keretrendszer főablaka központi környezetet biztosít a szimulációs munkaterület kezeléséhez. A következő fő részekből áll:

- **Menüsor (Menu bar):** Hozzáférést biztosít az alkalmazás összes parancsához, nézetéhez és beállításához.
- **Eszköztárak (Toolbars):** Környezetfüggő eszköztárak, amelyek gyors hozzáférést biztosítanak a gyakran használt parancsokhoz. Elérhetőségük a kiválasztott működési módtól (Interaktív vagy Szkript) és az aktív laptól függ.
- **Futtatási késleltetés választó (Run Delay Selector):** Egy legördülő lista, amellyel beállítható a végrehajtási lépések közötti futtatási késleltetés ezredmásodpercben (pl. 1000 ms).
- **Lapos vezérlőpult (Tabbed Control Panel):** Öt különálló lapra rendezi a modulkezelési és végrehajtási feladatokat:
  - **Műveletek (Operation):** Vezérlőket tartalmaz a teljes szimuláció futtatásához, léptetéséhez, leállításához és visszaállításához, valamint az NMI (nem maszkolható megszakítás) kiváltásához.
  - **Processzor (Processor):** Eszközöket biztosít a CPU-modulok létrehozásához, konfigurálásához, engedélyezéséhez, letiltásához, valamint a rendszerbuszhoz történő csatlakoztatásához és leválasztásához.
  - **Memória (Memory):** Memóriamodulok kezelésére, tulajdonságaik módosítására, valamint a memóriatartalom (Bináris vagy Intel HEX formátum) betöltésére/mentésére szolgál.
  - **I/O port:** Kezeli a bemeneti/kimeneti portokat és a virtuális eszközöket. Ezenkívül kezeli az interaktív grafikus paneljeik konfigurálását is.
  - **Szkript (Script):** Dedikált vezérlők egyéni szkriptek létrehozásához, betöltéséhez, mentéséhez és végrehajtásához, amikor a keretrendszer Szkript módban van.
- **Rendszerkonzol (SysConsole):** A főablak alján található. Interaktív parancssori felületként szolgál, és megjeleníti a rendszerüzeneteket, a parancsok visszajelzéseit és a figyelmeztetéseket.

### 3.2 Integrált nézegető- és naplózóablakok

A CoreLAB számos integrált vizuális modult tartalmaz a szimulált hardver belső állapotának vizsgálatához és a végrehajtás nyomon követéséhez. Ezek külön ablakokként indíthatók:

| Modul | Leírás |
|---|---|
| **Modulfelfedező (Module Explorer)** | Az összes példányosított CPU, memória és I/O port modul kezelésére és megtekintésére szolgál egy strukturált fastruktúrában. |
| **Töréspontkezelő (Breakpoint Manager)** | Eszköz a végrehajtási töréspontok kezelésére, amellyel a szimuláció adott feltételek vagy címek esetén megállítható. |
| **HexViewer** | Egy memórianézegető összetevő, amely lehetővé teszi egy kiválasztott memóriamodul adatainak valós idejű vizsgálatát. |
| **RegViewer** | Valós idejű információkat jelenít meg a csatlakoztatott processzor belső regisztereiről és jelzőiről (flags). |
| **RunLogger** | Valós idejű kimenetet biztosít a végrehajtott utasításokról, beleértve a címet, a gépi kódot és az assembly mnemonikot. |
| **BusLogger** | Naplózza a rendszerbuszon áthaladó adat-, cím- és vezérlőjeleket (MEMRD, MEMWR, IORD, IOWR). |
| **IntLogger** | Naplót vezet a csatlakoztatott I/O modulok által kiváltott hardveres megszakításkérésekről. |
| **Szkriptszerkesztő (ScriptEditor)** | Beépített szövegszerkesztő környezet egyéni vezérlőszkriptek írásához, szerkesztéséhez és kezeléséhez. |
| **Szkriptkonzol (ScriptConsole)** | Egy dedikált kimeneti konzol, amely megjeleníti egy futó szkript eredményeit és egyedi szöveges üzeneteit. |

### 3.3 Interaktív I/O panelek

Bizonyos virtuális I/O modulok (például kijelzők, kapcsolók vagy LED-mátrixok) interaktív grafikus panelekkel rendelkeznek. Ezek a panelek közvetlenül az **I/O port** lapon vagy a **Nézet (View)** menün keresztül mozgathatók, átméretezhetők, átnevezhetők és átkapcsolhatók (elrejthetők/megjeleníthetők), hogy a virtuális hardver munkaterületet az Ön igényeinek megfelelően testreszabja.
