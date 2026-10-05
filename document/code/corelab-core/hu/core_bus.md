# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## ISysBus a core_bus modulból

`ISysBus` a CoreLAB rendszersín-interfésze. Meghatározza a memória- és I/O-
műveleteket, amelyekkel a CPU a rendszersínen keresztül kommunikál a memóriával és az I/O-port eszközökkel.


A forrás az interfészt a CPU és az eszközök közötti kapcsolatként azonosítja, amely a `TCPU` osztálytól a
`TIOPort`, illetve `TMemory` között.

### Interfészmetódusok

|név                                                     |leírás                                                                                                                                      |
|--------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
|`function ReadMemory(AAddress: DWord): QWord;`          |Kiolvassa az `AAddress` által megadott memóriacímen található értéket. A forrás szerint ezt a műveletet kizárólag a `TMemory` valósítja meg.|
|`procedure WriteMemory(AAddress: DWord; AValue: QWord);`|Kiír egy értéket az `AAddress` által megadott memóriacímre. A forrás szerint ezt a műveletet kizárólag a `TMemory` valósítja meg.           |
|`function ReadPort(APort: Word): Byte;`                 |Kiolvas egy bájtot a megadott I/O-portról. A forrás szerint ezt a műveletet kizárólag a `TIOPort` valósítja meg.                            |
|`procedure WritePort(APort: Word; AValue: Byte);`       |Kiír egy bájtot a megadott I/O-portra. A forrás szerint ezt a műveletet kizárólag a `TIOPort` valósítja meg.                                |

### Interfészazonosító

Az `ISysBus` GUID-azonosítója:

`{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}`

### Használat

A forrás megjegyzése szerint az `ISysBus` biztosítja a kommunikációs útvonalat a `TCPU` és a
`TIOPort`, illetve `TMemory` között.

A `TBus` megvalósítja az `ISysBus` interfészt, így biztosítja ezeknek a műveleteknek a rendszerszintű megvalósítását.

