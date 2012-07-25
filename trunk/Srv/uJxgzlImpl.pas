//==================================================================//
//    网上支付接口实现单元：
//    功能描述：为了实现考生从网上自助缴费而设置的接口。
//    接口名称：Ijxgzl
//    接口引用：http://url/jxgzl/jxgzlWebSrv.dll/soap/Ijxgzl
//            或者：http://url/jxgzl/jxgzlWebSrv.dll/wsdl/Ijxgzl
//==================================================================//
{ Invokable implementation File for TjxgzlSrv which implements IjxgzlSrv }

unit uJxgzlImpl;

interface

uses InvokeRegistry, SysUtils, Types, uJxgzlIntf, DB, ADODB, DBClient, WebBrokerSOAP;

type

  { TjxgzlSrv }
  Tjxgzl = class(TInvokableClass, Ijxgzl)
  private
    function RecordIsExists(const sqlstr:string):Boolean;
    function ExecSql(const sqlstr:string):Boolean;
    function WriteSysLog(const UserId,sWhat:string):Boolean;
    function WriteLoginLog(const UserId,sVer:string):Boolean;
    function WriteLogoutLog(const UserId:string):Boolean;
    function TeacherIsExistsByNo(const sNo,sXnxq: string): Boolean;
  public
    function RegIsOK:Boolean;stdcall;//系统是否注册
    function SrvIsOK:Boolean;stdcall; //服务器是否准备好/是否可用
    //判断WEB Server是否为合法的用户接入服务器IP(即WEB服务器IP验证)
    function IsValidIP:Boolean;stdcall;

    //判断服务器当前是否可以进行网上报名，如果允许网上报名则返回字符串：OK ；如果不允许，则返回不允许的原因，如服务关闭、IP不正确、不在报名时间内等等
    function IsCanNetPrintZKZ:Boolean;stdcall;

    function GetXnXqList:string;stdcall;

    //通过职工号和学年学期获取工作量信息，返回XML格式的DataSet值
    function GetJxgzlInfo(const sNo,sXnxq:string):string;stdcall;
    //得到教学工作量信息
    function GetJxgzlInfo2(const sNo,sXnxq:string;out BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,Addr,
                         Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;

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

implementation
uses uJxgzlSoapDM;
const
  gbSplitChar :string = '<|>';

function Tjxgzl.ExecSql(const sqlstr: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.ExecSqlCmd(sqlstr);
  finally
    dm.Free;
  end;
end;

function Tjxgzl.GetBankSrvUrl: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := BankSrvUrl;
end;

function Tjxgzl.GetBankWapSrvUrl: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := BankWapSrvUrl;
end;

function Tjxgzl.GetBullitInfo(const RecCount: Integer=5): string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select top '+IntToStr(RecCount)+' ID,内容,ActionTime from 公告通知表 order by 是否置顶 desc,ActionTime desc';
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    Result := dm.cds_Query.XMLData;
    dm.cds_Query.Close;
  finally
    dm.Free;
  end;
end;

function Tjxgzl.GetHelpInfo: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 帮助信息 from 网站帮助信息表';
  try
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlStr;
    dm.DataSet_Temp.Open;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    dm.DataSet_Temp.Close;
  finally
    dm.Free;
  end;
end;

function Tjxgzl.GetJxgzlInfo(const sNo, sXnxq: string): string;
var
  dm:TJxgzlSoapDM;
  sData,sqlstr:string;
  iCompressType:Integer;
  //ICompressType: -1: Auto, 0: Not Compress, 1: Compress
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from 工作量总表_Web where gzh='+quotedstr(sNo);
    if sXnxq<>'' then
      sqlstr := sqlstr+' and xnxq='+quotedstr(sXnxq);
    sqlstr := sqlstr+' order by 规则号';
    
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function Tjxgzl.GetJxgzlInfo2(const sNo, sXnxq: string; out BmNo, Ksh, Sfzh, Xm,
  Xb, Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English,
  Computer, Tc: string): Boolean;
begin
  if not TeacherIsExistsByNo(sNo,sXnxq) then
  begin
    Result := False;
    Exit;
  end;
  with TClientDataSet.Create(nil) do
  begin
    try
      XMLData := GetJxgzlInfo(sNo,sXnxq);
      BmNo := FieldByName('报名序号').AsString;
      Ksh := FieldByName('考生号').AsString;
      Sfzh := FieldByName('身份证号').AsString;
      Xm := FieldByName('姓名').AsString;
      Xb := FieldByName('性别').AsString;
      Mz := FieldByName('民族').AsString;
      ZzMm := FieldByName('政治面貌').AsString;
      OldSchool := FieldByName('现就读学校').AsString;
      OldZy := FieldByName('所学专业').AsString;
      Jlqk := FieldByName('受奖励情况').AsString;
      Addr := FieldByName('暑期通讯地址').AsString;
      Yzbm := FieldByName('邮政编码').AsString;
      Tel := FieldByName('暑期联系电话').AsString;
      ZyZhcp := FieldByName('专业综合测评情况').AsString;
      English := FieldByName('全省高校英语等级考试情况').AsString;
      Computer := FieldByName('全省高校计算机等级考试情况').AsString;
      Tc := FieldByName('特长').AsString;
      Result := True;
    finally
      Free;
    end;
  end;
end;

function Tjxgzl.GetUserAccount: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := UserAccount;
end;

function Tjxgzl.GetUserDM: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := UserDM;
end;

function Tjxgzl.GetUserNetBankInfo(out UserDM, UserAccount, BankSrvUrl,
  BankWapSrvUrl:string): Boolean;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 商户代码,商户帐号,网站支付URL,手机支付URL from 用户网银信息表';
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    UserDM := dm.cds_Query.Fields[0].AsString;
    UserAccount := dm.cds_Query.Fields[1].AsString;
    BankSrvUrl := dm.cds_Query.Fields[2].AsString;
    BankWapSrvUrl := dm.cds_Query.Fields[3].AsString;
    Result := dm.cds_Query.RecordCount>0;
    dm.cds_Query.Close;
  finally
    dm.Free;
  end;
end;

function Tjxgzl.GetXnXqList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select distinct xnxq from 工作量总表_Web order by xnxq';
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    Result := dm.cds_Query.XMLData;
    dm.cds_Query.Close;
  finally
    dm.Free;
  end;
end;

function Tjxgzl.IsCanNetPrintZKZ: Boolean;
var
  sqlStr:string;
begin
  sqlStr := 'select count(*) from 网上报名时间设置表 where (打印准考证=1)';
  Result := RecordIsExists(sqlstr);
end;

function Tjxgzl.IsValidIP: Boolean;
var
  dm:TJxgzlSoapDM;
begin
  //Result := False;
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.IsValidIP(GetSOAPWebModule.Request.RemoteAddr);
  finally
    dm.Free;
  end;
end;

function Tjxgzl.RecordIsExists(const sqlstr: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.RecordIsExists(sqlstr);
  finally
    dm.Free;
  end;
end;

function Tjxgzl.RegIsOK: Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.RegIsOK;
  finally
    dm.Free;
  end;
end;

function Tjxgzl.SrvIsOK: Boolean;
begin
  Result := RegIsOK;
end;

function Tjxgzl.TeacherIsExistsByNo(const sNo, sXnxq: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 工作量总表_Web where zgh='+quotedstr(sNo);
  if sXnxq<>'' then
    sqlstr := sqlstr+' and xnxq='+quotedstr(sXnxq);
  Result := RecordIsExists(sqlstr);
end;

function Tjxgzl.TeacherLoginByNo(const sNo, sXM: string): Boolean;
var
  sqlstr:string;
begin
  //WriteLogoutLog(sNo);
  sqlstr := 'select count(*) from 工作量总表 where 教师职工号='+quotedstr(sNo)+' and 教师姓名='+quotedstr(sXM);
  Result := RecordIsExists(sqlstr);
{
  if Result then
     WriteLoginLog(sNo,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web登录失败！');
  end;
}
end;

function Tjxgzl.TeacherLoginBySfzh(const sfzh,sXM: string): Boolean;
var
  sqlstr:string;
begin
  //WriteLogoutLog(sNo);
  sqlstr := 'select count(*) from 工作量总表 where 身份证号='+quotedstr(sfzh)+' and 教师姓名='+quotedstr(sXM);
  Result := RecordIsExists(sqlstr);
{
  if Result then
     WriteLoginLog(sNo,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web登录失败！');
  end;
}
end;

function Tjxgzl.WriteLoginLog(const UserId, sVer: string): Boolean;
var
  sIP,sSrvHost,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sSrvHost := UserId; //GetSOAPWebModule.Request.RemoteHost;
  if Length(sSrvHost)>30 then
    sSrvHost := Copy(sSrvHost,1,30);
  sqlstr := 'Insert Into 操作员登录表 (操作员编号,登录时间,登录IP,SrvHost,是否在线,客户端版本) values'+
            '('+quotedstr('WebUser')+',GetDate(),'+quotedstr(sIP)+','+quotedstr(sSrvHost)+',1,'+quotedstr(sVer)+')';
  Result := ExecSql(sqlstr);
end;

function Tjxgzl.WriteLogoutLog(const UserId: string): Boolean;
var
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Update 操作员登录表 Set 注销时间=getdate(),注销IP='+quotedstr(sIP)+',是否在线=0 '+
            'where 操作员编号='+quotedstr(UserID)+' and 是否在线=1';
  Result := ExecSql(sqlstr);
end;

function Tjxgzl.WriteSysLog(const UserId, sWhat: string): Boolean;
var
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Insert Into 操作日志表 (用户,ActionTime,内容,IP) values'+
            '('+quotedstr(UserID)+',GetDate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
  Result := ExecSql(sqlstr);
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(Tjxgzl);
end.

