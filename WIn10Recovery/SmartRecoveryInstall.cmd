rem SmartRecoveryInstall.cmd
set TARGETDISK=0
set RECOVERYPARTIONSIZE=15000
set TARGETOSMODE="UEFI"
set USBDISKVOL=X:


rem Create RecoveryImage Partition
%USBDISKVOL%\batch\BatchSubstitute.bat "$TARGETDISK$" %TARGETDISK% %USBDISKVOL%\OEM\CreateRecoveryPartitions-%TARGETOSMODE%.txt > CreateRecoveryPartitions.scp
%USBDISKVOL%\batch\BatchSubstitute.bat "$RECOVERYPARTIONSIZE$" %RECOVERYPARTIONSIZE% CreateRecoveryPartitions.scp > CreateRecoveryPartitions.scp
diskpart /s CreateRecoveryPartitions.scp


mkdir r:\RecoveryImage
copy %USBDISKVOL%\RecoveryImage\Install.wim r:\RecoveryImage

rem Add a Script to Push-Button Reset Features
%USBDISKVOL%\OEM\AddOEMResetBtnSupport.cmd
rem Add a Hardware Recovery Button to Start Windows RE
%USBDISKVOL%\OEM\AddHWRecoveryBtnSupport.cmd
rem Add a Custom Tool to the Windows RE Boot Options Menu
%USBDISKVOL%\OEM\AddCustomToolBtnSupport.cmd

rem Hide Recovery & WinRE Partition
%USBDISKVOL%\batch\BatchSubstitute.bat "$TARGETDISK$" %TARGETDISK% %USBDISKVOL%\OEM\HideRecoveryPartitions-%TARGETOSMODE%.txt > HideRecoveryPartitions.scp
diskpart /s HideRecoveryPartitions.scp

