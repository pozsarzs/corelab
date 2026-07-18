# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Command line engine

|filename            |base, parent|class            |description                       |
|--------------------|------------|-----------------|----------------------------------|
|chkcommandengine.pas|            |                 |Class checker program             |
|cmd\_data.pas       |TCommand    |TCmd\_commandname|Data handler command classes      |
|cmd\_general.pas    |TCommand    |TCmd\_commandname|General command classes           |
|cmd\_logic.pas      |TCommand    |TCmd\_commandname|Logical command classes           |
|cmd\_math.pas       |TCommand    |TCmd\_commandname|Arithmetical command classes      |
|cmd\_object.pas     |TCommand    |TCmd\_commandname|Object handler command classes    |
|cmd\_sim.pas        |TCommand    |TCmd\_commandname|Simulation control command classes|
|cmd\_string.pas     |TCommand    |TCmd\_commandname|String handler command classes    |
|cmd\_test.pas       |TCommand    |TCmd\_commandname|Test command classes              |
|command.pas         |            |TCommand         |Command class                     |
|commandcontext.pas  |            |TCommandContext  |Command context class             |
|commandengine.pas   |            |TCommandEngine   |Command line engine class         |
|commandparser.pas   |            |TCommandParser   |Command parser class              |
|commandregistry.pas |            |TCommandRegistry |Command registry class            |
|token.pas           |            |TToken           |Token class                       |
