@echo off

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set PATH=d:\tools;%PATH%;
    set tools=e:\\\tools
    set backup_batch=e:/tools/BackUpPc1.bat
    set TopFolder="Documents and Settings"

    call :main SF-2007-01

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: backup
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
    set PC=%1

    rm -rf e:/backup/%PC%
    %tools%\mkdir --parents e:/backup/%PC%
    %tools%\mkdir --parents c:/tmp
    ::xcopy /T /E /I "c:\Documents and Settings" e:\backup
    :: c: & cd "c:\Documents and Settings" & find . -name "*.odt" -exec e:/tools/BackUpPc1.bat '{}' ';'

    call :backup "*.txt" %PC%
    call :backup "*.dat" %PC%
    call :backup "*.pcb" %PC%
    call :backup "*.jpg" %PC%
    call :backup "*.odt" %PC%
    call :backup "*.ods" %PC%
    call :backup "*.odp" %PC%
    call :backup "*.odg" %PC%
    call :backup "*.avi" %PC%
    call :backup "*.mp4" %PC%
    call :backup "*.mp3" %PC%
    call :backup "*.gif" %PC%
    call :backup "*.bmp" %PC%
    call :backup "*.doc" %PC%
    call :backup "*.xls" %PC%
    call :backup "*.ppt" %PC%
    call :backup "*.bat" %PC%

echo. & pause & exit


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: backup
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:backup


echo.
echo Creating all backup folders for %1 files:
    
    rm -f c:/tmp/tmp3.bat c:/tmp/tmp2.bat c:/tmp/tmp4.bat c:/tmp/tmp5.bat
    c: & cd "c:\Documents and Settings" & find . -type f -name %1 -exec printf "dirname ""{}"" >> c:/tmp/tmp3.bat \n" ';' > c:\tmp\tmp2.bat
    call c:\tmp\tmp2.bat
    uniq c:/tmp/tmp3.bat
    echo.
    cat c:/tmp/tmp3.bat | sed "s/^/e: \& cd e:\\\backup\\\%PC% \& %tools%\\\mkdir --parents --verbose \x22/g" > c:/tmp/tmp4.bat
    cat c:/tmp/tmp4.bat | sed "s/$/\x22/g" > c:/tmp/tmp5.bat
    call c:\tmp\tmp5.bat

echo Copying each backup file for %1 files:
    c: & cd "c:\Documents and Settings" & find . -type f -name %1 -exec %backup_batch% '{}' %2 ';'

goto :EOF                                                                             
