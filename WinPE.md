WinPE.md
=======


+ [Windows Preinstallation Environment Wiki](https://en.wikipedia.org/wiki/Windows_Preinstallation_Environment)
+ [Wpeutil Command-Line Options](https://technet.microsoft.com/en-us/library/hh824818.aspx)
+ [WinPE for Windows 8.1: Windows PE 5.1 ](https://technet.microsoft.com/en-us/library/hh825110.aspx)
+ WinPE for Windows 8: Windows PE 5.0
+ WinPE for WIndows 10: Windows PE 10.0

####Detect whether Windows PE is booted in BIOS or UEFI mode
```
wpeutil UpdateBootInfo
for /f "tokens=2* delims=  " %%A in ('reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType') DO SET Firmware=%%B
:: Note: delims is a TAB followed by a space.
if %Firmware%==0x1 echo The PC is booted in BIOS mode.
if %Firmware%==0x2 echo The PC is booted in UEFI mode.
```
