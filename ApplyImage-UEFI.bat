rem == ApplyImage-UEFI.bat ==

rem == These commands deploy a specified Windows
rem    image file to the Windows partition, and configure
rem    the system partition.

rem    Usage:   ApplyImage WimFileName 
rem    Example: ApplyImage E:\Images\ThinImage.wim ==

rem == Copy the image to the recovery partition ==
md R:\RecoveryImage
copy %1 R:\RecoveryImage\Install.wim

rem == Apply the image to the Windows partition ==
dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:C:\

rem == Copy boot files to the System partition ==
C:\Windows\System32\bcdboot C:\Windows /s S:

:rem == Copy the Windows RE image to the
:rem    Windows RE Tools partition ==
md T:\Recovery\WindowsRE
xcopy /h C:\Windows\System32\Recovery\Winre.wim T:\Recovery\WindowsRE\

:rem == Register the location of the recovery tools ==
C:\Windows\System32\Reagentc /Setreimage /Path T:\Recovery\WindowsRE /Target C:\Windows

:rem == Register the location of the
:rem    push-button reset recovery image. ==
C:\Windows\System32\Reagentc /Setosimage /Path R:\RecoveryImage /Target C:\Windows /Index 1

:rem == Restrict permissions of recovery folder to local Admin group
C:\Windows\System32\icacls R:\RecoveryImage /inheritance:r /T
C:\Windows\System32\icacls R:\RecoveryImage /grant:r SYSTEM:(F) /T
C:\Windows\System32\icacls R:\RecoveryImage /grant:r *S-1-5-32-544:(F) /T

:rem == Verify the configuration status of the images. ==
C:\Windows\System32\Reagentc /Info /Target C:\Windows
