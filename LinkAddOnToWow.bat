@echo off
setlocal

:: 检查是否有两个参数 "D:\Program Files\World of Warcraft" SpellActionMonitor
if "%~2"=="" (
    echo Usage: %0 WowDir AddOnName
    exit /b
)

:: 设置变量 
set "WowDir=%~1"
set "AddOnName=%~2"

cd /d %~dp0%
set ProjectDir=%~dp0%

mklink /D "%WowDir%\_retail_\Interface\AddOns\%AddOnName%" "%ProjectDir%\AddOns\%AddOnName%"

@REM if %errorlevel% neq 0 (
@REM     echo Failed to create symbolic link.
@REM     exit /b
@REM ) else (
@REM     echo Symbolic link created successfully.
@REM )

endlocal