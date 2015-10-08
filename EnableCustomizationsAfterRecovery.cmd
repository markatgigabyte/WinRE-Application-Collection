rem EnableCustomizationsAfterRecovery.cmd
set ScriptFolder=%~dp0

for /f "skip=2 tokens=2,*" %%a in ('reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RecoveryEnvironment" /v "TargetOS"') do set "TargetOS=%%b"
echo TargetOS: %TargetOS% >> %LogFile%
for %%A in (%TargetOS%) do set "TargetOSDrive=%%~dpA"

copy "%ScriptFolder%\Unattend.xml" "%TargetOSDrive%\Windows\Panther\Unattend.xml" /y
copy "%ScriptFolder%\LayoutModification.xml" "%TargetOSDrive%\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml" /y
copy "%ScriptFolder%\oobe.xml" "%TargetOSDrive%\System32\Info\Oobe.xml" /y
