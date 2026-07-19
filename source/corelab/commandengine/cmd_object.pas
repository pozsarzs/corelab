{ Object Management Commands:

  name: 	CRTE
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CRTE $target type
  example:	CRTE	$MY8008	TCPU

  name: 	DEST
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	ATTH
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	DETH
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	GETP
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]
  example:	GETP	$target	$MY8008.HasPanel

  name: 	SETP
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]
  example:	SETP	$source	$MY8008.PanelTitle

  name: 	RSET
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	LDST
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]

  name: 	SVST
  description:	Convert byte size value to its ASCII character representation.
  scope:	csScriptOnly
  flags:	
  exitcode:	always zero
  syntax:	CHR $target|$target[n] value|$source|$source[n]




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

