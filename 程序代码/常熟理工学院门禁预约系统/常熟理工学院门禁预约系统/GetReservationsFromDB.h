#include "MyDB.h"                                                              //支持底层数据库操作
#include <vector>
#include <windows.h>                                                           //用于支持定时器操作
#include "ReservationMessages.h"
using namespace std;

class GetReservationsFromDB                                                    //用于定时从数据库中获取信息
{
private:
	int timer_id;                                                              //定时器ID
	int uElapse;                                                               //定时秒数
	CString sql;                                                               //获取信息的sql语句
public:
	GetReservationsFromDB(CString, int);                                       //初始化并启动定时器
	void CloseTimer();                                                         //关闭定时器
};

extern vector<ReservationMessages> database_messges;                           //系统全局变量-用于保存从数据库中获取的信息
extern CString DatabaseName;                                                   //要访问的数据库的名字

void WINAPI getReservations(HWND hWnd, UINT nMsg, UINT nTimerid, DWORD dwTime);//定时器函数