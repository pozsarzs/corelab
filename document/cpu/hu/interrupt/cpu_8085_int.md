# CoreLAB

## Intel 8085 mikroprocesszor

### Megszakításkezelés

**Működési elv**

A 8085 öt dedikált megszakítási bemenettel rendelkezik, beépített prioritási
sorrenddel: **TRAP** (legmagasabb) > **RST 7.5** > **RST 6.5** > **RST 5.5** >
**INTR** (legalacsonyabb), közülük a TRAP nem maszkolható (NMI). Az RST 5.5,
6.5 és 7.5 egyenként engedélyezhető vagy tiltható a szoftveres megszakítás-maszk
segítségével (`SIM` utasítás). Az INTR és az RST 5.5-7.5 globálisan is letiltható
a `DI` utasítással.

**Átadható opkódok**

Csak az INTR bemenet vár külső utasítást: ez pontosan úgy működik, mint a 8080
megszakítása. A megszakításvezérlő hardvernek kell egy utasítást (jellemzően
`RST n` vagy 3 bájtos `CALL`) a buszra tennie.

A TRAP és az RST 5.5/6.5/7.5 esetében nincs átadott opkód. A CPU az adatbusz
beolvasása nélkül, belsőleg generál egy szubrutinhívást, automatikusan a verembe
mentve a programszámlálót (PC).

**Ugrási címek**

A dedikált hardveres megszakítások (opkód nélküli, belső) ugrási címei:

* TRAP:    `$0024`
* RST 5.5: `$002C`
* RST 6.5: `$0034`
* RST 7.5: `$003C`

Az INTR bemeneten átadott (vagy a programkódból szoftveresen meghívott)
hagyományos 1 bájtos RST utasítások címei megegyeznek a 8080-as processzoréval:

* RST 0: `$0000`
* RST 1: `$0008`
* RST 2: `$0010`
* RST 3: `$0018`
* RST 4: `$0020`
* RST 5: `$0028`
* RST 6: `$0030`
* RST 7: `$0038`
