{ Data management commands:

  name: 	CHR
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	SET $target 
  description:	Create variable and/or assign value to variable or array element.
  scope:	csScriptOnly
  exitcode:	always zero
  syntax:	SET $target|$target[n] value|$source|$source[n]

  name: 	FLL
  description:	Fill an array with a specific byte value.
  scope:	csScriptOnly
  exitcode:	always zero
  syntax:	FLL target value|$variable|$array[n]

  name: 	ORD
  description:	Convert ASCII character to its byte value.
  scope:	csScriptOnly
  exitcode:	always zero
  syntax:	ORD $target|$target[n] value|$source|$source[n]

  name: 	SWP
  description:	Swap the values of two variables.
  scope:	csScriptOnly
  exitcode:	
  syntax:	SWP $variable1|$array1[n] $variable2|$array2[n]

  Note:
  - value:      numerical value
  - "value":	string
  - variable:	variable  
  - $variable:	value of variable  

  Exit codes:
  - 0   	Success
  - 1..9	1: Általános hiba, 2: Rossz paraméterszám, 3: Érvénytelen szintaxis
  - 10..19	Data & Variable Errors	10: Nem létező változó, 11: Típushiba, 12: Írásvédett / konstans cél, 13: Indexhiba / tömbhatár
  - 20..29	Simulation & Hardware Errors	20: Nem létező modul/CPU, 21: Buszhiba, 22: Érvénytelen cím/port

}

