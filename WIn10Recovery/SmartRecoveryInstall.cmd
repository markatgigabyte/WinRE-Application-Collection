rem SmartRecoveryInstall.cmd
set TARGETDISK=0
set RECOVERYPARTIONSIZE=15000
set TARGETOSMODE="UEFI"
set USBDISKVOL=X:


rem Create RecoveryImage Partition
batch\BatchSubstitute.bat "$TARGETDISK$" %TARGETDISK% CreateRecoveryPartitions-%TARGETOSMODE%.txt > CreateRecoveryPartitions.scp
batch\BatchSubstitute.bat "$RECOVERYPARTIONSIZE$" %RECOVERYPARTIONSIZE% CreateRecoveryPartitions.scp > CreateRecoveryPartitions.scp
diskpart /s CreateRecoveryPartitions.scp


mkdir r:\RecoveryImage
copy %USBDISKVOL%\RecoveryImage\Install.wim r:\RecoveryImage

rem Add a Script to Push-Button Reset Features
AddOEMResetBtnSupport.cmd
rem Add a Hardware Recovery Button to Start Windows RE
AddHWRecoveryBtnSupport.cmd
rem Add a Custom Tool to the Windows RE Boot Options Menu
AddCustomToolBtnSupport.cmd

rem Hide Recovery & WinRE Partition
batch\BatchSubstitute.bat "$TARGETDISK$" %TARGETDISK% HideRecoveryPartitions-%TARGETOSMODE%.txt > HideRecoveryPartitions.scp
diskpart /s HideRecoveryPartitions.scp

