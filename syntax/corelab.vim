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
syn keyword corelabStatement ATIO ATME ATPU CRIO CFIO CFME CFPU CHWD CRME CRPU DIIO DIME DIPU DSIO DSME DSPU DTIO DTME DTPU EDME ENIO ENME ENPU EXAP LDME LDPR LDSC LDSS NMI NWPR NWSC RNIO RSAP RSIO RSME RSPU RST RUN RUSC RWIO SESC SHBL SHBM SHHV SHIL SHIO SHME SHRL SHRV SHSC SHSE STEP STOP STSC SVME SVPR SVSC SVSS ADD AND BIT CALL COMP CONV DEC DEPO END EXAM EXIT HELP INC INRG JPEQ JPZR JPGE JPGT JPLE JPLT JPNE JPNZ MUL NOT OR PRNT RTRN SHL SHR SUB SWAP WAIT XOR

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
