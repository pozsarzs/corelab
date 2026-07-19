cmp
everywhere
cmp   - Compare target with value by subtraction and set flags without modifying target.

0 (OK / True / Zero): A parancs sikeresen lefutott, a vizsgált feltétel igaz, vagy az aritmetikai művelet eredménye 0 lett.

1 (False / Non-zero): A feltétel hamis, vagy a művelet eredménye nem nulla.

-1 (Error): Hiba történt (pl. nem létező objektum, érvénytelen memória-címzés, nullával osztás).

A jump paraméterezési lehetőségei:
1. Röviden, közvetlen értékkel:

jump target_label 0 – Ugrás, ha a legutolsó parancs exit code-ja 0 (sikeres / igaz / nulla).

jump target_label !0 – Ugrás, ha NEM 0 (vagy nz, mint non-zero).

2. Relációs operátorokkal (a teljes rugalmasságért):

jump error_handler < 0 – Ugrás hiba esetén (bármilyen negatív exit code).

jump target == 1 – Ugrás konkrét visszatérési értékre.

Így egyszerűsödnek a korábbi parancsok:
inrange rA 10 20
Nem kell neki célváltozó. Ha a tartományban van, 0-val tér vissza, ha nincs, 1-gyel. Utána közvetlenül: jump ok_label 0.

dec rCounter
Ha a csökkentés után a regiszter értéke 0 lett, a parancs exit code-ja 0, egyébként 1. Ciklushoz utána közvetlenül: jump loop_start !0.

strfind str1 "x" idx_var
Ha megtalálta a részszöveget: exit code 0 (az index pedig megy a változóba). Ha nincs benne: exit code 1.

load "rom.bin" into mem1
Ha sikeres a fájlbetöltés: 0. Ha nem létezik a fájl: -1. Utána közvetlenül: jump file_error < 0.


Egyik sem felesleges, de a goto feltételes ugrás része kiváltható külön if blokkokkal, ha a szkriptnyelv támogatja a strukturált vezérlést (bár assembly-szerű környezetben a feltételes jump teljesen természetes). A ver integrálható lenne az info-ba is, de külön hagyományosabb.

date
everywhere
date [into ] - Display current system date/time or store it in a variable.

exit
everywhere
exit [code] - Terminate the shell, script, or simulation environment.

goto
scriptonly
goto  [if ] - Jump execution to a label, optionally with an inline condition.

help
interactive
help [command] - Display general help overview or detailed usage for a specific command.

input
scriptonly
input  [prompt] - Print prompt and read user input into a variable.

pause
everywhere
pause [ms|key] - Suspend execution for a specified number of milliseconds or until a keypress.

print
everywhere
print <message|value...> - Output text, variables, or expressions to the console.

ver
interactive
ver - Display CoreLAB version, build info, and copyright.



**Data management**

A let teljesen felesleges, mivel a korábban definiált set parancs pontosan ezt a funkciót látja el (vagy a BASIC stílusú direkt értékadás: var = 10, arr[0] = 5). A chr és ord hasznosak konverzióhoz, bár összevonhatók lennének a korábbi conv vagy egy általános típuskonvertáló parancsba. A clear, fill és swp nagyon praktikusak memóriával és tömbökkel való low-level munkához.

chr
scriptonly
chr  - Convert integer/byte value to its ASCII character representation in-place.

clear
everywhere
clear  - Zero out an array, memory range, or buffer in-place.

fill
everywhere
fill   [count] - Fill an array or memory range with a specific byte/character value.

let
scriptonly
let  =  - Assign value to variable or array element (redundant: use set or direct assignment instead).

ord
scriptonly
ord  - Convert ASCII character to its integer/byte value in-place.

swp
everywhere
swp   - Swap the values of two registers, variables, or memory cells.


**String handler**
A strins és a strrepl kiváltható lenne a strdel + concat kombinációval, vagy a set (indexelt értékadás) segítségével, de szkriptnyelvben kényelmesebb, ha megmaradnak. Az stritem önálló parancsként felesleges, ha a változók indexelhetők (pl. get str[2] into var), egyébként egy általános substr (részszöveg kivétele) hasznosabb helyette. A többi indokolt.

