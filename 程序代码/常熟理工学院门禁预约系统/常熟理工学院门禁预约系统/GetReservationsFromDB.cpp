#include "stdafx.h"
#include "GetReservationsFromDB.h"

vector<ReservationMessages> database_messges;                                  //系统全局变量-用于保存从数据库中获取的信息
CString DatabaseName;                                                          //要访问的数据库的名字
CString DatabaseSQl;                                                           //从数据库中读取数据的SQL语句

GetReservationsFromDB::GetReservationsFromDB(CString sql, int uElapse = 2000)
{
	this->uElapse = uElapse;
	this->sql = sql;
	DatabaseSQl = this->sql;
	SetTimer(NULL, this->timer_id, this->uElapse, getReservations);
}

void GetReservationsFromDB::CloseTimer()                                       //关闭定时器
{
	KillTimer(NULL, this->timer_id);
}

void WINAPI getReservations(HWND hWnd, UINT nMsg, UINT nTimerid, DWORD dwTime) //定时器函数-从数据库中读取预约信息
{
	database_messges.clear();                                                  //清除原先读取的预约信息
	MyDB *mydb = new MyDB(DatabaseName);                                       //数据库基类
	mydb->ConnectDatabase();                                                   //连接数据库
	if (mydb->IsConnect()){
		DBReservationMessage *db_msg = new DBReservationMessage(mydb->getDatabase());    //获取数据对象
		db_msg->query(DatabaseSQl);                                            //依照sql查询预约信息

		for (int i = 0; i < db_msg->getRow(); ++i){                            //按照记录数据转化为类封装好的信息
			int r_id = _ttoi(db_msg->getResult(i, 0));
			int u_id = _ttoi(db_msg->getResult(i, 1));
			int o_id = _ttoi(db_msg->getResult(i, 2));
			bool is_valid = _ttoi(db_msg->getResult(i, 3)) == 1;
			bool is_lock = _ttoi(db_msg->getResult(i, 4)) == 1;
			int yea = _ttoi(db_msg->getResult(i, 5));
			int mon = _ttoi(db_msg->getResult(i, 6));
			int day = _ttoi(db_msg->getResult(i, 7));
			int sta = _ttoi(db_msg->getResult(i, 8));
			int fin = _ttoi(db_msg->getResult(i, 9));
			CString qr = db_msg->getResult(i, 10);
			CString in = db_msg->getResult(i, 11);
			ReservationMessages msg(r_id, u_id, o_id, is_valid, is_lock, yea, mon, day, sta, fin, qr, in);
			database_messges.push_back(msg);                                   //保存到全局消息中，供界面控制使用
		}
		db_msg->Close();                                                       //关闭数据链接
		mydb->CloseDatabase();                                                 //关闭数据库
	}

	//Todo 获取预约者的姓名
	for(unsigned long i = 0; i < database_messges.size(); ++i){
		mydb = new MyDB(DatabaseName);                                         //数据库基类
		mydb->ConnectDatabase();                                               //连接数据库
		if(mydb->IsConnect()){
			DBReservationMessage *db_msg = new DBReservationMessage(mydb->getDatabase());
			int u_id = database_messges[i].getUser_id();
			CString tempSQL;
			tempSQL.Format(_T("select userName from Users where user_id = %d;"), u_id);
			db_msg->query(tempSQL);
			CString username = db_msg->getResult(0, 0);
			database_messges[i].setUsername(username);
			db_msg->Close();                                                   //关闭数据链接
		}
		mydb->CloseDatabase();                                                 //关闭数据库
	}
}