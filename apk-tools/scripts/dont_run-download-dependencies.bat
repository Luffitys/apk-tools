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

if not exist "%bin_path%\7zr.exe" (
    echo Downloading 7zr
    curl -o "%bin_path%\7zr.exe" -sLJO https://www.7-zip.org/a/7zr.exe
)

if not exist "%bin_path%\7z" (
    echo Downloading 7z standalone
    curl -o "%bin_path%\7z.7z" -sLJO https://www.7-zip.org/a/7z2301-extra.7z
    echo Extracting 7z standalone
    "%bin_path%\7zr.exe" x "%bin_path%\7z.7z" -o"%bin_path%\7z"
    del "%bin_path%\7z.7z"
    echo.
)

if not exist "%bin_path%\mmt" (
    echo Downloading Magisk MMT template
    curl -o "%bin_path%\mmt.zip" -sLJO https://github.com/Zackptg5/MMT-Extended/archive/refs/heads/master.zip
    echo.
    echo Extracting Magisk MMT template
    "%bin_path%\7z\7za.exe" x "%bin_path%\mmt.zip" -o"%bin_path%\mmt"
    del "%bin_path%\mmt.zip"
    echo.
)