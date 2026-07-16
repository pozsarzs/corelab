# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Command line engine

|filename            |base, parent|class             |description            |
|--------------------|------------|------------------|-----------------------|
|chkcommandengine.pas|            |                  |Class checker program  |
|cmd_data.pas        |TCommand    |TCmd__commandname_|                       |
|cmd_general.pas     |TCommand    |TCmd__commandname_|                       |
|cmd_logic.pas       |TCommand    |TCmd__commandname_|                       |
|cmd_math.pas        |TCommand    |TCmd__commandname_|                       |
|cmd_object.pas      |TCommand    |TCmd__commandname_|                       |
|cmd_sim.pas         |TCommand    |TCmd__commandname_|                       |
|cmd_string.pas      |TCommand    |TCmd__commandname_|                       |
|commandcontext.pas  |            |TCommandContext   |                       |
|commandengine.pas   |            |TCommandEngine    |                       |
|commandinit.pas     |            |                  |                       |
|commandparser.pas   |            |TCommandParser    |                       |
|command.pas         |            |TCommand          |                       |
|commandregistry.pas |            |TCommandRegistry  |                       |
|token.pas           |            |TToken            |                       |
