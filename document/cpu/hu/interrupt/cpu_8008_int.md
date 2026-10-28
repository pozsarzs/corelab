# CoreLAB

## Intel 8008 mikroprocesszor

### Megszakításkezelés

**Működési elv** 

A megszakítás (`INTR`) elfogadásakor a CPU megszakítja a normál végrehajtást,
és a memóriából történő utasításolvasás helyett az adatbuszról vesz át egy
utasítást közvetlenül a megszakítást kérő perifériától.

**Átadható opkódok**  

Elméletileg bármilyen utasítás bejuttatható a CPU-ba. A gyakorlatban szinte
kizárólag egybájtos utasításokat használnak, hogy a hardveres vezérlés egyszerű
maradjon. Többbájtos utasítás (pl. `CALL` vagy `JMP`) átadása is lehetséges, de
ehhez az azt kérő hardvernek kell a megfelelő időzítéssel a buszra helyeznie az
utasítás 2. és 3. bájtját is.

**Ugrási címek**  

A leggyakrabban átadott utasítás az `RST`. Ez egy egybájtos szubrutinhívás, amely
a hardveres verembe menti a programszámlálót (PC), majd a beépített 8 darab fix
memóriacím egyikére ugrik:

* RST 0: `$0000`
* RST 1: `$0008`
* RST 2: `$0010`
* RST 3: `$0018`
* RST 4: `$0020`
* RST 5: `$0028`
* RST 6: `$0030`
* RST 7: `$0038`

**Állapotmentés**  

A CPU az RST általi PC-mentésen kívül semmit nem csinál automatikusan. A
regiszterek (A, B, C, D, E, H, L) és a flagek mentése és visszaállítása kizárólag
a megszakítási rutin feladata.
