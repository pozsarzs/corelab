" Vim syntax file
" Language:     CoreLAB scriptembly
" Maintainer:   Pozsar Zsolt <pozsarzs@gmail.com>
" Last Change:  2026 Jul 23

if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

" instructions:
syn keyword corelabStatement ADD AND ATIO ATME ATPU BIT CALL CFIO CFME CFPU CHWD COMP CONV CRIO CRME CRPU DEC DIIO DIME DIPU DSIO DSME DSPU DTIO DTME DTPU EDME END ENIO ENME ENPU EXAP EXIT HELP INC INRG JPCA JPNC JPNZ JPZE JUMP LDME LDPR LDRG LDSC MUL MVIO NMI NOT NWPR NWSC OR PRNT RDIO RDME RNIO RSAP RSIO RSME RSPU RST RTRN RUN RUSC RWIO SESC SHBL SHBM SHHV SHIL SHIO SHL SHME SHR SHRL SHRV SHSC SHSE STEP STOP STSC SUB SVME SVPR SVSC SWAP SZIO WAIT WRIO WRME XOR

" registers:
syn match   corelabConstant "\$R[0-9A-F]"

" strings:
syn region  corelabString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=corelabStringEscape
syn match   corelabStringEscape contained '""'

" preprocessor commands:
syn match   corelabPreProc "^\s*#!.*corelab.*$"
syn match   corelabPreProc "^\s*@corelab\(\.exe\)\?.*$"
syn match   corelabPreProc "^\s*@goto.*$"
syn match   corelabPreProc "^\s*:eof.*$"

" comments:
syn match   corelabComment ";.*$"

" parent classes:
syn case match
syn match corelabType "\<T[A-Z]\w*\>"

hi def link corelabStatement    Statement
hi def link corelabDevice       Special
hi def link corelabType         Type
hi def link corelabOperator     Operator
hi def link corelabConstant     Constant
hi def link corelabIdentifier   Identifier
hi def link corelabString       String
hi def link corelabStringEscape SpecialChar
hi def link corelabPreProc      PreProc
hi def link corelabComment      Comment

let b:current_syntax = "corelab"
