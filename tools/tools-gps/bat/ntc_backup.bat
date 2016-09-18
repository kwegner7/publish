@echo off

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set tools=N:\\\tools
    set tools=C:\\\cygwin\\\bin

    set tmp=N:\\\tools\\\tmp
    set tmp=C:\\\tmp
    set tmp1=%tmp%\t1.txt
    set tmp2=%tmp%\t2.txt
    set batch1=%tmp%\flash1.bat
    set batch2=%tmp%\flash2.bat
    set script=%tmp%\diskpart_script.txt
    set label=%tmp%\volume_label.txt

    set cat=%tools%\\\cat
    set sed=%tools%\\\sed

    set cat=D:\\\tools\\\cat
    set sed=D:\\\tools\\\sed

    set this_batch=n:\\\\tools\\\\ntc_backup
    set this_batch=d:\\\\view\\\\tools\\\\ntc_backup

    set backup_folder=N:\\\NTC STUDENT BACKUPS\\\
    set xcopy_command=xcopy /D /E /R /Y /I

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
    (echo list volume) 1> %tmp%\diskpart_script.txt
    (diskpart /s %script% | grep Removeable             ) > %tmp1%
    (%cat% %tmp1% | %sed% "s@  Volume .     @@"         ) > %tmp2%
    (%cat% %tmp2% | %sed% "s@ .*@:@"                    ) > %tmp1%
    (%cat% %tmp1% | %sed% "s@^@call %this_batch% EACH @") > %batch1%

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: invoke the batch file to xcopy each flash drive
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    call %batch1%

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

    vol %1 | head -1 | sed "s/.*is //" > %label%
    (%cat% %label% | %sed% "s/^/Copying flash drive to %backup_folder%/") > %tmp1%
    type %tmp1% 
    (%cat% %label% | %sed% "s/$/qquuoottee/") > %tmp1%
    (%cat% %tmp1%) > %label%

    (%cat% %label% | %sed% "s@^@%xcopy_command% %1\\\ qquuoottee%backup_folder%@") > %tmp1%
    (%cat% %tmp1% | %sed% s@qquuoottee@""""@g) > %batch2%
  ::(%cat% %tmp1% | %sed% s@qquuoottee@\x22@g) > %batch2% THIS WORKS WITH CYGWIN
    cat %batch2%

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

