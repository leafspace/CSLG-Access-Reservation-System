#pragma once

namespace controllerUDP_NET
{
	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary> 
	/// Form1 摘要
	///
	/// 警告: 如果您更改该类的名称，则需要更改 
	///          与该类所依赖的所有 .resx 文件关联的托管资源编译器工具的 
	///          “资源文件名”属性。  否则，
	///          设计器将不能与此窗体关联的
	///          本地化资源正确交互。
	/// </summary>
	public __gc class Form1 : public System::Windows::Forms::Form
	{	
	public:
		Form1(void)
		{
			InitializeComponent();
		}
  
	protected:
		void Dispose(Boolean disposing)
		{
			if (disposing && components)
			{
				components->Dispose();
			}
			__super::Dispose(disposing);
		}
	private: System::Windows::Forms::TextBox *  textBox1;
	private: System::Windows::Forms::Button *  button1;
	private: System::Windows::Forms::Button *  button2;
	private: bool bStopRun;
	public private: System::Windows::Forms::TextBox *  TextBoxGateway1;
	public private: System::Windows::Forms::Label *  Label6;
	public private: System::Windows::Forms::TextBox *  TextBoxGateway2;
	public private: System::Windows::Forms::TextBox *  TextBoxGateway3;
	public private: System::Windows::Forms::TextBox *  TextBoxGateway4;
	public private: System::Windows::Forms::Label *  Label7;
	public private: System::Windows::Forms::TextBox *  TextBoxMask1;
	public private: System::Windows::Forms::Label *  Label4;
	public private: System::Windows::Forms::TextBox *  TextBoxMask2;
	public private: System::Windows::Forms::TextBox *  TextBoxMask3;
	public private: System::Windows::Forms::TextBox *  TextBoxMask4;
	public private: System::Windows::Forms::Label *  Label5;
	public private: System::Windows::Forms::TextBox *  TextBoxIP1;
	public private: System::Windows::Forms::Label *  Label1;
	public private: System::Windows::Forms::TextBox *  TextBoxSN;
	public private: System::Windows::Forms::Label *  Label2;
	public private: System::Windows::Forms::TextBox *  TextBoxIP2;
	public private: System::Windows::Forms::TextBox *  TextBoxIP3;
	public private: System::Windows::Forms::TextBox *  TextBoxIP4;
	public private: System::Windows::Forms::Label *  Label3;

	private:
		/// <summary>
		/// 必需的设计器变量。
		/// </summary>
		System::ComponentModel::Container * components;

		/// <summary>
		/// 设计器支持所需的方法 - 不要使用代码编辑器修改
		/// 此方法的内容。
		/// </summary>
		void InitializeComponent(void)
		{
			this->textBox1 = new System::Windows::Forms::TextBox();
			this->button1 = new System::Windows::Forms::Button();
			this->button2 = new System::Windows::Forms::Button();
			this->TextBoxGateway1 = new System::Windows::Forms::TextBox();
			this->Label6 = new System::Windows::Forms::Label();
			this->TextBoxGateway2 = new System::Windows::Forms::TextBox();
			this->TextBoxGateway3 = new System::Windows::Forms::TextBox();
			this->TextBoxGateway4 = new System::Windows::Forms::TextBox();
			this->Label7 = new System::Windows::Forms::Label();
			this->TextBoxMask1 = new System::Windows::Forms::TextBox();
			this->Label4 = new System::Windows::Forms::Label();
			this->TextBoxMask2 = new System::Windows::Forms::TextBox();
			this->TextBoxMask3 = new System::Windows::Forms::TextBox();
			this->TextBoxMask4 = new System::Windows::Forms::TextBox();
			this->Label5 = new System::Windows::Forms::Label();
			this->TextBoxIP1 = new System::Windows::Forms::TextBox();
			this->Label1 = new System::Windows::Forms::Label();
			this->TextBoxSN = new System::Windows::Forms::TextBox();
			this->Label2 = new System::Windows::Forms::Label();
			this->TextBoxIP2 = new System::Windows::Forms::TextBox();
			this->TextBoxIP3 = new System::Windows::Forms::TextBox();
			this->TextBoxIP4 = new System::Windows::Forms::TextBox();
			this->Label3 = new System::Windows::Forms::Label();
			this->SuspendLayout();
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(152, 32);
			this->textBox1->Multiline = true;
			this->textBox1->Name = S"textBox1";
			this->textBox1->ScrollBars = System::Windows::Forms::ScrollBars::Vertical;
			this->textBox1->Size = System::Drawing::Size(536, 472);
			this->textBox1->TabIndex = 0;
			this->textBox1->Text = S"";
			// 
			// button1
			// 
			this->button1->Location = System::Drawing::Point(24, 288);
			this->button1->Name = S"button1";
			this->button1->TabIndex = 1;
			this->button1->Text = S"Test";
			this->button1->Click += new System::EventHandler(this, button1_Click);
			// 
			// button2
			// 
			this->button2->Location = System::Drawing::Point(24, 328);
			this->button2->Name = S"button2";
			this->button2->TabIndex = 2;
			this->button2->Text = S"Exit";
			this->button2->Click += new System::EventHandler(this, button2_Click);
			// 
			// TextBoxGateway1
			// 
			this->TextBoxGateway1->Location = System::Drawing::Point(8, 200);
			this->TextBoxGateway1->Name = S"TextBoxGateway1";
			this->TextBoxGateway1->Size = System::Drawing::Size(24, 21);
			this->TextBoxGateway1->TabIndex = 40;
			this->TextBoxGateway1->Text = S"192";
			// 
			// Label6
			// 
			this->Label6->Location = System::Drawing::Point(8, 176);
			this->Label6->Name = S"Label6";
			this->Label6->Size = System::Drawing::Size(88, 16);
			this->Label6->TabIndex = 36;
			this->Label6->Text = S"Gateway:";
			// 
			// TextBoxGateway2
			// 
			this->TextBoxGateway2->Location = System::Drawing::Point(40, 200);
			this->TextBoxGateway2->Name = S"TextBoxGateway2";
			this->TextBoxGateway2->Size = System::Drawing::Size(24, 21);
			this->TextBoxGateway2->TabIndex = 41;
			this->TextBoxGateway2->Text = S"168";
			// 
			// TextBoxGateway3
			// 
			this->TextBoxGateway3->Location = System::Drawing::Point(80, 200);
			this->TextBoxGateway3->Name = S"TextBoxGateway3";
			this->TextBoxGateway3->Size = System::Drawing::Size(24, 21);
			this->TextBoxGateway3->TabIndex = 39;
			this->TextBoxGateway3->Text = S"168";
			// 
			// TextBoxGateway4
			// 
			this->TextBoxGateway4->Location = System::Drawing::Point(112, 200);
			this->TextBoxGateway4->Name = S"TextBoxGateway4";
			this->TextBoxGateway4->Size = System::Drawing::Size(24, 21);
			this->TextBoxGateway4->TabIndex = 38;
			this->TextBoxGateway4->Text = S"254";
			// 
			// Label7
			// 
			this->Label7->Location = System::Drawing::Point(32, 208);
			this->Label7->Name = S"Label7";
			this->Label7->Size = System::Drawing::Size(104, 24);
			this->Label7->TabIndex = 37;
			this->Label7->Text = S".     .     .";
			// 
			// TextBoxMask1
			// 
			this->TextBoxMask1->Location = System::Drawing::Point(8, 152);
			this->TextBoxMask1->Name = S"TextBoxMask1";
			this->TextBoxMask1->Size = System::Drawing::Size(24, 21);
			this->TextBoxMask1->TabIndex = 34;
			this->TextBoxMask1->Text = S"255";
			// 
			// Label4
			// 
			this->Label4->Location = System::Drawing::Point(8, 136);
			this->Label4->Name = S"Label4";
			this->Label4->Size = System::Drawing::Size(88, 16);
			this->Label4->TabIndex = 30;
			this->Label4->Text = S"Mask:";
			// 
			// TextBoxMask2
			// 
			this->TextBoxMask2->Location = System::Drawing::Point(40, 152);
			this->TextBoxMask2->Name = S"TextBoxMask2";
			this->TextBoxMask2->Size = System::Drawing::Size(24, 21);
			this->TextBoxMask2->TabIndex = 35;
			this->TextBoxMask2->Text = S"255";
			// 
			// TextBoxMask3
			// 
			this->TextBoxMask3->Location = System::Drawing::Point(80, 152);
			this->TextBoxMask3->Name = S"TextBoxMask3";
			this->TextBoxMask3->Size = System::Drawing::Size(24, 21);
			this->TextBoxMask3->TabIndex = 33;
			this->TextBoxMask3->Text = S"255";
			// 
			// TextBoxMask4
			// 
			this->TextBoxMask4->Location = System::Drawing::Point(112, 152);
			this->TextBoxMask4->Name = S"TextBoxMask4";
			this->TextBoxMask4->Size = System::Drawing::Size(24, 21);
			this->TextBoxMask4->TabIndex = 32;
			this->TextBoxMask4->Text = S"0";
			// 
			// Label5
			// 
			this->Label5->Location = System::Drawing::Point(32, 160);
			this->Label5->Name = S"Label5";
			this->Label5->Size = System::Drawing::Size(104, 24);
			this->Label5->TabIndex = 31;
			this->Label5->Text = S".     .     .";
			// 
			// TextBoxIP1
			// 
			this->TextBoxIP1->Location = System::Drawing::Point(8, 96);
			this->TextBoxIP1->Name = S"TextBoxIP1";
			this->TextBoxIP1->Size = System::Drawing::Size(24, 21);
			this->TextBoxIP1->TabIndex = 27;
			this->TextBoxIP1->Text = S"192";
			// 
			// Label1
			// 
			this->Label1->Location = System::Drawing::Point(8, 43);
			this->Label1->Name = S"Label1";
			this->Label1->Size = System::Drawing::Size(29, 23);
			this->Label1->TabIndex = 25;
			this->Label1->Text = S"SN:";
			// 
			// TextBoxSN
			// 
			this->TextBoxSN->Location = System::Drawing::Point(40, 40);
			this->TextBoxSN->Name = S"TextBoxSN";
			this->TextBoxSN->Size = System::Drawing::Size(64, 21);
			this->TextBoxSN->TabIndex = 22;
			this->TextBoxSN->Text = S"39990";
			// 
			// Label2
			// 
			this->Label2->Location = System::Drawing::Point(8, 80);
			this->Label2->Name = S"Label2";
			this->Label2->Size = System::Drawing::Size(88, 16);
			this->Label2->TabIndex = 23;
			this->Label2->Text = S"New IP:";
			// 
			// TextBoxIP2
			// 
			this->TextBoxIP2->Location = System::Drawing::Point(40, 96);
			this->TextBoxIP2->Name = S"TextBoxIP2";
			this->TextBoxIP2->Size = System::Drawing::Size(24, 21);
			this->TextBoxIP2->TabIndex = 26;
			this->TextBoxIP2->Text = S"168";
			// 
			// TextBoxIP3
			// 
			this->TextBoxIP3->Location = System::Drawing::Point(80, 96);
			this->TextBoxIP3->Name = S"TextBoxIP3";
			this->TextBoxIP3->Size = System::Drawing::Size(24, 21);
			this->TextBoxIP3->TabIndex = 28;
			this->TextBoxIP3->Text = S"168";
			// 
			// TextBoxIP4
			// 
			this->TextBoxIP4->Location = System::Drawing::Point(112, 96);
			this->TextBoxIP4->Name = S"TextBoxIP4";
			this->TextBoxIP4->Size = System::Drawing::Size(24, 21);
			this->TextBoxIP4->TabIndex = 29;
			this->TextBoxIP4->Text = S"90";
			// 
			// Label3
			// 
			this->Label3->Location = System::Drawing::Point(32, 104);
			this->Label3->Name = S"Label3";
			this->Label3->Size = System::Drawing::Size(104, 24);
			this->Label3->TabIndex = 24;
			this->Label3->Text = S".     .     .";
			// 
			// Form1
			// 
			this->AutoScaleBaseSize = System::Drawing::Size(6, 14);
			this->ClientSize = System::Drawing::Size(704, 518);
			this->Controls->Add(this->TextBoxGateway1);
			this->Controls->Add(this->Label6);
			this->Controls->Add(this->TextBoxGateway2);
			this->Controls->Add(this->TextBoxGateway3);
			this->Controls->Add(this->TextBoxGateway4);
			this->Controls->Add(this->Label7);
			this->Controls->Add(this->TextBoxMask1);
			this->Controls->Add(this->Label4);
			this->Controls->Add(this->TextBoxMask2);
			this->Controls->Add(this->TextBoxMask3);
			this->Controls->Add(this->TextBoxMask4);
			this->Controls->Add(this->Label5);
			this->Controls->Add(this->TextBoxIP1);
			this->Controls->Add(this->Label1);
			this->Controls->Add(this->TextBoxSN);
			this->Controls->Add(this->Label2);
			this->Controls->Add(this->TextBoxIP2);
			this->Controls->Add(this->TextBoxIP3);
			this->Controls->Add(this->TextBoxIP4);
			this->Controls->Add(this->Label3);
			this->Controls->Add(this->button2);
			this->Controls->Add(this->button1);
			this->Controls->Add(this->textBox1);
			this->Name = S"Form1";
			this->Text = S"Form1";
			this->Load += new System::EventHandler(this, Form1_Load);
			this->ResumeLayout(false);

		}	
	private: System::Void button2_Click(System::Object *  sender, System::EventArgs *  e)
			 {
				 bStopRun = true;
				 this->Close() ;
			 }

	private: System::Void button1_Click(System::Object *  sender, System::EventArgs *  e)
			 {
				// TODO: 在此添加控件通知处理程序代码
				this->button1->Enabled = false;

				WComm_UDP::IWCOMM_OPERATE		*wudp ;				//.NET通信对象

				String*    strTemp;
				String*    strInfo;

				wudp = new WComm_UDP::WComm_Operate();
				

				while (true)
				{
				
					bStopRun = false;


 					__int64 lngRet;
					String* strT;			//中间变量
					String* strFrame;	    //通信返回的数据
					String* strCmd;         //发送的指令帧
					long controllerSN;      //控制器序列号
					String* strIPAddr;		//IP地址
					String* strMac;			//MAC地址
					String* strHexNewIP;    //New IP (十六进制)
                    String* strHexMask;     //掩码(十六进制)
                    String* strHexGateway;  //网关(十六进制)

			      
					//刷卡记录变量
					__int64  cardId;		//卡号    
					__int64  status;        //状态    
					String* strSwipeDate;   //日期时间

					String* strRunDetail;   //运行信息
			
			    
					controllerSN = System::Convert::ToInt64(this->TextBoxSN->Text) ;  //测试使用的.NET控制器
					strIPAddr = "";	          //一开始为空, 表示广播包方式

					strInfo = String::Concat("控制器通信－" , controllerSN.ToString() , "-.NET");
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					Application::DoEvents();
			    
					//读取运行状态信息
					strCmd = wudp -> CreateBstrCommand(controllerSN, "811000000000");	//生成指令帧 
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	//发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
					{
						strInfo = String::Concat( "\r\n", "出错处理" );
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					//数据处理
					strInfo = String::Concat("\r\n", "读取运行信息成功");
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);

					//对运行信息的详细分析
					strRunDetail = ""  ;
					strInfo =String::Concat("\r\n", "设备序列号S/N: " ,"\t", wudp->GetSNFromRunInfo(strFrame).ToString());
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
					
					strInfo =String::Concat("\r\n", "设备时钟:      " ,"\t", wudp->GetClockTimeFromRunInfo(strFrame) );
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);

					strInfo =String::Concat("\r\n", "刷卡记录数:    " ,"\t", wudp->GetCardRecordCountFromRunInfo(strFrame).ToString() );
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
				
					strInfo =String::Concat("\r\n", "权限数:        " ,"\t", wudp->GetPrivilegeNumFromRunInfo(strFrame).ToString() );
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
					strInfo =String::Concat("\r\n", "最近的一条刷卡记录: " ,"\t" );
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);

					strSwipeDate = wudp->GetSwipeDateFromRunInfo(strFrame,  &cardId, &status) ;
					if (strSwipeDate->Length != 0 )
					{
						//记录的详细解析
						strInfo =String::Concat("\r\n", "卡号: " ,"\t", cardId.ToString() );
						strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
						
						strT =  wudp->NumToStrHex(status,1);
						strInfo = String::Concat("\t", "状态: " ,"\t", (status.ToString())); 
						strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
						strInfo = String::Concat("(", strT , ")" );
						strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);

						strInfo =String::Concat("\t", "时间: " ,"\t", strSwipeDate );
						strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
					}

