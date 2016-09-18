@echo off

    echo.
    ::echo %1%
    cp -f --verbose %1 d:/backup/%1
    exit

 
    set temp_batch=C:\\\tmp\\\temp1.bat
 


    echo REM Batch file to backup stuff > %temp_batch%

    :: echo cp --verbose %4/%1 %5/%1 >> %temp_batch%
    echo.
    echo cp --verbose %1 %4/%1 >> %temp_batch%

    :: type %temp_batch%
    c: & cd %3 & cd .. & %temp_batch%

    exit

    :: echo Copying %1
    :: echo xcopy  {D {R {Y {I  %1 d:/backup/%1 | sed "s@/@\\\@g" | sed "s@{@/@g" >> %temp_batch%
 
    echo Parameters: 1 is %1
    echo Parameters: 2 is %2
    echo Parameters: 3 is %3
    echo Parameters: 4 is %4
    echo Parameters: 5 is %5
    echo.
