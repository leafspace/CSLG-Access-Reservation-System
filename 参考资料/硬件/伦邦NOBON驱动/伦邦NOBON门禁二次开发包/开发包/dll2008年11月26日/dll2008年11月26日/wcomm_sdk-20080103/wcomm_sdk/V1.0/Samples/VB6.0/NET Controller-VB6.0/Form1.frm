VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   7965
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9930
   LinkTopic       =   "Form1"
   ScaleHeight     =   7965
   ScaleWidth      =   9930
   StartUpPosition =   3  '窗口缺省
   Begin VB.TextBox TextGateway1 
      Height          =   270
      Left            =   120
      TabIndex        =   21
      Text            =   "192"
      Top             =   3000
      Width           =   375
   End
   Begin VB.TextBox TextGateway2 
      Height          =   270
      Left            =   675
      TabIndex        =   20
      Text            =   "168"
      Top             =   3000
      Width           =   375
   End
   Begin VB.TextBox TextGateway3 
      Height          =   270
      Left            =   1245
      TabIndex        =   19
      Text            =   "168"
      Top             =   3000
      Width           =   375
   End
   Begin VB.TextBox TextGateway4 
      Height          =   270
      Left            =   1800
      TabIndex        =   18
      Text            =   "254"
      Top             =   3000
      Width           =   375
   End
   Begin VB.TextBox TextMask1 
      Height          =   270
      Left            =   120
      TabIndex        =   16
      Text            =   "255"
      Top             =   2160
      Width           =   375
   End
   Begin VB.TextBox TextMask2 
      Height          =   270
      Left            =   675
      TabIndex        =   15
      Text            =   "255"
      Top             =   2160
      Width           =   375
   End
   Begin VB.TextBox TextMask3 
      Height          =   270
      Left            =   1245
      TabIndex        =   14
      Text            =   "255"
      Top             =   2160
      Width           =   375
   End
   Begin VB.TextBox TextMask4 
      Height          =   270
      Left            =   1800
      TabIndex        =   13
      Text            =   "0"
      Top             =   2160
      Width           =   375
   End
   Begin VB.TextBox TextIP4 
      Height          =   270
      Left            =   1800
      TabIndex        =   12
      Text            =   "90"
      Top             =   1440
      Width           =   375
   End
   Begin VB.TextBox TextIP3 
      Height          =   270
      Left            =   1240
      TabIndex        =   11
      Text            =   "168"
      Top             =   1440
      Width           =   375
   End
   Begin VB.TextBox TextIP2 
      Height          =   270
      Left            =   680
      TabIndex        =   10
      Text            =   "168"
      Top             =   1440
      Width           =   375
   End
   Begin VB.TextBox TextIP1 
      Height          =   270
      Left            =   120
      TabIndex        =   8
      Text            =   "192"
      Top             =   1440
      Width           =   375
   End
   Begin VB.TextBox TextSN 
      Height          =   375
      Left            =   600
      TabIndex        =   3
      Text            =   "39990"
      Top             =   240
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Exit"
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   4200
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   7815
      Left            =   2280
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   120
      Width           =   7455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Test"
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Top             =   3720
      Width           =   1095
   End
   Begin VB.Label Label7 
      Caption         =   ".     .     .    ."
      Height          =   375
      Left            =   570
      TabIndex        =   22
      Top             =   3105
      Width           =   2040
   End
   Begin VB.Label Label6 
      Caption         =   ".     .     .    ."
      Height          =   375
      Left            =   570
      TabIndex        =   17
      Top             =   2265
      Width           =   2040
   End
   Begin VB.Label Label5 
      Caption         =   ".     .     .    ."
      Height          =   375
      Left            =   570
      TabIndex        =   9
      Top             =   1545
      Width           =   2040
   End
   Begin VB.Label Label4 
      Caption         =   "Gateway:"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Mask:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "New IP:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "SN:"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   360
      Width           =   495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long) '延时

