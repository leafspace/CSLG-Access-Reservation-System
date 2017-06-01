
// 常熟理工学院门禁预约系统Dlg.cpp : 实现文件
//

#include "stdafx.h"
#include "常熟理工学院门禁预约系统.h"
#include "常熟理工学院门禁预约系统Dlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

	// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	// 实现
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// C常熟理工学院门禁预约系统Dlg 对话框




C常熟理工学院门禁预约系统Dlg::C常熟理工学院门禁预约系统Dlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(C常熟理工学院门禁预约系统Dlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void C常熟理工学院门禁预约系统Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);

	DDX_Control(pDX, IDC_LIST1, ctrlList_msg);                          //初始化列表
	DDX_Control(pDX, IDC_COMBO1, comboBox_room);
}

BEGIN_MESSAGE_MAP(C常熟理工学院门禁预约系统Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_TIMER()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON3, &C常熟理工学院门禁预约系统Dlg::OnBnClickedButton3)
	ON_CBN_SELCHANGE(IDC_COMBO1, &C常熟理工学院门禁预约系统Dlg::OnCbnSelchangeCombo1)
	ON_BN_CLICKED(IDC_BUTTON1, &C常熟理工学院门禁预约系统Dlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &C常熟理工学院门禁预约系统Dlg::OnBnClickedButton2)
END_MESSAGE_MAP()


// C常熟理工学院门禁预约系统Dlg 消息处理程序

BOOL C常熟理工学院门禁预约系统Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码
	GetDlgItem(IDC_EDIT1)->SetWindowText(_T("CSLG Access reservation system"));//设置输入数据框的默认数值

	comboBox_room.AddString(_T("(local)"));                                    //默认活动室
	comboBox_room.SetCurSel(0);                                                //设置0号默认选中
	CRect rect;
	ctrlList_msg.GetHeaderCtrl()->EnableWindow(false);                         //固定标题不被移动
	ctrlList_msg.GetClientRect(&rect);                                         //获取编程语言列表视图控件的位置和大小
	ctrlList_msg.SetExtendedStyle(ctrlList_msg.GetExtendedStyle()
		| LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);                            //为列表视图控件添加全行选中和栅格风格

	ctrlList_msg.InsertColumn(0, _T("序号"), LVCFMT_CENTER, 40, 0);
	ctrlList_msg.InsertColumn(1, _T("预约人"), LVCFMT_CENTER, 60, 1);
	ctrlList_msg.InsertColumn(2, _T("预约时间"), LVCFMT_CENTER, (rect.Width() - 150) / 2, 2);
	ctrlList_msg.InsertColumn(3, _T("时长"), LVCFMT_CENTER, 50, 3);
	ctrlList_msg.InsertColumn(4, _T("备注"), LVCFMT_CENTER, (rect.Width() - 150) / 2, 4);

	get_db_data = NULL;
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void C常熟理工学院门禁预约系统Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void C常熟理工学院门禁预约系统Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR C常熟理工学院门禁预约系统Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void C常熟理工学院门禁预约系统Dlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
}


void C常熟理工学院门禁预约系统Dlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码
}


void C常熟理工学院门禁预约系统Dlg::OnBnClickedButton3()
{
	// TODO: 在此添加控件通知处理程序代码
	GetDlgItem(IDC_EDIT1)->GetWindowText(DatabaseName);                        //获取数据库访问名
	comboBox_room.ResetContent();                                              //重置下拉框
	MyDB *mydb = new MyDB(DatabaseName);
	mydb->ConnectDatabase();                                                   //连接数据库
	if (mydb->IsConnect()){
		DBRoom *db_msg = new DBRoom(mydb->getDatabase());
		CString str("select * from ActivityRooms;");                           //查询所有的活动室
		db_msg->query(str);

		for (int i = 0; i < db_msg->getRow(); ++i){                            //遍历数据集
			int r_id = _ttoi(db_msg->getResult(i, 0));
			CString r_name = db_msg->getResult(i, 1);
			CString information = db_msg->getResult(i, 2);
			ActivityRoom t_room(r_id, r_name, information);                    //将获取的数据转换为对象保存
			this->rooms.push_back(t_room);
			comboBox_room.AddString(r_name);                                   //添加到下拉框中
		}
		comboBox_room.SetCurSel(0);                                            //设置第一个属性默认选中

		this->get_db_data = new GetReservationsFromDB(_T("select * from Reservations where room_id = 1;"), 3000);

		db_msg->Close();
		mydb->CloseDatabase();
		SetTimer(1, 1000, NULL);
	}
}


void C常熟理工学院门禁预约系统Dlg::OnCbnSelchangeCombo1()                        //相应下拉框点击，显示某活动室预约情况
{
	// TODO: 在此添加控件通知处理程序代码
	if (get_db_data != NULL){
		get_db_data->CloseTimer();
	}

	CString room_name;
	comboBox_room.GetLBText(comboBox_room.GetCurSel(), room_name);             //获取当前选中的活动室名
	int room_id = 1;
	for (int i = 0; i < this->rooms.size(); ++i){                              //找到拥有此名字的活动室的ID
		if (this->rooms[i].getRoomName() == room_name){
			room_id = this->rooms[i].getRoomID();
			break;
		}
	}
	CString sql;
	sql.Format(_T("select * from Reservations where room_id = %d;"), room_id); //书写查询sql
	this->get_db_data = new GetReservationsFromDB(sql, 3000);                  //开始查询数据
}


void C常熟理工学院门禁预约系统Dlg::OnTimer(UINT nIDEvent)                        //定时通过保存在数据集当中的数据更新列表
{
	ctrlList_msg.DeleteAllItems();                                             //删除所有item
	for (int i = 0; i < database_messges.size(); ++i){                         //更新列表数据
		ctrlList_msg.InsertItem(i, _T(""));
		ReservationMessages msg = database_messges[i];

		ctrlList_msg.SetItemText(i, 0, msg.getReservationID());
		ctrlList_msg.SetItemText(i, 1, msg.getUsername());
		ctrlList_msg.SetItemText(i, 2, msg.getTime());
		ctrlList_msg.SetItemText(i, 3, msg.getDuration());
		ctrlList_msg.SetItemText(i, 4, msg.getInformation());
	}
}