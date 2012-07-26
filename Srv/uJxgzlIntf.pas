//==================================================================//
//    工作量网上查询接口申明单元：
//    功能描述：为了实现教师从网上自助查询自己的工作量而设置的接口。
//    接口名称：Ijxgzl
//    接口引用：http://url/jxgzl/jxgzlWebSrv.dll/soap/Ijxgzl
//            或者：http://url/jxgzl/jxgzlWebSrv.dll/wsdl/Ijxgzl
//==================================================================//
{ Invokable interface IjxgzlSrv }

unit uJxgzlIntf;

interface

uses InvokeRegistry, Types, SOAPHTTPClient;

type

  { Invokable interfaces must derive from IInvokable }
  Ijxgzl = interface(IInvokable)
  ['{FDC1B1DE-71B9-4064-9A4E-D2AA07E02A72}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function RegIsOK:Boolean;stdcall;//系统是否注册
    function SrvIsOK:Boolean;stdcall; //服务器是否准备好/是否可用
    //判断WEB Server是否为合法的用户接入服务器IP(即WEB服务器IP验证)
    function IsValidIP:Boolean;stdcall;

    //判断服务器当前是否可以进行网上报名，如果允许网上报名则返回字符串：OK ；如果不允许，则返回不允许的原因，如服务关闭、IP不正确、不在报名时间内等等
    function IsCanNetPrintZKZ:Boolean;stdcall;

    function GetXnXqList:string;stdcall;

    //通过职工号和学年学期获取工作量信息，返回XML格式的DataSet值
    function GetJxgzlInfo(const sNo,sXnxq:string;const iRecCount,iPage:Integer):string;stdcall;
    function GetJxgzlRecordCount(const sNo,sXnxq:string):Integer;stdcall;
    //得到教学工作量信息
    function GetJxgzlDelta(const id:string):string;stdcall;

    function TeacherLoginByNo(const sNo,sXM:string):Boolean;stdcall;//通过职工号登录
    function TeacherLoginBySfzh(const sfzh,sXM:string):Boolean;stdcall;//通过身份证号登录

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

function GetIjxgzl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Ijxgzl;

implementation

function GetIjxgzl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Ijxgzl;
const
  defWSDL = 'http://localhost/jxgzl/jxgzlWebSrv.dll/wsdl/Ijxgzl';
  defURL  = 'http://localhost/jxgzl/jxgzlWebSrv.dll/soap/Ijxgzl';
  defSvc  = 'Ijxgzlservice';
  defPrt  = 'IjxgzlPort';
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
    Result := (RIO as Ijxgzl);
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
  InvRegistry.RegisterInterface(TypeInfo(Ijxgzl));

end.
