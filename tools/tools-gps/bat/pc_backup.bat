@echo on

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: set home=c:\\\CopyOfTanzania2009

    set PATH=%PATH%;c:\tools

    set backup_batch=c:\\\tools\\\pc_backup1.bat
    set temp_batch=c:\\\tmp\\\temp1.bat
    set tools=c:\\\tools

    set TopFolder="Documents and Settings"
    set SourceDir=e:/
    set BackupDir=e:/backup/SF-2007-01/latest
    set NewBackupDir=e:/backup/SF-2007-01/24-NOV-2009

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: backup
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main

    ::xcopy /T /E /I c:\ d:\backup
    c: & cd c:\ & %tools%\find . -name "*.odt" -exec c:/tools/pc_backup1.bat '{}' ';'
    pause
    exit

    c: & cd c:\ & %tools%\find . -name "*.odt" -exec cp --verbose '{}' d:/backup/'{}' ';'
 
    goto :skip

    rm -rf e:\backup\2009-NOV-24\%TopFolder%
    xcopy /T /E /I c:\%TopFolder% e:\backup\2009-NOV-24\%TopFolder%

:skip
    echo Removing latest backup folder ...
    rm -rf %BackupDir%/%TopFolder%
    echo Creating latest backup folders ...
    xcopy /T /E /I c:\%TopFolder% e:\backup\SF-2007-01\latest\%TopFolder%
    touch -t 200901010000 e:/backup/SF-2007-01/latest/%TopFolder%/timestamp.wri
    :: c: & cd %home% & cd .. & %tools%\find %TopFolder% -name "*" -mtime -10 -type f -exec %backup_batch% '{}' ';'
    c: & cd c:\%TopFolder% & cd .. & %tools%\find %TopFolder% -name "*.odt" -newer e:/backup/SF-2007-01/latest/%TopFolder%/timestamp.wri -exec %backup_batch% '{}' "Documents and Settings" "%SourceDir%" "%BackupDir%" "%NewBackupDir%" ';'

echo. & pause & exit

