::@echo off
set "apktool_ver=2.8.1"
set "apksigner_ver=1.3.0"
set "adb_ver=33.0.3"

set "binaries_path=binaries"
set "apktool_path=%binaries_path%"
set "apksigner_path=%binaries_path%"

set "adb_path=%binaries_path%"
set "adb_files=adb.exe AdbWinApi.dll AdbWinUsbApi.dll"

if not exist "%binaries_path%" (
    md %binaries_path%
)

if not exist "%apktool_path%\apktool.jar" (
    echo Downloading apktool
    curl -o "%apktool_path%\apktool.jar" -sLJO https://github.com/iBotPeaches/Apktool/releases/download/v%apktool_ver%/apktool_%apktool_ver%.jar
)

if not exist "%apksigner_path%\apksigner.jar" (
    echo Downloading apksigner
    curl -o "%apksigner_path%\apksigner.jar" -sLJO https://github.com/patrickfav/uber-apk-signer/releases/download/v%apksigner_ver%/uber-apk-signer-%apksigner_ver%.jar
)

for %%f in (%adb_files%) do (
    if not exist "%adb_path%\%%f" (
        echo Downloading %%f
        REM curl -o "%adb_path%\%%f" -sLJO https://github.com/awake558/adb-win/blob/master/SDK_Platform-Tools_for_Windows/platform-tools_r%adb_ver%-windows/%%f
    )
)

if not exist "out" (
    md out
)