					//门磁按钮状态
					//Bit位  7   6   5   4   3   2   1   0
					//说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
					strInfo =String::Concat("\r\n\r\n", "门磁状态  1号门磁 2号门磁 3号门磁 4号门磁" ,"\r\n",  "                   "   );
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
					if (wudp->GetDoorStatusFromRunInfo(strFrame,1) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   关   ");
					}
					if (wudp->GetDoorStatusFromRunInfo(strFrame,2) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   关   ");
					}

					if (wudp->GetDoorStatusFromRunInfo(strFrame,3) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   关   ");
					}

					if (wudp->GetDoorStatusFromRunInfo(strFrame,4) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  "   关   ");
					}

					
		
					////按钮状态
					////Bit位  7   6   5   4   3   2   1   0
					////说明   门磁4   门磁3   门磁2   门磁1   按钮4   按钮3   按钮2   按钮1
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, "\r\n");
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, "按钮状态  1号按钮 2号按钮 3号按钮 4号按钮\r\n                   ");
					if (wudp->GetButtonStatusFromRunInfo(strFrame,1) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 松开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 按下   ");
					}
					if (wudp->GetButtonStatusFromRunInfo(strFrame,2) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 松开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 按下   ");
					}
					if (wudp->GetButtonStatusFromRunInfo(strFrame,3) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 松开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 按下   ");
					}
					if (wudp->GetButtonStatusFromRunInfo(strFrame,3) == 1)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 松开   ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 按下   ");
					}

				
					strRunDetail =strRunDetail->Insert(strRunDetail->Length, "\r\n故障状态:\t");
					lngRet =wudp->GetErrorNoFromRunInfo(strFrame);
					if ( lngRet== 0)
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length,  " 无故障  ");
					}
					else
					{
						strRunDetail =strRunDetail->Insert(strRunDetail->Length, " 有故障   ");
						if ((lngRet & 1) > 0)
						{
							strRunDetail = strRunDetail->Insert(strRunDetail->Length, "\r\n        \t系统故障1");
						}
						if ((lngRet & 2) > 0)
						{
							strRunDetail = strRunDetail->Insert(strRunDetail->Length, "\r\n        \t系统故障2");
						}
						if ((lngRet & 4) > 0)
						{
							strRunDetail = strRunDetail->Insert(strRunDetail->Length, "\r\n        \t系统故障3[设备时钟有故障], 请校正时钟处理");
						}
						if ((lngRet & 8) > 0)
						{
							strRunDetail = strRunDetail->Insert(strRunDetail->Length, "\r\n        \t系统故障4");
						}
					}
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strRunDetail);

					Application::DoEvents();
        
					//查询控制器的IP设置
					//读取网络配置信息指令
					strCmd = wudp->CreateBstrCommand(controllerSN, "0111");	//生成指令帧 读取网络配置信息指令
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	//发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
					{
						strInfo ="\r\n查询控制器IP 失败";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
					    long startLoc;			//字符串的起始位置
						String* deviceInfo;
						
						deviceInfo = "";
						//MAC
						startLoc = 11-1;
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "\r\nMAC:\t\t");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "-");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc+2, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "-");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc+4, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "-");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc+6, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "-");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc+8, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "-");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, strFrame->Substring( startLoc+10, 2));
						strMac = strFrame->Substring( startLoc, 12);
					

						//IP
						startLoc = 23-1;
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "\r\nIP:\t\t");
						strInfo = String::Concat("0x",strFrame->Substring( startLoc, 2));
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+2, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+4, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+6, 2)).ToString());

						//Subnet Mask
						startLoc = 31-1;
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "\r\n子网掩码:\t");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+2, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+4, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+6, 2)).ToString());

						//Default Gateway
						startLoc = 39-1;
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "\r\n网关:\t\t");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+2, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+4, 2)).ToString());
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, ".");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc+6, 2)).ToString());

						//TCP Port
						startLoc = 47-1;
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, "\r\nPORT:\t\t");
						deviceInfo = deviceInfo->Insert(deviceInfo->Length, wudp->StrHexToNum(strFrame->Substring( startLoc, 4)).ToString());
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,deviceInfo);
					}

					strInfo = "\r\n开始IP地址设置: "          ;
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					//新的IP设置: (MAC不变) IP地址: 192.168.168.90; 掩码: 255.255.255.0; 网关: 192.168.168.254; 端口: 60000
					strInfo = String::Concat(  "F211", strMac );						        //功能号
					strHexNewIP = String::Concat(wudp->NumToStrHex(System::Convert::ToInt64( this->TextBoxIP1->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxIP2->Text), 1),
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxIP3->Text), 1),
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxIP4->Text), 1));
					strHexMask = String::Concat( wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxMask1->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxMask2->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxMask3->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxMask4->Text), 1));
					strHexGateway =  String::Concat(wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxGateway1->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxGateway2->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxGateway3->Text), 1) ,
						wudp->NumToStrHex(System::Convert::ToInt64(this->TextBoxGateway4->Text), 1));
					strTemp = String::Concat(  strHexNewIP, strHexMask, strHexGateway, "60EA" );
					strInfo = strInfo->Insert(strInfo->Length,strTemp);					
					strCmd = wudp->CreateBstrCommand(controllerSN,strInfo );					//生成指令帧 读取网络配置信息指令
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
					{
						strInfo ="\r\nIP地址设置出错";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
						strInfo ="\r\nIP地址设置完成...要等待3秒钟, 请稍候";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						Application::DoEvents();
						System::Threading::Thread::Sleep(3000);		//'引入3秒延时
						lngRet = MessageBox::Show(this,"IP地址设置完成","",MessageBoxButtons::OK);
					}

 					//采用新的IP地址进行通信
					strTemp =".";
					strIPAddr = String::Concat(this->TextBoxIP1->Text ,strTemp,
						this->TextBoxIP2->Text,strTemp,
						this->TextBoxIP3->Text,strTemp,
						this->TextBoxIP4->Text);
					strInfo = String::Concat( "\r\n采用新的IP地址进行通信" , strIPAddr);
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);


					//校准控制器时间
					strCmd = wudp->CreateBstrCommandOfAdjustClockByPCTime(controllerSN);  //生成指令帧
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
					{
						strInfo ="\r\n校准控制器时间出错";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
						strInfo ="\r\n校准控制器时间成功";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					}
		

					//远程开1号门
					strCmd = wudp->CreateBstrCommand(controllerSN,"9D1001");  //生成指令帧
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
					{
						strInfo ="\r\n远程开门失败";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
						strInfo ="\r\n远程开门成功";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					}
					Application::DoEvents();

					//提取记录
					long recIndex;
					recIndex = 1;
					while(true)
					{
						if (bStopRun)
						{
							break;
						}

						strT =String::Concat("8D10", wudp->NumToStrHex(recIndex,4));
						strCmd  = wudp->CreateBstrCommand(controllerSN, strT) ;  //生成指令帧
						strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
						if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 						{
							//没有收到数据,
							//失败处理代码... (查ErrCode针对性分析处理)
							//用户可考虑重试
							strInfo ="\r\n提取记录出错";
							this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
							break;
						}
						else
						{
							strSwipeDate = wudp->GetSwipeDateFromRunInfo(strFrame,  &cardId, &status) ;
							if (strSwipeDate->Length != 0 )
							{
								//记录的详细解析
								strRunDetail="";
								strInfo =String::Concat("\r\n", "卡号: ", cardId.ToString()  );
								strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
								strT =  wudp->NumToStrHex(status,1);
								strInfo = String::Concat( "\t", "状态: " , (status.ToString())); 
								strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
								strInfo = String::Concat("(", strT , ")" );
								strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
								strInfo =String::Concat( "\t", "时间: " , strSwipeDate );
								strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
								recIndex = recIndex + 1;                    //下一条记录
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strRunDetail);
								this->textBox1->SelectionStart = this->textBox1->TextLength;
								this->textBox1->ScrollToCaret();			//显示最后一行

							}
							else
							{
								strInfo =String::Concat("\r\n提取记录完成. 总共提取记录数 = " ,  (recIndex-1).ToString()  );
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
								this->textBox1->SelectionStart = this->textBox1->TextLength;
								this->textBox1->ScrollToCaret();			//显示最后一行
								break;
							}
							Application::DoEvents();
						}
					}
					if ((0 != wudp ->ErrCode)||(strFrame->Length == 0))	
					{
						break;		//出错 退出
					}

			        
					//删除已提取的记录
					if (recIndex > 1)   //只有提取了记录才进行删除
					{
						strTemp =String::Concat("是否删除控制器上已提取的记录: ", (recIndex-1).ToString());
						if ( MessageBox::Show(this,strTemp,"删除",MessageBoxButtons::YesNo) == DialogResult::Yes )
						{
							strT = String::Concat("8E10" , wudp->NumToStrHex(recIndex-1, 4));
  							strCmd  = wudp->CreateBstrCommand(controllerSN, strT) ;                     //生成指令帧
							strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
							if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 							{
								//没有收到数据,
								//失败处理代码... (查ErrCode针对性分析处理)
								//用户可考虑重试
								strInfo ="\r\n删除记录失败";
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
								break;
							}
							else
							{
								strInfo ="\r\n删除记录成功";
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
							} 						
						}
					}



					//发送权限操作(1.先清空权限)
  					strCmd  = wudp->CreateBstrCommand(controllerSN, "9310") ;                   //生成指令帧 
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 					{
						//没有收到数据,
						//失败处理代码... (查ErrCode针对性分析处理)
						//用户可考虑重试
						strInfo ="\r\n清空权限失败";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
						strInfo ="\r\n清空权限成功";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					} 						

 
					//发送权限操作(2.再添加权限)
					//权限格式: 卡号（2）+区号（1）+门号（1）+卡起始年月日（2）+卡截止年月日（2）+ 控制时段索引号（1）+密码（3）+备用（4，用0填充）
					//发送权限按: 先发1号门(卡号小的先发), 再发2号门(卡号小的先发)
					//此案例中权限设为: 卡有效期从(2007-8-14 到2020-12-31), 采用默认时段1(任意时间有效), 缺省密码(1234), 备用值以00填充
					//以三个卡： 07217564 [9C4448]，342681[B9A603]，25409969[F126FE]为例，分别可以通过控制器的2个门。
					//实际使用按需修改
			        
					//!!!!!!!注意:  此处卡号已直接按从小到大排列赋值了. 实际使用中要用算法实现排序
					long cardno[3];
					long privilegeIndex;
					long doorIndex;
					long cardIndex;
					String* privilege;
					cardno[0] = 342681 ;
					cardno[1] = 7217564;
					cardno[2] = 25409969;
					privilegeIndex = 1  ;
					for( doorIndex = 0;doorIndex<=1; doorIndex++)
					{
						for(cardIndex = 0; cardIndex <= 2; cardIndex++)
						{
			                privilege = ""; 
							privilege = privilege->Insert(privilege->Length,wudp->CardToStrHex(cardno[cardIndex]));           //卡号
							privilege = privilege->Insert(privilege->Length,wudp->NumToStrHex(doorIndex + 1, 1));			  //门号
							privilege = privilege->Insert(privilege->Length,wudp->MSDateYmdToWCDateYmd("2007-8-14"));         //有效起始日期
							privilege = privilege->Insert(privilege->Length,wudp->MSDateYmdToWCDateYmd("2020-12-31"));        //有效截止日期
							privilege = privilege->Insert(privilege->Length,wudp->NumToStrHex(1, 1));						  //时段索引号
							privilege = privilege->Insert(privilege->Length,wudp->NumToStrHex(123456, 3));					  //用户密码
							privilege = privilege->Insert(privilege->Length,wudp->NumToStrHex(0, 4));						  //备用4字节(用0填充)
						
							if (privilege->Length != (16 * 2))
							{
								//生成的权限不符合要求, 请查一下上一指令中写入的每个参数是否正确
								strInfo = "\r\n生成的权限不符合要求: 添加权限失败";
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
								break;
							}


							strTemp =String::Concat( "9B10" ,wudp->NumToStrHex(privilegeIndex, 2), privilege);				 //权限索引号
							strCmd  = wudp->CreateBstrCommand(controllerSN, strTemp) ;                  //生成指令帧 
							strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
							if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 							{
								//没有收到数据,
								//失败处理代码... (查ErrCode针对性分析处理)
								//用户可考虑重试
								strInfo ="\r\n添加权限失败";
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
								break;
							}
							else
							{
								privilegeIndex = privilegeIndex + 1;
							} 						
							Application::DoEvents();
						}
					}
					strInfo =String::Concat("\r\n添加权限数 = ",(privilegeIndex-1).ToString());
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
							
			        
					//发送控制时段
					//发送要设定的时段 [注意0,1时段为系统固定化,更改是无效的, 所以设定的时段一般从2开始]
					//此案例设定时段2: 从2007-8-1到2007-12-31日
					// 星期1到5允许在7:30-12:30, 13:30-17:30, 19:00-21:00通过, 其他时间不允许
					String* timeseg;
					long timeIndex;
					timeseg = "";
					timeseg = timeseg->Insert(timeseg->Length,wudp->NumToStrHex(0x1F, 1));            //星期控制
					timeseg = timeseg->Insert(timeseg->Length,wudp->NumToStrHex(0x00, 1));            // 下一链接时段(0--表示无)
					timeseg = timeseg->Insert(timeseg->Length,wudp->NumToStrHex(0x00, 2));            // 保留2字节(0填充)
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("07:30:00")); //  起始时分秒1
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("12:30:00")); //  终止时分秒1
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("13:30:00")); //  起始时分秒2
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("17:30:00")); //  终止时分秒2
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("19:00:00")); //  起始时分秒3
 					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateHmsToWCDateHms("21:00:00")); //  终止时分秒3
					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateYmdToWCDateYmd("2007-08-01")); //  起始日期
 					timeseg = timeseg->Insert(timeseg->Length,wudp->MSDateYmdToWCDateYmd("2007-12-31")); //  终止日期
					timeseg = timeseg->Insert(timeseg->Length,wudp->NumToStrHex(0x00, 4));            // 保留4字节(0填充)
					if (timeseg->Length  != (24 * 2))
					{
						//生成的时段不符合要求, 请查一下上一指令中写入的每个参数是否正确
						strInfo ="\r\n生成的时段不符合要求: 修改时段失败";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}

					timeIndex = 2;
					strTemp =String::Concat( "9710" ,wudp->NumToStrHex(timeIndex, 2), timeseg);				//时段索引号2
					strCmd  = wudp->CreateBstrCommand(controllerSN, strTemp) ;                  //生成指令帧 
					strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
					if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 					{
						//没有收到数据,
						//失败处理代码... (查ErrCode针对性分析处理)
						//用户可考虑重试
						strInfo ="\r\n添加时段失败";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
						break;
					}
					else
					{
						strInfo ="\r\n添加时段成功";
						this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					} 						
					Application::DoEvents();

	 
					//实时监控
					// 读取运行状态是实现监控的关键指令。 在进行监控时, 先读取最新记录索引位的记录. 读取到最新的记录， 同时可以获取到刷卡记录数。
					// 这时就可以用读取到刷卡记录数加1填充到要读取的最新记录索引位上，去读取运行状态， 以便获取下一个记录。
					// 如果读取到了新的刷卡记录， 就可以将索引位增1， 否则保持索引位不变。 这样就可以实现数据的实时监控。
					// 遇到通信不上的处理，这时可对串口通信采取超时400-500毫秒作为出错，可重试一次，再接收不到数据， 可认为设备与PC机间的不能通信。
					__int64 watchIndex;
					long recCnt;

					watchIndex = 0   ;                   //缺省从0, 表示先提取最近一个记录
					recCnt = 0       ;                   //监控记录计数
					strInfo ="\r\n开始实时监控......(请刷卡3次)" ;
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					this->textBox1->SelectionStart = this->textBox1->TextLength;
					this->textBox1->ScrollToCaret();			//显示最后一行

					Application::DoEvents();
					
					while (recCnt < 3)         //测试中 读到3个就停止
					{
		   					if (bStopRun)
							{
								break;
							}

							strTemp =String::Concat( "8110" ,wudp->NumToStrHex(watchIndex, 2));			//表示第watchIndex个记录, 如果是0则取最新一条记录
							strCmd  = wudp->CreateBstrCommand(controllerSN, strTemp) ;                  //生成指令帧 
							strFrame = wudp -> udp_comm(strCmd, strIPAddr, 60000);	                    //发送指令, 并获取返回信息
							if (( 0 != wudp ->ErrCode)||(strFrame->Length  ==0))	
 							{
								//没有收到数据,
								//失败处理代码... (查ErrCode针对性分析处理)
								//用户可考虑重试
								strInfo ="\r\n实时监控失败";
								this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
								break;
							}
							else
							{
								strSwipeDate = wudp->GetSwipeDateFromRunInfo(strFrame,  &cardId, &status) ;
								if (strSwipeDate->Length != 0 )
								{
									//记录的详细解析
									strRunDetail="";
									strInfo =String::Concat("\r\n", "卡号: ", cardId.ToString()  );
									strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
									strT =  wudp->NumToStrHex(status,1);
									strInfo = String::Concat( "\t", "状态: " , (status.ToString())); 
									strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
									strInfo = String::Concat("(", strT , ")" );
									strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
									strInfo =String::Concat( "\t", "时间: " , strSwipeDate );
									strRunDetail =strRunDetail->Insert(strRunDetail->Length, strInfo);
									recIndex = recIndex + 1;             //下一条记录
									this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strRunDetail);
								
									if (watchIndex == 0)                //如果收到第一条记录
									{
										watchIndex = wudp->GetCardRecordCountFromRunInfo(strFrame);
										watchIndex =  watchIndex + 1;   //指向(总记录数+1), 也就是下次刷卡的存储索引位
									}
									else
									{
										watchIndex = watchIndex + 1 ; //指向下一个记录位
									}
									recCnt = recCnt + 1;                //记录计数	
									this->textBox1->SelectionStart = this->textBox1->TextLength;
									this->textBox1->ScrollToCaret();			//显示最后一行

								}
							}
							Application::DoEvents();
					}
					strInfo ="\r\n已停止实时监控" ;
					this->textBox1->Text = this->textBox1->Text->Insert(this->textBox1->Text->Length ,strInfo);
					Application::DoEvents();

					break;
				}
				this->textBox1->SelectionStart = this->textBox1->TextLength;
				this->textBox1->ScrollToCaret();			//显示最后一行
				this->button1->Enabled = true;

				wudp = NULL;

			 }

	private: System::Void Form1_Load(System::Object *  sender, System::EventArgs *  e)
			 {
			 }

};
}


