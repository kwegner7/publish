@set DRIVE=%~dx1%
@set FOLDER="%1%"
@set SVN_FOLDER=%FOLDER%\.svn
@chdir %FOLDER%
@echo Current folder is %FOLDER%
@if exist %SVN_FOLDER% (
    @echo Checking in files ...
    @echo.
    @svn commit -m ""
) else (
    @echo This is not a Subversion working folder
)
@echo.
@pause