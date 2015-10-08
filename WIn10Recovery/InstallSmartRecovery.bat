
set TARGETDISK=0
set TARGETOSMODE="UEFI"
set USBDISKVOL=X:

rem Step1: Create RecoveryImage Partition
batch\BatchSubstitute.bat "$TARGETDISK" %TARGETDISK% CreateRecoveryPartitions-%TARGETOSMODE%.txt > CreateRecoveryPartitions.scp
diskpart /s CreateRecoveryPartitions.scp
mkdir r:\RecoveryImage
copy %USBDISKVOL%\RecoveryImage\Install.wim r:\RecoveryImage
mkdir r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\\BasicReset_AfterImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\\BasicReset_BeforeImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\\FactoryReset_AfterDiskFormat.cmd.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\\FactoryReset_AfterImageApply.cmd r:\RecoveryImage\OEM


copy  %USBDISKVOL%\RecoveryImage\OEM\Resetconfig-%TARGETOSMODE%.xml r:\RecoveryImage\Resetconfig.xml

copy %USBDISKVOL%\RecoveryImage\OEM\\ResetPartitions-BIOS.txt r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\\ResetPartitions-UEFI.txt r:\RecoveryImage\OEM





