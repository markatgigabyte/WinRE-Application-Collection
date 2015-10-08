:rem == RetrieveLogFiles.cmd

:rem == This sample script retrieves the files that 
:rem    were saved in memory by 
:rem    SaveLogFiles.cmd,
:rem    and adds them back to the system.
:rem
:rem    It also runs a system diagnostic, and sends the output
:rem    to the C:\Fabrikam folder.


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

:rem == 3. Run system diagnostics using the
:rem       DirectX Diagnostic tool, and save the 
:rem       results to the C:\Fabrikam folders. ==

mkdir %TARGETOSDRIVE%\Gigabyte
%TARGETOS%\system32\dxdiag.exe /whql:off /t %TARGETOSDRIVE%\Gigabyte\DxDiag-TestLogFiles.txt

EXIT 0
