# CLMemory - Súgó

## 1. Bevezetés

A CLMemory a CoreLAB keretrendszer memória-bővítményeinek kipróbálására szolgáló
grafikus alkalmazás. Az alkalmazás segítségével memória-plugin tölthető be,
megtekinthetők és módosíthatók a plugin egyes tulajdonságai, valamint
memóriarekeszek olvashatók és írhatók. A bővítmény állapota fájlba menthető,
illetve fájlból visszatölthető.

### 1.1 Főbb funkciók

- Memória-bővítmények keresése egy megadott könyvtárban.
- Bővítmény betöltése és cseréje.
- A betöltött bővítmény tulajdonságainak megjelenítése.
- A memória méretének, engedélyezett állapotának és memóriamódjának beállítása.
- Memóriacímről egy bájt beolvasása.
- Egy bájt kiírása memóriacímre.
- A bővítmény állapotának mentése és betöltése.

### 2. Rendszerkövetelmények

Az alkalmazás FreeBSD, Linux és Windows operációs rendszereken használható.

## 3. A felhasználói felület

### 3.1 Főablak

A főablak fő részei:

- **Bővítménykönyvtár mező:** a memória-bővítményeket tartalmazó könyvtár megadása.
- **Fájllista:** a könyvtárban található memória-pluginok listája. A lista a fájlnevet, méretet és típust mutatja.
- **Tulajdonságlista:** a betöltött bővítmény adatait és beállítható tulajdonságait jeleníti meg.
- **Memóriatáblázat:** a vizsgált memóriacím és az adat hexadecimális értékének megadására, illetve megjelenítésére szolgál.
- **Állapotsor:** a betöltések sorszámát, a kiválasztott fájl nevét és a műveletek rövid visszajelzését mutatja.

### 3.2 Tulajdonságlista

A tulajdonságlista a betöltött plugin adatait és konfigurációs értékeit mutatja.

| Tulajdonság | Leírás |
|---|---|
| Filename | A betöltött bővítmény fájlneve. |
| Modname | A bővítmény neve. |
| Description | A bővítmény leírása. |
| Enabled | A memória-bővítmény engedélyezett állapota. |
| MemoryMode | A memória működési módja. |
| AddressRangeSize | A memória címtartományának mérete. |

Az `AddressRangeSize` értéke 16 bájt és 16 MB közötti lehet.

### 3.3 Memóriatáblázat

A memóriatáblázat két adatot kezel:

- **Cím:** a vizsgálandó memóriacím, hexadecimális formában.
- **Adat:** a memóriacímhez tartozó bájtérték, hexadecimális formában.

Az adatmezőbe 8 bites érték írható be. A cím és az adat hexadecimális formátumú.

## 4. Az alkalmazás használata

### 4.1 Bővítménykönyvtár kiválasztása

### 4.1 Bővítménykönyvtár kiválasztása

1. Válaszd a **Bővítménykönyvtár kiválasztása** menüpontot, vagy használd a könyvtármező melletti kiválasztógombot.
2. Válaszd ki a bővítményeket tartalmazó könyvtárat.
3. A fájllista frissül, és megjeleníti a felismert bővítményfájlokat.

A **Bővítménylista frissítése** parancs újraolvassa az aktuális könyvtár tartalmát.

### 4.2 Bővítmény betöltése vagy cseréje

1. Válaszd ki a kívánt bővítményfájlt a fájllistában.
2. Indítsd el a **Bővítmény betöltése/cseréje** parancsot.
3. Sikeres betöltéskor a tulajdonságlista frissül, és a memória vizsgálatára szolgáló mezők, illetve műveletek engedélyezetté válnak.

Új bővítmény betöltésekor a korábbi példány felszabadításra kerül.

### 4.3 Memória olvasása

1. Add meg a címet az **Cím** mezőben, hexadecimális formában.
2. Válaszd a **Vizsgálat** parancsot.
3. A program beolvassa a megadott cím tartalmát.
4. A beolvasott bájt a **Data** mezőben jelenik meg.

Ha a cím kívül esik a memória címtartományán, az állapotsor erre figyelmeztet.

### 4.4 Memória írása

