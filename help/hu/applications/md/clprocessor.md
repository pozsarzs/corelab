# CLProcessor - Súgó

## 1. Bevezetés

A CLProcessor a CoreLAB keretrendszer processzor-bővítményeinek betöltésére és kipróbálására szolgáló grafikus alkalmazás. A betöltött processzor a tesztkörnyezethez csatlakozik, ahol léptetve vagy folyamatosan futtatható.

### 1.1 Főbb funkciók

- Processzor-bővítmények keresése és betöltése.
- A processzor tulajdonságainak és regisztereinek megjelenítése.
- Regiszterértékek betöltése a processzorból és visszaírása.
- A processzor alaphelyzetbe állítása.
- NMI és IRQ megszakításkérés kezdeményezése.
- A processzor programjának léptetett vagy folyamatos futtatása.
- A programfutás naplózása.
- Memóriatartalom vizsgálata, törlése, betöltése és mentése.
- A tesztkörnyezet szabványos I/O-portjainak és ASCII-konzoljának használata.
- A processzor állapotának mentése és visszatöltése.

### 2. Rendszerkövetelmények

Az alkalmazás FreeBSD, Linux és Windows operációs rendszereken használható.

## 3. A felhasználói felület

### 3.1 Főablak

A főablakban találhatók a bővítmény kiválasztására és betöltésére szolgáló elemek, a processzor tulajdonságai és regiszterei, valamint a futtatás és a tesztkörnyezet kezelésére szolgáló parancsok.

### 3.2 Processzortulajdonságok

A tulajdonságlista a betöltött processzor adatait és konfigurációs jellemzőit mutatja. A forráskódban kezelt tulajdonságok:

| Tulajdonság | Leírás |
|---|---|
| Filename | A betöltött bővítmény fájlneve. |
| Modname | A processzor-bővítmény neve. |
| Description | A bővítmény leírása. |
| Architecture | A processzor architektúrája. |
| Enabled | A processzor engedélyezett állapota. |
| AddressWidth | A processzor címbuszának szélessége. |
| Architecture | A processzor architektúrája. |
| Endianness | A bájtok tárolási sorrendje. |
| HasSeparateIOBus | A processzor külön I/O-buszt használ-e. |
| MaxCodeAddress | A kódmemória maximális címe. |
| MaxIOPortAddress | Az I/O-portok maximális címe. |
| MaxMemAddress | A memóriacímzés maximális címe. |

### 3.3 Regiszterlista

A regiszterlista a betöltött processzor regisztereit és azok aktuális értékét jeleníti meg. A regiszterek neve és mérete a processzor-bővítménytől függ.

A megadott értékek hexadecimális formában jelennek meg. A beviteli mező ellenőrzi, hogy az érték hexadecimális-e, és belefér-e az adott regiszter méretébe.

### 3.4 Memória

A tesztkörnyezet memóriatartalma bankok szerint kezelhető. A forrás alapján a 0. bank a Neumann- és Harvard-architektúrájú processzorok kódmemóriája, az 1. bank pedig a Harvard-adatmemória.

A memóriaméret a programban `MEM_SIZE` konstanssal van meghatározva.

### 3.5 Állapotsor

Az állapotsor a betöltési sorszámot, a kiválasztott bővítmény nevét és a műveletek rövid visszajelzését jeleníti meg.

## 4. Az alkalmazás használata

### 4.1 Bővítménykönyvtár kiválasztása

1. Válaszd a **Bővítménykönyvtár kiválasztása** menüpontot, vagy használd a könyvtármező melletti kiválasztógombot.
2. Válaszd ki a processzor-bővítményeket tartalmazó könyvtárat.
3. A fájllista frissül.

A **Bővítménylista frissítése** parancs újraolvassa az aktuális könyvtár tartalmát.

### 4.2 Processzor betöltése vagy cseréje

1. Válaszd ki a kívánt processzor-bővítményt a fájllistában.
2. Indítsd el a **Bővítmény betöltése/cseréje** parancsot.
3. Sikeres betöltéskor a processzor példánya létrejön, a tesztbuszhoz csatlakozik, majd a tulajdonság- és regiszterlista frissül.

### 4.3 Regiszterek betöltése a processzorból

A **Regiszterértékek betöltése a CPU-ból** parancs frissíti a regiszterlistát a processzor aktuális értékeivel.

### 4.4 Regiszterek visszaírása a processzorba

