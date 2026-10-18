# CoreLAB - Súgó

## 8. Hibaelhárítás

Az alábbi táblázat a CoreLAB használata során felmerülő leggyakoribb hibaüzeneteket és figyelmeztetéseket, valamint azok lehetséges okait és megoldásait tartalmazza.

| Hiba / Figyelmeztetés | Lehetséges ok / Teendő |
|---|---|
| Plugin directory does not exist. | Ellenőrizze a bővítmények könyvtárának elérési útját, vagy győződjön meg arról, hogy az alapértelmezett `library` mappa létezik. |
| Cannot load plugins from [path]. | A megadott könyvtár üres lehet, vagy a bővítményfájlok sérültek, esetleg nem kompatibilisek. |
| Missing help file. / Missing help viewer. | Ellenőrizze, hogy a `corelab_en.chm` (vagy lokalizált) fájl és az `lhelp` megjelenítő elérhető-e a rendszer elérési útján (path) vagy az alkalmazás könyvtárában. |
| Cannot destroy attached module named '[name]'. | Megsemmisítés előtt le kell választania a modult a rendszerbuszról. |
| Cannot be used '[command]' in interactive/script mode. | A végrehajtott parancs a másik működési módra van korlátozva. Váltson módot, és próbálja újra. |
| Command '[command]' is not available while simulation is running. | A konfigurációs vagy modulkezelő parancsok használata előtt állítsa le a szimuláció végrehajtását. |
| Module named '[name]' exists. | A modulpéldányok nevének egyedinek kell lennie. Válasszon másik nevet az új modulhoz. |
| Module named '[name]' not exists. | Ellenőrizze a példány nevének helyesírását a parancsban vagy a szkriptben. |
| Cannot create module named '[name]'. | Előfordulhat, hogy a bővítmény hiányzik vagy nem sikerült inicializálni. Ellenőrizze az elérhető betöltött bővítményeket. |
| Module named '[name]' has been already attached. | A modul már csatlakoztatva van a rendszerbuszhoz. |
| Only one CPU connection is allowed. | A CoreLAB jelenleg egyszerre csak egy CPU modul rendszerbuszhoz történő csatlakoztatását támogatja. |
| Cannot load/save memory content... | Ellenőrizze a fájlengedélyeket, győződjön meg arról, hogy a fájlformátum (BIN/HEX) megfelelő, és ellenőrizze az Intel HEX fájlok ellenőrzőösszegét (checksum). |
| Property '[name]' is read only or not exists. | Ellenőrizze a tulajdonság nevének helyesírását. Egyes tulajdonságok manuálisan nem módosíthatók. |
| Value '[value]' is bad. | Győződjön meg arról, hogy a megadott érték megfelelő formátumú (pl. helyes hexadecimális szintaxis vagy logikai (boolean) értékek). |
| Cannot load/save project from [file]. | Győződjön meg arról, hogy rendelkezik a szükséges olvasási/írási jogosultságokkal, és a fájl érvényes `.clprj` formátumú. |
| Cannot load/save script to [file]. | Ellenőrizze a fájlengedélyeket, és győződjön meg arról, hogy érvényes `.clsce` szkriptfájlról van szó. |
