# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Command engine class for command line

|filename            |base, parent|class            |description              |
|--------------------|------------|-----------------|-------------------------|
|cmd-f.pas           |            |(include file)   |File menu commands       |
|cmd-io.pas          |            |(include file)   |I/O port menu commands   |
|cmd-m.pas           |            |(include file)   |Memory menu commands     |
|cmd-o.pas           |            |(include file)   |Operation menu commands  |
|cmd-p.pas           |            |(include file)   |Processor menu commands  |
|cmd-v.pas           |            |(include file)   |Viewer menu commands     |
|command.pas         |            |TCommand         |Command class            |
|commandengine.pas   |            |TCommandEngine   |Command line engine class|
|commandregistry.pas |            |TCommandRegistry |Command registry class   |
|commandparser.pas   |            |TCommandParser   |Command parser class     |
|token.pas           |            |TToken           |Token class              |
