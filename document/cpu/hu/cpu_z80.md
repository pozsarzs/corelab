# CoreLAB

## Zilog Z80 mikroprocesszor

### Műszaki paraméterek

|Paraméter                            |Specifikáció                                                                            |
|-------------------------------------|----------------------------------------------------------------------------------------|
|**Megjelenés dátuma**                |1976. július                                                                            |
|**Gyártástechnológia**               |4 µm NMOS szilíciumkapus                                                                |
|**Tranzisztorszám**                  |~8 500                                                                                  |
|**Architektúra**                     |Neumann                                                                                 |
|**Adatbusz szélessége**              |8 bites                                                                                 |
|**Címbusz szélessége**               |16 bites                                                                                |
|**Órajel-frekvencia**                |2,5 MHz (Z80), legfeljebb 4 MHz (Z80A)                                                  |
|**Maximálisan címezhető memória**    |64 KB                                                                                   |
|**Maximálisan címezhető I/O-terület**|256 port (8 bites I/O-címtér)                                                           |
|**Verem**                            |Külső, RAM-alapú, veremmutatón keresztül.                                               |
|**Általános célú regiszterek**       |A, F, B, C, D, E, H, L, A', F', B', C', D', E', H', L'                                  |
|**Speciális regiszterek**            |PC, SP, IX, IY, I, R                                                                    |
|**Megszakításkezelés**               |Maszkolható INT és nem maszkolható NMI; három maszkolható megszakítási mód (IM 0, 1, 2).|

**Jelölések:**

* **S** - Előjeljelző
* **Z** - Zérusjelző
* **Y** - Y jelző, nem dokumentált
* **H** - Félátvitel-jelző
* **X** - X jelző, nem dokumentált
* **P** - Paritás-/túlcsordulásjelző
* **N** - Összeadás/kivonás jelző
* **C** - Átviteljelző

### OpCode-ok

- `/`: a művelet végrehajtódik/nem hajtódik végre.
- `*`: alternatív opkódok; nem használhatók.
- `d8` vagy `d16`: 8 vagy 16 bites közvetlen adat.
- `a16`: 16 bites memória-cím.
- `r8`: 8 bites előjeles adat, amely hozzáadódik a PC, IX vagy IY értékéhez.

### Műveleti kódok

|műv. kód|mnemonik |méret|ciklus|jelző|
|:------:|:--------|----:|-----:|-----|
