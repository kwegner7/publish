@set FILE1=PendingData.csv
@set FILE2=PocketMoney.csv

@set FILE3="AccountingData(Master).csv"
@set FILE6="AccountingData(Staff).csv"
@set FILE5=student-accounts-2010.csv

@set FILE4="AccountingData(PocketMoney).csv"

@if exist c:\database\lists\csv\%FILE1% copy c:\database\lists\csv\%FILE1% c:\backups\database\%FILE1%
@if exist c:\database\lists\csv\%FILE2% copy c:\database\lists\csv\%FILE2% c:\backups\database\%FILE2%

@if exist c:\database\tables\csv\%FILE3% copy c:\database\tables\csv\%FILE3% c:\backups\database\%FILE3%
@if exist c:\database\tables\csv\%FILE6% copy c:\database\tables\csv\%FILE6% c:\backups\database\%FILE6%
@if exist c:\database\tables\csv\%FILE5% copy c:\database\tables\csv\%FILE5% c:\backups\database\%FILE5%

@if exist c:\database\pocket-money\csv\%FILE4% copy c:\database\pocket-money\csv\%FILE4% c:\backups\database\%FILE4%

    cd c:\backups && c:\cygwin\bin\svn status -vu database
    cd c:\backups && c:\cygwin\bin\svn commit -m "" database
    cd c:\backups && c:\cygwin\bin\svn status -vu database

"C:\Program Files\SyncToy 2.1\SyncToy.exe"

REM @pause
exit

    svnadmin create /cygdrive/c/svn
    svn import c:/backups/database file:///c:/svn/database -m "initialize backups"
    then remove the files
    svn co file:///c:/svn/database c:/backups/database 

