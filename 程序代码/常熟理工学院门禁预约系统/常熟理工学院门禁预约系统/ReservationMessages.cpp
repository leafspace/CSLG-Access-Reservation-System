#include "stdafx.h"
#include "ReservationMessages.h"

ReservationMessages::ReservationMessages(int reservation_id, int user_id, int room_id, 
	bool isValid = true, bool isLock = false, 
	int year = 2000, int month = 1, int day = 1, int start = 0, int finish = 0, 
	CString qr_location = NULL, CString information = NULL)
{
	this->reservation_id = reservation_id;
	this->user_id = user_id;
	this->room_id = room_id;
	this->isValid = isValid;
	this->isLock = isLock;
	this->year = year;
	this->month = month;
	this->day = day;
	this->start = start;
	this->finish = finish;
	this->qr_location = qr_location;
	this->information = information;
}

ReservationMessages::ReservationMessages(int reservation_id, int user_id, int room_id, CString username, 
	bool isValid = true, bool isLock = false, 
	int year = 2000, int month = 1, int day = 1, int start = 0, int finish = 0, 
	CString qr_location = NULL, CString information = NULL)
{
	this->reservation_id = reservation_id;
	this->user_id = user_id;
	this->room_id = room_id;
	this->username = username;
	this->isValid = isValid;
	this->isLock = isLock;
	this->year = year;
	this->month = month;
	this->day = day;
	this->start = start;
	this->finish = finish;
	this->qr_location = qr_location;
	this->information = information;
}

void ReservationMessages::setUsername(CString username)
{
	this->username = username;
}

int ReservationMessages::getReservation_id()
{
	return this->reservation_id;
}

int ReservationMessages::getUser_id()
{
	return this->user_id;
}

bool ReservationMessages::IsValid()
{
	return this->isValid;
}

bool ReservationMessages::IsLock()
{
	return this->isLock;
}

int ReservationMessages::getYear()
{
	return this->year;
}

int ReservationMessages::getMonth()
{
	return  this->month;
}

int ReservationMessages::getDay()
{
	return this->day;
}

int ReservationMessages::getStart()
{
	return this->start;
}

int ReservationMessages::getFinish()
{
	return this->finish;
}

CString ReservationMessages::getQr_location()
{
	return this->qr_location;
}

CString ReservationMessages::getInformation()
{
	return this->information;
}

CString ReservationMessages::getReservationID()
{
	CString str;
	str.Format(_T("%d"), this->getReservation_id());
	return str;
}

CString ReservationMessages::getUsername()
{
	return this->username;
}

CString ReservationMessages::getTime()                                         //获取预约时间
{
	CString str;
	str.Format(_T("%d年%d月%d日-%d：%d起"), this->year, this->month, this->day, this->start / 100, this->start % 100);
	return str;
}

CString ReservationMessages::getDuration()                                     //获取预约持续时间
{
	int minite = this->finish % 100 - this->start % 100;                       //获取分钟上的值
	int hour = (minite < 0) ? this->finish / 100 - 1 - this->start / 100 : 
		this->finish / 100 - this->start / 100;                                //获取小时上的值
	if (minite < 0){
		minite += 60;
	}

	CString str;
	str.Format(_T("%.1lf"), (double)(hour + minite * 1.0 / 60));               //总数值
	return str;
}