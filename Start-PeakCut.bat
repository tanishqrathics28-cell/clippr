@echo off
setlocal EnableDelayedExpansion
title PeakCut Studio Server

echo ========================================================
echo               PeakCut Studio Launcher                   
echo ========================================================
echo.

:: Ensure Python 3.12 and FFmpeg are in PATH
set "PYTHON_DIR=C:\Users\tanis\AppData\Local\Programs\Python\Python312"
set "FFMPEG_DIR=C:\Users\tanis\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg.Essentials_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0.1-essentials_build\bin"

if exist "%PYTHON_DIR%" (
    set "PATH=%PYTHON_DIR%;%PYTHON_DIR%\Scripts;%FFMPEG_DIR%;%PATH%"
)

:: Move to PeakCut project directory where studio module resides
set "DIR=%~dp0"
if exist "%DIR%studio\server.py" (
    cd /d "%DIR%"
) else if exist "%DIR%PeakCut-main\studio\server.py" (
    cd /d "%DIR%PeakCut-main"
)

if exist "%PYTHON_DIR%\python.exe" (
    set "PY_CMD=%PYTHON_DIR%\python.exe"
) else (
    set "PY_CMD=python"
)

echo [1/3] Environment ready: Python 3.12 and FFmpeg configured.
echo [2/3] Starting PeakCut Studio Web Server...
echo.
echo ========================================================
echo  Localhost URL:  http://127.0.0.1:8765
echo  Keep this window open while using PeakCut.
echo ========================================================
echo.

:: Launch browser after 2 seconds so the server has finished binding the port
start /b "" cmd /c "timeout /t 2 /nobreak >nul && start http://127.0.0.1:8765"

set "PYTHONUNBUFFERED=1"
"%PY_CMD%" -m studio.server

pause
