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
