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
####WinPE: Mount and Customize
```
Dism /Mount-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"C:\WinPE_amd64\mount"
//Add customizations
Dism /Unmount-Image /MountDir:"C:\WinPE_amd64\mount" /commit
MakeWinPEMedia /UFD C:\WinPE_amd64 F:
```
####WinPE: Adding PowerShell support to Windows PE
```
Dism /Mount-Image /ImageFile:"C:\WinPE_amd64_PS\media\sources\boot.wim" /Index:1 /MountDir:"C:\WinPE_amd64_PS\mount"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFX.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"

Dism /Add-Package /Image:"C:\WinPE_amd64_PS\mount" /PackagePath:"C:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"

Dism /Unmount-Image /MountDir:C:\WinPE_amd64_PS\mount /Commit
```
####Winpeshl.exe/Winpeshl.ini or cmd.exe/startnet.cmd
By default, Winpeshl.exe is the first process run when Windows PE is booted. This is specified by the following registry value of type REG_SZ.
```
HKEY_LOCAL_MACHINE
   System
      Setup
         CmdLine
```
Winpeshl.exe searches for a file called Winpeshl.ini. If the file does not exist, Winpeshl.exe starts a Cmd.exe process that executes the Startnet.cmd script. If Winpeshl.ini does exist and it contains apps to launch, these apps are executed instead of Cmd.exe.

####Wpeinit.exe, wpeutil.exe, and wpeutil.dll
Startnet.cmd starts Wpeinit.exe. Wpeinit.exe installs Plug and Play devices, processes Unattend.xml settings, and loads network resources.
Wpeinit.exe installs Plug and Play (PnP) devices, starting the networking stack, and processing Unattend.xml settings when Windows PE starts. For more information, see Wpeinit and Startnet.cmd: Using WinPE startup scripts.
Networking can be started at any time by running either by allowing Wpeinit.exe to run when Windows PE starts, or by running the Wpeutil Command-Line Options command.
Customized shell apps can call directly into Wpeutil.dll with the LoadLibrary and GetProcAddress functions. For related information, see INFO: Alternatives to Using GetProcAddress() With LoadLibrary().


####WinPE: Create USB Bootable drive
```
diskpart
  list disk
  select disk <disk number>
  clean
  create partition primary
  format quick fs=fat32 label="Windows PE"
  assign letter="F"
  exit

MakeWinPEMedia /UFD C:\winpe_amd64 F:
```
####WinPE: Create a Boot CD, DVD, ISO, or VHD
```
MakeWinPEMedia /ISO C:\WinPE_amd64 C:\WinPE_amd64\WinPE_amd64.iso
```
####WinPE: Create a Boot VHD
```
diskpart
create vdisk file="C:\WinPE.vhdx" maximum=1000
attach vdisk
create partition primary
assign letter=V
format fs=ntfs quick
exit

MakeWinPEMedia /UFD C:\WinPE_amd64 V:

diskpart
select vdisk file="C:\WinPE.vhdx"
detach vdisk
exit
```
####WinPE: Install on a Hard Drive (Flat Boot or Non-RAM)
```
diskpart
list disk
select <disk number>
clean
rem === Create the Windows PE partition. ===
create partition primary size=2000
format quick fs=fat32 label="Windows PE"
assign letter=P
active
rem === Create a data partition. ===
create partition primary
format fs=ntfs quick label="Other files"
assign letter=O
list vol
exit

dism /Apply-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /Index:1 /ApplyDir:P:\
```
