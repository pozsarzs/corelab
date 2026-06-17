# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Syntax highlighting

### Syntax files

|Editor            |Filename                 |Install method                                                            |  
|------------------|-------------------------|--------------------------------------------------------------------------|  
|GTKSourceView     |corelab.lang             |copy file into ~/.local/share/gtksourceview-?/language-specs/             |
|MCEdit            |Syntax                   |insert file content to top of ~/.local/share/mc/Syntax                    |
|                  |corelab.syntax           |copy file into ~/.local/share/mc/Syntax/                                  |
|Micro             |corelab.yaml             |copy file into ~/.config/micro/syntax/                                    |
|Nano              |corelab.nanorc           |copy file into /usr/share/nano/                                           |
|Notepad++         |corelab.xml              |copy file into %USERPROFILE%\AppData\Roaming\\Notepad++\\userDefineLangs\ |
|(Neo)Vim          |corelab.vim              |copy file into ~/.config/vim/syntax/                                      |
|                  |scripts.vim              |copy file into ~/.config/vim/                                             |
|Visual Studio Code|corelab-script           |copy directory to ~/.vscode/extensions/                                   |
|Visual Studio Code|corelab-script-0.0.1.vsix|Install with Visual Studio Code application                               |

> [!NOTE]
> Applications using GtkSourceView, for example: Builder, Geany, Gedit, Mousepad, Pluma, Scribes.
> The target directory is not the same for all of them.  
> 
> You can install VSCode extension from Marketplace from
> https://marketplace.visualstudio.com/items?itemName=pozsarzs.corelab-script
> URL.  

### Synopsis

 - case: insensitivity  
 - comment: after `#`  
 - start line:  
     `#!\....`  
     `@corelab.exe...`  
     `@goto eof`  
     `@:eof`
 - text: between `""`  
 - words:
   - (...)
   - (...)
   - (...)
   - (...)
