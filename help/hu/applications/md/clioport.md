# CLIOPort - Súgó

## 1. Bevezetés

A CLIOPort a CoreLAB keretrendszer I/O-port bővítményeinek kipróbálására szolgáló
grafikus alkalmazás, amely lehetővé teszi egy I/O-port plugin kiválasztását,
betöltését, tulajdonságainak megtekintését, valamint a portok bájtszintű
olvasását és írását. A panellel rendelkező bővítmények saját kezelőablaka is
megjeleníthető.

### 1.1 Főbb funkciók

- I/O-port bővítmények keresése egy megadott könyvtárban.
- Bővítmény betöltése és cseréje.
- A betöltött bővítmény tulajdonságainak megjelenítése.
- Bájtszintű olvasás és írás a bővítmény portjain.
- A bővítmény állapotának fájlba mentése és fájlból visszatöltése.
- A bővítmény saját ablakának megjelenítése és ablakjellemzőinek módosítása.

### 2. Rendszerkövetelmények

Az alkalmazás FreeBSD, Linux és Windows operációs rendszereken használható.

## 3. A felhasználói felület

### 3.1 Főablak

A főablak a következő fő részekből áll:

- **Bővítménykönyvtár mező:** a keresési könyvtár megadása.
- **Fájllista:** a könyvtárban található I/O-port bővítmények listája. A lista a
  fájlnevet, méretet és típust mutatja.
- **Tulajdonságlista:** a betöltött bővítmény adatait és konfigurációs
  tulajdonságait jeleníti meg.
- **Porttábla:** a bővítmény portcímeit és az azokhoz tartozó hexadecimális
  adatokat mutatja.
- **Állapotsor:** a betöltések sorszámát, a kiválasztott fájl nevét és az
  aktuális művelet rövid visszajelzését jeleníti meg.

### 3.2 Tulajdonságlista

A tulajdonságlista a betöltött plugin jellemzőit jeleníti meg.

| Tulajdonság | Leírás |
|---|---|
| Filename | A betöltött bővítmény fájlneve. |
| Modname | A bővítmény neve. |
| Description | A bővítmény leírása. |
| Int. vector (Hex) | A megszakításvektor hexadecimális értéke. |
| HasPanel | Jelzi, hogy a bővítmény rendelkezik-e saját ablakkal. |
| Enabled | A bővítmény engedélyezett állapota. |
| AddressRangeSize | A bővítmény által kezelt portcímek száma. |
| LatchedOutput | A kimenet reteszelt működését jelző tulajdonság. |
| ReadBackOutput | A kimenet visszaolvashatóságát jelző tulajdonság. |
| DataInMode | Az adatbemeneti vonalak módja. |
| DataInNegation | Az adatbemeneti vonalak invertálása. |
| DataOutMode | Az adat-kimeneti vonalak módja. |
| DataOutNegation | Az adat-kimeneti vonalak invertálása. |
| SelMode | A kiválasztójel módja. |
| SelNegation | A kiválasztójel invertálása. |

A konfigurációs értékek módosítása a bővítmény saját működésén keresztül történik.

### 3.3 Porttábla

A porttábla minden kezelt porthoz egy sort jelenít meg. Az első oszlop a
báziscímhez viszonyított eltolást (`BA+0`, `BA+1`, ...) a második oszlop az
adatot tartalmazza hexadecimális formában. Az adatmezőbe 8 bites, `00` és `FF`
közötti hexadecimális érték írható be.

## 4. Az alkalmazás használata

### 4.1 Bővítménykönyvtár kiválasztása

1. Válaszd a **Bővítménykönyvtár kiválasztása** menüpontot, vagy használd a könyvtármező melletti kiválasztógombot.
2. Válaszd ki a bővítményeket tartalmazó könyvtárat.
3. A fájllista frissül, és megjeleníti a felismert bővítményfájlokat.

A **Bővítménylista frissítése** parancs újraolvassa az aktuális könyvtár tartalmát.

### 4.2 Bővítmény betöltése vagy cseréje

1. Válaszd ki a kívánt bővítményfájlt a fájllistában.
2. Indítsd el a **Bővítmény betöltése/cseréje** parancsot.
3. Sikeres betöltéskor a tulajdonságlista és a porttábla feltöltődik.
4. Ha a bővítmény saját panellel rendelkezik, az alkalmazás létrehozza és megjeleníti azt.
Új bővítmény betöltésekor a korábban betöltött bővítmény példánya és - ha van - saját ablaka felszabadításra kerül.