Private Sub Command1_Click()
        '.NET通信操作 (案例针对controllerSN操作)
        Dim wudp As WComm_UDP.WComm_Operate '操作UDP对象
        Dim strFrame As String      '返回的数据
        Dim strCmd As String        '要发送的指令帧
        Dim ret    As Long          '函数的返回值
        Dim controllerSN As Long    '控制器序列号
        
        '刷卡记录变量
        Dim cardId As Long          '卡号
        Dim status As Long          '状态
        Dim swipeDate As String     '日期时间
        
        Dim strRunDetail As String  '运行信息
        
        Dim ipAddr As String        'ip地址
        Dim strMac As String        'MAC地址
        Dim strHexNewIP As String   'New IP (十六进制)
        Dim strHexMask As String    '掩码(十六进制)
        Dim strHexGateway As String '网关(十六进制)
     
        Set wudp = New WComm_UDP.WComm_Operate  '新建
        
        controllerSN = Me.TextSN.Text         '测试使用的.NET控制器
        ipAddr = ""                 '为空, 表示广播包方式
        
        Me.Text1.Text = "控制器通信" & "-" & controllerSN & "-.NET"
       
        '读取运行状态信息
        strCmd = wudp.CreateBstrCommand(controllerSN, "8110" & wudp.NumToStrHex(0, 3)) '生成指令帧 wudp.NumToStrHex(0,3) 表示第0个记录, 也就最新记录
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                                '发送指令, 并获取返回信息

        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "读取运行信息失败"
            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "读取运行信息成功"

            '对运行信息的详细分析
            '控制器的当前时间
            strRunDetail = ""
            strRunDetail = strRunDetail & vbCrLf & "设备序列号S/N: " & vbTab & wudp.GetSNFromRunInfo(strFrame)
            strRunDetail = strRunDetail & vbCrLf & "设备时钟:      " & vbTab & wudp.GetClockTimeFromRunInfo(strFrame)
            strRunDetail = strRunDetail & vbCrLf & "刷卡记录数:    " & vbTab & wudp.GetCardRecordCountFromRunInfo(strFrame)
            strRunDetail = strRunDetail & vbCrLf & "权限数:        " & vbTab & wudp.GetPrivilegeNumFromRunInfo(strFrame)
            strRunDetail = strRunDetail & vbCrLf & vbCrLf & "最近的一条刷卡记录: " & vbTab
            swipeDate = wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status)

            If swipeDate <> "" Then
                  strRunDetail = strRunDetail & vbCrLf & "卡号: " & cardId & vbTab & " 状态:" & vbTab & status & "(" & wudp.NumToStrHex(status, 1) & ")" & vbTab & "时间:" & vbTab & swipeDate
            End If

            '门磁按钮状态
            'Bit位     7     6       5       4        3       2       1       0
            '说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
            strRunDetail = strRunDetail & vbCrLf & "门磁状态  1号门磁 2号门磁 3号门磁 4号门磁"
            strRunDetail = strRunDetail & vbCrLf
            strRunDetail = strRunDetail & "          "
            If wudp.GetDoorStatusFromRunInfo(strFrame, 1) = 1 Then
                strRunDetail = strRunDetail & "   开   "
            Else
                strRunDetail = strRunDetail & "   关   "
            End If
            If wudp.GetDoorStatusFromRunInfo(strFrame, 2) = 1 Then
                strRunDetail = strRunDetail & "   开   "
            Else
                strRunDetail = strRunDetail & "   关   "
            End If
            If wudp.GetDoorStatusFromRunInfo(strFrame, 3) = 1 Then
                strRunDetail = strRunDetail & "   开   "
            Else
                strRunDetail = strRunDetail & "   关   "
            End If
            If wudp.GetDoorStatusFromRunInfo(strFrame, 4) = 1 Then
                strRunDetail = strRunDetail & "   开   "
            Else
                strRunDetail = strRunDetail & "   关   "
            End If

            strRunDetail = strRunDetail & vbCrLf
            strRunDetail = strRunDetail & "按钮状态  1号按钮 2号按钮 3号按钮 4号按钮"
            strRunDetail = strRunDetail & vbCrLf
            strRunDetail = strRunDetail & "          "
            If wudp.GetButtonStatusFromRunInfo(strFrame, 1) = 1 Then
                strRunDetail = strRunDetail & " 松开   "
            Else
                strRunDetail = strRunDetail & " 按下   "
            End If
            If wudp.GetButtonStatusFromRunInfo(strFrame, 2) = 1 Then
                strRunDetail = strRunDetail & " 松开   "
            Else
                strRunDetail = strRunDetail & " 按下   "
            End If
            If wudp.GetButtonStatusFromRunInfo(strFrame, 3) = 1 Then
                strRunDetail = strRunDetail & " 松开   "
            Else
                strRunDetail = strRunDetail & " 按下   "
            End If
            If wudp.GetButtonStatusFromRunInfo(strFrame, 4) = 1 Then
                strRunDetail = strRunDetail & " 松开   "
            Else
                strRunDetail = strRunDetail & " 按下   "
            End If

            strRunDetail = strRunDetail & vbCrLf & "故障状态:" & vbTab
            Dim errorNo As Integer
            errorNo = wudp.GetErrorNoFromRunInfo(strFrame)
            If errorNo = 0 Then
                strRunDetail = strRunDetail & " 无故障   "
            Else
                strRunDetail = strRunDetail & " 有故障  "
                If (errorNo And 1) Then
                    strRunDetail = strRunDetail & vbCrLf & "        " & vbTab & "系统故障1"
                End If
                If errorNo And 2 Then
                    strRunDetail = strRunDetail & vbCrLf & "        " & vbTab & "系统故障2"
                End If
                If errorNo And 4 Then
                    strRunDetail = strRunDetail & vbCrLf & "        " & vbTab & "系统故障3[设备时钟有故障], 请校正时钟处理"
                End If
                If errorNo And 8 Then
                    strRunDetail = strRunDetail & vbCrLf & "        " & vbTab & "系统故障4"
                End If
            End If
            Me.Text1.Text = Me.Text1.Text & strRunDetail
        End If

        DoEvents
        
        '查询控制器的IP设置
        '读取网络配置信息指令
        strCmd = wudp.CreateBstrCommand(controllerSN, "0111")  '生成指令帧 读取网络配置信息指令
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                     '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
             '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            
            Set wudp = Nothing
            Exit Sub
        Else
            Dim startLoc As Integer
            Dim deviceInfo As String
            '
            deviceInfo = ""

            'MAC
            startLoc = 11
            deviceInfo = deviceInfo & vbCrLf & "MAC:" & vbTab & vbTab & (Mid$(strFrame, startLoc, 2))
            deviceInfo = deviceInfo & "-" & (Mid$(strFrame, startLoc + 2, 2))
            deviceInfo = deviceInfo & "-" & (Mid$(strFrame, startLoc + 4, 2))
            deviceInfo = deviceInfo & "-" & (Mid$(strFrame, startLoc + 6, 2))
            deviceInfo = deviceInfo & "-" & (Mid$(strFrame, startLoc + 8, 2))
            deviceInfo = deviceInfo & "-" & (Mid$(strFrame, startLoc + 10, 2))
            strMac = (Mid$(strFrame, startLoc, 12))

            'IP
            startLoc = 23
            deviceInfo = deviceInfo & vbCrLf & "IP:" & vbTab & vbTab & CLng("&H" & (Mid$(strFrame, startLoc, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 2, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 4, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 6, 2)))

            'Subnet Mask
            startLoc = 31
            deviceInfo = deviceInfo & vbCrLf & "子网掩码:" & vbTab & CLng("&H" & (Mid$(strFrame, startLoc, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 2, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 4, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 6, 2)))

            'Default Gateway
            startLoc = 39
            deviceInfo = deviceInfo & vbCrLf & "网关:" & vbTab & vbTab & CLng("&H" & (Mid$(strFrame, startLoc, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 2, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 4, 2)))
            deviceInfo = deviceInfo & "." & CLng("&H" & (Mid$(strFrame, startLoc + 6, 2)))

            'UDP Port
            startLoc = 47
            deviceInfo = deviceInfo & vbCrLf & "PORT:" & vbTab & vbTab & CLng("&H" & (Mid$(strFrame, startLoc + 2, 2)) & (Mid$(strFrame, startLoc, 2)))
            Me.Text1.Text = Me.Text1.Text & (vbCrLf & deviceInfo & vbCrLf)
        End If
      
        Me.Text1.Text = Me.Text1.Text & vbCrLf & "开始IP地址设置: " & vbCrLf & "IP 192.168.168.90/Mask 255.255.255.0/Gateway 192.168.168.254: Port 60000"
        
        DoEvents
        
       '新的IP设置: (MAC不变) IP地址: 192.168.168.90; 掩码: 255.255.255.0; 网关: 192.168.168.254; 端口: 60000
        strHexNewIP = wudp.NumToStrHex(Me.TextIP1.Text, 1) & wudp.NumToStrHex(Me.TextIP2.Text, 1) & wudp.NumToStrHex(Me.TextIP3.Text, 1) & wudp.NumToStrHex(Me.TextIP4.Text, 1)
        strHexMask = wudp.NumToStrHex(Me.TextMask1.Text, 1) & wudp.NumToStrHex(Me.TextMask2.Text, 1) & wudp.NumToStrHex(Me.TextMask3.Text, 1) & wudp.NumToStrHex(Me.TextMask4.Text, 1)
        strHexGateway = wudp.NumToStrHex(Me.TextGateway1.Text, 1) & wudp.NumToStrHex(Me.TextGateway2.Text, 1) & wudp.NumToStrHex(Me.TextGateway3.Text, 1) & wudp.NumToStrHex(Me.TextGateway4.Text, 1)
        
        strCmd = wudp.CreateBstrCommand(controllerSN, "F211" & strMac & strHexNewIP & strHexMask & strHexGateway & "60EA")     '生成指令帧 读取网络配置信息指令
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)       '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)

            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "IP地址设置完成...要等待3秒钟, 请稍候"
            DoEvents
            Sleep (3000) '引入3秒延时
            ret = MsgBox("IP地址设置完成", vbOKOnly)
        End If

        '采用新的IP地址进行通信
       ' ipAddr = "192.168.168.90"
        ipAddr = Me.TextIP1.Text & "." & Me.TextIP2.Text & "." & Me.TextIP3.Text & "." & Me.TextIP4.Text
        Me.Text1.Text = Me.Text1.Text & vbCrLf & "采用新的IP地址进行通信" & ipAddr
        Me.Text1.Text = Me.Text1.Text & vbCrLf
        
       
        '校准控制器时间
        strCmd = wudp.CreateBstrCommandOfAdjustClockByPCTime(controllerSN) '生成指令帧
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                    '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            
            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "校准控制器时间成功"
        End If
        
        
        '远程开1号门
        strCmd = wudp.CreateBstrCommand(controllerSN, "9D10" & "01") '生成指令帧
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)              '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            
            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "远程开门成功"
        End If
        
        
        '提取记录
        Dim recIndex As Long    '记录索引号
        recIndex = 1
        Do While (True)
            strCmd = wudp.CreateBstrCommand(controllerSN, "8D10" & wudp.NumToStrHex(recIndex, 4))       '生成指令帧 8D10为提取记录指令
            strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                           '发送指令, 并获取返回信息
            If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
                '没有收到数据,
                '失败处理代码... (查ErrCode针对性分析处理)
                '用户可考虑重试
                Me.Text1.Text = Me.Text1.Text & vbCrLf & "提取记录出错"
                
                Set wudp = Nothing
                Exit Sub
            Else
                swipeDate = wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status)
    
                If swipeDate <> "" Then
                    strRunDetail = "卡号: " & cardId & vbTab & " 状态:" & vbTab & status & "(" & wudp.NumToStrHex(status, 1) & ")" & vbTab & "时间:" & vbTab & swipeDate
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & strRunDetail
                    recIndex = recIndex + 1                          '下一条记录
                Else
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "提取记录完成. 总共提取记录数 =" & (recIndex - 1)
                    Exit Do
                End If
                Me.Text1.SelStart = Len(Me.Text1.Text)              '显示新数据
             End If
             DoEvents            'VB.NET使用Application.DoEvents()
        Loop
        
        
        '删除已提取的记录
        If (recIndex > 1) Then  '只有提取了记录才进行删除
            If MsgBox("是否删除控制器上已提取的记录: " & (recIndex - 1) & "个", vbYesNo) = vbYes Then
                strCmd = wudp.CreateBstrCommand(controllerSN, "8E10" & wudp.NumToStrHex(recIndex - 1, 4)) '生成指令帧
                strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                                           '发送指令, 并获取返回信息
                If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
                    '没有收到数据,
                    '失败处理代码... (查ErrCode针对性分析处理)
                    '用户可考虑重试
                  
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "删除记录失败"
                    Set wudp = Nothing
                    Exit Sub
                Else
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "删除记录成功"
                End If
            End If
        End If
        
        '发送权限操作(1.先清空权限)
        strCmd = wudp.CreateBstrCommand(controllerSN, "9310") '生成指令帧
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)       '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            '用户可考虑重试
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "清空权限失败"
            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "清空权限成功"
        End If

        '发送权限操作(2.再添加权限)
        '权限格式: 卡号（2）+区号（1）+门号（1）+卡起始年月日（2）+卡截止年月日（2）+ 控制时段索引号（1）+密码（3）+备用（4，用0填充）
        '发送权限按: 先发1号门(卡号小的先发), 再发2号门(卡号小的先发)
        '此案例中权限设为: 卡有效期从(2007-8-14 到2020-12-31), 采用默认时段1(任意时间有效), 缺省密码(1234), 备用值以00填充
        '以三个卡： 07217564 [9C4448]，342681[B9A603]，25409969[F126FE]为例，分别可以通过控制器的2个门。
        '实际使用按需修改
        Dim doorIndex As Long
        Dim cardno(2) As Long
        Dim privilege As String
        Dim privilegeIndex As Long '权限索引位
        
        '!!!!!!!注意:  此处卡号已直接按从小到大排列赋值了. 实际使用中要用算法实现排序
        cardno(0) = 342681
        cardno(1) = 7217564
        cardno(2) = 25409969
        privilegeIndex = 1
        For doorIndex = 0 To 1
            Dim cardIndex As Long
            For cardIndex = 0 To 2
                privilege = ""
                privilege = wudp.CardToStrHex(cardno(cardIndex))                   '卡号
                privilege = privilege & wudp.NumToStrHex(doorIndex + 1, 1)         '门号
                privilege = privilege & wudp.MSDateYmdToWCDateYmd("2007-8-14")     '有效起始日期
                privilege = privilege & wudp.MSDateYmdToWCDateYmd("2020-12-31")    '有效截止日期
                privilege = privilege & wudp.NumToStrHex(1, 1)                     '时段索引号
                privilege = privilege & wudp.NumToStrHex(123456, 3)                '用户密码
                privilege = privilege & wudp.NumToStrHex(0, 4)                     '备用4字节(用0填充)
                If (Len(privilege) <> (16 * 2)) Then
                    '生成的权限不符合要求, 请查一下上一指令中写入的每个参数是否正确
                    Set wudp = Nothing
                    Exit Sub
                End If
                strCmd = wudp.CreateBstrCommand(controllerSN, "9B10" & wudp.NumToStrHex(privilegeIndex, 2) & privilege) '生成指令帧
                strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                                                         '发送指令, 并获取返回信息
            
                If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
                    '没有收到数据,
                    '失败处理代码... (查ErrCode针对性分析处理)
                    '用户可考虑重试
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加权限失败"
                    Set wudp = Nothing
                    Exit Sub
                Else
                    privilegeIndex = privilegeIndex + 1
                End If
            Next cardIndex
        Next doorIndex
        Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加权限数 = " & (privilegeIndex - 1)
        
        
        '发送控制时段
        '发送要设定的时段 [注意0,1时段为系统固定化,更改是无效的, 所以设定的时段一般从2开始]
        '此案例设定时段2: 从2007-8-1到2007-12-31日
        ' 星期1到5允许在7:30-12:30, 13:30-17:30, 19:00-21:00通过, 其他时间不允许
        Dim timeseg As String
        timeseg = ""
        timeseg = timeseg & wudp.NumToStrHex(&H1F, 1)    '星期控制
        timeseg = timeseg & wudp.NumToStrHex(0, 1)       ' 下一链接时段(0--表示无)
        timeseg = timeseg & wudp.NumToStrHex(0, 2)       ' 保留2字节(0填充)
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("07:30:00")       ' 起始时分秒1
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("12:30:00")       ' 终止时分秒1
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("13:30:00")       ' 起始时分秒2
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("17:30:00")       ' 终止时分秒2
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("19:00:00")       ' 起始时分秒3
        timeseg = timeseg & wudp.MSDateHmsToWCDateHms("21:00:00")       ' 终止时分秒3
        timeseg = timeseg & wudp.MSDateYmdToWCDateYmd("2007-08-01")     ' 起始日期
        timeseg = timeseg & wudp.MSDateYmdToWCDateYmd("2007-12-31")     ' 终止日期
        timeseg = timeseg & wudp.NumToStrHex(0, 4)                      ' 保留4字节(0填充)
        If (Len(timeseg) <> (24 * 2)) Then
            '生成的时段不符合要求, 请查一下上一指令中写入的每个参数是否正确
            Set wudp = Nothing
            Exit Sub
        End If
        strCmd = wudp.CreateBstrCommand(controllerSN, "9710" & wudp.NumToStrHex(2, 2) & timeseg) '生成指令帧
        strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                                          '发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            '用户可考虑重试
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加时段失败"
            Set wudp = Nothing
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加时段成功"
        End If
        
        '实时监控
       ' 读取运行状态是实现监控的关键指令。 在进行监控时, 先读取最新记录索引位的记录. 读取到最新的记录， 同时可以获取到刷卡记录数。
       ' 这时就可以用读取到刷卡记录数加1填充到要读取的最新记录索引位上，去读取运行状态， 以便获取下一个记录。
       ' 如果读取到了新的刷卡记录， 就可以将索引位增1， 否则保持索引位不变。 这样就可以实现数据的实时监控。
       ' 遇到通信不上的处理，这时可对串口通信采取超时400-500毫秒作为出错，可重试一次，再接收不到数据， 可认为设备与PC机间的不能通信。
       Dim watchIndex As Long
       Dim recCnt As Long
       watchIndex = 0                      '缺省从0, 表示先提取最近一个记录
       recCnt = 0                          '监控记录计数
       Me.Text1.Text = Me.Text1.Text & vbCrLf & "开始实时监控....(请刷卡3次)"
       DoEvents
       Do While (recCnt < 3)        '测试中 读到3个就停止
            strCmd = wudp.CreateBstrCommand(controllerSN, "8110" & wudp.NumToStrHex(watchIndex, 3)) '生成指令帧 wudp.NumToStrHex(watchIndex,3) 表示第watchIndex个记录, 如果是0则取最新一条记录
            strFrame = wudp.udp_comm(strCmd, ipAddr, 60000)                                         '发送指令, 并获取返回信息
            If ((wudp.ErrCode <> 0) Or (strFrame = "")) Then
                '没有收到数据,
                '失败处理代码... (查ErrCode针对性分析处理)
                Set wudp = Nothing
                Exit Sub
            Else
                swipeDate = wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status)
                If swipeDate <> "" Then '有记录时
                    strRunDetail = "卡号: " & cardId & vbTab & " 状态:" & vbTab & status & "(" & wudp.NumToStrHex(status, 1) & ")" & vbTab & "时间:" & vbTab & swipeDate
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & strRunDetail
                    Me.Text1.SelStart = Len(Me.Text1.Text)              '显示新数据
                    If watchIndex = 0 Then                              '如果收到第一条记录
                         watchIndex = wudp.GetCardRecordCountFromRunInfo(strFrame) + 1   '指向(总记录数+1), 也就是下次刷卡的存储索引位
                    Else
                         watchIndex = watchIndex + 1   '指向下一个记录位
                    End If
                    recCnt = recCnt + 1                '记录计数
                End If
            End If
            DoEvents
       Loop
       Me.Text1.Text = Me.Text1.Text & vbCrLf & "已停止实时监控"
       Me.Text1.SelStart = Len(Me.Text1.Text)          '显示新数据
       
       Set wudp = Nothing
End Sub

Private Sub Command2_Click()
    Unload Me
    End
End Sub

