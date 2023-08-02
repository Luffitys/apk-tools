@echo off
call "scripts\dont_run-set-variables.bat"
setlocal enabledelayedexpansion

where java >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Java is not installed. Please first install Java or add it to the Windows PATH environment
    echo.
    pause
    exit /b 1
)

if "%~1" neq "" (
    set "selected_apk=%~1"
    goto :SelectOptions
)

set "input_path=%cd%\input"
set "apk_files="
set "file_count=0"
echo.

for %%F in ("%input_path%\*.apk") do (
    set /a "file_count+=1"
    echo !file_count!. %%~nxF
    set "apk_files=!apk_files! "%%~dpnxF""
)

if "%file_count%" == "0" (
    echo No APK file found at input path %input_path%
    echo Please put an APK file in there or use drag and drop on the .bat file
    echo.
    pause
    exit /b 1
)

echo.
set /p "selection=Enter the number of the APK file to decompile, or drag and drop an APK file on the .bat file: "

if not "%selection%" == "" (
    set "selected_apk="
    for /f "tokens=%selection%" %%F in ("%apk_files%") do set "selected_apk=%%~F"
)

if not defined selected_apk (
    echo Invalid selection. Enter a valid number or drag and drop an APK file on the .bat file
    pause
    exit /b 1
)

:SelectOptions
echo.
echo Select an option:
echo [1] Decompile dex (classes.dex)
echo [2] Decompile resources (res/)

set /p "decompile_choice=Enter option number or press Enter to decompile both: "

if "%decompile_choice%" == "1" set "decompile_option=--no-res"
if "%decompile_choice%" == "2" set "decompile_option=--no-src"

call "scripts\dont_run-download-dependencies.bat"

if not exist "%out_path%" (
    md "%out_path%"
)

for %%A in ("%selected_apk%") do set "decompile_folder=%%~nA"
java -jar "%bin_path%\apktool.jar" d %decompile_option% "%selected_apk%" -o "%out_path%\%decompile_folder%"

echo.
pause
