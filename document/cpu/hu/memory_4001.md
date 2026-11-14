# CoreLAB

## Intel 4001 ROM

### Műszaki paraméterek

|Paraméter                 | Jellemző                                       |
|--------------------------|------------------------------------------------|
|**Megjelenés éve**        | 1971                                           |
|**Technológia**           | PMOS                                           |
|**Memória típusa**        | Maszkolással programozható ROM                 |
|**Memóriakapacitás**      | 2048 bit (256 × 8 bites szó)                   |
|**I/O port**              | 4 konfigurálható I/O vonal                     |
|**Adatbusz**              | 4 bites, multiplexelt                          |
|**Chipkiválasztás**       | 4 bites chipszám, fémmaszkkal meghatározva     |
|**Tokozás**               | 16 lábú DIP                                    |
|**Rendszerkompatibilitás**| Intel MCS-4 / MCS-40                           |
|**Időzítőjelek**          | φ1, φ2 és SYNC, a rendszertől érkeznek         |
|**Elsődleges feladat**    | Program- és adattárolás, valamint periféria-I/O|

### Leírás

Az Intel 4001 egy maszkolással programozható ROM, amelyet az MCS-4 mikroszámítógép-rendszerhez terveztek. A memória 256 darab, egyenként 8 bites szó tárolására alkalmas, így összesen 2048 bit (2 kbit) programkód vagy adattábla tárolható benne.

A ROM mellett a chip egy négyvonalas I/O portot és a hozzá tartozó vezérlőlogikát is tartalmazza. Az egyes I/O vonalak fémmaszk-opcióval bemenetként vagy kimenetként konfigurálhatók; a közvetlen vagy invertált működés is választható. A 4001 a processzorral a rendszer négyszeres, multiplexelt adatbuszán keresztül kommunikál.

A ROM kiválasztása a fémmaszkkal meghatározott chipszám alapján történik. A szabványos rendszerben legfeljebb 16 különböző 4001-es chipszám címezhető. Az áramkör 16 lábú DIP tokban készült, és az MCS-4 rendszer kétfázisú órajelét, valamint szinkronizáló jelét használja.
