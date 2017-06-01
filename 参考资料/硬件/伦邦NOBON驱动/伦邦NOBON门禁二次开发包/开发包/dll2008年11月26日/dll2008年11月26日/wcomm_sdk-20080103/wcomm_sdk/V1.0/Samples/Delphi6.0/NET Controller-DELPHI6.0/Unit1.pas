unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleServer,  COMOBJ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Text1: TMemo;
    Button2: TButton;
    EditSN: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditIP1: TEdit;
    EditIP2: TEdit;
    EditIP3: TEdit;
    EditIP4: TEdit;
    Label6: TLabel;
    EditMask1: TEdit;
    EditMask2: TEdit;
    EditMask3: TEdit;
    EditMask4: TEdit;
    Label7: TLabel;
    EditGateway1: TEdit;
    EditGateway2: TEdit;
    EditGateway3: TEdit;
    EditGateway4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
strCmd:      WideString;    //要发送的指令帧
strFuncData: WideString;    //要发送的功能及数据
strFrame:    WideString;    //返回的数据
ret:         Integer;       //函数的返回值
controllerSN: Integer;	    //控制器序列号

//刷卡记录变量
cardId:      Integer;	    //卡号
status:      Integer;       //状态
swipeDate:   WideString;    //日期时间

strRunDetail: WideString;   //运行信息

recIndex:    Integer; 	    //记录索引号
errorNo:     Integer;	    //故障号

//用于权限上送
doorIndex:   Integer;       //门号
cardno:      array[0..2] of integer ;  //3个卡号
privilege:   WideString;    //权限
privilegeIndex: Integer;    //权限索引号
cardIndex:   Integer;       //卡索引号

timeseg:     WideString;    //时段

//用于实时监控
watchIndex: Integer;        //监控索引号
recCnt:     Integer;        //刷卡记录计数

wudp:       Variant;        //WComm_Operate对象
ipAddr:     WideString;
strMac:     WideString;
strHexNewIP:    WideString;  //New IP (十六进制)
strHexMask:     WideString;  //掩码(十六进制)
strHexGateway:  WideString;  //网关(十六进制)

startLoc:   Integer;

