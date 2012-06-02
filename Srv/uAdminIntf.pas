{ Invokable interface IAdmin }

unit uAdminIntf;

interface

uses InvokeRegistry, Types, SOAPHTTPClient,Classes;

type

  { Invokable interfaces must derive from IInvokable }
  IAdmin = interface(IInvokable)
  ['{D2864EC6-FDDC-4B1E-A097-C5217B80A1F3}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
    function Query_Data(const SqlText: string;out iCompressType:Integer; out sData: string):Integer; stdcall;
    function Update_Data(const pkField,SqlText: string;const iCompressType:Integer;
                         const sData: string; out sError:string):Boolean; stdcall;
    function GetRecordCount(const sTableName:string):Integer; stdcall;
    function GetRecordBySqlCmd(const sqlStr:string):Integer; stdcall;
    function IsAutoIncField(const sFieldName,sTableName:string):Boolean; stdcall;
    function ExecSql(const SqlText: string;out sError:string):Boolean; stdcall;
    function GetUserInfo:string;stdcall;//获取机主用户名称
    function GetMACInfo:string;stdcall;//获取机主MAC信息
    function GetUserCode:string;stdcall;//获取机主用户注册码
    function RegUserInfo(const UserName,UserCode:string):Boolean;stdcall;
    function RegIsOK:Boolean;stdcall;//系统是否注册
    function SrvIsOK:Boolean;stdcall;

    function CzyLogin(const Czy_ID,Czy_Pwd:string;const sVersion:string=''):Boolean;stdcall;//登录
    function CzyLogout(const Czy_ID:string):Boolean;stdcall;//退出
    function IsLogined(const Czy_ID:string):Boolean;stdcall;//是否已登录
    function GetCzyName(const Czy_ID:string):string;stdcall;
    function GetCzyLevel(const Czy_ID:string):string;stdcall;
    function ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd:string):Boolean;stdcall;
    function RecordIsExists(const sWhere,sTable:string):Boolean;stdcall;
    function ReleaseLoginLog(const Czy_ID:string):Boolean ;stdcall; //清空登录日志
    function ReleaseLog(const Czy_ID:string):Boolean ;stdcall; //清空操作日志

    function GetSrvAutoUpdateUrl:string;stdcall;      //得到服务器更新地址
    function GetClientAutoUpdateUrl:string;stdcall;   //得到客户端更新地址

    function SetCzyRight(const Czy_ID:string;const iMenuID:Integer;const bEnabled,bVisibled:Boolean):Boolean;stdcall; //设置操作员权限
    //妈啦个篦，WebService中不能传递MemoryStream 内存流
    //function UploadKsPhoto(const fn, sData:string;const MS:TMemoryStream):Boolean;stdcall;

    //通过学号获取考生信息，返回XML格式的DataSet值
    function GetKsInfoByBmNo(const BmNo:string):string;overload;stdcall;
    function GetKsInfoByBmNo(const BmNo:string;out sData,sError:string):Boolean;overload;stdcall;
    //通过身份证号获取考生信息，返回XML格式的DataSet值
    function GetKsInfoBySfzh(const sfzh:string):string;overload;stdcall;
    function GetKsInfoBySfzh(const sfzh:string;out sData,sError:string):Boolean;overload;stdcall;

    //通过报名序号获取考生的身份证号，返回string类型值
    function GetKsSfzhByBmNo(const BmNo:string):string;stdcall;
    function GetKsBmNoBySfzh(const Sfzh:string):string;stdcall;

    function GetBmNo: string;stdcall; //得到一个报名序号

    function KsIsPaidBySfzh(const sfzh:string):Boolean;stdcall; //是否已报名
    function KsIsPaidByBmNo(const BmNo:string):Boolean;stdcall; //是否已报名

    function GetHintMessage:string;stdcall; //得到提示信息

    function SetPrintBHById(const sId,sPrintBH:string):Boolean;stdcall;
    function GetPrintBHById(const sId:string):string;stdcall;
    function GetNetPayQueryUrl:string;stdcall;  //得到B2C商户登陆页面URL(可查询网银交易记录)

    function GetWebSrvUrl:string;stdcall; //Web服务器网址，如：http://jxgzl.jxstnu.edu.cn/
    function GetUploadProcessFile:string;stdcall; //上传脚本处理文件（含http路径），如：http://jxgzl.jxstnu.edu.cn/Upfile_Photo.asp
    function GetUploadVirtualDir:string;stdcall;  //上传文件存放目录（相对路径），如：UploadFiles/
    function GetKsXz:string;stdcall;    //得到考生须知内容
    function GetKsCj(const bkLb:string):string;stdcall; //得到考生成绩，多行变单行之后的结果

    function ReadHsgzLxData:string;stdcall; //得到核算规则类型数据表内容
    function WriteHsgzLxData(const sData:string;out sError:string):Boolean;stdcall; //保存核算规则类型数据表内容
    function DropView(const ViewName:string):Boolean;stdcall; //创建视图
    function CreateView(const ViewName,sqlStr:string):Boolean;stdcall; //创建视图
  end;


function GetIAdmin(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IAdmin;

implementation

function GetIAdmin(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IAdmin;
const
  defWSDL = 'http://localhost:1024/jxgzlWadSrv.jxgzl/wsdl/IAdmin';
  defURL  = 'http://localhost:1024/jxgzlWadSrv.jxgzl/soap/IAdmin';
  defSvc  = 'IAdminservice';
  defPrt  = 'IAdminPort';
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
    Result := (RIO as IAdmin);
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
  InvRegistry.RegisterInterface(TypeInfo(IAdmin));

end.
