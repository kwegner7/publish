@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: paths
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    set FOLDER_LISTS=c:\database\lists\csv
    set FOLDER_TABLES=c:\database\tables\csv
    set FOLDER_POCKET_MONEY=c:\database\pocket-money\csv

    set FOLDER_BACKUPS="c:\backups\extract"
    if not exist %FOLDER_BACKUPS% mkdir %FOLDER_BACKUPS%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: copy files
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    call :main %FOLDER_LISTS% "PendingData.csv"
    call :main %FOLDER_LISTS% "PocketMoney.csv"
	
    call :main %FOLDER_TABLES% "AccountingData(Master).csv"
    call :main %FOLDER_TABLES% "AccountingData(Staff).csv"
    call :main %FOLDER_TABLES% "student-accounts-2010.csv"
	
    call :main %FOLDER_POCKET_MONEY% "AccountingData(PocketMoney).csv"

    call :main %FOLDER_LISTS% "*.csv"
    call :main %FOLDER_TABLES% "*.csv"
    call :main %FOLDER_LISTS%\.. "Monthly Staff Billing.ods"
	
    :: cd %FOLDER_BACKUPS%\.. && c:\cygwin\bin\tar -cvf extract.tar extract && dir

    pause
exit
	
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
    set FOLDER=%1
    set FILE=%2

    if exist %FOLDER%\%FILE% copy %FOLDER%\%FILE% %FOLDER_BACKUPS%\%FILE%
goto :EOF 

