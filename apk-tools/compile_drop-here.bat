@echo off
setlocal enabledelayedexpansion

where java >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Java is not installed. Please first install Java or add it to the Windows PATH environment.
    pause
    exit /b 1
)

if "%~1"=="" (
    echo Please select the decompiled APK folder to compile or drag and drop the folder here:
    pushd "out"
    set "apk_folders="
    set "folder_count=0"

    for /d %%F in (*) do (
        set /a "folder_count+=1"
        set "apk_folders[!folder_count!]=%%F"
        echo [!folder_count!] %%F
    )

    echo.
    set /p "selection=Enter the number of the APK folder to compile: "
    if not "%selection%" == "" (
        set "selected_folder=!apk_folders[%selection%]!"
    )

    if not defined selected_folder (
        echo Invalid selection. Enter a valid number or drag and drop an APK folder on the .bat.
        pause
        exit /b 1
    )
    set "filepath=!selected_folder!"
    popd
) else (
    set "filepath=%~1"
)

call "scripts\update-dependencies.bat"

java -jar "out\binaries\apktool.jar" b "%filepath%"

pause
