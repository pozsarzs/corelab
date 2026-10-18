# CoreLAB - Súgó

## 6. Parancsok

Ezeket a parancsokat a SysConsol parancssorában (csCommandLine) és szkriptekben is használhatja, feltéve, hogy az adott utasítás az aktuális kontextusban megengedett – vagyis, hogy engedélyezett-e a szimuláció során és az aktív működési módban (omInteractive vagy omScript). A szintaxist tekintve a megjegyzéseknek pontosvesszővel (`;`) kell kezdődniük, a karakterláncokat pedig idézőjelek közé (`"`) kell tenni. Az értékeket (például *index* vagy *address* /cím/) közvetlenül vagy a regiszterek tartalmára hivatkozva (pl. *$R0*–*$RF*) is meg lehet adni; magukat a regisztereket azonban kizárólag a nevükkel (*R0*–*RF*) kell megadni.

| utasítás | leírás | hatókör | szintaxis | arg. | szim. alatt | működési mód |
|---|---|---|---|---|---|---|
| ADD | Hozzáadja az értéket az RA-hoz helyben. | [csScript] | ADD value | 1 | Igen | [omScript] |
| AND | Bitenkénti/logikai ÉS helyben. | [csScript] | AND value | 1 | Igen | [omScript] |
| ATIO | I/O port vagy eszközmodul csatlakoztatása a buszhoz. | [csCommandLine, csScript] | ATIO instancename | 1 | Nem | [omInteractive, omScript] |
| ATME | Memóriamodul csatlakoztatása a buszhoz. | [csCommandLine, csScript] | ATME instancename | 1 | Nem | [omInteractive, omScript] |
| ATPU | Processzormodul csatlakoztatása a buszhoz. | [csCommandLine, csScript] | ATPU instancename | 1 | Nem | [omInteractive, omScript] |
| BIT | A megadott bit ellenőrzése. | [csScript] | BIT index | 1 | Igen | [omScript] |
| CALL | Szubrutin meghívása. | [csScript] | CALL label | 1 | Igen | [omScript] |
| CFIO | I/O port modul konfigurálása. | [csCommandLine, csScript] | CFIO instancename.property value | 2 | Nem | [omInteractive, omScript] |
| CFME | Memóriamodul konfigurálása. | [csCommandLine, csScript] | CFME instancename.property value | 2 | Nem | [omInteractive, omScript] |
| CFPU | Processzormodul konfigurálása. | [csCommandLine, csScript] | CFPU instancename.property value | 2 | Nem | [omInteractive, omScript] |
| CHWD | Munkakönyvtár megváltoztatása. | [csCommandLine, csScript] | CHWD directory | 1 | Nem | [omInteractive, omScript] |
| COMP | Az RA összehasonlítása egy értékkel kivonás útján. | [csScript] | COMP value | 1 | Igen | [omScript] |
| CONV | Az RA-ban lévő szám átalakítása 2/8/16-os számrendszerbe. | [csScript] | CONV target base | 2 | Igen | [omScript] |
| CRIO | I/O port vagy eszközmodul példányosítása. | [csCommandLine, csScript] | CRIO library instancename | 2 | Nem | [omInteractive, omScript] |
| CRME | Memóriamodul példányosítása. | [csCommandLine, csScript] | CRME library instancename | 2 | Nem | [omInteractive, omScript] |
| CRPU | Processzormodul példányosítása. | [csCommandLine, csScript] | CRPU library instancename | 2 | Nem | [omInteractive, omScript] |
| DEC | Az RA csökkentése 1-gyel helyben. | [csScript] | DEC | 0 | Igen | [omScript] |
| DIIO | I/O port vagy eszközmodul letiltása. | [csCommandLine, csScript] | DIIO instancename | 1 | Nem | [omInteractive, omScript] |
| DIME | Memóriamodul letiltása. | [csCommandLine, csScript] | DIME instancename | 1 | Nem | [omInteractive, omScript] |
| DIPU | Processzormodul letiltása. | [csCommandLine, csScript] | DIPU instancename | 1 | Nem | [omInteractive, omScript] |
| DSIO | I/O port vagy eszközmodul megsemmisítése. | [csCommandLine, csScript] | DSIO instancename | 1 | Nem | [omInteractive, omScript] |
| DSME | Memóriamodul megsemmisítése. | [csCommandLine, csScript] | DSME instancename | 1 | Nem | [omInteractive, omScript] |
| DSPU | Processzormodul megsemmisítése. | [csCommandLine, csScript] | DSPU instancename | 1 | Nem | [omInteractive, omScript] |
| DTIO | I/O port vagy eszközmodul leválasztása a buszról. | [csCommandLine, csScript] | DTIO instancename | 1 | Nem | [omInteractive, omScript] |
| DTME | Memóriamodul leválasztása a buszról. | [csCommandLine, csScript] | DTME instancename | 1 | Nem | [omInteractive, omScript] |
| DTPU | Processzormodul leválasztása a buszról. | [csCommandLine, csScript] | DTPU instancename | 1 | Nem | [omInteractive, omScript] |
| EDME | A vizsgálat/elhelyezés (examine/deposit) ablak megjelenítése. | [csCommandLine] | EDME instancename | 1 | Nem | [omInteractive] |
| END | A főprogram vége. | [csScript] | END | 0 | Igen | [omScript] |
| ENIO | I/O port vagy eszközmodul engedélyezése. | [csCommandLine, csScript] | ENIO instancename | 1 | Nem | [omInteractive, omScript] |
| ENME | Memóriamodul engedélyezése. | [csCommandLine, csScript] | ENME instancename | 1 | Nem | [omInteractive, omScript] |
| ENPU | Processzormodul engedélyezése. | [csCommandLine, csScript] | ENPU instancename | 1 | Nem | [omInteractive, omScript] |
| EXAP | Kilépés az alkalmazásból. | [csCommandLine, csScript] | EXAP | 0 | Igen | [omInteractive, omScript] |
| EXIT | Szkript befejezése (leállítása). | [csScript] | EXIT | 0 | Igen | [omScript] |
| HELP | Súgó áttekintés vagy egy parancs részletes használatának megjelenítése. | [csCommandLine, csScript] | HELP [command] | 1 | Igen | [omInteractive, omScript] |
| INC | Az RA növelése 1-gyel helyben. | [csScript] | INC | 0 | Igen | [omScript] |
| INRG | Ellenőrzi, hogy az RA a min és max értékek között van-e. | [csScript] | INRG min max | 2 | Igen | [omScript] |
| JPCA | Ugrás a megadott címkére, ha RF/C = true. | [csScript] | JPCA label | 1 | Igen | [omScript] |
| JPNC | Ugrás a megadott címkére, ha RF/C = false. | [csScript] | JPNC label | 1 | Igen | [omScript] |
| JPNZ | Ugrás a megadott címkére, ha RF/Z = false. | [csScript] | JPNZ label | 1 | Igen | [omScript] |
| JPZE | Ugrás a megadott címkére, ha RF/Z = true. | [csScript] | JPZE label | 1 | Igen | [omScript] |
| JUMP | Ugrás a megadott címkére. | [csScript] | JUMP label | 1 | Igen | [omScript] |
| LDME | Memóriatartalom betöltése fájlból. | [csCommandLine, csScript] | LDME instancename filename | 2 | Nem | [omInteractive, omScript] |
| LDPR | Váltás interaktív módba és projekt betöltése fájlból. | [csCommandLine] | LDPR filename.clprj | 1 | Nem | [omInteractive, omScript] |
| LDRG | Érték betöltése a megadott regiszterbe. | [csScript] | LDRG register value | 2 | Igen | [omScript] |
| LDSC | Váltás szkript módba és szkript betöltése fájlból. | [csCommandLine] | LDSC filename.clsce | 1 | Nem | [omScript] |
| MUL | Az RA szorzása az értékkel helyben. | [csScript] | MUL value | 1 | Igen | [omScript] |
| MVIO | I/O eszközpanel pozíciójának beállítása. | [csCommandLine, csScript] | MVIO instancename left-top | 2 | Igen | [omInteractive, omScript] |
| NMI | Nem maszkolható megszakítás hívása. | [csCommandLine] | NMI | 0 | Nem | [omInteractive] |
| NOT | Bitenkénti/logikai NEM helyben. | [csScript] | NOT | 0 | Igen | [omScript] |
| NWPR | Váltás interaktív módba és új projekt létrehozása. | [csCommandLine] | NWPR | 0 | Nem | [omInteractive, omScript] |
| NWSC | Váltás szkript módba és új szkript létrehozása. | [csCommandLine] | NWSC | 0 | Nem | [omScript] |
| OR | Bitenkénti/logikai VAGY helyben. | [csScript] | OR value | 1 | Igen | [omScript] |
| PRNT | Szöveg kiírása a konzolra. | [csScript] | PRNT "text" ["text"] | 1 | Igen | [omScript] |
| RDIO | Érték olvasása az I/O portról és tárolása az RA regiszterben. | [csScript] | RDIO address | 1 | Igen | [omScript] |
| RDME | Érték olvasása a memóriából és tárolása az RA regiszterben. | [csScript] | RDME address | 1 | Igen | [omScript] |
| RNIO | I/O eszközpanel átnevezése. | [csCommandLine, csScript] | RNIO instancename caption | 2 | Igen | [omInteractive, omScript] |
| RSAP | Alkalmazás újraindítása. | [csCommandLine, csScript] | RSAP | 0 | Igen | [omInteractive, omScript] |
| RSIO | I/O port vagy eszközmodul visszaállítása. | [csCommandLine, csScript] | RSIO instancename | 1 | Nem | [omInteractive, omScript] |
| RSME | Memóriamodul visszaállítása. | [csCommandLine, csScript] | RSME instancename | 1 | Nem | [omInteractive, omScript] |
| RSPU | Processzormodul visszaállítása. | [csCommandLine, csScript] | RSPU instancename | 1 | Nem | [omInteractive, omScript] |
| RST | Minden modul visszaállítása. | [csCommandLine, csScript] | RST | 0 | Nem | [omInteractive] |
| RTRN | Visszatérés a szubrutinból. | [csScript] | RTRN | 0 | Igen | [omScript] |
| RUN | Szimuláció futtatása. | [csCommandLine, csScript] | RUN | 0 | Nem | [omInteractive, omScript] |
| RUSC | Szkript futtatása. | [csCommandLine] | RUN | 0 | Nem | [omScript] |
| RWIO | Olvasás/írás ablak megjelenítése. | [csCommandLine] | RWIO instancename | 1 | Nem | [omInteractive] |
| SESC | Szkript lépésenkénti futtatása. | [csCommandLine] | SESC | 0 | Nem | [omScript] |
| SHBL | BusLogger ablak megjelenítése. | [csCommandLine, csScript] | SHBL | 0 | Igen | [omInteractive, omScript] |
| SHBM | BreakPoint Manager ablak megjelenítése. | [csCommandLine] | SHBM | 0 | Igen | [omInteractive, omScript] |
| SHHV | HexViewer ablak megjelenítése. | [csCommandLine, csScript] | SHHV instancename | 1 | Igen | [omInteractive, omScript] |
| SHIL | IntLogger ablak megjelenítése. | [csCommandLine, csScript] | SHIL | 0 | Igen | [omInteractive, omScript] |
| SHIO | I/O eszközpanel megjelenítése. | [csCommandLine, csScript] | SHIO instancename | 1 | Igen | [omInteractive, omScript] |
| SHL | A célbitek eltolása balra a megadott számmal helyben. | [csScript] | SHL count | 1 | Igen | [omScript] |
| SHME | Modulfelfedező ablak megjelenítése. | [csCommandLine] | SHME | 0 | Igen | [omInteractive] |
| SHRL | RunLogger ablak megjelenítése. | [csCommandLine, csScript] | SHRL | 0 | Igen | [omInteractive, omScript] |
| SHR | A célbitek eltolása jobbra a megadott számmal helyben. | [csScript] | SHR count | 1 | Igen | [omScript] |
| SHRV | RegViewer ablak megjelenítése. | [csCommandLine, csScript] | SHRV instancename | 1 | Igen | [omInteractive, omScript] |
| SHSC | ScriptConsole ablak megjelenítése. | [csCommandLine, csScript] | SHSC | 0 | Igen | [omInteractive, omScript] |
| SHSE | ScriptEditor ablak megjelenítése. | [csCommandLine, csScript] | SHSE | 0 | Igen | [omInteractive, omScript] |
| STEP | Szimuláció lépésenkénti futtatása. | [csCommandLine, csScript] | STEP | 0 | Nem | [omInteractive, omScript] |
| STOP | Szimuláció leállítása. | [csCommandLine, csScript] | STOP | 0 | Igen | [omInteractive, omScript] |
| STSC | Szkript leállítása. | [csCommandLine] | STSC | 0 | Igen | [omScript] |
| SUB | Érték kivonása az RA-ból helyben. | [csScript] | SUB value | 1 | Igen | [omScript] |
| SVME | Memóriatartalom mentése fájlba. | [csCommandLine, csScript] | SVME filename instancename | 2 | Nem | [omInteractive, omScript] |
| SVPR | Projekt mentése fájlba. | [csCommandLine] | SVPR filename.clprj | 1 | Nem | [omInteractive] |
| SVSC | Szkript mentése fájlba. | [csCommandLine] | SVSC filename.clsce | 1 | Nem | [omScript] |
| SWAP | Két regiszter értékének felcserélése. | [csScript] | SWAP register register | 2 | Igen | [omScript] |
| SZIO | I/O eszközpanel méretének beállítása. | [csCommandLine, csScript] | SZIO instancename width-height | 2 | Igen | [omInteractive, omScript] |
| WAIT | Várakozás a megadott milliszekundumig. | [csScript] | WAIT ms | 1 | Igen | [omScript] |
| WRIO | Érték olvasása az RA regiszterből és írása az I/O portra. | [csScript] | WRIO address | 1 | Igen | [omScript] |
| WRME | Érték olvasása az RA regiszterből és tárolása a memóriában. | [csScript] | WRME address | 1 | Igen | [omScript] |
| XOR | Bitenkénti/logikai kizáró VAGY (XOR) helyben. | [csScript] | XOR value | 1 | Igen | [omScript] |