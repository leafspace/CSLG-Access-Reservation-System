class ActivityRoom                                                             //活动室类
{
private:
	int room_id;                                                               //活动室ID
	CString room_name;                                                         //活动室名
	CString information;                                                       //活动室备注信息
public:
	ActivityRoom(int, CString, CString);                                       //构造方法
	int getRoomID();                                                           //获取活动室ID
	CString getRoomName();                                                     //获取活动室名
	CString getInformation();                                                  //获取活动室备注信息
};