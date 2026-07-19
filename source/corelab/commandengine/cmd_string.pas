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
