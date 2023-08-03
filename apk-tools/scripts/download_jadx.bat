@echo off
cd ..
call "scripts\dont_run-set-variables.bat"
call "scripts\dont_run-download-dependencies.bat"

if not exist "%bin_path%\jadx.exe" (
    echo Downloading nightly JADX
    curl -o "%bin_path%\jadx.zip" -sLJO https://nightly.link/skylot/jadx/workflows/build-artifacts/master/jadx-gui-%jadx_ver%-no-jre-win.exe.zip
    echo.
    echo Extracting JADX
    "%bin_path%\7z\7za.exe" x "%bin_path%\jadx.zip" -o"%bin_path%"
    del "%bin_path%\jadx.zip"
    ren "%bin_path%\jadx-gui-%jadx_ver%.exe" "jadx.exe"
    echo.
)
pause
