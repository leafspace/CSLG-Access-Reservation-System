// controllerMFC_V6.h : main header file for the CONTROLLERMFC_V6 application
//

#if !defined(AFX_CONTROLLERMFC_V6_H__91B9189F_13BF_4903_90E7_ECDA5065CC8C__INCLUDED_)
#define AFX_CONTROLLERMFC_V6_H__91B9189F_13BF_4903_90E7_ECDA5065CC8C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CControllerMFC_V6App:
// See controllerMFC_V6.cpp for the implementation of this class
//

class CControllerMFC_V6App : public CWinApp
{
public:
	CControllerMFC_V6App();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CControllerMFC_V6App)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CControllerMFC_V6App)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CONTROLLERMFC_V6_H__91B9189F_13BF_4903_90E7_ECDA5065CC8C__INCLUDED_)
