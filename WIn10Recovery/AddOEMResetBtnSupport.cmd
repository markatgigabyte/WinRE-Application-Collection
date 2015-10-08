rem AddOEMResetBtnSupport.cmd
mkdir r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\BasicReset_AfterImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\BasicReset_BeforeImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\FactoryReset_AfterDiskFormat.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\FactoryReset_AfterImageApply.cmd r:\RecoveryImage\OEM
copy %USBDISKVOL%\RecoveryImage\OEM\Resetconfig-%TARGETOSMODE%.xml r:\RecoveryImage\Resetconfig.xml
copy %USBDISKVOL%\RecoveryImage\OEM\ResetPartitions-%TARGETOSMODE%.txt r:\RecoveryImage\OEM
