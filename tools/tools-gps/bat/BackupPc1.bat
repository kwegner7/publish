@echo off


    set PC=SF-2007-01

    echo.
    ::echo %1%
    ::dirname %1%
    cp -f --verbose %1 e:/backup/%PC%/%1
    exit
