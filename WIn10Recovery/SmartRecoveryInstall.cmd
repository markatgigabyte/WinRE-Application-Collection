rem SmartRecoveryInstall.cmd
set TARGETDISK=0
set RECOVERYPARTIONSIZE=15000
set TARGETOSMODE="UEFI"
set USBDISKVOL=X:


rem Step1: Create RecoveryImage Partition
batch\BatchSubstitute.bat "$TARGETDISK$" %TARGETDISK% CreateRecoveryPartitions-%TARGETOSMODE%.txt > CreateRecoveryPartitions.scp
batch\BatchSubstitute.bat "$RECOVERYPARTIONSIZE$" %RECOVERYPARTIONSIZE% CreateRecoveryPartitions.scp > CreateRecoveryPartitions.scp
diskpart /s CreateRecoveryPartitions.scp
mkdir r:\RecoveryImage
copy %USBDISKVOL%\RecoveryImage\Install.wim r:\RecoveryImage


OEMResetBtnSupport.cmd
HWRecoveryBtnSupport.cmd
CustomToolBtnSupport.cmd


