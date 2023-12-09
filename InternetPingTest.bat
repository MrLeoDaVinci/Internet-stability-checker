@echo off
setlocal enabledelayedexpansion

set "PASS=0"
set "FAIL=0"
set /a "MAX_TIME=0"
set "COUNTDOWN=5"

:Welcome
cls
echo Welcome to Leo's Internet Stability Checker.
echo Starting in !COUNTDOWN! seconds...    & timeout /nobreak /t 1 >nul
set /a "COUNTDOWN-=1"
if !COUNTDOWN! gtr 0 goto Welcome

:PingLoop
cls
echo Pinging Google...
ping -n 1 google.com >nul 2>&1
if !errorlevel! equ 0 (
    for /f "tokens=7 delims== " %%i in ('ping -4 -n 1 google.com ^| find "time="') do (
        set "pingTime=%%i"
        set "pingTime=!pingTime:~0,-2!"
        echo Response Time: !pingTime! ms

        set /a "PASS+=1"
        if !pingTime! gtr !MAX_TIME! set "MAX_TIME=!pingTime!"
    )
) else (
    echo Ping failed.
    set /a "FAIL+=1"
)

echo.
echo Pass Count: %PASS%
echo Fail Count: %FAIL%
echo Max Response Time: %MAX_TIME% ms

timeout /nobreak /t 1 >nul
goto PingLoop
