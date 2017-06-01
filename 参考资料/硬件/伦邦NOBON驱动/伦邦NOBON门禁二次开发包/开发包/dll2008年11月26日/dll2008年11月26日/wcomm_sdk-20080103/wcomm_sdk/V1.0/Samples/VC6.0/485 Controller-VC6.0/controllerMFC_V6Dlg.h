// controllerMFC_V6Dlg.h : header file
//

#if !defined(AFX_CONTROLLERMFC_V6DLG_H__B249177C_3BD5_4376_8F8A_D64F404EFCF4__INCLUDED_)
#define AFX_CONTROLLERMFC_V6DLG_H__B249177C_3BD5_4376_8F8A_D64F404EFCF4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CControllerMFC_V6Dlg dialog

class CControllerMFC_V6Dlg : public CDialog
{
// Construction
public:
	CControllerMFC_V6Dlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CControllerMFC_V6Dlg)
	enum { IDD = IDD_CONTROLLERMFC_V6_DIALOG };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CControllerMFC_V6Dlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CControllerMFC_V6Dlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	virtual void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONTROLLERMFC_V6DLG_H__B249177C_3BD5_4376_8F8A_D64F404EFCF4__INCLUDED_)
