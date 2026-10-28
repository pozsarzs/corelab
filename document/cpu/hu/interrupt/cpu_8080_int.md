# CoreLAB

## Intel 8080 mikroprocesszor

### Megszakításkezelés

**Működési elv**

A 8080-nak egyetlen hardveres megszakítási módja van (ez felel meg a Z80-as
"IM 0" módjának). Ha a megszakítások engedélyezve vannak (`EI` utasítás után),
és az **INT** lábon jelzés érkezik, a CPU megszakítja a normál futást. A memóriából
történő olvasás helyett a CPU `INTA` (Interrupt Acknowledge) ciklust indít, és
az adatbuszról olvassa be a végrehajtandó utasítást. A megszakítás elfogadásakor
a megszakítás-engedélyezés automatikusan letiltódik (mintha egy `DI` utasítás
futott volna le).

**Átadható opkódok**

* Bármilyen érvényes 8080-as utasítás bejuttatható a processzorba.
* Leggyakrabban 1 bájtos utasításokat alkalmaznak, mert a hardveres vezérlés
  így a legegyszerűbb.
* Többbájtos utasítás (pl. egy 3 bájtos `CALL a16`) is átadható. Ilyenkor
  a megszakításvezérlő hardvernek (például egy Intel 8259-nek) kell a CPU
  megfelelő olvasási ciklusaihoz igazodva a 2. és 3. bájtot a buszra tennie.

**Ugrási címek**

Ha a megszakítási hardver egybájtos utasítást ad át, az szinte kizárólag az
`RST` (Restart). Ez automatikusan a verembe (Stack) menti a programszámlálót,
majd 8 darab, hardveresen rögzített nulláslap-cím valamelyikére ugrik:

* RST 0: `$0000` (Opkód: `$C7`)
* RST 1: `$0008` (Opkód: `$CF`)
* RST 2: `$0010` (Opkód: `$D7`)
* RST 3: `$0018` (Opkód: `$DF`)
* RST 4: `$0020` (Opkód: `$E7`)
* RST 5: `$0028` (Opkód: `$EF`)
* RST 6: `$0030` (Opkód: `$F7`)
* RST 7: `$0038` (Opkód: `$FF`)
