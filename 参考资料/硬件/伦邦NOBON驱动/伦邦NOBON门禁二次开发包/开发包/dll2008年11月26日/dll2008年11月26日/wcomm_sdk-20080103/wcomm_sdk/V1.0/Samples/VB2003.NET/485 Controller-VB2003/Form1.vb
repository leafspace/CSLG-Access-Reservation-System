Public Class Form1
    Inherits System.Windows.Forms.Form

#Region " Windows 窗体设计器生成的代码 "

    Public Sub New()
        MyBase.New()

        '该调用是 Windows 窗体设计器所必需的。
        InitializeComponent()

        '在 InitializeComponent() 调用之后添加任何初始化

    End Sub

    '窗体重写 dispose 以清理组件列表。
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Windows 窗体设计器所必需的
    Private components As System.ComponentModel.IContainer

    '注意: 以下过程是 Windows 窗体设计器所必需的
    '可以使用 Windows 窗体设计器修改此过程。
    '不要使用代码编辑器修改它。
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Text1 As System.Windows.Forms.TextBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents TextBoxSN As System.Windows.Forms.TextBox
    Friend WithEvents TextBoxSerialPort As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.Button1 = New System.Windows.Forms.Button
        Me.Button2 = New System.Windows.Forms.Button
        Me.Text1 = New System.Windows.Forms.TextBox
        Me.TextBoxSN = New System.Windows.Forms.TextBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.TextBoxSerialPort = New System.Windows.Forms.TextBox
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(32, 120)
        Me.Button1.Name = "Button1"
        Me.Button1.TabIndex = 1
        Me.Button1.Text = "Test"
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(32, 160)
        Me.Button2.Name = "Button2"
        Me.Button2.TabIndex = 2
        Me.Button2.Text = "Exit"
        '
        'Text1
        '
        Me.Text1.Location = New System.Drawing.Point(128, 16)
        Me.Text1.Multiline = True
        Me.Text1.Name = "Text1"
        Me.Text1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.Text1.Size = New System.Drawing.Size(488, 424)
        Me.Text1.TabIndex = 0
        Me.Text1.Text = ""
        '
        'TextBoxSN
        '
        Me.TextBoxSN.Location = New System.Drawing.Point(40, 24)
        Me.TextBoxSN.Name = "TextBoxSN"
        Me.TextBoxSN.Size = New System.Drawing.Size(64, 21)
        Me.TextBoxSN.TabIndex = 3
        Me.TextBoxSN.Text = "26604"
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(11, 28)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(29, 23)
        Me.Label1.TabIndex = 4
        Me.Label1.Text = "SN:"
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(11, 59)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(88, 16)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Serial Port:"
        '
        'TextBoxSerialPort
        '
        Me.TextBoxSerialPort.Location = New System.Drawing.Point(40, 80)
        Me.TextBoxSerialPort.Name = "TextBoxSerialPort"
        Me.TextBoxSerialPort.Size = New System.Drawing.Size(64, 21)
        Me.TextBoxSerialPort.TabIndex = 5
        Me.TextBoxSerialPort.Text = "COM1"
        '
        'Form1
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(6, 14)
        Me.ClientSize = New System.Drawing.Size(624, 454)
        Me.Controls.Add(Me.TextBoxSerialPort)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.TextBoxSN)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.Text1)
        Me.Controls.Add(Me.Label2)
        Me.Name = "Form1"
        Me.Text = "Form1"
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Me.Close()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        '串口通信操作 (案例针对controllerSN操作)
        Dim wserial As WComm_Serial.CWComm_Serial    '操作COM对象
        Dim wudp As WComm_UDP.WComm_Operate '操作UDP对象
        Dim strFrame As String      '返回的数据
        Dim strCmd As String        '要发送的指令帧
        Dim ret As Long             '函数的返回值
        Dim controllerSN As Long    '控制器序列号
        Dim comPort As String       '通信串口号

        '刷卡记录变量
        Dim cardId As Long          '卡号
        Dim status As Long          '状态
        Dim swipeDate As String     '日期时间

        Dim strRunDetail As String  '运行信息

        Cursor.Current = Cursors.WaitCursor

        wserial = New WComm_Serial.CWComm_Serial      '创建通信COM对象
        wudp = New WComm_UDP.WComm_Operate            '新建

        controllerSN = System.Convert.ToInt64(Me.TextBoxSN.Text) '测试使用的控制器
        comPort = Me.TextBoxSerialPort.Text      '使用的通信端口

        Me.Text1.Text = "控制器通信" & "-" & controllerSN & "-" & comPort
        Application.DoEvents()

        '读取运行状态信息
        strCmd = wudp.CreateBstrCommand(controllerSN, "8110" & wudp.NumToStrHex(0, 3)) '生成指令帧 wudp.NumToStrHex(0,3) 表示第0个记录, 也就最新记录
        strFrame = wserial.serial_comm(strCmd, comPort)                            '发送指令, 并获取返回信息

        If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "读取运行信息失败"
            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
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
            strRunDetail = strRunDetail & vbCrLf

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

        Application.DoEvents()

        '校准控制器时间
        strCmd = wudp.CreateBstrCommandOfAdjustClockByPCTime(controllerSN)    '生成指令帧
        strFrame = wserial.serial_comm(strCmd, comPort)                       '发送指令, 并获取返回信息
        If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "校准控制器时间成功"
        End If

        Application.DoEvents()

        '远程开1号门
        strCmd = wudp.CreateBstrCommand(controllerSN, "9D10" & "01")          '生成指令帧
        strFrame = wserial.serial_comm(strCmd, comPort)                       '发送指令, 并获取返回信息
        If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)

            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
            Exit Sub
        Else
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "远程开门成功"
        End If


        Application.DoEvents()

        '提取记录
        Dim recIndex As Long    '记录索引号
        recIndex = 1
        Do While (True)
            strCmd = wudp.CreateBstrCommand(controllerSN, "8D10" & wudp.NumToStrHex(recIndex, 4))       '生成指令帧为提取记录指令
            strFrame = wserial.serial_comm(strCmd, comPort)                                             '发送指令, 并获取返回信息
            If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
                '没有收到数据,
                '失败处理代码... (查ErrCode针对性分析处理)
                '用户可考虑重试
                Me.Text1.Text = Me.Text1.Text & vbCrLf & "提取记录出错"

                wserial = Nothing
                wudp = Nothing
                Cursor.Current = Cursors.Default
                Exit Sub
            Else
                swipeDate = wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status)

                If swipeDate <> "" Then
                    strRunDetail = "卡号: " & cardId & vbTab & " 状态:" & vbTab & status & "(" & wudp.NumToStrHex(status, 1) & ")" & vbTab & "时间:" & vbTab & swipeDate
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & strRunDetail
                    recIndex = recIndex + 1                         '下一条记录
                    Me.Text1.SelectionStart = Len(Me.Text1.Text)          '显示新数据
                    Me.Text1.ScrollToCaret()
                Else
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "提取记录完成. 总共提取记录数 =" & (recIndex - 1)
                    Exit Do
                End If
                Me.Text1.SelectionStart = Len(Me.Text1.Text)              '显示新数据
            End If
            Application.DoEvents()
        Loop
        Me.Text1.SelectionStart = Len(Me.Text1.Text)          '显示新数据
        Me.Text1.ScrollToCaret()


        '删除已提取的记录
        If (recIndex > 1) Then  '只有提取了记录才进行删除
            If MsgBox("是否删除控制器上已提取的记录: " & (recIndex - 1) & "个", vbYesNo) = vbYes Then
                strCmd = wudp.CreateBstrCommand(controllerSN, "8E10" & wudp.NumToStrHex(recIndex - 1, 4)) '生成指令帧
                strFrame = wserial.serial_comm(strCmd, comPort)                                           '发送指令, 并获取返回信息
                If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
                    '没有收到数据,
                    '失败处理代码... (查ErrCode针对性分析处理)
                    '用户可考虑重试

                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "删除记录失败"
                    wserial = Nothing
                    wudp = Nothing
                    Cursor.Current = Cursors.Default
                    Exit Sub
                Else
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "删除记录成功"
                End If
            End If
        End If

        '发送权限操作(1.先清空权限)
        strCmd = wudp.CreateBstrCommand(controllerSN, "9310") '生成指令帧
        strFrame = wserial.serial_comm(strCmd, comPort)       '发送指令, 并获取返回信息
        If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            '用户可考虑重试
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "清空权限失败"
            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
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
                    wserial = Nothing
                    wudp = Nothing
                    Cursor.Current = Cursors.Default
                    Exit Sub
                End If
                strCmd = wudp.CreateBstrCommand(controllerSN, "9B10" & wudp.NumToStrHex(privilegeIndex, 2) & privilege) '生成指令帧
                strFrame = wserial.serial_comm(strCmd, comPort)                                                         '发送指令, 并获取返回信息

                If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
                    '没有收到数据,
                    '失败处理代码... (查ErrCode针对性分析处理)
                    '用户可考虑重试
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加权限失败"
                    wserial = Nothing
                    Cursor.Current = Cursors.Default
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
        timeseg = timeseg & wudp.NumToStrHex(0, 4)       ' 保留4字节(0填充)
        If (Len(timeseg) <> (24 * 2)) Then
            '生成的时段不符合要求, 请查一下上一指令中写入的每个参数是否正确
            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
            Exit Sub
        End If
        strCmd = wudp.CreateBstrCommand(controllerSN, "9710" & wudp.NumToStrHex(2, 2) & timeseg) '生成指令帧
        strFrame = wserial.serial_comm(strCmd, comPort)                                          '发送指令, 并获取返回信息
        If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
            '没有收到数据,
            '失败处理代码... (查ErrCode针对性分析处理)
            '用户可考虑重试
            Me.Text1.Text = Me.Text1.Text & vbCrLf & "添加时段失败"
            wserial = Nothing
            wudp = Nothing
            Cursor.Current = Cursors.Default
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
        Me.Text1.SelectionStart = Len(Me.Text1.Text)          '显示新数据
        Me.Text1.ScrollToCaret()
        Application.DoEvents()
        Do While (recCnt < 3)        '测试中 读到3个就停止
            strCmd = wudp.CreateBstrCommand(controllerSN, "8110" & wudp.NumToStrHex(watchIndex, 3)) '生成指令帧 wudp.NumToStrHex(watchIndex,3) 表示第watchIndex个记录, 如果是0则取最新一条记录
            strFrame = wserial.serial_comm(strCmd, comPort)                            '发送指令, 并获取返回信息
            If ((wserial.ErrCode <> 0) Or (strFrame = "")) Then
                '没有收到数据,
                '失败处理代码... (查ErrCode针对性分析处理)
                wserial = Nothing
                wudp = Nothing
                Cursor.Current = Cursors.Default
                Exit Sub
            Else
                swipeDate = wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status)
                If swipeDate <> "" Then      '有记录时
                    strRunDetail = "卡号: " & cardId & vbTab & " 状态:" & vbTab & status & "(" & wudp.NumToStrHex(status, 1) & ")" & vbTab & "时间:" & vbTab & swipeDate
                    Me.Text1.Text = Me.Text1.Text & vbCrLf & strRunDetail
                    Me.Text1.SelectionStart = Len(Me.Text1.Text)          '显示新数据
                    Me.Text1.ScrollToCaret()
                    If watchIndex = 0 Then                                               '如果收到第一条记录
                        watchIndex = wudp.GetCardRecordCountFromRunInfo(strFrame) + 1   '指向(总记录数+1), 也就是下次刷卡的存储索引位
                    Else
                        watchIndex = watchIndex + 1  '指向下一个记录位
                    End If
                    recCnt = recCnt + 1               '记录计数
                End If
            End If
            Application.DoEvents()
        Loop
        Me.Text1.Text = Me.Text1.Text & vbCrLf & "已停止实时监控"
        Me.Text1.SelectionStart = Len(Me.Text1.Text)          '显示新数据
        Me.Text1.ScrollToCaret()

        wserial = Nothing
        wudp = Nothing
        Cursor.Current = Cursors.Default

    End Sub
End Class
