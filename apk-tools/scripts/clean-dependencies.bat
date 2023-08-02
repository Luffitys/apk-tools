@echo off
call "scripts\dont_run-set-variables.bat"

if exist "..\%bin_path%" (
    del ..\%bin_path%
    echo.
    pause
)
