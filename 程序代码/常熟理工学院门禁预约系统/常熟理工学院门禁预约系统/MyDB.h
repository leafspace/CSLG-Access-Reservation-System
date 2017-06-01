#include <afxdb.h>                                                             //用于支持数据库操作

class MyDB                                                                     //重构的访问SQL Server的数据库连接操作
{
private:
	char* username;                                                            //用户名
	char* password;                                                            //密码
	CString database;                                                          //数据库名
	CDatabase m_db;                                                            //访问数据库的基类
public:
	MyDB(CString);
	~MyDB();
	bool ConnectDatabase();                                                    //连接数据库操作
	bool IsConnect();                                                          //判断是否连接上数据库
	CDatabase* getDatabase();                                                  //获取基类
	void CloseDatabase();                                                      //关闭数据库的连接
};

class DBRoom :public CRecordset                                                //重构的访问活动室表的操作
{
private:
	CString **result;                                                          //数据库的查询结果
	int row;                                                                   //查询结果的行数
	int col;                                                                   //查询结果的列数
public:
	DBRoom(CDatabase* pDatabase = NULL) :CRecordset(pDatabase) {
	}
	~DBRoom(){
		this->Close();
	}
	void query(CString);                                                       //数据库查询操作
	void update(CString);                                                      //数据库修改操作
	int getRow();                                                              //获取查询结果行数
	int getCol();                                                              //获取查询结果列数
	CString** getResult();                                                     //获取查询结果数据集
	CString getResult(int row, int col);                                       //获取某个位置上的查询结果
};

class DBReservationMessage :public CRecordset
{
private:
	CString **result;                                                          //数据库的查询结果
	int row;                                                                   //查询结果的行数
	int col;                                                                   //查询结果的列数
public:
	DBReservationMessage(CDatabase* pDatabase = NULL) :CRecordset(pDatabase) {
	}
	~DBReservationMessage(){
		this->Close();
	}
	void query(CString);                                                       //数据库查询操作
	void update(CString);                                                      //数据库修改操作
	int getRow();                                                              //获取查询结果行数
	int getCol();                                                              //获取查询结果列数
	CString** getResult();                                                     //获取查询结果数据集
	CString getResult(int row, int col);                                       //获取某个位置上的查询结果
};