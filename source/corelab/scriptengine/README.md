# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Command engine class for script handler

|filename          |base, parent  |class         |description              |
|------------------|--------------|--------------|-------------------------|
|cmd-access.pas    |              |(include file)|Data access commands     |
|cmd-arithmetic.pas|              |(include file)|Arithmetic commands      |
|cmd-control.pas   |              |(include file)|Control commands         |
|cmd-logic.pas     |              |(include file)|Logic commands           |
|cmd-other.pas     |              |(include file)|Other commands           |
|scriptengine.pas  |TCommandEngine|TScriptEngine |Script engine class      |
|scriptruntime.pas |              |TScriptRuntime|Runtime environment class|