1. Add meg a címet az **Cím** mezőben.
2. Add meg a kiírandó bájtértéket a **Adat** mezőben.
3. Válaszd a **Tárolás** parancsot.
4. A program meghívja a bővítmény írási műveletét, majd visszajelzést ad az állapotsorban.

A program jelzi, ha a cím a címtartományon kívül esik, illetve ha a memória ROM módban van.

### 4.5 A bővítmény állapotának betöltése

1. Válaszd a **Állapot betöltése** parancsot.
2. Válaszd ki a korábban mentett állományt.
3. A program átadja az állapotadatokat a bővítménynek.
4. Sikeres betöltés után a tulajdonságlista frissül.

### 4.6 A bővítmény állapotának mentése

1. Válaszd a **Állapot mentése** parancsot.
2. Add meg a célfájlt.
3. A program lekéri a bővítmény állapotadatait, majd elmenti azokat a kiválasztott fájlba.

## 5. Menüparancsok

### 5.1 Fájl

- Bővítménykönyvtár kiválasztása
- Gyakori helyek
- Bővítménylista frissítése
- Bővítmény betöltése/cseréje
- Alkalmazás újraindítása
- Kilépés

Az **Gyakori helyek** almenüben a forrás szerint az alábbi útvonalak szerepelhetnek, ha léteznek:

- `./`
- `/usr/lib/corelab/`
- `/usr/local/lib/corelab/`
- `./plugins/`
- `~/.local/lib/corelab/`

### 5.2 Memory

- Vizsgálat (Egy bájt beolvasása a megadott memóriacímről.)
- Tárolás (Egy bájt kiírása a megadott memóriacímre.)
- Állapot betöltése
- Állapot mentése

### 5.3 Help

- Súgó
- Névjegy

## 6. Beállítások

Az alkalmazás nem tartalmaz általános beállítási párbeszédablakot.

## 7. Hibaelhárítás

| Hiba | Lehetséges ok / teendő |
|---|---|
| A megadott könyvtár nem létezik. | Ellenőrizd a bővítménykönyvtár útvonalát. |
| A bővítmény nem tölthető be. | Ellenőrizd a fájlt és a betöltő által jelzett hibát. |
| A fájl nem CoreLAB memória-bővítmény. | Olyan bővítményt válassz, amely a szükséges memória-belépési pontokat biztosítja. |
| Hibás hexadecimális adat. | Csak hexadecimális érték adható meg. |
| A megadott memória mérete kívül esik a megengedett tartományon. | A memória mérete 16 bájt és 16 MiB közötti lehet. |
| A cím a címtartományon kívül esik. | Ellenőrizd a megadott címet és a memória méretét. |
| A memória csak olvasható. | ROM módban az írás nem módosítja a memóriát. |
| Hiányzik a súgófájl vagy a súgónéző. | Ellenőrizd a súgófájl és az `lhelp` elérhetőségét. |
| Nem olvasható vagy nem írható a bővítmény állapota. | Ellenőrizd a kiválasztott bővítményt és az állományt. |

## 8. Függelék

### 8.1 Fájlformátumok

| Kiterjesztés / minta | Rendeltetés |
|---|---|
| `memory_*.dll` | Windows memória-bővítmény. |
| `libmemory_*.so` | Linux/Unix memória-bővítmény. |
| `*.clpst` | CoreLAB bővítményállapot-fájl. |

### 8.2 Billentyűparancsok

| Parancs | Leírás
|:-:|---|
| Ctrl-D | Bővítménykönyvtár kiválasztása |
| Ctrl-E | Egy bájt beolvasása a megadott memóriacímről |
| Ctrl-P | Egy bájt kiírása a megadott memóriacímre |

### 8.3 Fogalomtár

- **Memória-bővítmény (plugin):** dinamikusan betöltött modul, amely memóriaműveleteket valósít meg.
- **AddressRangeSize:** a bővítmény által kezelt memóriacímek tartományának mérete.
- **MemoryMode:** a memória működési módja, például ROM vagy RAM, a bővítmény által támogatott mód.
- **Állapotfájl:** a bővítmény állapotának mentésére és visszaállítására szolgáló `.clpst` fájl.

### 8.4 Verziótörténet

- **v0.1.0:** első változat.
