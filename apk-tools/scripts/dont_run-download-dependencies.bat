@echo off
call "scripts\dont_run-set-variables.bat"

if not exist "%bin_path%" (
    md "%bin_path%"
)
echo.

if not exist "%bin_path%\apktool.jar" (
    echo Downloading apktool
    curl -o "%bin_path%\apktool.jar" -sLJO https://github.com/iBotPeaches/Apktool/releases/download/v%apktool_ver%/apktool_%apktool_ver%.jar
)

if not exist "%bin_path%\apksigner.jar" (
    echo Downloading apksigner
    curl -o "%bin_path%\apksigner.jar" -sLJO https://github.com/patrickfav/uber-apk-signer/releases/download/v%apksigner_ver%/uber-apk-signer-%apksigner_ver%.jar
)

for %%f in (%adb_files%) do (
    if not exist "%bin_path%\%%f" (
        echo Downloading %%f
        curl -o "%bin_path%\%%f" -sLJO https://github.com/awake558/adb-win/blob/master/SDK_Platform-Tools_for_Windows/platform-tools_r%adb_ver%-windows/%%f
    )
)

if not exist "%bin_path%\7z.exe" (
    echo Downloading 7z
    curl -o "%bin_path%\7z.exe" -sLJO https://www.7-zip.org/a/7zr.exe
)