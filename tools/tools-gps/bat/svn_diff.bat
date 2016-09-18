@set DRIVE=%~dx1%
@set FOLDER="%1%"
@set SVN_FOLDER=%FOLDER%\.svn
@chdir %FOLDER%
@echo Current folder is %FOLDER%
@if exist %SVN_FOLDER% (
    @echo Modifications to working files ...
    @echo.
    @svn diff
) else (
    @echo This is not a Subversion working folder
)
@echo.
@pause