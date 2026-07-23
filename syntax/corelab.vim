" Vim syntax file
" Language:     CoreLAB scriptembly
" Maintainer:   Pozsar Zsolt <pozsarzs@gmail.com>
" Last Change:  2026 Jul 23

if exists("b:current_syntax")
  finish
endif

syn case ignore
syn sync lines=250

" keywords:
syn keyword corelabStatement ABS ADD AND APPX ASCI ATTH BIT CALL CALM CHAR COMP CONV CRTE DEC DEPO DEST DETH END EXAM EXIT FILL GETP HELP IDV IMD INC INDX INPW INRG JPEQ JPGE JPGT JPLE JPLT JPNE JPNZ JPZR 
syn keyword corelabStatement MSGW MUL NOT OR PAUS POPA PRNT PSHA RDV RSET RTRN SAPP SDEL SETP SETV SFND SHL SHR SINS SLEN SLOW SREP SSUB STEP STOP STRT SUB SUPP SWAP WAIT XOR 

" system constants:
syn match   corelabConstant "\$[?]"
syn match   corelabConstant "\$\(ARG\|ARGCNT\|DATE\|FC\|FZ\|HOME\|INSCNT\|PRJDIR\|RNDB\|RNDI\|RNDW\|TIME\|VER\)\>"

" variables:
syn match   corelabIdentifier "\$\w\+\(\.\w\+\)*\>"

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
