rem AddOEMResetBtnSupport.cmd
mkdir -p r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\Resetconfig-%TARGETOSMODE%.xml r:\RecoveryImage\Resetconfig.xml
copy %USBDISKVOL%\RecoveryImage\OEM\BasicReset_AfterImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\SaveLogFiles.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\BasicReset_BeforeImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\RetrieveLogFiles.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\FactoryReset_AfterDiskFormat.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\CheckPartitions.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\FactoryReset_AfterImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\InstallApps.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\ResetPartitions-%TARGETOSMODE%.txt r:\RecoveryImage\OEM
