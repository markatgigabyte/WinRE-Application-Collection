#Add a Hardware Recovery Button to Start Windows RE

REF: https://technet.microsoft.com/zh-tw/library/jj631607.aspx

![UEFI Disk Layout](https://camo.githubusercontent.com/c672b20837d8586a808377a7af87e32da305535c/68747470733a2f2f692d746563686e65742e7365632e732d6d7366742e636f6d2f656e2d75732f6c6962726172792f646e3632313839302e61613166666432362d663833352d346537332d613139612d66633136316638623363383528763d77696e2e3130292e6a70673f74647569643d283538633433353435336364303734323666656433333532333537633437316565292832353633383029283234353935393429285864536e30653368332e6b2d764b75444c78344e5f43696d4b66357a366474793077292829)

T: WinRE Tools

S: System (Efi System Partition)

C: Windows



註: BIOS Mode時 , WinRE Tools至於 C:\Recovery目錄下

```
diskpart
select disk 0
select partition 1
assign letter="T"
select partition 2
assign letter="S"
exit
```

```
mkdir S:\EFI\Fabrikam
xcopy /e /h S:\EFI\Microsoft\* S:\EFI\Fabrikam\
del /a S:\EFI\Fabrikam\Boot\BCD
```

建立新的 BCD 存放區，並設定 Windows RE 開機所需的項目。

```
bcdedit /createstore S:\BCD
rem 當UEFI BIOS由這Boot時 ,呼叫執行WinRE osloader {22222222-2222-2222-2222-222222222222}
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

bcdedit /store S:\BCD /set {default} device ramdisk=[T:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {default} path \Windows\System32\winload.efi
bcdedit /store S:\BCD /set {default} locale en-US
bcdedit /store S:\BCD /set {default} displaymessage "Recovery"
bcdedit /store S:\BCD /set {default} osdevice ramdisk=[T:]\Recovery\WindowsRE\winre.wim,{11111111-1111-1111-1111-111111111111}
bcdedit /store S:\BCD /set {default} systemroot \Windows
bcdedit /store S:\BCD /set {default} nx OptIn
bcdedit /store S:\BCD /set {default} bootmenupolicy Standard
bcdedit /store S:\BCD /set {default} winpe Yes
```
將新建立的 BCD 存放區移到次要開機路徑。
```
xcopy /h S:\BCD* S:\EFI\Fabrikam\Boot\.
del /a S:\BCD*
```
在韌體開機順序清單結尾建立新的開機裝置項目。該項目應該指向：S:\EFI\Fabrikam\Boot\bootmgfw.efi。
設定讓韌體在按下硬體按鈕時使用新建立的開機裝置項目。

使用 DiskPart 隱藏 ESP 和 Windows RE 工具磁碟分割。

```
select disk 0
select partition 1
remove
set id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
gpt attributes=0x8000000000000001
select partition 2
remove
gpt attributes=0x8000000000000001
exit
```
