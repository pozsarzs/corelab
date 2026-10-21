# CoreLAB - Súgó

## 8. Hibaelhárítás

Az alábbi táblázat a CoreLAB használata során felmerülő leggyakoribb hibaüzeneteket és figyelmeztetéseket, valamint azok lehetséges okait és megoldásait tartalmazza.

| Hiba / Figyelmeztetés | Lehetséges ok / Teendő |
|---|---|
| A bővítmények könyvtára nem létezik. | Ellenőrizze a bővítmények könyvtárának elérési útját, vagy győződjön meg arról, hogy az alapértelmezett `library` mappa létezik. |
| Nem sikerült betölteni a bővítményeket innen: [path]. | A megadott könyvtár üres lehet, vagy a bővítményfájlok sérültek, esetleg nem kompatibilisek. |
| Hiányzó súgófájl. / Hiányzó súgómegjelenítő. | Ellenőrizze, hogy a `corelab_en.chm` (vagy lokalizált) fájl és az `lhelp` megjelenítő elérhető-e a rendszer elérési útján (path) vagy az alkalmazás könyvtárában. |
| A(z) '[name]' nevű csatolt modul nem semmisíthető meg. | Megsemmisítés előtt le kell választania a modult a rendszerbuszról. |
| A(z) '[command]' nem használható interaktív/szkript módban. | A végrehajtott parancs a másik működési módra van korlátozva. Váltson módot, és próbálja újra. |
| A(z) '[command]' parancs nem elérhető a szimuláció futása közben. | A konfigurációs vagy modulkezelő parancsok használata előtt állítsa le a szimuláció végrehajtását. |
| A(z) '[name]' nevű modul már létezik. | A modulpéldányok nevének egyedinek kell lennie. Válasszon másik nevet az új modulhoz. |
| A(z) '[name]' nevű modul nem létezik. | Ellenőrizze a példány nevének helyesírását a parancsban vagy a szkriptben. |
| Nem hozható létre a(z) '[name]' nevű modul. | Előfordulhat, hogy a bővítmény hiányzik vagy nem sikerült inicializálni. Ellenőrizze az elérhető betöltött bővítményeket. |
| A(z) '[name]' nevű modul már csatolva van. | A modul már csatlakoztatva van a rendszerbuszhoz. |
| Csak egyetlen processzorkapcsolat engedélyezett. | A CoreLAB jelenleg egyszerre csak egy CPU modul rendszerbuszhoz történő csatlakoztatását támogatja. |
| Nem sikerült a memóriatartalmat betölteni/kimenteni. | Ellenőrizze a fájlengedélyeket, győződjön meg arról, hogy a fájlformátum (BIN/HEX) megfelelő, és ellenőrizze az Intel HEX fájlok ellenőrzőösszegét (checksum). |
| A(z) '[name]' tulajdonság csak olvasható vagy nem létezik. | Ellenőrizze a tulajdonság nevének helyesírását. Egyes tulajdonságok manuálisan nem módosíthatók. |
| A(z) '[value]' érték hibás. | Győződjön meg arról, hogy a megadott érték megfelelő formátumú (pl. helyes hexadecimális szintaxis vagy logikai (boolean) értékek). |
| Nem sikerült betölteni/kimenteni a projektet a(z) [file] fájlból/fájlba. | Győződjön meg arról, hogy rendelkezik a szükséges olvasási/írási jogosultságokkal, és a fájl érvényes `.clprj` formátumú. |
| Nem sikerült betölteni/kimenteni a szkriptet a(z) [file] fájlból/fájlba. | Ellenőrizze a fájlengedélyeket, és győződjön meg arról, hogy érvényes `.clsce` szkriptfájlról van szó. |
