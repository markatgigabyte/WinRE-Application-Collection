#Windows 10 Recovery System

目的: 提供流程給End User,以進行Windows System磁區備份及還原工作

1.利用USB Stick 進行備份及還原工作 2. 1.Shrink Partiton ,挖出15G空間,作為Recovery Image 儲存空間 2.產生install.wim 3.加入一鍵Reset

0.修改winre.wim增加Backup功能????????
1.針對沒有RecoveryImage 分割區的系統建立建立RecoveryImage分割區(16G)
2.備份System Image to Install.wim, 放入RecoveryImage分割區
3.加入一鍵reset 功能

https://msdn.microsoft.com/zh-tw/library/windows/hardware/dn938312(v=vs.85).aspx

![aaaa](https://i-technet.sec.s-msft.com/en-us/library/dn621890.aa1ffd26-f835-4e73-a19a-fc161f8b3c85(v=win.10).jpg?tduid=(58c435453cd07426fed3352357c471ee)(256380)(2459594)(XdSn0e3h3.k-vKuDLx4N_CimKf5z6dty0w)())

![bbb](https://i-technet.sec.s-msft.com/en-us/library/dn621890.53744847-f2a3-4133-8fe2-f9fe788ee12e(v=win.10).jpg?tduid=(58c435453cd07426fed3352357c471ee)(256380)(2459594)(XdSn0e3h3.k-vKuDLx4N_CimKf5z6dty0w)())




BasicReset_BeforeImageApply

在單一 ResetConfig.xml 檔案中，您可以指定最多四個 Run 區段。不過，每個 Run 區段針對階段屬性必須包含不同的值。











![Alt text](http://i.stack.imgur.com/9Ifmj.gif)
