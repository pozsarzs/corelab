# CoreLAB

## Zilog Z80 mikroprocesszor

### Megszakításkezelés

Ez a mikroprocesszor egy **NMI** (Nem maszkolható megszakítás) és egy **INT**
bemenettel rendelkezik. Az NMI letilthatatlan, az INT, a `EI` és `DI` utasításokkal
szoftveresen engedélyezhető vagy tiltható. Az INT-nek három üzemmódja van (IM0-2).

**Működési elv**  

- _NMI_: Nincs utasítás- vagy vektorátadás az adatbuszon. A CPU automatikusan a
   verembe menti a PC-t.
- _INT - IM0_: A periféria egy gépi kódú utasítást (opkódot) tesz az adatbuszra.
- _INT - IM1_: A perifériának nem kell adatot tennie a buszra. A CPU automatikusan
  generál egy belső `RST 38H` utasítást.
- _INT - IM2_: A periféria nem opkódot, hanem egy 8-bites **vektort** (alsó
  címtöredéket) ad át az adatbuszon. Ez az érték a hardveres konvenciók miatt
  általában páros szám.

**Átadható opkódok/vektor**  

- _NMI_: nincs
- _INT - IM0_: Bármilyen érvényes utasítás, de szinte kizárólag az egybájtos
  `RST` hívásokat használják.
- _INT - IM1_: nincs
- _INT - IM2_: vektor

**Ugrási címek**  

- _NMI_: Fix `$0066`.
- _INT - IM0_: `$0000`, `$0008`, `$0010`, `$0018`, `$0020`, `$0028`, `$0030`, `$0038`.
- _INT - IM1_: Fix `$0038`.
- _INT - IM2_: A CPU egy 16-bites mutatót képez úgy, hogy a felső bájt a dedikált
  `I` (Interrupt) regiszterből jön, az alsó bájt pedig a buszról kapott vektor. A
  CPU kiolvassa az ezen a 16-bites címen (és a következőn) tárolt értéket, és
  erre a kiolvasott memóriacímre ugrik. Rendelkezésre áll egy teljes, 128 elemű
  megszakítási vektortábla bárhol a memóriában.
