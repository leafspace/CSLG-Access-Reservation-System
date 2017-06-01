class ReservationMessages                                                      //用于表示某个预约消息
{
private:
	int reservation_id;                                                        //预约消息对应数据库中的消息ID
	int user_id;                                                               //预约用户ID
	int room_id;                                                               //预约房间ID
	CString username;
	bool isValid;                                                              //预约是否可行
	bool isLock;                                                               //预约是否为锁定预约
	int year;
	int month;
	int day;
	int start;                                                                 //预约开始时间-四位数
	int finish;                                                                //预约结束时间-四位数
	CString qr_location;                                                       //二维码的路径
	CString information;                                                       //备注信息

public:
	ReservationMessages(int, int, int, bool, bool, int, int, int, int, int, CString, CString);
	ReservationMessages(int, int, int, CString, bool, bool, int, int, int, int, int, CString, CString);
	void setUsername(CString username);

	int getReservation_id();
	int getUser_id();
	bool IsValid();
	bool IsLock();
	int getYear();
	int getMonth();
	int getDay();
	int getStart();
	int getFinish();
	CString getQr_location();
	CString getInformation();                                                  //获取备注信息

	CString getReservationID();                                                //获取预约消息ID
	CString getUsername();                                                     //获取预约用户名
	CString getTime();                                                         //获取预约时间
	CString getDuration();                                                     //获取预约持续时间
};