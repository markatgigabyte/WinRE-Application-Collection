:rem === RunDxDiag.cmd - UTF-8 File format ===

:rem == This sample script runs a system diagnostic,
:rem    and sends the output to the C:\Fabrikam folder.


:rem == 1. Use the registry to identify the location of
:rem       the new operating system and the primary hard
:rem       drive. For example, 
:rem       %TARGETOS% may be defined as C:\Windows
:rem       %TARGETOSDRIVE% may be defined as C:
for /F "tokens=1,2,3 delims= " %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RecoveryEnvironment" /v TargetOS') DO SET TARGETOS=%%C

:rem == 2. Run system diagnostics using the
:rem       DirectX Diagnostic tool, and save the 
:rem       results to the C:\Fabrikam folder. ==

mkdir %TARGETOSDRIVE%\Fabrikam
%TARGETOS%\system32\dxdiag.exe /whql:off /t %TARGETOSDRIVE%\Fabrikam\DxDiag-TestLogFiles.txt

EXIT 0
