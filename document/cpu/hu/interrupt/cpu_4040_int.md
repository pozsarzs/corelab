# CoreLAB

## Intel 4040 mikroprocesszor

### Megszakításkezelés

**Működési elv**

A 4040 egyetlen hardveres megszakítási bemenettel rendelkezik (**INTERRUPT** láb).
A megszakítás szoftveresen az `ENI` (Enable Interrupt) utasítással engedélyezhető
és a `DIN` (Disable Interrupt) utasítással tiltható. A megszakítás elfogadásakor
a CPU befejezi a folyó utasítást, majd automatikusan a kibővített (7 szintű)
belső hardveres verembe menti a programszámlálót (PC).

**Átadható opkódok**

A 4040 nem olvas be sem opkódot, sem megszakítási vektort az adatbuszról az
eljárás során. A folyamat teljesen belső és hardveresen "beégetett".

**Ugrási címek**

A processzor fixen a ROM `$003` címére ugrik, és innen kezdi meg a megszakítási
rutin végrehajtását.

**Állapotmentés**

Automatikus regiszter- vagy flagmentés nincs (csak a PC mentődik), így ezek
szoftveres megőrzéséről a programozónak kell gondoskodnia. A megszakítási
rutinból való visszatéréshez a 4040-ben újonnan bevezetett `BBS` utasítást kell
használni. Ez nemcsak a veremből tölti vissza a hívás előtti PC-t, hanem
hardveresen törli az `INTA` (Interrupt Acknowledge) állapotot is, amivel újra
szabaddá teszi az utat a következő megszakítások számára.