concat
scriptonly
concat   - Append string to target in-place (e.g., concat str1 " text").

length
scriptonly
length   - Store the length of string into a variable (e.g., length str1 len_var).

lowcase
scriptonly
lowcase  - Convert target string to lowercase in-place.

strdel
scriptonly
strdel   [count] - Delete characters from target starting at index in-place.

strfind
scriptonly
strfind    - Find index of substring in string and store result in var (-1 if not found).

strins
scriptonly
strins    - Insert substring into target at specified index in-place.

stritem
scriptonly
stritem    - Get character at index into var (redundant if array/string indexing is supported).

strrepl
scriptonly
strrepl  <old_str> <new_str> - Replace occurrences of old_str with new_str in target in-place.

upcase
scriptonly
upcase  - Convert target string to uppercase in-place.


**Arithmetic**
abs
everywhere
abs  - Replace target value with its absolute value in-place (e.g., abs rA).

add
everywhere
add   - Add value to target in-place (e.g., add rA 0x10).

conv
interactive
conv  [to <BIN|DEC|HEX|OCT>] - Convert and print number in different base formats (useful for debugging).

dec
everywhere
dec  [count] - Decrement integer target by 1 or by count in-place (e.g., dec rB).

div
everywhere
div   - Perform floating-point division on target in-place (e.g., div var1 2.5).

idiv
everywhere
idiv   - Perform integer division on target in-place (e.g., idiv rA 4).

imod
everywhere
imod   - Calculate integer division remainder and store in target (e.g., imod rA 10).

inc
everywhere
inc  [count] - Increment integer target by 1 or by count in-place (e.g., inc rB).

mul
everywhere
mul   - Multiply target by value in-place (e.g., mul rA 2).

sub
everywhere
sub   - Subtract value from target in-place (e.g., sub rA 0x05).



Tartományvizsgálat (inrange – ha külön parancs marad):
Szintaxis: inrange <vizsgált_érték> <min> <max> [cél_változó]
Működés: Ha megadsz célváltozót, abba ír 1 (igaz) vagy 0 (hamis) értéket. Ha nem adsz meg (pl. interaktív módban), csak kiírja az eredményt a konzolra.
Példa: inrange rA 0x10 0x20 flag_var

**Logic**
and
everywhere
and   - Bitwise/logical AND. Stores result in target (e.g., and rA 0x0F).

inrange
scriptonly
inrange    [into ] - Check if value is between min and max, store boolean in var (redundant as standalone command).

not
everywhere
not  - Bitwise/logical NOT. Inverts all bits of target in-place (e.g., not rB).

or
everywhere
or   - Bitwise/logical OR. Stores result in target (e.g., or var1 0x80).

shl
everywhere
shl   - Shift target bits left by count in-place (e.g., shl rA 2).

shr
everywhere
shr   - Shift target bits right by count in-place (e.g., shr rA 1).

xor
everywhere
xor   - Bitwise/logical XOR. Stores result in target (e.g., xor rA rB).

**Object Management**

create
scriptonly
create   [params...] - Instantiate a hardware module, variable, or array.

destroy
everywhere
destroy  - Delete an object and free its memory.

attach
scriptonly
attach  to <bus|cpu> [at ] - Connect a hardware module to the bus.

detach
everywhere
detach  - Disconnect a module from the bus.

set
everywhere
set   - Write a value to a state, register, memory cell, or variable.

get
everywhere
get  [into ] - Read a state, register, or memory cell.

reset
everywhere
reset [target] - Restore a hardware module or the whole system to default state.

load
everywhere
load  into  [at ] - Load binary data or state from a file.

save
everywhere
save  to  [from  size ] - Save state or memory dump to a file.

info
everywhere
info [target] - Display metadata of an object, or list all objects if no target is given.

show
interactive
show <topology|modules|memory> - Display system overview or object lists.


**Simulation control**

run
everywhere
run [cpu_id] [until <cycles|time>] - Start execution, optionally up to a target limit.

step
everywhere
step [count] [cpu_id] - Execute a specific number of instructions (default: 1).

stop
everywhere
stop [cpu_id] - Halt execution (essential interactively or in async scripts).

