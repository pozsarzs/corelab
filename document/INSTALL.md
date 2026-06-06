## Installation from source package

Lazarus LCL units are required to compile Xcorelab and FreePascal compiler is
required to compile all programs.  

> [!IMPORTANT]
> On DOS and Windows operating systems, FreePascal's BIN directory contains the
> compiler and additional necessary utilities (make, rstconv), so this directory
> must be included in the PATH.

### 1. On Unix-like systems
  
  Build and install:
  ```
  $ ./configure [app=no] [lib=no] [lhelp=no] [stagedir=...]  
  $ make
  # make install
  ```
  Remove:
  ```
  # make uninstall
  ```

### 2. On Windows
  
  Build:
  ```
  > cd source
  > buildw64.bat [/nocui] [/nogui] [/noutil] [/nolhelp]
  ```  
