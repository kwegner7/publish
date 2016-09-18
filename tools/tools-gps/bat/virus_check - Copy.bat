@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: The following folders must exist on the PC:
::    c:\cygwin\bin  (containing all linux commands)
::    c:\tools       (containing this batch file)
::    c:\tmp         (contains temp files produced by this script)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: paths
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set bin=C:\\\cygwin\\\bin
    set tools=c:\\\tools
    set tmp=C:\\\tmp

    set tools=d:\\\view\\\tools

    set tmp1=%tmp%\t1.wri
    set tmp2=%tmp%\t2.wri
    set tmp_batch=%tmp%\flash1.bat
    set tmp_script=%tmp%\diskpart_script.wri
    set tmp_label=%tmp%\volume_label.wri

    set this_batch=%tools%\\\\virus_check
    set PATH=c:\cygwin\bin;%PATH%
 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: recursive invocation from batch file passing "EACH" as parameter
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not .%1==.EACH goto :main
    call :list_volume %2
    call :each_volume %2
    goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: otherwise,loop on each drive letter and create batch file
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: determine which drives removeable and create batch file
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    (echo list volume) 1> %tmp_script%
    (diskpart /s %tmp_script% | egrep "Partition|Removeable"  ) > %tmp1%
    (cat %tmp1% | sed "s@  Volume .     @@"         ) > %tmp2%
    (cat %tmp2% | sed "s@ .*@:@"                    ) > %tmp1%
    (cat %tmp1% | sed "s@^@call %this_batch% EACH @") > %tmp_batch%

    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    :: invoke temporary batch file, do something each flash drive
    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    call %tmp_batch%

echo. & pause & exit


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: list the volume
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:list_volume

    echo.
    echo ___________________________________________
    vol %1 | head -1 | sed "s/ Volume in drive/Flash drive/g" | sed "s^is ^is \`^" | sed "s/$/'/"

goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: do something with each volume
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:each_volume

    vol %1 | head -1 | sed "s/.*is //" > %tmp_label%
    :: (ls -1 %1/auto* %1/AUTO* %1/%Re*)
    find %1/ -maxdepth 1 -name "AUTO*" -printf "    %%M %%p %%t\n"
    find %1/ -maxdepth 1 -name "auto*" -printf "    %%M %%p %%t\n"
    find %1/ -maxdepth 1 -name "Re*"   -printf "    %%M %%p %%t\n"
    find %1/ -maxdepth 1 -perm 770     -printf "    %%M %%p %%t\n"
    find %1/ -maxdepth 1 -perm 550     -printf "    %%M %%p %%t\n"
    %1 & dir/ah /B

goto :EOF                                                                             




::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: to delete certain hidden viruses, use Safe Mode Command Line
:: Autolt V3: windo.exe is the virus executable
:: DRIVESYS1 c:\windows\system32\bycool1\windo.exe
:: HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::  attrib -h -s %1 & attrib -r %1 & del %1



@echo off

c: & cd \ & echo Checking Drive C:
dir/s *ravmon* camp.* *scvv* "* .exe"
dir/s *.exe | find "06/08/20"
echo.


pause
exit

@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: specify the receivers to be analyzed here
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    set select_receivers=r*
    set select_receivers=r107 r131 r134

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: paths
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    ::set sbc_home=I:\projects\Comm\WestLake_LA\Programs\ARL
    ::set sbc_home=%sbc_home%\MSN\3_Working_Folders
    ::set sbc_home=%sbc_home%\11_Software\SBC_software
    ::set daily_log=%sbc_home%\daily_log
    ::set tools=%sbc_home%\tools
    ::set grep=%tools%\grep

    set daily_log=D:\acd\data
    set tools=D:\tools
    set grep=%tools%\grep


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: loop on each receiver
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main

    for /D %%i in (%daily_log%\%select_receivers%) do call :each_file %%i

echo. & pause & exit


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: loop on each daily log file to be processed
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:each_file

    echo. & echo Processing receiver %~nx1 ...
    set folder=%daily_log%\%~nx1
    if exist %folder%\kurt_analysis.wri del/q %folder%\kurt_analysis.wri

    set select_logs=
    set select_logs=%select_logs% %folder%\2008-01-21

    for %%j in (%select_logs%) do call :analysis %%j %1

goto :EOF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: invoke the dr program to analyze a daily log file
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:analysis

    echo %~nx1
    %~d1 & cd %~dp1
    echo ================================= >> %~dp1%kurt_analysis.wri
    echo Receiver %~nx2 Date %~nx1         >> %~dp1%kurt_analysis.wri
    echo ================================= >> %~dp1%kurt_analysis.wri
    call %tools%\dr %~f1% >> kurt_analysis.wri

goto :EOF

