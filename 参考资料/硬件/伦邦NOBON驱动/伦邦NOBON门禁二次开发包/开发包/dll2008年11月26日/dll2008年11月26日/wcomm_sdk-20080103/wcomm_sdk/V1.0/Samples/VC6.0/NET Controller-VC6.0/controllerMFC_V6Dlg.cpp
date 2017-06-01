// controllerMFC_V6Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "controllerMFC_V6.h"
#include "controllerMFC_V6Dlg.h"

#include "atlbase.h"			          //加入
#import "..\..\..\bin\WComm_UDP.tlb"      //加入
using namespace WComm_UDP;				  //加入


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CControllerMFC_V6Dlg dialog

CControllerMFC_V6Dlg::CControllerMFC_V6Dlg(CWnd* pParent /*=NULL*/)
	: CDialog(CControllerMFC_V6Dlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CControllerMFC_V6Dlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CControllerMFC_V6Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CControllerMFC_V6Dlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CControllerMFC_V6Dlg, CDialog)
	//{{AFX_MSG_MAP(CControllerMFC_V6Dlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CControllerMFC_V6Dlg message handlers

BOOL CControllerMFC_V6Dlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	((CEdit*) GetDlgItem(IDC_EDITSN))->SetWindowText( _T("39990") );		//缺省控制器号

	((CEdit*) GetDlgItem(IDC_EDITIP1)) ->SetWindowText( _T("192") );		//New IP
	((CEdit*) GetDlgItem(IDC_EDITIP2)) ->SetWindowText( _T("168"));
	((CEdit*) GetDlgItem(IDC_EDITIP3)) ->SetWindowText( _T("168"));
	((CEdit*) GetDlgItem(IDC_EDITIP4)) ->SetWindowText( _T("90"));
	((CEdit*) GetDlgItem(IDC_EDITMASK1)) ->SetWindowText( _T("255") );		//Mask
	((CEdit*) GetDlgItem(IDC_EDITMASK2)) ->SetWindowText( _T("255") );		//Mask
	((CEdit*) GetDlgItem(IDC_EDITMASK3)) ->SetWindowText( _T("255") );		//Mask
	((CEdit*) GetDlgItem(IDC_EDITMASK4)) ->SetWindowText( _T("0") );		//Mask
	((CEdit*) GetDlgItem(IDC_EDITGATEWAY1)) ->SetWindowText( _T("192") );		//Gateway
	((CEdit*) GetDlgItem(IDC_EDITGATEWAY2)) ->SetWindowText( _T("168") );		//Gateway
	((CEdit*) GetDlgItem(IDC_EDITGATEWAY3)) ->SetWindowText( _T("168") );		//Gateway
	((CEdit*) GetDlgItem(IDC_EDITGATEWAY4)) ->SetWindowText( _T("254") );		//Gateway
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CControllerMFC_V6Dlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

HCURSOR CControllerMFC_V6Dlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

bool bStopRun;		//用于停止测试
void CControllerMFC_V6Dlg::OnCancel() 
{
	// TODO: Add extra cleanup here
	bStopRun = true;
	CDialog::OnCancel();
}