1. Módosítsd a kívánt regiszter értékét a regiszterlistában.
2. Válaszd a **Regiszterértékek mentése a CPU-ba** parancsot.
3. A program a megjelenített értékeket visszaírja a processzor regisztereibe.

Az értéknek az adott regiszter méretébe kell férnie, és hexadecimális formátumúnak kell lennie.

### 4.5 Processzor alaphelyzetbe állítása

A **Alaphelyzet** parancs meghívja a processzor resetműveletét, majd frissíti a regiszterlistát.

### 4.6 Megszakításkérések

- **NMI:** nem maszkolható megszakításkérést küld a processzornak.
- **IRQ:** megszakításkérést küld a processzornak a főablakban megadott megszakításvektorral.

Az IRQ-vektor mező hexadecimális értéket fogad el. A forráskódban a vektor két hexadecimális számjegyre van formázva.

### 4.7 Program léptetett futtatása

A **Lépés** parancs egy processzorlépést hajt végre, majd frissíti a regiszterlistát.

### 4.8 Program folyamatos futtatása és leállítása

- **Futtatás:** elindítja az ismétlődő processzorléptetést.
- **Leállítás:** leállítja az ismétlődő léptetést, majd frissíti a regiszterlistát.

A futtatás sebessége a csúszkával módosítható; a csúszka pozíciója a léptető időzítő intervallumát állítja.

### 4.9 Futtatási napló

A **RunLogger** parancs megjeleníti a futtatási napló ablakát. A processzor eseménykezelője az utasításhatároknál rögzíti az aktuális utasítást.

### 4.10 Memóriatartalom vizsgálata

Az **Vizsgálat/tárolás** parancs megnyitja a memória vizsgálatára és módosítására szolgáló ablakot.

A **HexViewer** parancs megjeleníti a HexViewer ablakot. Az ablak a betöltött processzor architektúráját és a tesztmemória méretét kapja meg.

### 4.11 Memória betöltése fájlból

A **Memóriatartalom betöltése** parancs fájlból tölti be a memóriatartalmat. A betöltés előtt meg kell adni a célbankot és a címtartományt.

A forráskód két fájlformátumot kezel:

- bináris (`.bin`)
- Intel HEX (`.hex`)

Bináris fájl esetén a kiválasztott címtartományba kerülnek a beolvasott bájtok. Intel HEX betöltése előtt a célbank tartalma törlődik.

### 4.12 Memóriatartalom mentése fájlba

A **Memóriatartalom mentése** parancs a kiválasztott bank megadott címtartományát menti fájlba. A támogatott formátumok:

- bináris (`.bin`)
- Intel HEX (`.hex`)

### 4.13 Memóriabankok törlése

- **(Kód)memória törlése:** a 0. bank minden bájtját nullára állítja.
- **Adat memória törlése:** az 1. bank minden bájtját nullára állítja.

### 4.14 ASCII-konzol

Az **ASCII-konzol** parancs létrehozza és megjeleníti az ASCII-konzol paneljét. A panel neve a konzol I/O-címét tartalmazza. A konzol megszakításkezelőt is kap, és a főablakban beállított megszakításvektort használja.

### 4.15 Szabványos I/O-port

A **Szabványos port** parancs létrehozza és megjeleníti a szabványos I/O-port paneljét.

### 4.16 I/O-portok megszakításkérése

A megfelelő menüponttal engedélyezhető vagy letiltható az I/O-port felől érkező megszakításkérés továbbítása.

### 4.17 I/O-portok alaphelyzetbe állítása

A **Portok alaphelyzetbe állítása** parancs alaphelyzetbe állítja a létrehozott ASCII-konzolt és szabványos I/O-portot.

### 4.18 Processzorállapot mentése és betöltése

- **Állapot mentése:** a processzor állapotát `.clpst` fájlba menti.
- **Állapot betöltése:** a kiválasztott `.clpst` fájlból visszatölti a processzor állapotát.

Sikeres betöltés után a tulajdonságlista frissül.

## 5. Menüparancsok

### 5.1 File

- Bővítménykönyvtár kiválasztása
- Gyakori helyek
- Bővítménylista frissítése
- Bővítmény betöltése/cseréje
- Alkalmazás újraindítása
- Kilépés

A **Gyakori helyek** almenüben az alábbi útvonalak szerepelhetnek, amennyiben léteznek:
- `./`
- `/usr/lib/corelab/`
- `/usr/local/lib/corelab/`
- `./plugins/`
- `~/.local/lib/corelab/`

### 5.2 Processor