begin
        //.NET控制器通信操作 (案例针对controllerSN操作)
        controllerSN :=StrToInt64(EditSN.Text);        //测试使用的.NET 控制器
        ipAddr := '';                 //为空, 表示广播包方式

        Text1.Text := '控制器通信' + '-' + IntToStr(controllerSN) + '-.NET';

        //创建对象
        wudp := CreateOleObject('WComm_UDP.WComm_Operate');

        //读取运行状态信息
        strFuncData := '8110' + wudp.NumToStrHex(0, 3);               // wudp.NumToStrHex(0,3) 表示第0个记录, 也就最新记录
        strCmd := wudp.CreateBstrCommand(controllerSN, strFuncData);  //生成指令帧
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000);             //发送指令, 并获取返回信息
        if ((wudp.ErrCode <> 0) or (strFrame = '')) then
            begin
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '读取运行信息失败';
            Exit;
            end
        Else
            begin
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '读取运行信息成功';
            //对运行信息的详细分析
            //控制器的当前时间
            strRunDetail := ''  ;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '设备序列号S/N: ' +  Chr(9) + IntToStr( wudp.GetSNFromRunInfo(strFrame));
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '设备时钟:      ' +  Chr(9) + wudp.GetClockTimeFromRunInfo(strFrame);
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '刷卡记录数:    ' +  Chr(9) + IntToStr(wudp.GetCardRecordCountFromRunInfo(strFrame));
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '权限数:        ' +  Chr(9) + IntToStr(wudp.GetPrivilegeNumFromRunInfo(strFrame));
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +  Chr(13) + Chr(10) + '最近的一条刷卡记录: ' +  Chr(9)                     ;
            swipeDate := wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status) ;
            If swipeDate <> '' Then
            begin
                  strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '卡号: ' + IntToStr(cardId) +  Chr(9) + ' 状态:' +  Chr(9) + IntToStr(status) + '(' + wudp.NumToStrHex(status, 1) + ')' +  Chr(9) + '时间:' +  Chr(9) + swipeDate ;
            end ;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10)                                               ;

            //门磁按钮状态
            //Bit位  7   6   5   4   3   2   1   0
            //说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '门磁状态  1号门磁 2号门磁 3号门磁 4号门磁' ;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10)                                               ;
            strRunDetail := strRunDetail + '          '                                                     ;
            If wudp.GetDoorStatusFromRunInfo(strFrame, 1) = 1 Then
                strRunDetail := strRunDetail + '   开   '
            Else
                strRunDetail := strRunDetail + '   关   '           ;
            If wudp.GetDoorStatusFromRunInfo(strFrame, 2) = 1 Then
                strRunDetail := strRunDetail + '   开   '
            Else
                strRunDetail := strRunDetail + '   关   '           ;
            If wudp.GetDoorStatusFromRunInfo(strFrame, 3) = 1 Then
                strRunDetail := strRunDetail + '   开   '
            Else
                strRunDetail := strRunDetail + '   关   '           ;
            If wudp.GetDoorStatusFromRunInfo(strFrame, 4) = 1 Then
                strRunDetail := strRunDetail + '   开   '
            Else
                strRunDetail := strRunDetail + '   关   '           ;

            strRunDetail := strRunDetail +  Chr(13) + Chr(10);
            //按钮状态
            //Bit位  7   6   5   4   3   2   1   0
            //说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
            strRunDetail := strRunDetail + '按钮状态  1号按钮 2号按钮 3号按钮 4号按钮';
            strRunDetail := strRunDetail +  Chr(13) + Chr(10)                         ;
            strRunDetail := strRunDetail + '          '                               ;
            If wudp.GetButtonStatusFromRunInfo(strFrame, 1) = 1 Then
                strRunDetail := strRunDetail + ' 松开   '
            Else
                strRunDetail := strRunDetail + ' 按下   '            ;
            If wudp.GetButtonStatusFromRunInfo(strFrame, 2) = 1 Then
                strRunDetail := strRunDetail + ' 松开   '
            Else
                strRunDetail := strRunDetail + ' 按下   '            ;
            If wudp.GetButtonStatusFromRunInfo(strFrame, 3) = 1 Then
                strRunDetail := strRunDetail + ' 松开   '
            Else
                strRunDetail := strRunDetail + ' 按下   '            ;
            If wudp.GetButtonStatusFromRunInfo(strFrame, 4) = 1 Then
                strRunDetail := strRunDetail + ' 松开   '
            Else
                strRunDetail := strRunDetail + ' 按下   '            ;

            strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '故障状态:' +  Chr(9);
            errorNo := wudp.GetErrorNoFromRunInfo(strFrame);
            If errorNo = 0 Then
                strRunDetail := strRunDetail + ' 无故障  '
            Else
                begin
                strRunDetail := strRunDetail + ' 有故障  '   ;
                If (errorNo And 1) > 0  Then
                    strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '        ' +  Chr(9) + '系统故障1'  ;
                If (errorNo And 2) > 0  Then
                    strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '        ' +  Chr(9) + '系统故障2';
                If (errorNo And 4) > 0 Then
                    strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '        ' +  Chr(9) + '系统故障3[设备时钟有故障], 请校正时钟处理';
                If (errorNo And 8) > 0 Then
                    strRunDetail := strRunDetail +  Chr(13) + Chr(10) + '        ' +  Chr(9) + '系统故障4';
                end  ;
            Text1.Text := Text1.Text + strRunDetail;
            end  ;

        //查询控制器的IP设置
        //读取网络配置信息指令
        strCmd := wudp.CreateBstrCommand(controllerSN, '0111');   //生成指令帧 读取网络配置信息指令
        strFrame := wudp.udp_comm(strCmd,  ipAddr, 60000)  ;      //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            begin
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            Exit;
            end
        Else
            begin
            strRunDetail := '';

            //'MAC
            startLoc := 11; 
            
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +   'MAC:' + chr(9) + chr(9) + (copy (strFrame, startLoc, 2));
            strRunDetail := strRunDetail + '-' + (copy(strFrame, startLoc + 2, 2));
            strRunDetail := strRunDetail + '-' + (copy(strFrame, startLoc + 4, 2));
            strRunDetail := strRunDetail + '-' + (copy(strFrame, startLoc + 6, 2));
            strRunDetail := strRunDetail + '-' + (copy(strFrame, startLoc + 8, 2));
            strRunDetail := strRunDetail + '-' + (copy(strFrame, startLoc + 10, 2));

            strMac := copy(strFrame, startLoc, 12);

            //IP
            startLoc := 23;  
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +  'IP:' + chr(9) + chr(9) + IntToStr(StrToInt('$' + (copy(strFrame, startLoc, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 2, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 4, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 6, 2))));

            //Subnet Mask
            startLoc := 31;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +  '子网掩码:' + chr(9) + IntToStr(StrToInt('$' + (copy(strFrame, startLoc, 2)))) ;
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 2, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 4, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 6, 2))));


            //Default Gateway
            startLoc := 39;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +   '网关:' + chr(9) + chr(9) + IntToStr(StrToInt('$' + (copy(strFrame, startLoc, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 2, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 4, 2))));
            strRunDetail := strRunDetail + '.' + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 6, 2))));

            //TCP Port
            startLoc := 47;
            strRunDetail := strRunDetail +  Chr(13) + Chr(10) +  'PORT:' + chr(9) + chr(9) + IntToStr(StrToInt('$' + (copy(strFrame, startLoc + 2, 2)) + (copy(strFrame, startLoc, 2))));
            Text1.Text := Text1.Text + Chr(13) + Chr(10) +  strRunDetail +  Chr(13) + Chr(10);
            End ;


        Text1.Text := Text1.Text + Chr(13) + Chr(10) + '开始IP地址设置: '+ Chr(13) + Chr(10); // + 'IP 192.168.168.90/Mask 255.255.255.0/Gateway 192.168.168.254: Port 60000';

        application.ProcessMessages ;

        //新的IP设置: (MAC不变) IP地址: 192.168.168.90; 掩码: 255.255.255.0; 网关: 192.168.168.254; 端口: 60000
        strHexNewIP := wudp.NumToStrHex(EditIP1.Text, 1) + wudp.NumToStrHex(EditIP2.Text, 1) + wudp.NumToStrHex(EditIP3.Text, 1) + wudp.NumToStrHex(EditIP4.Text, 1);
        strHexMask := wudp.NumToStrHex(EditMask1.Text, 1)  +  wudp.NumToStrHex(EditMask2.Text, 1)  +  wudp.NumToStrHex(EditMask3.Text, 1)  +  wudp.NumToStrHex(EditMask4.Text, 1) ;
        strHexGateway := wudp.NumToStrHex(EditGateway1.Text, 1)  +  wudp.NumToStrHex(EditGateway2.Text, 1)  +  wudp.NumToStrHex(EditGateway3.Text, 1)  +  wudp.NumToStrHex(EditGateway4.Text, 1) ;

        strCmd := wudp.CreateBstrCommand(controllerSN, 'F211' + strMac + strhexnewip + strhexmask + strhexgateway +  '60EA'); // 生成指令帧 读取网络配置信息指令
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000);                    //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            begin
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            Exit;
            end
        Else
            begin
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) +  'IP地址设置完成...要等待3秒钟, 请稍候' ;
            application.ProcessMessages ;
            Sleep (3000);                                                                                                   //引入3秒延时
            ret := Application.MessageBox (PChar('IP地址设置完成'),'', MB_OK)
            End;

        //采用新的IP地址进行通信
        ipAddr := EditIP1.Text + '.' + EditIP2.Text + '.' + EditIP3.Text + '.' + EditIP4.Text;
        Text1.Text := Text1.Text +  Chr(13) + Chr(10) +  '采用新的IP地址进行通信' + ipAddr;

        //校准控制器时间
        strCmd := wudp.CreateBstrCommandOfAdjustClockByPCTime(controllerSN) ;  //生成指令帧
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)                    ;  //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            Exit
        Else
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '校准控制器时间成功';
        
        
        //远程开1号门
        strCmd := wudp.CreateBstrCommand(controllerSN, '9D10' + '01');        //生成指令帧
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)                    ; //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            Exit
        Else
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '远程开门成功';
       
        
        //提取记录
        recIndex := 1 ;
        While true do
        begin
            strFuncData := '8D10' + wudp.NumToStrHex(recIndex, 4);            // wudp.NumToStrHex(recIndex,4) 表示第recIndex个记录
            strCmd := wudp.CreateBstrCommand(controllerSN,strFuncData );      //生成指令帧 8D10为提取记录指令
            strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)           ;      //发送指令, 并获取返回信息
            If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
                begin
                //没有收到数据,
                //失败处理代码... (查ErrCode针对性分析处理)
                //用户可考虑重试
                Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '提取记录出错';
                Exit;
                end
            Else
                begin
                swipeDate := wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status) ;
                If swipeDate <> '' Then
                   begin
	                   strRunDetail := '卡号: ' + IntToStr(cardId) +  Chr(9) + ' 状态:' +  Chr(9) + IntToStr(status) + '(' + wudp.NumToStrHex(status, 1) + ')' +  Chr(9) + '时间:' +  Chr(9) + swipeDate ;
	                   Text1.Text := Text1.Text +  Chr(13) + Chr(10) + strRunDetail;
	                   recIndex := recIndex + 1;             //下一条记录
                   end
                Else
                   begin
                    Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '提取记录完成. 总共提取记录数 =' + IntToStr(recIndex - 1);
                    break;
                    end;
             end ;
             application.ProcessMessages            
        end;
        
        
        //删除已提取的记录
        If (recIndex > 1) Then  //只有提取了记录才进行删除
        begin
            If (Application.MessageBox (PChar('是否删除控制器上已提取的记录: '+ (IntToStr(recIndex - 1 )) + '个'),'删除',MB_YESNO) = IDYES ) Then
                begin
                strFuncData := '8E10' + wudp.NumToStrHex(recIndex - 1, 4);
                strCmd := wudp.CreateBstrCommand(controllerSN, strFuncData);  //生成指令帧
                strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)           ;  //发送指令, 并获取返回信息
                If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
                    begin
                    //没有收到数据,
                    //失败处理代码... (查ErrCode针对性分析处理)
                    //用户可考虑重试

                    Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '删除记录失败';
                    Exit;
                    end
                Else
                    Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '删除记录成功';
            End;
        End;

        //发送权限操作(1.先清空权限)
        strCmd := wudp.CreateBstrCommand(controllerSN, '9310');               //生成指令帧
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)             ;        //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            begin
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            //用户可考虑重试
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '清空权限失败';
            Exit;
            end
        Else
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '清空权限成功';


        //发送权限操作(2.再添加权限)
        //权限格式: 卡号（2）+区号（1）+门号（1）+卡起始年月日（2）+卡截止年月日（2）+ 控制时段索引号（1）+密码（3）+备用（4，用0填充）
        //发送权限按: 先发1号门(卡号小的先发), 再发2号门(卡号小的先发)
        //此案例中权限设为: 卡有效期从(2007-8-14 到2020-12-31), 采用默认时段1(任意时间有效), 缺省密码(1234), 备用值以00填充
        //以三个卡： 07217564 [9C4448]，342681[B9A603]，25409969[F126FE]为例，分别可以通过控制器的2个门。
        //实际使用按需修改
        
        //!!!!!!!注意:  此处卡号已直接按从小到大排列赋值了. 实际使用中要用算法实现排序
        cardno[0] := 342681 ;
        cardno[1] := 7217564;
        cardno[2] := 25409969;
        privilegeIndex := 1  ;
        For doorIndex := 0 To 1 do
            For cardIndex := 0 To 2 do
                begin
                privilege := '';
                privilege := wudp.CardToStrHex(cardno[cardIndex]) ;                  //卡号
                privilege := privilege + wudp.NumToStrHex(doorIndex + 1, 1) ;        //门号
                privilege := privilege + wudp.MSDateYmdToWCDateYmd('2007-8-14') ;    //有效起始日期
                privilege := privilege + wudp.MSDateYmdToWCDateYmd('2020-12-31');    //有效截止日期
                privilege := privilege + wudp.NumToStrHex(1, 1)                 ;    //时段索引号
                privilege := privilege + wudp.NumToStrHex(123456, 3)            ;    //用户密码
                privilege := privilege + wudp.NumToStrHex(0, 4)                 ;    //备用4字节(用0填充)
                If (Length(privilege) <> (16 * 2)) Then
                    //生成的权限不符合要求, 请查一下上一指令中写入的每个参数是否正确
                    Exit;
                strFuncData := '9B10' + wudp.NumToStrHex(privilegeIndex, 2) + privilege;
                strCmd := wudp.CreateBstrCommand(controllerSN, strFuncData );   //生成指令帧
                strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)            ;   //发送指令, 并获取返回信息

                If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
                    begin
                    //没有收到数据,
                    //失败处理代码... (查ErrCode针对性分析处理)
                    //用户可考虑重试
                    Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '添加权限失败';
                    Exit;
                    end
                Else
                    privilegeIndex := privilegeIndex + 1;
            end;
        Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '添加权限数 := ' + IntToStr(privilegeIndex - 1);
        
        
        //发送控制时段
        //发送要设定的时段 [注意0,1时段为系统固定化,更改是无效的, 所以设定的时段一般从2开始]
        //此案例设定时段2: 从2007-8-1到2007-12-31日
        // 星期1到5允许在7:30-12:30, 13:30-17:30, 19:00-21:00通过, 其他时间不允许
        timeseg := '';
        timeseg := timeseg + wudp.NumToStrHex($1F, 1);     //星期控制
        timeseg := timeseg + wudp.NumToStrHex(0, 1)   ;    // 下一链接时段(0--表示无)
        timeseg := timeseg + wudp.NumToStrHex(0, 2)   ;    // 保留2字节(0填充)
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('07:30:00')  ;    // 起始时分秒1
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('12:30:00')  ;    // 终止时分秒1
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('13:30:00')  ;    // 起始时分秒2
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('17:30:00')  ;    // 终止时分秒2
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('19:00:00')  ;    // 起始时分秒3
        timeseg := timeseg + wudp.MSDateHmsToWCDateHms('21:00:00')  ;    // 终止时分秒3
        timeseg := timeseg + wudp.MSDateYmdToWCDateYmd('2007-8-1')  ;    // 起始日期
        timeseg := timeseg + wudp.MSDateYmdToWCDateYmd('2007-12-31');    // 终止日期
        timeseg := timeseg + wudp.NumToStrHex(0, 4)  ;                   // 保留4字节(0填充)
        If (Length(timeseg) <> (24 * 2)) Then
            //生成的时段不符合要求, 请查一下上一指令中写入的每个参数是否正确
            Exit;

        strFuncData :=  '9710' + wudp.NumToStrHex(2, 2) + timeseg;
        strCmd := wudp.CreateBstrCommand(controllerSN,strFuncData);      //生成指令帧
        strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)          ;      //发送指令, 并获取返回信息
        If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
            begin
            //没有收到数据,
            //失败处理代码... (查ErrCode针对性分析处理)
            //用户可考虑重试
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '添加时段失败';
            Exit;
            end
        Else
            Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '添加时段成功';


       // 实时监控
       // 读取运行状态是实现监控的关键指令。 在进行监控时, 先读取最新记录索引位的记录. 读取到最新的记录， 同时可以获取到刷卡记录数。
       // 这时就可以用读取到刷卡记录数加1填充到要读取的最新记录索引位上，去读取运行状态， 以便获取下一个记录。
       // 如果读取到了新的刷卡记录， 就可以将索引位增1， 否则保持索引位不变。 这样就可以实现数据的实时监控。
       // 遇到通信不上的处理，这时可对串口通信采取超时400-500毫秒作为出错，可重试一次，再接收不到数据， 可认为设备与PC机间的不能通信。
       watchIndex := 0   ;                   //缺省从0, 表示先提取最近一个记录
       recCnt := 0       ;                   //监控记录计数
       Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '开始实时监控......(请刷卡3次)';
       Text1.SelStart := Length(Text1.Text)  ;           //显示新加入的数据
       application.ProcessMessages                                       ;
       While (recCnt < 3) do        //测试中 读到3个就停止
         begin
            strFuncData :=   '8110' + wudp.NumToStrHex(watchIndex, 3) ;   //wudp.NumToStrHex(watchIndex,3) 表示第watchIndex个记录, 如果是0则取最新一条记录
            strCmd := wudp.CreateBstrCommand(controllerSN,strFuncData);   //生成指令帧
            strFrame := wudp.udp_comm(strCmd, ipAddr, 60000)          ;   //发送指令, 并获取返回信息
            If ((wudp.ErrCode <> 0) Or (strFrame = '')) Then
                //没有收到数据,
                //失败处理代码... (查ErrCode针对性分析处理)
                Exit
            Else
                begin
		                swipeDate := wudp.GetSwipeDateFromRunInfo(strFrame, cardId, status) ;
		                If swipeDate <> '' Then   //有记录时
	                    begin
	                    strRunDetail := '卡号: ' + IntToStr(cardId) +  Chr(9) + ' 状态:' +  Chr(9) + IntToStr(status) + '(' + wudp.NumToStrHex(status, 1) + ')' +  Chr(9) + '时间:' +  Chr(9) + swipeDate ;
	                    Text1.Text := Text1.Text +  Chr(13) + Chr(10) + strRunDetail;
	                    Text1.SelStart := Length(Text1.Text)   ;           //显示新加入的数据
	                    If watchIndex = 0 Then                                                //如果收到第一条记录
	                         watchIndex := wudp.GetCardRecordCountFromRunInfo(strFrame) + 1   //指向(总记录数+1), 也就是下次刷卡的存储索引位
	                    Else
	                         watchIndex := watchIndex + 1 ;                                   //指向下一个记录位
	                    recCnt := recCnt + 1;                                                 //记录计数
	                    End;
                End;
            application.ProcessMessages ;
         end;
       Text1.Text := Text1.Text +  Chr(13) + Chr(10) + '已停止实时监控';
       Text1.SelStart := Length(Text1.Text)  ;           //显示新加入的数据
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
halt(1);
end;

end.



