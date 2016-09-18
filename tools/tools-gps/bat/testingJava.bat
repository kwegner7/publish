@echo off

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set PATH=c:\cygwin\bin;%PATH%;

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: if the file does not exist, then touch it
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set file1="C:\\database\\tables\\csv\\AccountingData(Master).csv"
    set file2="C:\\database\\tables\\csv\\AccountingData(Staff).csv"
    set file5="C:\\database\\tables\\csv\\student-accounts-2010.csv"
    set file3="C:\\database\\lists\\csv\\PendingData.csv"
    set file4="C:\\database\\lists\\csv\\PocketMoney.csv"

    if not exist %file1% touch %file1%
    if not exist %file2% touch %file2%
    if not exist %file3% touch %file3%
    if not exist %file4% touch %file4%
    if not exist %file5% touch %file5%

    exit

    echo.
    echo Creating all backup folders > c:/data/view/tools/bat/Akemi.wri
    which javac >> c:/data/view/tools/bat/Akemi.wri 
    echo %PATH% >> c:/data/view/tools/bat/Akemi.wri

    set folder=%daily_log%\%~nx1
    if exist c:\tmp\carina.wri touch c:\tmp\carina1.wri
    if not exist c:\tmp\carina2.wri touch c:\tmp\carina2.wri
    touch c:\tmp\maja.wri
