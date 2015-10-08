rem This script creates a system report by using the DirectX Diagnostic tool, and sends it to a new folder called C:\Fabrikam.
md C:\Fabrikam
C:\Windows\System32\dxdiag /t C:\Fabrikam\DxDiag-TestLogFiles.txt
