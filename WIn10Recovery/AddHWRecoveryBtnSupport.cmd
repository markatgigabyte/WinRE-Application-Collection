rem --AddHWRecoveryBtnSupport.cmd--
rem Create a folder on the system partition to hold boot files for the secondary boot path.
mkdir S:\EFI\Fabrikam
rem Copy a set of boot files from the \EFI\Microsoft folder to the new folder.
xcopy /e /h S:\EFI\Microsoft\* S:\EFI\Gigabyte\
rem Delete the BCD store that was copied to the new folder in the previous step.
del /a S:\EFI\Gigabyte\Boot\BCD
rem Create a new BCD store and configure the required entries for booting Windows RE.
bcdedit /createstore S:\BCD

bcdedit /store S:\BCD /create {bootmgr} /d "Windows Boot Manager"
bcdedit /store S:\BCD /set {bootmgr} device partition=S:
bcdedit /store S:\BCD /set {bootmgr} locale en-US
bcdedit /store S:\BCD /set {bootmgr} integrityservices Enable

bcdedit /store S:\BCD /create {11111111-1111-1111-1111-111111111111} /d "Windows Recovery" /device
bcdedit /store S:\BCD /set {11111111-1111-1111-1111-111111111111} ramdisksdidevice partition=T:
bcdedit /store S:\BCD /set {11111111-1111-1111-1111-111111111111} ramdisksdipath \Recovery\WindowsRE\boot.sdi

bcdedit /store S:\BCD /create {22222222-2222-2222-2222-222222222222} /d "Windows Recovery Environment" /application osloader
bcdedit /store S:\BCD /set {bootmgr} default {22222222-2222-2222-2222-222222222222}
bcdedit /store S:\BCD /set {bootmgr} displayorder {22222222-2222-2222-2222-222222222222}

bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} device ramdisk=[T:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} path \Windows\System32\winload.efi
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} locale en-US
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} displaymessage "Recovery"
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} osdevice ramdisk=[T:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} systemroot \Windows
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} nx OptIn
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} bootmenupolicy Standard
bcdedit /store S:\BCD /set {22222222-2222-2222-2222-222222222222} winpe Yes

rem Move the newly-created BCD store to the secondary boot path.
xcopy /h S:\BCD* S:\EFI\Gigabyte\Boot\.
del /a S:\BCD*
