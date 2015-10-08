
set TARGETDISK=0
set TARGETOSMODE="UEFI"

rem Step1: Create RecoveryImage Partition
batch\BatchSubstitute.bat "$TARGETDISK" %TARGETDISK% CreateRecoveryPartitions-%TARGETOSMODE%.txt > CreateRecoveryPartitions.scp
diskpart /s CreateRecoveryPartitions.scp
mkdir r:\RecoveryImage
rem Step2: Create install.wim

rem Step3: create Resetconfig.xml 
batch\BatchSubstitute.bat "$TARGETDISK" %TARGETDISK% Resetconfig-%TARGETOSMODE%.xml > Resetconfig.xml
batch\BatchSubstitute.bat "$TARGETDISK" %TARGETDISK% Resetconfig-%TARGETOSMODE%.xml > Resetconfig.xml

rem BasicReset_AfterImageApply.cmd,
rem BasicReset_BeforeImageApply.cmd
rem FactoryReset_AfterDiskFormat.cmd
rem FactoryReset_AfterImageApply.cmd

rem Ste4: create ResetPartitions-BIOS.txt



