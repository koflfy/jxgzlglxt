//==================================================================//
//    网上报名接口申明单元：
//    功能描述：为了实现考生从网上自助缴费而设置的接口。
//    接口名称：IZsbBm
//    接口引用：http://url/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm
//            或者：http://url/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm
//==================================================================//
{ Invokable interface IZsbBmSrv }

unit uJxgzlIntf;

interface

uses InvokeRegistry, Types, SOAPHTTPClient;

type

  { Invokable interfaces must derive from IInvokable }
  IZsbBm = interface(IInvokable)
  ['{FDC1B1DE-71B9-4064-9A4E-D2AA07E02A72}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function RegIsOK:Boolean;stdcall;//系统是否注册
    function SrvIsOK:Boolean;stdcall; //服务器是否准备好/是否可用
    //判断WEB Server是否为合法的用户接入服务器IP(即WEB服务器IP验证)
    function IsValidIP:Boolean;stdcall;

    //判断服务器当前是否可以进行网上报名，如果允许网上报名则返回字符串：OK ；如果不允许，则返回不允许的原因，如服务关闭、IP不正确、不在报名时间内等等
    function IsCanNetBm:string;stdcall;
    function IsCanNetPrintZKZ:Boolean;stdcall;
    function IsCanNetLocateCj:Boolean;stdcall;

    function GetPhotoUrlByUserName(const UserName:string):string;stdcall;
    function SetPhotoUrlByUserName(const UserName,sUrl:string):Boolean;stdcall;
    function SetPhotoUrlByBmNo(const BmNo,sUrl:string):Boolean;stdcall;

    function GetMzList:string;stdcall;
    function GetZzmmList:string;stdcall;
    function GetSchoolList:string;stdcall;
    function GetEnglistList:string;stdcall;
    function GetComputerList:string;stdcall;
    function GetZyLbList:string;stdcall;
    function GetZyList(const ZyLb:string):string;stdcall;

    function KsRegister(const UserName,UserPwd,Sfzh:string):Boolean;stdcall;
    //报名：用户名，报名序号，考生号，身份证号，姓名，性别，民族，政治面貌，现就读学校，现专业，奖励情况，
    //     暑期地址，邮政编码，暑期电话，专业综合测评情况，英语等级考试，计算机等级考试，特长
    function KsBM(const UserName,BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,
                  Addr,Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;
    //报考：用户名，专业类别，志愿1，2，3，是否允许调剂==>1：允许，0：不允许
    function KsBK(const UserName,ZyLb,Zy1,Zy2,Zy3,SfyxTj:string):Boolean;stdcall;

    function GetKsBMInfo(const UserName:string;out BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,Addr,
                         Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;

    function GetKsBKInfo(const UserName:string;
                         out ZyLb,Zy1,Zy2,Zy3,SfyxTj:string):Boolean;stdcall;

    //查询本校考生的考生号
    function GetKshBySfzh(const Sfzh:string;out Ksh:string):string;stdcall;
    //通过用户名获取考生信息，返回XML格式的DataSet值
    function GetKsInfo(const UserName:string):string;stdcall;
    //通过用户名获取考生信息，返回XML格式的DataSet值
    function GetKsZkzInfo(const UserName:string):string;stdcall;
    //通过用户名获取考生成绩信息，返回XML格式的DataSet值
    function GetKsCjInfo(const UserName:string):string;stdcall;

    function GetKsKcTime(const bkLb:string):string;stdcall; //得到考试课程和考试时间
    function GetKsXz:string;stdcall;    //考生须知

    function KsIsExistsByUserName(const UserName:string):Boolean;stdcall;//通过报名序号判断考生是否存在
    function KsIsExistsBySfzh(const sfzh:string):Boolean;stdcall;//通过身份证号判断考生是否存在

    function KsLoginByUserName(const UserName,pwd:string):Boolean; stdcall;//输入报名序号和密码认证进行登录

    function GetBmNo: string;stdcall; //得到一个报名序号

    //通过户名获取考生的报名序号，返回string类型值
    function GetKsBmNoByUserName(const UserName:string):string;stdcall;
    //通过户名获取考生的身份证号，返回string类型值
    function GetKsSfzhByUserName(const UserName:string):string;stdcall;

    //获取公告通知，RecCount为希望获取的记录数目，结果返回XML格式的DataSet值。
    function GetBullitInfo(const  RecCount:Integer=5):string;stdcall;
    //获取帮助信息，返回结果为一个多行的字符串值。行与行之间用回车换行符分隔，即通常的#13#10符
    function GetHelpInfo:string;stdcall;
    //获取用户的网银配置信息：UserDM:商户代码 UserAccount:商户帐号,BankSrvUrl:网银支付接口地址,BankWapSrvUrl:手机支付接口地址
    //获取成功返回True，否则返回False
    function GetUserNetBankInfo(out UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string):Boolean;stdcall;
    //得到用户（商户）代码
    function GetUserDM:string;stdcall;
    //得到用户（商户）帐号
    function GetUserAccount:string;stdcall;
    //得到网银支付接口网址
    function GetBankSrvUrl:string;stdcall;
    //得到手机支付接口网址
    function GetBankWapSrvUrl:string;stdcall;
  end;

function GetIZsbBm(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IZsbBm;

implementation

function GetIZsbBm(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IZsbBm;
const
  defWSDL = 'http://localhost/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm';
  defURL  = 'http://localhost/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm';
  defSvc  = 'IZsbBmservice';
  defPrt  = 'IZsbBmPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;

  RIO.HTTPWebNode.UseUTF8InHeader := True;

  try
    Result := (RIO as IZsbBm);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(IZsbBm));

end.
