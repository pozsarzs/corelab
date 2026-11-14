## Intel 4002 RAM – magyar leírás

### Műszaki paraméterek

|Paraméter                 |Jellemző                                                                          |
|--------------------------|----------------------------------------------------------------------------------|
|**Megjelenés éve**        |1971                                                                              |
|**Gyártástechnológia**    |P-csatornás, szilíciumkapus PMOS                                                  |
|**Memória típusa**        |RAM, belső frissítő áramkörrel                                                    |
|**Memóriakapacitás**      |320 bit (4 × 20 × 4 bites karakter)                                               |
|**Memóriaszervezés**      |4 regiszter; regiszterenként 16 adat- és 4 státuszkarakter                        |
|**Kimeneti port**         |4 bites, pufferelt kimeneti port (O0–O3)                                          |
|**Adatbusz**              |4 bites, kétirányú és multiplexelt                                                |
|**Chipkiválasztás**       |4002-1 / 4002-2 fémmaszk-változat és P0 láb; 4 chipszám a kiválasztott RAM-bankban|
|**Tokozás**               |16 lábú DIP                                                                       |
|**Rendszerkompatibilitás**|Intel MCS-4 / MCS-40                                                              |
|**Időzítőjelek**          |φ1, φ2 és SYNC, a rendszertől érkeznek                                            |
|**Tápfeszültség**         |VDD = −15 V a VSS ponthoz képest                                                  |
|**Elsődleges feladat**    |Adattárolás és perifériák kimeneti vezérlése                                      |

### Leírás

Az Intel 4002 egy 320 bites RAM, amelyet az MCS-4 mikroszámítógép-rendszerhez terveztek. A memória négy regiszterből áll, regiszterenként húsz darab 4 bites karakterrel: tizenhat adatkarakterrel és négy státuszkarakterrel. Az adatkarakterek az SRC utasítással címezhetők, míg a státuszkaraktereket az I/O vagy RAM utasítás OPA mezője választja ki.

A RAM mellett a 4002 egy négybites kimeneti portot is tartalmaz, O0–O3 jelű pufferelt kimenetekkel. A processzortól érkező adatot a kimeneti regiszterek tárolják, így a kimenetek a port betöltése után is stabilak maradnak. A port a CPU és a külső eszközök közötti adatátvitelre szolgál; kizárólag kimeneti port.

Az áramkör a processzorral a rendszer négyszeres, kétirányú, multiplexelt adatbuszán keresztül kommunikál. A RAM celláinak adattartalmát belső frissítő áramkör tartja fenn. A 4002-1 és 4002-2 fémmaszk-változat, valamint a külső P0 láb négyféle chipkiválasztást tesz lehetővé az aktuálisan kiválasztott RAM-bankon belül. Az áramkör 16 lábú DIP tokban készült, és a rendszer kétfázisú órajelét, valamint SYNC jelét használja.
