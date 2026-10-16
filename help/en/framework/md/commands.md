|inst.|description                                           |scope                    |syntax                          |args.|under sim.|operation mode           |
|-----|------------------------------------------------------|-------------------------|--------------------------------|-----|----------|-------------------------|
|ADD  |Add value to RA in-place.                             |[csScript]               |ADD value                       |1    |True      |[omScript]               |
|AND  |Bitwise/logical AND in-place.                         |[csScript]               |AND value                       |1    |True      |[omScript]               |
|ATIO |Attach I/O port or device module to bus.              |[csCommandLine, csScript]|ATIO instancename               |1    |False     |[omInteractive, omScript]|
|ATME |Attach memory module to bus.                          |[csCommandLine, csScript]|ATME instancename               |1    |False     |[omInteractive, omScript]|
|ATPU |Attach processor module to bus.                       |[csCommandLine, csScript]|ATPU instancename               |1    |False     |[omInteractive, omScript]|
|BIT  |Check the specified bit.                              |[csScript]               |BIT index                       |1    |True      |[omScript]               |
|CALL |Call subroutine.                                      |[csScript]               |CALL label                      |1    |True      |[omScript]               |
|CFIO |Configure I/O port module.                            |[csCommandLine, csScript]|CFIO instancename.property value|2    |False     |[omInteractive, omScript]|
|CFME |Configure memory module.                              |[csCommandLine, csScript]|CFME instancename.property value|2    |False     |[omInteractive, omScript]|
|CFPU |Configure processor module.                           |[csCommandLine, csScript]|CFPU instancename.property value|2    |False     |[omInteractive, omScript]|
|CHWD |Change work directory.                                |[csCommandLine, csScript]|CHWD directory                  |1    |False     |[omInteractive, omScript]|
|COMP |Compare RA with value by subtraction.                 |[csScript]               |COMP value                      |1    |True      |[omScript]               |
|CONV |'Convert the number in RA into base 2/8/16.           |[csScript]               |CONV target base                |2    |True      |[omScript]               |
|CRIO |Instantiate a I/O port or device module.              |[csCommandLine, csScript]|CRIO library instancename       |2    |False     |[omInteractive, omScript]|
|CRME |Instantiate a memory module.                          |[csCommandLine, csScript]|CRME library instancename       |2    |False     |[omInteractive, omScript]|
|CRPU |Instantiate a processor module.                       |[csCommandLine, csScript]|CRPU library instancename       |2    |False     |[omInteractive, omScript]|
|DEC  |Decrement RA by 1 in-place.                           |[csScript]               |DEC                             |0    |True      |[omScript]               |
|DIIO |Disable I/O port or device module.                    |[csCommandLine, csScript]|DIIO instancename               |1    |False     |[omInteractive, omScript]|
|DIME |Disable memory module.                                |[csCommandLine, csScript]|DIME instancename               |1    |False     |[omInteractive, omScript]|
|DIPU |Disable processor module.                             |[csCommandLine, csScript]|DIPU instancename               |1    |False     |[omInteractive, omScript]|
|DSIO |Destroy I/O port or device module.                    |[csCommandLine, csScript]|DSIO instancename               |1    |False     |[omInteractive, omScript]|
|DSME |Destroy memory module.                                |[csCommandLine, csScript]|DSME instancename               |1    |False     |[omInteractive, omScript]|
|DSPU |Destroy processor module.                             |[csCommandLine, csScript]|DSPU instancename               |1    |False     |[omInteractive, omScript]|
|DTIO |Detach I/O port or device module from bus.            |[csCommandLine, csScript]|DTIO instancename               |1    |False     |[omInteractive, omScript]|
|DTME |Detach memory module from bus.                        |[csCommandLine, csScript]|DTME instancename               |1    |False     |[omInteractive, omScript]|
|DTPU |Detach processor module from bus.                     |[csCommandLine, csScript]|DTPU instancename               |1    |False     |[omInteractive, omScript]|
|EDME |Show examine/deposit window                           |[csCommandLine]          |EDME instancename               |1    |False     |[omInteractive]          |
|END  |End of main program.                                  |[csScript]               |END                             |0    |True      |[omScript]               |
|ENIO |Enable I/O port or device module.                     |[csCommandLine, csScript]|ENIO instancename               |1    |False     |[omInteractive, omScript]|
|ENME |Enable memory module.                                 |[csCommandLine, csScript]|ENME instancename               |1    |False     |[omInteractive, omScript]|
|ENPU |Enable processor module.                              |[csCommandLine, csScript]|ENPU instancename               |1    |False     |[omInteractive, omScript]|
|EXAP |Exit from application.                                |[csCommandLine, csScript]|EXAP                            |0    |True      |[omInteractive, omScript]|
|EXIT |Terminate the script.                                 |[csScript]               |EXIT                            |0    |True      |[omScript]               |
|INC  |Increment RA by 1 in-place.                           |[csScript]               |INC                             |0    |True      |[omScript]               |
|INRG |Check if RA is between min and max.                   |[csScript]               |INRG min max                    |2    |True      |[omScript]               |
|JPCA |Jump to the specified label; if RF/C = true.          |[csScript]               |JPCA label                      |1    |True      |[omScript]               |
|JPNC |Jump to the specified label; if RF/C = false.         |[csScript]               |JPNC label                      |1    |True      |[omScript]               |
|JPNZ |Jump to the specified label; if RF/Z = false.         |[csScript]               |JPNZ label                      |1    |True      |[omScript]               |
|JPZE |Jump to the specified label if RF/Z = true.           |[csScript]               |JPZE label                      |1    |True      |[omScript]               |
|JUMP |Jump to the specified label.                          |[csScript]               |JUMP label                      |1    |True      |[omScript]               |
|LDME |Load memory content from file                         |[csCommandLine, csScript]|LDME instancename filename      |2    |False     |[omInteractive, omScript]|
|LDPR |Change to interactive mode and load project from file.|[csCommandLine]          |LDPR filename.clprj             |1    |False     |[omInteractive, omScript]|
|LDRG |Load a value to specified register.                   |[csScript]               |LDRG register value             |2    |True      |[omScript]               |
|LDSC |Change to script mode and load script from file.      |[csCommandLine]          |LDSC filename.clsce             |1    |False     |[omScript]               |
|MUL  |Multiply RA by value in-place.                        |[csScript]               |MUL value                       |1    |True      |[omScript]               |
|MVIO |Set position of I/O device panel.                     |[csCommandLine, csScript]|MVIO instancename left-top      |2    |True      |[omInteractive, omScript]|
|NMI  |Call non-maskable interrupt.                          |[csCommandLine]          |NMI                             |0    |False     |[omInteractive]          |
|NOT  |Bitwise/logical NOT in-place.                         |[csScript]               |NOT                             |0    |True      |[omScript]               |
|NWPR |Change to interactive mode and create new project.    |[csCommandLine]          |NWPR                            |0    |False     |[omInteractive, omScript]|
|NWSC |Change to script mode and create new script.          |[csCommandLine]          |NWSC                            |0    |False     |[omScript]               |
|OR   |Bitwise/logical OR in-place.                          |[csScript]               |OR value                        |1    |True      |[omScript]               |
|PRNT |Write text to console.                                |[csScript]               |PRNT "text" ["text"]            |1    |True      |[omScript]               |
|RDIO |Read a value from I/O port and store in register RA.  |[csScript]               |RDIO address                    |1    |True      |[omScript]               |
|RDME |Read a value from memory and store in register RA.    |[csScript]               |RDME address                    |1    |True      |[omScript]               |
|RNIO |Rename I/O device panel.                              |[csCommandLine, csScript]|RNIO instancename caption       |2    |True      |[omInteractive, omScript]|
|RSAP |Restart application.                                  |[csCommandLine, csScript]|RSAP                            |0    |True      |[omInteractive, omScript]|
|RSIO |Reset I/O port or device module.                      |[csCommandLine, csScript]|RSIO instancename               |1    |False     |[omInteractive, omScript]|
|RSME |Reset memory module.                                  |[csCommandLine, csScript]|RSME instancename               |1    |False     |[omInteractive, omScript]|
|RSPU |Reset processor module.                               |[csCommandLine, csScript]|RSPU instancename               |1    |False     |[omInteractive, omScript]|
|RST  |Reset all module.                                     |[csCommandLine, csScript]|RST                             |0    |False     |[omInteractive]          |
|RTRN |Return from subroutine.                               |[csScript]               |RTRN                            |0    |True      |[omScript]               |
|RUN  |Run simulation.                                       |[csCommandLine, csScript]|RUN                             |0    |False     |[omInteractive, omScript]|
|RUSC |Run script.                                           |[csCommandLine]          |RUN                             |0    |False     |[omScript]               |
|RWIO |Show read/write window                                |[csCommandLine]          |RWIO instancename               |1    |False     |[omInteractive]          |
|SESC |Run script step-by-step.                              |[csCommandLine]          |SESC                            |0    |False     |[omScript]               |
|SHBL |Show BusLogger window.                                |[csCommandLine, csScript]|SHBL                            |0    |True      |[omInteractive, omScript]|
|SHBM |Show BreakPoint Manager window.                       |[csCommandLine]          |SHBM                            |0    |True      |[omInteractive, omScript]|
|SHHV |Show HexViewer window.                                |[csCommandLine, csScript]|SHHV instancename               |1    |True      |[omInteractive, omScript]|
|SHIL |Show IntLogger window.                                |[csCommandLine, csScript]|SHIL                            |0    |True      |[omInteractive, omScript]|
|SHIO |Show I/O device panel.                                |[csCommandLine, csScript]|SHIO instancename               |1    |True      |[omInteractive, omScript]|
|SHL  |Shift target bits left by count in-place.             |[csScript]               |SHL count                       |1    |True      |[omScript]               |
|SHME |Show Module Explorer window.                          |[csCommandLine]          |SHME                            |0    |True      |[omInteractive]          |
|SHRL |Show RunLogger window.                                |[csCommandLine, csScript]|SHRL                            |0    |True      |[omInteractive, omScript]|
|SHR  |Shift target bits right by count in-place.            |[csScript]               |SHR count                       |1    |True      |[omScript]               |
|SHRV |Show RegViewer window.                                |[csCommandLine, csScript]|SHRV instancename               |1    |True      |[omInteractive, omScript]|
|SHSC |Show ScriptConsole window.                            |[csCommandLine, csScript]|SHSC                            |0    |True      |[omInteractive, omScript]|
|SHSE |Show ScriptEditor window.                             |[csCommandLine, csScript]|SHSE                            |0    |True      |[omInteractive, omScript]|
|STEP |Run simulation step-by-step.                          |[csCommandLine, csScript]|STEP                            |0    |False     |[omInteractive, omScript]|
|STOP |Stop simulation.                                      |[csCommandLine, csScript]|STOP                            |0    |True      |[omInteractive, omScript]|
|STSC |Stop script.                                          |[csCommandLine]          |STSC                            |0    |True      |[omScript]               |
|SUB  |Subtract value from RA in-place.                      |[csScript]               |SUB value                       |1    |True      |[omScript]               |
|SVME |Save memory content to file                           |[csCommandLine, csScript]|SVME filename instancename      |2    |False     |[omInteractive, omScript]|
|SVPR |Save project to file.                                 |[csCommandLine]          |SVPR filename.clprj             |1    |False     |[omInteractive]          |
|SVSC |Save script to file.                                  |[csCommandLine]          |SVSC filename.clsce             |1    |False     |[omScript]               |
|SWAP |Swap the values of two registers.                     |[csScript]               |SWAP register register          |2    |True      |[omScript]               |
|SZIO |Set size of I/O device panel.                         |[csCommandLine, csScript]|SZIO instancename width-height  |2    |True      |[omInteractive, omScript]|
|WAIT |Wait specified ms.                                    |[csScript]               |WAIT ms                         |1    |True      |[omScript]               |
|WRIO |Read a value from register RA and write to I/O port   |[csScript]               |WRIO address                    |1    |True      |[omScript]               |
|WRME |Read a value from register RA and store in memory     |[csScript]               |WRME address                    |1    |True      |[omScript]               |
|XOR  |Bitwise/logical XOR in-place.                         |[csScript]               |XOR value                       |1    |True      |[omScript]               |
