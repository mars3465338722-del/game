@echo off
chcp 65001 >nul
echo ============================================
echo   Batch rename PNG files to 1.png, 2.png ...
echo ============================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0rename.ps1"

echo.
echo Finished. Press any key to exit.
pause >nul