@echo off

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set tmp=c:\\\tmp
    set tools=d:\\\view\\\tools
    set flash_drive_folder=driver_for_monitor
    set backup_drive=G:
    set backup_location=backup

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: allow inferior method
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    if .%1==.INFERIOR goto :inferior_method

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: allow external call to "each_volume" subroutine
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    if not .%1==.EACH goto :main
        call :list_volume %2
        call :each_volume %2
        goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: loop on each drive letter and create single batch file
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: determine which drives removeable and create batch file
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    diskpart /s %tools%\diskpart_script0.txt | grep Removeable > %tmp%\t1.txt
    (cat %tmp%\t1.txt | sed "s@  Volume .     @@") > %tmp%\t2.txt
    (cat %tmp%\t2.txt | sed "s@ .*@:@") > %tmp%\t1.txt
    (cat %tmp%\t1.txt | sed "s@^@call %tools%\\\ntc_backup EACH @") > %tmp%\flash0.bat

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: invoke the batch file to xcopy each flash drive
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    call %tmp%\flash0.bat  

echo. & pause & exit

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: this method does not determine if the drive is removeable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:inferior_method

    set select_volumes=e: f: g: h: i: j: k: l: m: n;
    set select_volumes=%select_volumes% o: p: q: r: s: t: u: v: w:
    set select_volumes=%select_volumes% x: y: z:

    echo.
    for /D %%i in (%select_volumes%) do if exist %%i\ call :list_volume %%i

    echo.
    for /D %%i in (%select_volumes%) do if exist %%i\ call :each_volume %%i

    ::xcopy /D /E /V /F /R /Y /I %flash_drive% %backup_location%

echo. & pause & exit

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: list the volume
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:list_volume

    echo.
    vol %1 | head -1 | sed "s/ Volume in drive/Flash drive/g" | sed "s^is ^is \`^" | sed "s/$/'/"
goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: xcopy to the external hard drive
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:each_volume

    vol %1 | head -1 | sed "s/.*is //" > %tmp%\volume_label.txt
    (cat %tmp%\volume_label.txt | sed -r "s/^/\x22/") > %tmp%\t1.txt
    (cat %tmp%\t1.txt | sed -r s/$/\x22/) > %tmp%\volume_label.txt
    :: type %tmp%\volume_label.txt

    set xcopy_command=xcopy /D /E /V /F /R /Y /I %1\\\driver_for_monitor G:\\\backup\\\
    ::echo %xcopy_command%
    cat %tmp%\volume_label.txt | sed "s@^@ %xcopy_command%@" > %tmp%\flash.bat
    call %tmp%\flash.bat
 
goto :EOF                                                                             













::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: specify the receivers to be analyzed here
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set select_receivers=r101 r102 r106 r127 r131 r133 r134
    set select_receivers=r*

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: paths
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set sbc_home=i:\projects\Comm\WestLake_LA\Programs\ARL\MSN\3_Working_Folders\11_Software\SBC_software
    set daily_log=%sbc_home%\daily_log
    set tools=%sbc_home%\tools
    set grep=%tools%\grep

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: loop on each receiver
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main0

    for /D %%i in (%daily_log%\%select_receivers%) do call :each_file %%i

echo. & pause & exit


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: loop on each daily log file to be processed
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:each_file

    echo. & echo Processing receiver %~nx1 ...
    set folder=%daily_log%\%~nx1
    if exist %folder%\analysis.wri del/q %folder%\analysis.wri
    set select_logs=%folder%\2007-??-?? %folder%\2007-??-??.00?
    for %%j in (%select_logs%) do call :analysis %%j %1

goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: invoke the dr program to analyze a daily log file
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:analysis

    echo %~nx1
    %~d1 & cd %~dp1
    echo ================================= >> %~dp1%analysis.wri
    echo Receiver %~nx2 Date %~nx1         >> %~dp1%analysis.wri
    echo ================================= >> %~dp1%analysis.wri
    call %tools%\dr %~f1% >> analysis.wri

goto :EOF

