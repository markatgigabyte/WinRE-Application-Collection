:rem == SaveLogFiles.cmd

:rem == This sample script preserves files that would 
:rem    otherwise be removed by placing them in a 
:rem    temporary location in memory, to be retrieved by
:rem    RetrieveLogFiles.cmd.

:rem == 1. Use the registry to identify the location of
:rem       the new operating system and the primary hard
:rem       drive. For example, 
:rem       %TARGETOS% may be defined as C:\Windows
:rem       %TARGETOSDRIVE% may be defined as C:
for /F "tokens=1,2,3 delims= " %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RecoveryEnvironment" /v TargetOS') DO SET TARGETOS=%%C

for /F "tokens=1 delims=\" %%A in ('Echo %TARGETOS%') DO SET TARGETOSDRIVE=%%A

:rem == 2. Copy old logs to a temporary folder in memory
mkdir X:\Temp
xcopy %TARGETOS%\Logs\*.* X:\temp /cherkyi

EXIT 0
