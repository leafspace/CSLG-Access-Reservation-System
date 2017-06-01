
// 常熟理工学院门禁预约系统Dlg.h : 头文件
//

#pragma once
#include "GetReservationsFromDB.h"
#include "ActivityRoom.h"
#include "afxwin.h"
// C常熟理工学院门禁预约系统Dlg 对话框
class C常熟理工学院门禁预约系统Dlg : public CDialogEx
{
	// 构造
public:
	C常熟理工学院门禁预约系统Dlg(CWnd* pParent = NULL);	// 标准构造函数

	// 对话框数据
	enum { IDD = IDD_MY_DIALOG };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


	// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()

private:
	CListCtrl ctrlList_msg;                                                    //预约消息列表框
	CComboBox comboBox_room;                                                   //活动室下拉框
	GetReservationsFromDB *get_db_data;                                        //获取预约消息计时器
	vector<ActivityRoom> rooms;                                                //活动室列表
public:
	afx_msg void OnBnClickedButton1();                                         //开门
	afx_msg void OnBnClickedButton2();                                         //删除预约
	afx_msg void OnBnClickedButton3();                                         //连接数据库
	afx_msg void OnCbnSelchangeCombo1();                                       //相应下拉框点击，显示某活动室预约情况
	afx_msg void OnTimer(UINT nIDEvent);                                       //刷新活动室列表
};
