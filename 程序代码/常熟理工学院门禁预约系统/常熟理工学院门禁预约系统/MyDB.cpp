#include "stdafx.h"
#include "MyDB.h"

MyDB::MyDB(CString dataSource)
{
	this->username = "sa";
	this->password = "123456";
	this->database = dataSource;
}

MyDB::~MyDB()
{
	this->CloseDatabase();
}

bool MyDB::ConnectDatabase()                                                   //连接数据库操作
{
	CString str("ODBC;UID=");                                                  //连接数据库前缀
	str += this->username;
	str += ";pwd=";
	str += this->password;

	if ((this->m_db.Open(this->database, false, false, str, true)) != 0){      //打开数据库的连接
		return true;
	}
	else{
		return false;
	}
}

bool MyDB::IsConnect()                                                         //判断是否连接上数据库
{
	return this->m_db.IsOpen();
}

CDatabase* MyDB::getDatabase()
{
	return &(this->m_db);
}

void MyDB::CloseDatabase()                                                     //关闭数据库的连接
{
	this->m_db.Close();
}

void DBRoom::query(CString sql)                                                //数据库查询操作
{
	this->Open(CRecordset::forwardOnly, sql);                                  //执行查询语句

	int row = 0;
	while (!(this->IsEOF())){                                                  //获取数据记录行数
		++row;
		this->MoveNext();
	}
	this->Close();                                                             //关闭数据库并重新打开
	this->Open(CRecordset::forwardOnly, sql);

	this->row = row;
	this->col = this->GetODBCFieldCount();                                     //获取数据字段数
	result = new CString *[this->row];                                         //为数据集结果分配内存空间
	for (int i = 0; i < this->row; ++i){
		result[i] = new CString[this->col];
	}

	for (int i = 0; i < this->row; ++i){
		for (int j = 0; j < this->col; ++j){
			this->GetFieldValue(j, result[i][j]);                              //将字段数据保存进入数据集
		}
		this->MoveNext();
	}
}

void DBRoom::update(CString sql)                                               //数据库修改操作
{

}

int DBRoom::getRow()                                                           //获取查询结果行数
{
	if (result != NULL){
		return this->row;
	}
	else{
		return 0;
	}
}

int DBRoom::getCol()                                                           //获取查询结果列数
{
	if (result != NULL){
		return this->col;
	}
	else{
		return 0;
	}
}

CString** DBRoom::getResult()                                                  //获取查询结果数据集
{
	if (result != NULL){
		return this->result;
	}
	else{
		return NULL;
	}
}

CString DBRoom::getResult(int row, int col)                                    //获取某个位置上的查询结果
{
	if (result != NULL){
		return this->result[row][col];
	}
	else{
		return NULL;
	}
}

void DBReservationMessage::query(CString sql)
{
	this->Open(CRecordset::forwardOnly, sql);                                  //执行查询语句

	int row = 0;
	while (!(this->IsEOF())){                                                  //获取数据记录行数
		++row;
		this->MoveNext();
	}
	this->Close();                                                             //关闭数据库并重新打开
	this->Open(CRecordset::forwardOnly, sql);

	this->row = row;
	this->col = this->GetODBCFieldCount();                                     //获取数据字段数
	result = new CString *[this->row];                                         //为数据集结果分配内存空间
	for (int i = 0; i < this->row; ++i){
		result[i] = new CString[this->col];
	}

	for (int i = 0; i < this->row; ++i){
		for (int j = 0; j < this->col; ++j){
			this->GetFieldValue(j, result[i][j]);                              //将字段数据保存进入数据集
		}
		this->MoveNext();
	}
}

void DBReservationMessage::update(CString sql)                                 //数据库修改操作
{

}

int DBReservationMessage::getRow()                                             //获取查询结果行数
{
	if (result != NULL){
		return this->row;
	}
	else{
		return 0;
	}
}

int DBReservationMessage::getCol()                                             //获取查询结果列数
{
	if (result != NULL){
		return this->col;
	}
	else{
		return 0;
	}
}

CString** DBReservationMessage::getResult()                                    //获取查询结果数据集
{
	if (result != NULL){
		return this->result;
	}
	else{
		return NULL;
	}
}

CString DBReservationMessage::getResult(int row, int col)                      //获取某个位置上的查询结果
{
	if (result != NULL){
		return this->result[row][col];
	}
	else{
		return NULL;
	}
}
