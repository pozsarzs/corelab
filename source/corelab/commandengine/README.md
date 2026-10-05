# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Command engine class for command line

|filename           |base, parent|class           |description              |
|-------------------|------------|----------------|-------------------------|
|reg-f.pas          |            |(include file)  |File menu commands       |
|reg-io.pas         |            |(include file)  |I/O port menu commands   |
|reg-m.pas          |            |(include file)  |Memory menu commands     |
|reg-o.pas          |            |(include file)  |Operation menu commands  |
|reg-p.pas          |            |(include file)  |Processor menu commands  |
|reg-v.pas          |            |(include file)  |Viewer menu commands     |
|command.pas        |            |TCommand        |Command class            |
|commandengine.pas  |            |TCommandEngine  |Command line engine class|
|commandregistry.pas|            |TCommandRegistry|Command registry class   |
|commandparser.pas  |            |TCommandParser  |Command parser class     |
|token.pas          |            |TToken          |Token class              |
