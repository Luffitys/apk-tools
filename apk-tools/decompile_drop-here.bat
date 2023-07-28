::@echo off
setlocal enabledelayedexpansion

where java >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Java is not installed. Install Java or add it to the PATH environment.
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

for %%F in ("%input_path%\*.apk") do (
    set /a "file_count+=1"
    echo !file_count!. %%~nxF
    set "apk_files=!apk_files! "%%~dpnxF""
)

if "%file_count%" == "0" (
    echo No APK file found at input path (%input_path%)
    echo Please put an APK file there or use drag and drop on the .bat
    pause
    exit /b 1
)

echo.
set /p "selection=Enter the number of the APK file to decompile, or drag and drop an APK file on the .bat: "

if not "%selection%" == "" (
    set "selected_apk="
    for /f "tokens=%selection%" %%F in ("%apk_files%") do set "selected_apk=%%~F"
)

if not defined selected_apk (
    echo Invalid selection. Enter a valid number or drag and drop an APK file on the .bat.
    pause
    exit /b 1
)

:SelectOptions
echo Select an option:
echo [1] Decompile dex (classes.dex)
echo [2] Decompile resources (res/)

set /p "decompile_choice=Enter option number or press Enter to decompile both: "

if "%decompile_choice%" == "1" set "decompile_options=--no-res"
if "%decompile_choice%" == "2" set "decompile_options=--no-src"

call "scripts\update-dependencies.bat"

for %%A in ("%selected_apk%") do set "decompile_folder=%%~nA"
java -jar "binaries\apktool.jar" d %decompile_options% "%selected_apk%" -o "out\%decompile_folder%"

pause
