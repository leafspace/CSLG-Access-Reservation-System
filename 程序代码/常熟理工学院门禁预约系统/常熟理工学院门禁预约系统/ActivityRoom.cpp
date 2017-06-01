#include "stdafx.h"
#include "ActivityRoom.h"

ActivityRoom::ActivityRoom(int room_id, CString room_name, CString information)
{
	this->room_id = room_id;
	this->room_name = room_name;
	this->information = information;
}

int ActivityRoom::getRoomID()                                                  //获取活动室ID
{
	return this->room_id;
}

CString ActivityRoom::getRoomName()                                            //获取活动室名
{
	return this->room_name;
}

CString ActivityRoom::getInformation()                                         //获取活动室备注信息
{
	return this->information;
}