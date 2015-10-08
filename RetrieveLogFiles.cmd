:rem === RetrieveLogFiles.cmd - UTF-8 File format ===

:rem == This sample script retrieves the files that 
:rem    were saved in memory by 
:rem    SaveLogFiles.cmd,
:rem    and adds them back to the system.
:rem

:rem == 1. Use the registry to identify the location of
:rem       the new operating system and the primary hard
:rem       drive. For example, 
:rem       %TARGETOS% may be defined as C:\Windows
:rem       %TARGETOSDRIVE% may be defined as C:
for /F "tokens=1,2,3 delims= " %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RecoveryEnvironment" /v TargetOS') DO SET TARGETOS=%%C

for /F "tokens=1 delims=\" %%A in ('Echo %TARGETOS%') DO SET TARGETOSDRIVE=%%A

:rem == 2. Copy the old logs to the new OS 
:rem       at C:\Windows\OldLogs
mkdir %TARGETOS%\OldLogs
xcopy X:\Temp\*.* %TARGETOS%\OldLogs /cherkyi

EXIT 0
