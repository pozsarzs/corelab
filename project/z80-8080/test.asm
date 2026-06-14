A program beolvassa a 8 darab bájtot a $4096$ ($1000\text{h}$) címtől, mindegyikhez hozzáadja a saját sorszámát (egyfajta transzformációként), majd az eredményeket fordított sorrendben menti el a $4104$ ($1008\text{h}$) címtől kezdve.


ORG 0000h           ; A program a ROM elejéről, a 0000h címtől indul

START:
    LXI SP, 2000h   ; Veremmutató beállítása a RAM-ba (biztonsági okokból)

    ; Regiszterek előkészítése a másoláshoz és átalakításhoz
    LXI H, 1000h    ; HL = Forrás cím (4096 = 1000h)
    LXI D, 100Fh    ; DE = Cél cím vége (4104 + 7 = 410Fh) -> visszafele töltjük
    MVI C, 8        ; C  = Ciklusszámláló (8 adat)
    MVI B, 0        ; B  = Transzformációs érték (0-7)

LOOP:
    MOV A, M        ; Aktuális adat beolvasása a forrásból (HL)
    ADD B           ; Transzformáció: hozzáadjuk a sorszámot (B)
    
    STAX D          ; Eredmény mentése a cél címre (DE)
    
    INX H           ; Forrás cím növelése
    DCX D           ; Cél cím csökkentése (fordított sorrend miatt)
    INR B           ; Transzformációs érték növelése
    
    DCR C           ; Ciklusszámláló csökkentése
    JNZ LOOP        ; Ha C nem 0, folytatjuk a ciklust

HALT_LOOP:
    HLT             ; Program leállítása
    JMP HALT_LOOP   ; Biztonsági végtelen ciklus

; A kód mérete elhanyagolható (kb. 20-25 bájt), 
; így bőven a 4 kB-os limiten (1000h méret) belül van.