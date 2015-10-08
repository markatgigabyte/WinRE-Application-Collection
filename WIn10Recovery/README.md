#Windows 10 Recovery System

目的: 提供流程給End User,以進行Windows System磁區備份及還原工作

1.利用USB Stick 進行備份及還原工作 2. 1.Shrink Partiton ,挖出15G空間,作為Recovery Image 儲存空間 2.產生install.wim 3.加入一鍵Reset

0.修改winre.wim增加Backup功能????????
1.針對沒有RecoveryImage 分割區的系統建立建立RecoveryImage分割區(16G)
2.備份System Image to Install.wim, 放入RecoveryImage分割區
3.加入一鍵reset 功能


BasicReset_BeforeImageApply











![Alt text](http://i.stack.imgur.com/9Ifmj.gif)