- Regiszterértékek betöltése a CPU-ból
- Regiszterértékek mentése a CPU-ba
- Alaphelyzet (A processzor alaphelyzetbe állítása.)
- NMI (Nem maszkolható megszakításkérés küldése.)
- IRQ (Megszakításkérés küldése a megadott vektorral.)
- Lépés (Egy processzorlépés végrehajtása.)
- Futtatás (Folyamatos futtatás indítása.)
- Leállítás (A folyamatos futtatás leállítása.)
- RunLogger
- Állapot betöltése
- Állapot mentése

### 5.3 Memory

- Vizsgálat/tárolás (Memóriacímek és -adatok vizsgálata, illetve módosítása.)
- HexViewer
- Memóriatartalom betöltése
- Memóriatartalom mentése
- (Kód)memória törlése
- Adatmemória törlése

### 5.4 I/O

- ASCII-konzol (Az ASCII-konzol megjelenítése.)
- Szabványos port (A szabványos I/O-port megjelenítése.)
- Portok alaphelyzetbe állítása
- IRQ kérése (Az I/O-port felől érkező megszakításkérés engedélyezése vagy letiltása.)

### 5.5 Help

- Súgó
- Névjegy

## 6. Beállítások

### 6.1 Futtatási sebesség

A futtatási sebesség a főablak csúszkájával szabályozható. A csúszka a processzorléptetést végző időzítő intervallumát állítja.

### 6.2 IRQ-vektor

Az IRQ-vektor a főablakban adható meg. A mező hexadecimális értéket fogad el.

### 6.3 I/O-megszakítások

A menüben engedélyezhető vagy letiltható az I/O-portok megszakításkérésének továbbítása.

## 7. Hibaelhárítás

| Hiba | Lehetséges ok / teendő |
|---|---|
| A megadott könyvtár nem létezik. | Ellenőrizd a bővítménykönyvtár útvonalát. |
| A processzor-bővítmény nem tölthető be. | Ellenőrizd a fájlt és a betöltő által jelzett hibát. |
| A fájl nem CoreLAB processzor-bővítmény. | Olyan bővítményt válassz, amely biztosítja a szükséges processzor-belépési pontokat. |
| Hibás regiszterérték. | Az érték legyen hexadecimális, és férjen bele a regiszter méretébe. |
| Hibás IRQ-vektor. | Adj meg érvényes, két hexadecimális számjeggyel ábrázolható értéket. |
| A memóriafájl nem olvasható vagy nem menthető. | Ellenőrizd a fájl elérhetőségét és a jogosultságokat. |
| Az Intel HEX fájl betöltése hibát jelez. | Ellenőrizd a fájl formátumát és tartalmát. |
| Hiányzik a súgófájl vagy a súgónéző. | Ellenőrizd a `corelab_<nyelv>.chm`, a `corelab_en.chm` és az `lhelp` elérhetőségét. |

## 8. Függelék

### 8.1 Fájlformátumok

| Kiterjesztés / minta | Rendeltetés |
|---|---|
| `cpu_*.dll` | Windows processzor-bővítmény. |
| `libcpu_*.so` | Linux/Unix processzor-bővítmény. |
| `*.clpst` | CoreLAB bővítményállapot-fájl. |
| `*.bin` | Bináris memóriatartalom. |
| `*.hex` | Intel HEX memóriatartalom. |

### 8.2 Billentyűparancsok

| Parancs | Leírás |
|:-:|---|
| Ctrl-D | Bővítménykönyvtár kiválasztása |
| Ctrl-H | HexViewer |
| Ctrl-L | RunLogger |
| F4     | Vizsgálat/tárolás |
| F5     | Regiszterértékek betöltése a CPU-ból |
| F8     | Lépés |
| F9     | Futtatás | 
| F10    | Leállítás |

### 8.3 Fogalomtár

- **Processzor-bővítmény:** dinamikusan betöltött modul, amely processzort valósít meg.
- **Regiszter:** a processzor belső, névvel és mérettel rendelkező adattárolója.
- **NMI:** nem maszkolható megszakításkérés.
- **IRQ:** megszakításkérés, amelyhez a tesztkörnyezet vektort ad át.
- **Intel HEX:** memóriatartalom tárolására használt szöveges fájlformátum.
- **RunLogger:** a processzor végrehajtásához kapcsolódó naplóablak.
- **HexViewer:** a memória hexadecimális megjelenítésére szolgáló ablak.

### 8.4 Verziótörténet

- **v0.1.0:** első változat.
