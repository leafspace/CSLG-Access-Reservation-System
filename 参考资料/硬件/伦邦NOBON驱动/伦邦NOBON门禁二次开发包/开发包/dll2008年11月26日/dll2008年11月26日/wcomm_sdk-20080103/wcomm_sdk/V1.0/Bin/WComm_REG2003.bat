REM 注册WComm_UDP,WComm_Serial
@echo off

REM 先解除WComm_Serial注册
regsvr32  /s /u WComm_Serial

REM 再注册WComm_Serial类
regsvr32 /s /i WComm_Serial

REM 注册WComm_UDP
regasm11 /tlb: WComm_UDP.tlb WComm_UDP.dll
gacutil2003 /I WComm_UDP.dll

set /p Finish=操作完成(按回车返回)
