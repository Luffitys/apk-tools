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

if "%~1"=="" (
    if not exist "%out_path%" (
        md "%out_path%"
    )

    echo.
    echo Please select the decompiled APK folder to compile:
    echo.
    pushd "%out_path%"
    set "apk_folders="
    set "folder_count=0"

    for /d %%F in (*) do (
        set /a "folder_count+=1"
        set "apk_folders[!folder_count!]=%%F"
        echo [!folder_count!] %%F
    )

    echo.
    set /p "selection=Enter the number of the APK folder to compile: "
    if not "!selection!" == "" (
        set "selected_folder="
        for %%i in (!selection!) do set "selected_folder=!apk_folders[%%i]!"
    )

    if not defined selected_folder (
        echo Invalid selection
        pause
        exit /b 1
    )

    set "folder_path=%out_path%\!selected_folder!"
    popd
) else (
    echo.
    echo Drag and drop is not supported
    echo.
    pause
    exit /b 1
)

call "scripts\dont_run-download-dependencies.bat"

java -jar "%bin_path%\apktool.jar" b "%folder_path%"

echo.
echo Do you want to re-install the APK via adb? [Y/n]
echo Default: No
set /p "do_adb=Option: "

if /i "%do_adb%" == "Y" (
    %bin_path%\adb.exe install -r "%folder_path%\dist\%selected_folder%.apk"
)

echo.
pause