### 4.3 Port olvasása

1. Jelöld ki a porttáblában a kívánt sort.
2. Válaszd a **Bájt olvasása** parancsot.
3. A program beolvassa a kiválasztott port értékét.
4. Az eredmény hexadecimális formában megjelenik a porttáblában; az állapotsor rövid visszajelzést ad.

### 4.4 Port írása

1. Jelöld ki a porttáblában a kívánt sort.
2. Írd be az adatot a **Adat (Hex)** oszlopba.
3. Az adatmező szerkesztésének befejezésekor a program végrehajtja az írást.
4. Az értéknek 8 bites hexadecimális számnak kell lennie (`00`-`FF`).

### 4.5 A bővítmény állapotának mentése

1. Válaszd a **Állapot mentése** parancsot.
2. Add meg a célfájlt.
3. A program a bővítmény által szolgáltatott állapotadatokat a kiválasztott fájlba menti.

### 4.6 A bővítmény állapotának betöltése

1. Válaszd a **Állapot betöltése** parancsot.
2. Válaszd ki a korábban mentett állományt.
3. A program átadja az állapotadatokat a bővítménynek, majd frissíti a tulajdonságlistát.

### 4.7 A bővítmény saját ablakának kezelése

A saját ablakkal rendelkező bővítmények esetén a következő műveletek érhetők el:

- A bővítmény ablakának megjelenítése.
- Az ablak címének módosítása.
- Az ablak méretének és pozíciójának beállítása.

## 5. Menüparancsok

### 5.1 Fájl

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

### 5.2 Nézet

- Bővítményablak megjelenítése
- Bővítményablak címének beállítása
- Bővítményablak méretének/pozíciójának beállítása

### 5.3 I/O-port

- Bájt olvasása
- Bájt írása
- Állapot betöltése
- Állapot mentése

### 5.4 Súgó

- Súgó
- Névjegy

## 6. Beállítások

Az alkalmazás nem tartalmaz általános beállítási párbeszédablakot.

## 7. Hibaelhárítás

A program az alábbi esetekben jelenít meg hibaüzenetet:

| Hiba | Lehetséges ok / teendő |
|---|---|
| A megadott könyvtár nem létezik. | Ellenőrizd a bővítménykönyvtár útvonalát. |
| A bővítmény nem tölthető be. | Ellenőrizd a fájlt és a betöltő által jelzett hibát. |
| A fájl nem CoreLAB I/O-port bővítmény. | Olyan bővítményt válassz, amely a szükséges I/O-port belépési pontokat biztosítja. |
| Hiányzik a súgófájl. | Ellenőrizd a `corelab_<nyelv>.chm`, illetve a `corelab_en.chm` fájl elérhetőségét. |
| Hiányzik a súgónéző. | Ellenőrizd, hogy az `lhelp` elérhető-e a program számára. |
| Hibás hexadecimális adat. | Csak `00`-`FF` közötti, 8 bites hexadecimális érték adható meg. |
| Nem olvasható vagy nem írható a bővítmény állapota. | Ellenőrizd a kiválasztott bővítményt és az állományt. |

## 8. Függelék

### 8.1 Fájlformátumok

| Kiterjesztés / minta | Rendeltetés |
|---|---|
| `ioport_*.dll` | Windows I/O-port bővítmény. |
| `libioport_*.so` | Linux/Unix I/O-port bővítmény. |
| `*.clpst` | CoreLAB bővítményállapot-fájl. |

### 8.2 Billentyűparancsok

| Parancs | Leírás |
|:-:|---|
| Ctrl-D | Bővítménykönyvtár kiválasztása |
| Ctrl-R | Bájt olvasása |
| Ctrl-W | Bájt írása |

### 8.3 Fogalomtár

- **I/O-port:** a bővítményen keresztül elérhető bemeneti/kimeneti cím.
- **Bővítmény (plugin):** dinamikusan betöltött modul, amely I/O-port funkciókat valósít meg.
- **BA:** a porttáblában használt báziscím-jelölés; a sorok ehhez képest mutatják az eltolást.

### 8.4 Verziótörténet

- **v0.1.0:** első változat.
