@echo off
color 03
Mode 130,45
title Script StartPC
setlocal EnableDelayedExpansion

:: Dossier
mkdir C:\Users\%username%\Documents\SULFURAX\StartPC >nul 2>&1
mkdir C:\Users\%username%\Documents\SULFURAX\Backup >nul 2>&1
cd C:\Users\%username%\Documents\SULFURAX\StartPC >nul 2>&1

:: Run Admin
Reg.exe add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b

:: Show details BSOD
Reg add "HKLM\System\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d "1" /f >nul 2>&1

:: Blank/Color Character
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:: Add ANSI escape sequences
Reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:: Check Updates
goto CheckUpdates

:CheckUpdates
set local=1.0
set localtwo=%local%
if exist "%temp%\Updater.bat" DEL /S /Q /F "%temp%\Updater.bat" >nul 2>&1
curl -g -L -# -o "%temp%\Updater.bat" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/StartPC_Version" >nul 2>&1
call "%temp%\Updater.bat"
IF "%local%" gtr "%localtwo%" (
    curl -L -o %0 "https://github.com/SULFURA/StartPC/main/StartPC.cmd" >nul 2>&1
    call %0
	exit /b
)

:: Restore Point
powershell -ExecutionPolicy Unrestricted -NoProfile Enable-ComputerRestore -Drive 'C:\', 'D:\', 'E:\', 'F:\', 'G:\' >nul 2>&1
powershell -ExecutionPolicy Unrestricted -NoProfile Checkpoint-Computer -Description 'StartPC Restore Point' >nul 2>&1

::HKCU & HKLM backup
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set date1=%date:/=.%
>nul 2>&1 md C:\Users\%username%\Documents\SULFURAX\Backup\%date1%
reg export HKCU C:\Users\%username%\Documents\SULFURAX\Backup\%date1%\HKLM.reg /y >nul 2>&1
reg export HKCU C:\Users\%username%\Documents\SULFURAX\Backup\%date1%\HKCU.reg /y >nul 2>&1

:: Script
cls
goto Script 
title Script en cours...

:Script
::NSudo

:NSudo
C:
rmdir /S /Q "C:\Users\%username%\Documents\SULFURAX\StartPC\"
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\NSudo.exe" "https://github.com/SULFURA/StartPC/raw/main/files/NSudo.exe"

:: Services
goto Services

:Services
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\Services.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/Services.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\Services.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Cleanup
goto Cleanup

:Cleanup 
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\Cleanup.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/Cleanup.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\Cleanup.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: Cleanup Event Logs
goto CleanupEventLogs

:CleanupEventLogs
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\CleanupEventLogs.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/CleanupEventLogs.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\CleanupEventLogs.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Scoop Update / RM : Cleanup
goto scoop

:scoop
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\scoop.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/scoop.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
start scoop.cmd
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Set Priority
goto Priority

:Priority
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\Priority.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/Priority.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\Priority.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Refresh Network
goto RefreshNetwork

:RefreshNetwork
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\RefreshNetwork.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/RefreshNetwork.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\RefreshNetwork.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 20 /nobreak

:: Defrag
goto Defrag

:Defrag
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\Defrag.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/Defrag.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\Defrag.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: Checkup
goto Checkup

:Checkup
cls
curl -g -L -# -o "C:\Users\%username%\Documents\SULFURAX\StartPC\Checkup.cmd" "https://raw.githubusercontent.com/SULFURA/StartPC/main/files/Checkup.cmd"
cd "C:\Users\%username%\Documents\SULFURAX\StartPC\"
NSudo.exe -U:T -P:E "C:\Users\%username%\Documents\SULFURAX\StartPC\Checkup.cmd"
echo.
echo Don't touch anything, let the Script play alone
echo.
timeout /t 60 /nobreak

:: End
goto End

:End
cls
echo Fin du Script
title Fin du Script

:: Clear CMD + Exit
timeout /t 5 /nobreak
cls
exit

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul  
goto :eof