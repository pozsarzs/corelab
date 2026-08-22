# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## About software

The CoreLAB project is a functional 8 bits microprocessor and microcontroller
simulator born from a fusion of academic research, technical passion, and
historical preservation.

## How to get installer package for my OS?

**Visit homepage (see later) to download installer packages:**  

|operation system|arch.|package name                 |note  |
|----------------|:---:|-----------------------------|------|
|Linux           |amd64|corelab-0.1-amd64.bin        |(SFX) |
|                |amd64|corelab-0.1-amd64.zip        |      |
|Debian GNU/Linux|amd64|corelab_0.1-1_amd64.deb      |      |
|Raspberry Pi OS |armhf|corelab_0.1-1_armhf.deb      |      |
|OpenSuSE        |amd64|corelab-0.1-1.amd64.rpm      |      |
|Slackware       |amd64|corelab-0.1-amd64-1.txz      |      |
|FreeBSD         |amd64|corelab-0.1-freebsd-amd64.bin|(SFX) |
|                |amd64|corelab-0.1-freebsd-amd64.zip|      |
|                |amd64|corelab-0.1.txz              |      |
|Windows         |amd64|corelab-0.1-win64.exe        |      |
|                |amd64|corelab-0.1-win64.msi        |      |
|                |amd64|corelab-0.1-win64.zip        |      |
|all             |all  |corelab-0.1.tar.gz           |source|

**Download from Github**  
  
  ```
  $ git clone https://github.com/pozsarzs/corelab.git
  ```  
  
**Download from Debian repository**  
  
  set reporitory:  
  ```
  $ sudo echo "deb http://www.pozsarzs.hu/deb/ ./" >> /etc/apt/sources.list
  $ sudo wget -q -O - http://www.pozsarzs.hu/deb/KEY.gpg | apt-key add -
  $ sudo apt-get update
  ```
  install:  
  ```
  $ sudo apt-get install corelab
  ```  

**_Note:_**  

  How to resolve _Key is stored in legacy trusted.gpg keyring_ warning message:

  List all the GPG keys added to your system:
  ```
  $ sudo apt-key list
  ```
  Search dpkg1@szerafingomba.hu's public key:
  ```
    /etc/apt/trusted.gpg
    --------------------
    pub   rsa4096 2019-12-04 [SCEA]
          0503 875E 0F22 8B99 C057  9E0A 97AB CE11 F36E 9EE8
    uid           [ unknown] dpkg1 <dpkg1@szerafingomba.hu>
  ```  
  Copy dearmored key to the new place:
  ```
  $ sudo apt-key export f36e9ee8 | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/pozsarzs.gpg
  ```

## Contact

 - Homepage: <https://www.pozsarzs.hu/60_myprogcom/corelab/>  
 - Project webpage on Github: <https://pozsarzs.github.io/corelab>  
 - Author: Pozsár Zsolt <pozsarzs@gmail.com>  