void CControllerMFC_V6Dlg::OnOK() 
{
	// TODO: 在此添加控件通知处理程序代码
	//获得EDIT
	CEdit* pBoxOne;
	pBoxOne = (CEdit*) GetDlgItem(IDC_EDIT1);
	pBoxOne->SetWindowText( _T("") );
	
	MSG   message;   
	CString    strTemp;
	CString    strNewIPAddr;
	CString    strInfo;

	HRESULT hr;
	// Now we will intilize COM
	hr = CoInitialize(0);
	if (!SUCCEEDED(hr))
	{
		::MessageBox (NULL,(LPCTSTR)("创建Com失败"),"",0);
		return;	//出错
	}


	while (true)
	{
		bStopRun = false;

 		__int64 lngRet;
		BSTR bstrT;				//中间变量
		BSTR bstrFrame;	        //通信返回的数据
		BSTR bstrCmd;           //发送的指令帧
		long controllerSN;      //控制器序列号
      
		//刷卡记录变量
		__int64  cardId;		//卡号    
		__int64  status;        //状态    
		BSTR bstrSwipeDate;     //日期时间

		CString strRunDetail;   //运行信息
		BSTR strIPAddr;			//IP地址
		CString strMac;			//MAC地址
		CString strHexNewIP;    //New IP (十六进制)
        CString strHexMask;     //掩码(十六进制)
        CString strHexGateway;  //网关(十六进制)
		long startLoc;			//字符串的起始位置

    	IWCOMM_OPERATEPtr wudp(__uuidof(WComm_Operate));	//创建UDP 通信对象
    
		((CWnd*)GetDlgItem(IDC_EDITSN))->GetWindowText(strTemp);
		controllerSN = _ttol((LPCTSTR)strTemp);		//测试使用的控制器

		strIPAddr = BSTR(L"");		      //一开始为空, 表示广播包方式
		strTemp.Format("%d",controllerSN);
		strInfo = "控制器通信－" + strTemp + "-.NET" ;

		pBoxOne->SetWindowText( strInfo);
    
 		//读取运行状态信息(1081)
		bstrT = BSTR(L"811000000000");
		bstrCmd = wudp -> CreateBstrCommand(controllerSN, bstrT);	//生成指令帧 
		bstrFrame = wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	//发送指令, 并获取返回信息
		if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
		{
			strInfo = strInfo + char(13) + char(10) + "出错处理: 读取运行信息失败" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}
		//数据处理
		strInfo = strInfo +  char(13) + char(10) + "读取运行信息成功";

		//对运行信息的详细分析
		strRunDetail = ""  ;
		strTemp.Format("%ld",wudp->GetSNFromRunInfo(bstrFrame) );
		strRunDetail = strRunDetail +  char(13) + char(10) + "设备序列号S/N: " +  char(9) + strTemp;

		bstrT = wudp->GetClockTimeFromRunInfo(bstrFrame);
		strRunDetail = strRunDetail +  char(13) + char(10) + "设备时钟:      " +  char(9) + CString(bstrT);

		strTemp.Format("%ld",wudp->GetCardRecordCountFromRunInfo(bstrFrame) );
		strRunDetail = strRunDetail +  char(13) + char(10) + "刷卡记录数:    " +  char(9) + strTemp;

		strTemp.Format("%ld",wudp->GetPrivilegeNumFromRunInfo(bstrFrame) );
		strRunDetail = strRunDetail +  char(13) + char(10) + "权限数:        " +  char(9) + strTemp;

		strRunDetail = strRunDetail +  char(13) + char(10) +  char(13) + char(10) + "最近的一条刷卡记录: " +  char(9)   ;
		bstrSwipeDate = wudp->GetSwipeDateFromRunInfo(bstrFrame,  &cardId, &status) ;
		if (CString((bstrSwipeDate)) != "" )
		{
			strTemp.Format( "%ld",cardId);
			strRunDetail = strRunDetail +  char(13) + char(10) + "卡号: " + strTemp ;
			strTemp.Format( "%ld",status);
			strRunDetail = strRunDetail +  char(9) + " 状态:" +  char(9) + strTemp ;
			bstrT = wudp->NumToStrHex(status,1);
			strRunDetail = strRunDetail +  "(" + CString(bstrT) + ")" ;
			strRunDetail = strRunDetail +  char(9) + "时间:" +  char(9) + CString(bstrSwipeDate) ;
		}
		strRunDetail = strRunDetail +  "        ";

		//门磁按钮状态
		//Bit位  7   6   5   4   3   2   1   0
		//说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
		strRunDetail = strRunDetail +  char(13) + char(10) + "门磁状态  1号门磁 2号门磁 3号门磁 4号门磁" ;
		strRunDetail = strRunDetail +  char(13) + char(10)                                               ;
		strRunDetail = strRunDetail +  "        ";
		
		lngRet = wudp->GetDoorStatusFromRunInfo(bstrFrame, 1);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + "   开   ";
		}
		else
		{
			strRunDetail = strRunDetail + "   关   ";
		}

		lngRet = wudp->GetDoorStatusFromRunInfo(bstrFrame, 2);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + "   开   ";
		}
		else
		{
			strRunDetail = strRunDetail + "   关   ";
		}

		lngRet = wudp->GetDoorStatusFromRunInfo(bstrFrame, 3);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + "   开   ";
		}
		else
		{
			strRunDetail = strRunDetail + "   关   ";
		}

		lngRet = wudp->GetDoorStatusFromRunInfo(bstrFrame, 4);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + "   开   ";
		}
		else
		{
			strRunDetail = strRunDetail + "   关   ";
		}


		strRunDetail = strRunDetail +  char(13) + char(10);
		//按钮状态
		//Bit位  7   6   5   4   3   2   1   0
		//说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
		strRunDetail = strRunDetail + "按钮状态  1号按钮 2号按钮 3号按钮 4号按钮";
		strRunDetail = strRunDetail +  char(13) + char(10)                       ;
		strRunDetail = strRunDetail +  "        ";
		lngRet = wudp->GetButtonStatusFromRunInfo(bstrFrame, 1);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + " 松开   ";
		}
		else
		{
			strRunDetail = strRunDetail + " 按下   ";
		}
		lngRet = wudp->GetButtonStatusFromRunInfo(bstrFrame, 2);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + " 松开   ";
		}
		else
		{
			strRunDetail = strRunDetail + " 按下   ";
		}
		lngRet = wudp->GetButtonStatusFromRunInfo(bstrFrame, 3);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + " 松开   ";
		}
		else
		{
			strRunDetail = strRunDetail + " 按下   ";
		}
		lngRet = wudp->GetButtonStatusFromRunInfo(bstrFrame, 4);
		if (lngRet == 1)
		{
			strRunDetail = strRunDetail + " 松开   ";
		}
		else
		{
			strRunDetail = strRunDetail + " 按下   ";
		}
	
	
		strRunDetail = strRunDetail +  char(13) + char(10) + "故障状态:" +  char(9);
		lngRet = wudp->GetErrorNoFromRunInfo(bstrFrame);
		if (lngRet== 0)
		{
			strRunDetail = strRunDetail + " 无故障  "	;
		}
		else
		{
			strRunDetail = strRunDetail + " 有故障  "   ;
			if ((lngRet & 1) > 0)
			{
				strRunDetail = strRunDetail +  char(13) + char(10) + "        " +  char(9) + "系统故障1"  ;
			}
			if ((lngRet & 2) > 0)
			{
				strRunDetail = strRunDetail +  char(13) + char(10) + "        " +  char(9) + "系统故障2";
			}
			if ((lngRet & 4) > 0)
			{
				strRunDetail = strRunDetail +  char(13) + char(10) + "        " +  char(9) + "系统故障3[设备时钟有故障], 请校正时钟处理";
			}
			if ((lngRet & 8) > 0)
			{
				strRunDetail = strRunDetail +  char(13) + char(10) + "        " +  char(9) + "系统故障4";
			}
		}
		strInfo = strInfo + strRunDetail;
		pBoxOne->SetWindowText(strInfo );

		if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
				::TranslateMessage   (&message);   
				::DispatchMessage   (&message);   
			}   


        //查询控制器的IP设置
        //读取网络配置信息指令
        bstrCmd = wudp->CreateBstrCommand(controllerSN, "0111");       //生成指令帧 读取网络配置信息指令
        bstrFrame = wudp->udp_comm(bstrCmd,  strIPAddr, 60000) ;       //发送指令, 并获取返回信息
        if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" ))	
		{
			strInfo = strInfo + char(13) + char(10) + "出错处理" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}

        strRunDetail = "";

        //MAC
        startLoc = 11-1;                                                         ;
        strRunDetail = strRunDetail +  char(13) + char(10) +   "MAC:" + char(9) + char(9) + CString(bstrFrame).Mid(startLoc, 2);
        strRunDetail = strRunDetail + "-" +  CString(bstrFrame).Mid(startLoc + 2, 2);
        strRunDetail = strRunDetail + "-" +  CString(bstrFrame).Mid(startLoc + 4, 2);
        strRunDetail = strRunDetail + "-" +  CString(bstrFrame).Mid(startLoc + 6, 2);
        strRunDetail = strRunDetail + "-" +  CString(bstrFrame).Mid(startLoc + 8, 2);
        strRunDetail = strRunDetail + "-" +  CString(bstrFrame).Mid(startLoc + 10, 2);
        strMac =  CString(bstrFrame).Mid(startLoc , 12);

        //IP
        startLoc = 23-1; 
		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc, 2)));
		strTemp.Format( "%ld",lngRet);
        strRunDetail = strRunDetail +  char(13) + char(10) +  "IP:" + char(9) + char(9) + strTemp ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+2, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
   		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+4, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+6, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;

        //Subnet Mask
        startLoc = 31-1;
		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc, 2)));
		strTemp.Format( "%ld",lngRet);
        strRunDetail = strRunDetail +  char(13) + char(10) +  "子网掩码:" + char(9) + strTemp ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+2, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
   		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+4, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+6, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;


        //Default Gateway
        startLoc = 39-1;
 		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc, 2)));
		strTemp.Format( "%ld",lngRet);
        strRunDetail = strRunDetail +  char(13) + char(10) +  "网关:    " + char(9) + strTemp ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+2, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
   		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+4, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;
  		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc+6, 2)));
		strTemp.Format( "%ld",lngRet);
		strRunDetail = strRunDetail + "." + strTemp                              ;

        //TCP Port
        startLoc = 47-1;
 		lngRet = wudp->StrHexToNum(A2BSTR(CString(bstrFrame).Mid(startLoc, 4)));
		strTemp.Format( "%ld",lngRet);
        strRunDetail = strRunDetail +  char(13) + char(10) +  "PORT:" + char(9) + char(9) + strTemp;
        strInfo = strInfo + char(13) + char(10) +  strRunDetail +  char(13) + char(10);
		pBoxOne->SetWindowText(strInfo );


        strInfo = strInfo + char(13) + char(10) + "开始IP地址设置: "+ char(13);
		pBoxOne->SetWindowText(strInfo );

		if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
			::TranslateMessage   (&message);   
			::DispatchMessage   (&message);   
		}   

        //新的IP设置: (MAC不变) IP地址: 192.168.168.90; 掩码: 255.255.255.0; 网关: 192.168.168.254; 端口: 60000
		((CWnd*)GetDlgItem(IDC_EDITIP1))->GetWindowText(strTemp);
		strHexNewIP = CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITIP2))->GetWindowText(strTemp);
		strHexNewIP = strHexNewIP + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITIP3))->GetWindowText(strTemp);
		strHexNewIP = strHexNewIP + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITIP4))->GetWindowText(strTemp);
		strHexNewIP = strHexNewIP + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));

		((CWnd*)GetDlgItem(IDC_EDITMASK1))->GetWindowText(strTemp);
		strHexMask = CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITMASK2))->GetWindowText(strTemp);
		strHexMask = strHexMask + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITMASK3))->GetWindowText(strTemp);
		strHexMask = strHexMask + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITMASK4))->GetWindowText(strTemp);
		strHexMask =  strHexMask + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));

		((CWnd*)GetDlgItem(IDC_EDITGATEWAY1))->GetWindowText(strTemp);
		strHexGateway = CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITGATEWAY2))->GetWindowText(strTemp);
		strHexGateway = strHexGateway + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITGATEWAY3))->GetWindowText(strTemp);
		strHexGateway = strHexGateway + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));
		((CWnd*)GetDlgItem(IDC_EDITGATEWAY4))->GetWindowText(strTemp);
		strHexGateway = strHexGateway + CString((BSTR)wudp->NumToStrHex(_ttol((LPCTSTR)strTemp), 1));

		strTemp = "F211" + strMac + strHexNewIP + strHexMask + strHexGateway + "60EA";
		bstrCmd = wudp ->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;   //生成指令帧 读取网络配置信息指令
        bstrFrame = wudp->udp_comm(bstrCmd, strIPAddr, 60000);                    //发送指令, 并获取返回信息
        if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
		{
			strInfo = strInfo + char(13) + char(10) + "出错处理" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}

         
        strInfo = strInfo +  char(13) + char(10) +  "IP地址设置完成...要等待3秒钟, 请稍候" ;
		pBoxOne->SetWindowText(strInfo );
		if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
			::TranslateMessage   (&message);   
			::DispatchMessage   (&message);   
		}   
        Sleep (3000);               //引入3秒延时
		::MessageBox(NULL,(LPCTSTR)"IP地址设置完成","",MB_OK );
		pBoxOne->SetWindowText(strInfo );

        //采用新的IP地址进行通信
		((CWnd*)GetDlgItem(IDC_EDITIP1))->GetWindowText(strTemp);
		strNewIPAddr = strTemp ;
		((CWnd*)GetDlgItem(IDC_EDITIP2))->GetWindowText(strTemp);
		strNewIPAddr = strNewIPAddr + "." + strTemp;
		((CWnd*)GetDlgItem(IDC_EDITIP3))->GetWindowText(strTemp);
		strNewIPAddr = strNewIPAddr + "." + strTemp;
		((CWnd*)GetDlgItem(IDC_EDITIP4))->GetWindowText(strTemp);
		strNewIPAddr = strNewIPAddr + "." + strTemp;
		strIPAddr = strNewIPAddr.AllocSysString();

        strInfo = strInfo +  char(13) + char(10) +  "采用新的IP地址进行通信" + CString(strIPAddr);
		pBoxOne->SetWindowText(strInfo );


		//校准控制器时间
		bstrCmd = wudp -> CreateBstrCommandOfAdjustClockByPCTime(controllerSN);  //生成指令帧
		bstrFrame = wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	//发送指令, 并获取返回信息
		if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
		{
			strInfo = strInfo + char(13) + char(10) + "校准控制器时间出错" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}
		else
		{
			strInfo = strInfo + char(13) + char(10) + "校准控制器时间成功" ;
			pBoxOne->SetWindowText(strInfo );
		}

		//远程开1号门
 		bstrCmd = wudp ->CreateBstrCommand(controllerSN, A2BSTR("9D1001")) ;  //生成指令帧
		bstrFrame = wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	          //发送指令, 并获取返回信息
		if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
		{
			//没有收到数据,
			//失败处理代码... (查ErrCode针对性分析处理)
			strInfo = strInfo + char(13) + char(10) + "远程开门失败" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}
		else
		{
			strInfo = strInfo + char(13) + char(10) + "远程开门成功" ;
			pBoxOne->SetWindowText(strInfo );
		}
		 
		UpdateWindow();	//刷新窗口

		//提取记录
        long recIndex;
		recIndex = 1;
        while(true)
		{
			if (bStopRun)
			{
				break;
			}

			bstrT = wudp->NumToStrHex(recIndex, 4);
			strTemp = "8D10" + CString(bstrT);
			bstrCmd = wudp ->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;  //生成指令帧
			bstrFrame = wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	         //发送指令, 并获取返回信息
			if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
			{
				//没有收到数据,
                //失败处理代码... (查ErrCode针对性分析处理)
                //用户可考虑重试
				strInfo = strInfo + char(13) + char(10) + "提取记录出错" ;
				pBoxOne->SetWindowText(strInfo );
				break;
			}
			else
			{
				bstrSwipeDate = wudp->GetSwipeDateFromRunInfo(bstrFrame, &cardId, &status) ;
				if (CString((bstrSwipeDate)) != "" )
				{
					strRunDetail = "";
					strTemp.Format( "%ld",cardId);
					strRunDetail = strRunDetail  + "卡号: " + strTemp ;
					strTemp.Format( "%ld",status);
					strRunDetail = strRunDetail +  char(9) + " 状态:" +  char(9) + strTemp ;
					bstrT = wudp->NumToStrHex(status,1);
					strRunDetail = strRunDetail +  "(" + CString(bstrT) + ")" ;
					strRunDetail = strRunDetail +  char(9) + "时间:" +  char(9) + CString(bstrSwipeDate) ;
					strInfo = strInfo + char(13) + char(10) + strRunDetail ;
                    recIndex = recIndex + 1;                        //下一条记录
					pBoxOne->SetWindowText(strInfo );
					pBoxOne->LineScroll(pBoxOne->GetLineCount());	//显示最后一行
				}
				else
				{
					strTemp.Format("%ld", (recIndex-1));
					strInfo = strInfo + char(13) + char(10) + "提取记录完成. 总共提取记录数 =" + strTemp;
					pBoxOne->SetWindowText(strInfo );
					pBoxOne->LineScroll(pBoxOne->GetLineCount());	//显示最后一行
					break;
				}
			}
			if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
						::TranslateMessage   (&message);   
						::DispatchMessage   (&message);   
			}   

		}
		if ((ERROR_SUCCESS != wudp->ErrCode )||(CString(bstrFrame)==""))	
		{
			break;		//出错 退出
		}

        
        //删除已提取的记录
        if (recIndex > 1)   //只有提取了记录才进行删除
		{
			strTemp.Format("%ld", (recIndex-1));
			strTemp = "是否删除控制器上已提取的记录: " + strTemp;
			if (::MessageBox(NULL,(LPCTSTR)strTemp,"删除",MB_YESNO ) == IDYES)
			{
				bstrT = wudp->NumToStrHex(recIndex-1, 4);
				strTemp = "8E10" + CString(bstrT);
   				bstrCmd = wudp ->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;  //生成指令帧
				bstrFrame = wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	         //发送指令, 并获取返回信息
				if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)==""))	
				{
					//没有收到数据,
					//失败处理代码... (查ErrCode针对性分析处理)
					//用户可考虑重试
					strInfo = strInfo + char(13) + char(10) + "删除记录失败" ;
					pBoxOne->SetWindowText(strInfo );
					break;
				}
				else
				{
					strInfo = strInfo + char(13) + char(10) + "删除记录成功";
					pBoxOne->SetWindowText(strInfo );
				}
			}
		}

		//发送权限操作(1.先清空权限)
   		bstrCmd = wudp ->CreateBstrCommand(controllerSN, A2BSTR("9310")) ;  //生成指令帧 
		bstrFrame =  wudp -> udp_comm(bstrCmd, strIPAddr, 60000);	        //发送指令, 并获取返回信息
		if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
		{
			//没有收到数据,
			//失败处理代码... (查ErrCode针对性分析处理)
			//用户可考虑重试
			strInfo = strInfo + char(13) + char(10) + "清空权限失败" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}
		else
		{
			strInfo = strInfo + char(13) + char(10) + "清空权限成功" ;
			pBoxOne->SetWindowText(strInfo );
		}

        //发送权限操作(2.再添加权限)
        //权限格式: 卡号（2）+区号（1）+门号（1）+卡起始年月日（2）+卡截止年月日（2）+ 控制时段索引号（1）+密码（3）+备用（4，用0填充）
        //发送权限按: 先发1号门(卡号小的先发), 再发2号门(卡号小的先发)
        //此案例中权限设为: 卡有效期从(2007-8-14 到2020-12-31), 采用默认时段1(任意时间有效), 缺省密码(1234), 备用值以00填充
        //以三个卡： 07217564 [9C4448]，342681[B9A603]，25409969[F126FE]为例，分别可以通过控制器的2个门。
        //实际使用按需修改
        
        //!!!!!!!注意:  此处卡号已直接按从小到大排列赋值了. 实际使用中要用算法实现排序
		long cardno[3];
		long privilegeIndex;
		long doorIndex;
		long cardIndex;
		CString privilege;
        cardno[0] = 342681 ;
        cardno[1] = 7217564;
        cardno[2] = 25409969;
        privilegeIndex = 1  ;
        for( doorIndex = 0;doorIndex<=1; doorIndex++)
		{
            for(cardIndex = 0; cardIndex <= 2; cardIndex++)
			{
                
                privilege = ""; 
				bstrT = wudp->CardToStrHex(cardno[cardIndex]);
                privilege = privilege + CString(bstrT);                  //卡号
 				bstrT = wudp->NumToStrHex(doorIndex + 1, 1);
				privilege = privilege + CString(bstrT) ;                 //门号
				bstrT = wudp->MSDateYmdToWCDateYmd(A2BSTR("2007-8-14")) ;//有效起始日期
                privilege = privilege + CString(bstrT);                  
                bstrT = wudp->MSDateYmdToWCDateYmd(A2BSTR("2020-12-31"));//有效截止日期
				privilege = privilege + CString(bstrT) ;
                bstrT = wudp->NumToStrHex(1, 1)                 ;    //时段索引号
				privilege = privilege + CString(bstrT) ;
                bstrT = wudp->NumToStrHex(123456, 3)            ;    //用户密码
				privilege = privilege + CString(bstrT) ;
                bstrT = wudp->NumToStrHex(0, 4)                 ;    //备用4字节(用0填充)
				privilege = privilege + CString(bstrT) ;
                if (lstrlen(privilege) != (16 * 2))
				{
                    //生成的权限不符合要求, 请查一下上一指令中写入的每个参数是否正确
				   strInfo = strInfo + char(13) + char(10) + "生成的权限不符合要求: 添加权限失败" ;
				   pBoxOne->SetWindowText(strInfo );
				   break;;
				}

                bstrT = wudp->NumToStrHex(privilegeIndex, 2)                 ;    //权限索引号
				strTemp = "9B10" + CString(bstrT) + privilege;
				bstrCmd = wudp->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;  //生成指令帧 
				bstrFrame =( wudp -> udp_comm(bstrCmd, strIPAddr, 60000));	        //发送指令, 并获取返回信息
				if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
				{
					//没有收到数据,
					//失败处理代码... (查ErrCode针对性分析处理)
					//用户可考虑重试
					strInfo = strInfo + char(13) + char(10) + "添加权限失败" ;
					pBoxOne->SetWindowText(strInfo );
					break;
				}
				else
				{
                    privilegeIndex = privilegeIndex + 1;
				}
				if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
							::TranslateMessage   (&message);   
							::DispatchMessage   (&message);   
				}   
			}
		}
		strTemp.Format("%ld", privilegeIndex-1 );
		strInfo = strInfo + char(13) + char(10) + "添加权限数 = " + strTemp ;
		pBoxOne->SetWindowText(strInfo );
				
        
        //发送控制时段
        //发送要设定的时段 [注意0,1时段为系统固定化,更改是无效的, 所以设定的时段一般从2开始]
        //此案例设定时段2: 从2007-8-1到2007-12-31日
        // 星期1到5允许在7:30-12:30, 13:30-17:30, 19:00-21:00通过, 其他时间不允许
		CString timeseg;
        timeseg = "";
    	bstrT = wudp->NumToStrHex(0x1F, 1);
		timeseg = timeseg + CString(bstrT) ;   //星期控制
     	bstrT = wudp->NumToStrHex(0x00, 1);
		timeseg = timeseg + CString(bstrT) ;   // 下一链接时段(0--表示无)
    	bstrT = wudp->NumToStrHex(0x00, 2);
		timeseg = timeseg + CString(bstrT) ;   // 保留2字节(0填充)
    	bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("7:30:00"));
		timeseg = timeseg + CString(bstrT) ;   //  起始时分秒1
   		bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("12:30:00"));
		timeseg = timeseg + CString(bstrT) ;   //  终止时分秒1
    	bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("13:30:00"));
		timeseg = timeseg + CString(bstrT) ;   //  起始时分秒2
   		bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("17:30:00"));
		timeseg = timeseg + CString(bstrT) ;   //  终止时分秒2
    	bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("19:00:00"));
		timeseg = timeseg + CString(bstrT) ;   //  起始时分秒3
   		bstrT = wudp->MSDateHmsToWCDateHms(A2BSTR("21:00:00"));
		timeseg = timeseg + CString(bstrT) ;   //  终止时分秒3
    	bstrT = wudp->MSDateYmdToWCDateYmd(A2BSTR("2007-8-1"));
		timeseg = timeseg + CString(bstrT) ;   //  起始日期
   		bstrT = wudp->MSDateYmdToWCDateYmd(A2BSTR("2007-12-31"));
		timeseg = timeseg + CString(bstrT) ;   //  终止日期
    	bstrT = wudp->NumToStrHex(0x00, 4);
		timeseg = timeseg + CString(bstrT) ;   // 保留4字节(0填充)

        if (lstrlen(timeseg) != (24 * 2))
		{
            //生成的时段不符合要求, 请查一下上一指令中写入的每个参数是否正确
			strInfo = strInfo + char(13) + char(10) + "生成的时段不符合要求: 修改时段失败" ;
			pBoxOne->SetWindowText(strInfo );
			break;;
		}

		bstrT = wudp->NumToStrHex(2, 2)  ;                                  //时段索引号2
		strTemp = "9710" + CString(bstrT) + timeseg;
		bstrCmd = wudp->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;  //生成指令帧 
		bstrFrame = ( wudp -> udp_comm(bstrCmd, strIPAddr, 60000));	        //发送指令, 并获取返回信息
		if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" ))	
		{
			//没有收到数据,
			//失败处理代码... (查ErrCode针对性分析处理)
			//用户可考虑重试
			strInfo = strInfo + char(13) + char(10) + "添加时段失败" ;
			pBoxOne->SetWindowText(strInfo );
			break;
		}
		else
		{
			strInfo = strInfo + char(13) + char(10) + "添加时段成功" ;
			pBoxOne->SetWindowText(strInfo );
		}


        //实时监控
       // 读取运行状态是实现监控的关键指令。 在进行监控时, 先读取最新记录索引位的记录. 读取到最新的记录， 同时可以获取到刷卡记录数。
       // 这时就可以用读取到刷卡记录数加1填充到要读取的最新记录索引位上，去读取运行状态， 以便获取下一个记录。
       // 如果读取到了新的刷卡记录， 就可以将索引位增1， 否则保持索引位不变。 这样就可以实现数据的实时监控。
       // 遇到通信不上的处理，这时可对串口通信采取超时400-500毫秒作为出错，可重试一次，再接收不到数据， 可认为设备与PC机间的不能通信。
	   __int64 watchIndex;
	   long recCnt;

       watchIndex = 0   ;                   //缺省从0, 表示先提取最近一个记录
       recCnt = 0       ;                   //监控记录计数
       strInfo = strInfo + char(13) + char(10) + "开始实时监控......(请刷卡3次)" ;
	   pBoxOne->SetWindowText(strInfo );
	   UpdateWindow();	//刷新窗口
	   pBoxOne->LineScroll(pBoxOne->GetLineCount());	//显示最后一行

       while (recCnt < 3)         //测试中 读到3个就停止
	   {
		   	if (bStopRun)
			{
				break;
			}

		    bstrT = wudp->NumToStrHex(watchIndex, 3) ;                          //表示第watchIndex个记录, 如果是0则取最新一条记录
			strTemp = "8110" + CString(bstrT);
			bstrCmd = wudp->CreateBstrCommand(controllerSN, A2BSTR(strTemp)) ;  //生成指令帧 
			bstrFrame =( wudp -> udp_comm(bstrCmd, strIPAddr, 60000));	        //发送指令, 并获取返回信息
			if (( ERROR_SUCCESS != wudp ->ErrCode)||(CString(bstrFrame)=="" )	)	
			{
				//没有收到数据,
				//失败处理代码... (查ErrCode针对性分析处理)
				//用户可考虑重试
				strInfo = strInfo + char(13) + char(10) + "实时监控失败" ;
				pBoxOne->SetWindowText(strInfo );
				break;
			}
			else
			{
				bstrSwipeDate = wudp->GetSwipeDateFromRunInfo(bstrFrame, &cardId, &status) ;
				if (CString(bstrSwipeDate) != "" )
				{
					strRunDetail="";
					strTemp.Format( "%ld",cardId);
					strRunDetail = strRunDetail  + "卡号: " + strTemp ;
					strTemp.Format( "%ld",status);
					strRunDetail = strRunDetail +  char(9) + " 状态:" +  char(9) + strTemp ;
					bstrT = wudp->NumToStrHex(status,1);
					strRunDetail = strRunDetail +  "(" + CString(bstrT) + ")" ;
					strRunDetail = strRunDetail +  char(9) + "时间:" +  char(9) + CString((bstrSwipeDate)) ;
					strInfo = strInfo + char(13) + char(10) + strRunDetail ;
					pBoxOne->SetWindowText(strInfo );
                    recIndex = recIndex + 1;             //下一条记录
					UpdateWindow();	                     //刷新窗口
				   if (watchIndex == 0)                  //如果收到第一条记录
				   {
					   watchIndex = wudp->GetCardRecordCountFromRunInfo(bstrFrame);
					   watchIndex =  watchIndex + 1;     //指向(总记录数+1), 也就是下次刷卡的存储索引位
				   }
				   else
				   {
						watchIndex = watchIndex + 1 ;    //指向下一个记录位
				   }
					recCnt = recCnt + 1;                 //记录计数				}
				   pBoxOne->LineScroll(pBoxOne->GetLineCount());	//显示最后一行
				}
			}

			if(::PeekMessage   (&message,NULL,0,0,PM_REMOVE)){		//响应其他事件 如Exit按钮操作
				::TranslateMessage   (&message);   
				::DispatchMessage   (&message);   
			}   

	   }
		strInfo = strInfo + char(13) + char(10) + "已停止实时监控" ;
		pBoxOne->SetWindowText(strInfo );
	    pBoxOne->LineScroll(pBoxOne->GetLineCount());	//显示最后一行

		//释放资源
		wudp -> Release();
		break;
	}
	// Uninitialize COM
	CoUninitialize();
}
