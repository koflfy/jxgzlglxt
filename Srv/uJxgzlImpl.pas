//==================================================================//
//    网上支付接口实现单元：
//    功能描述：为了实现考生从网上自助缴费而设置的接口。
//    接口名称：IZsbBm
//    接口引用：http://url/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm
//            或者：http://url/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm
//==================================================================//
{ Invokable implementation File for TZsbBmSrv which implements IZsbBmSrv }

unit uJxgzlImpl;

interface

uses InvokeRegistry, SysUtils, Types, uJxgzlIntf, DB, ADODB, DBClient, WebBrokerSOAP;

type

  { TZsbBmSrv }
  TZsbBm = class(TInvokableClass, IZsbBm)
  private
    function RecordIsExists(const sqlstr:string):Boolean;
    function ExecSql(const sqlstr:string):Boolean;
    function WriteSysLog(const UserId,sWhat:string):Boolean;
    function WriteLoginLog(const UserId,sVer:string):Boolean;
    function WriteLogoutLog(const UserId:string):Boolean;
    function GetKsInfoByUserName(const UserName:string):string;
    function GetKsBmbFieldValue(const sFld,sValue,dFld:string):string;
    //通过报名序号获取考生的用户名，返回string类型值
    function GetKsUserNameByBmNo(const BmNo:string):string;
  public
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
    function GetKsXz:string;stdcall;    //得到考生须知信息

    function KsIsExistsByUserName(const UserName:string):Boolean;stdcall;//通过报名序号判断考生是否存在
    function KsIsExistsBySfzh(const sfzh:string):Boolean;stdcall;//通过身份证号判断考生是否存在

    function KsLoginByUserName(const UserName,pwd:string):Boolean; stdcall;//输入报名序号和密码认证进行登录

    function GetBmNo: string;stdcall; //得到一个报名序号

    //通过用户名获取考生的报名序号，返回string类型值
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

implementation
uses uJxgzlSoapDM;
const
  gbSplitChar :string = '<|>';

function TZsbBm.ExecSql(const sqlstr: string): Boolean;
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

function TZsbBm.GetBankSrvUrl: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := BankSrvUrl;
end;

function TZsbBm.GetBankWapSrvUrl: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := BankWapSrvUrl;
end;

function TZsbBm.GetZyLbList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 类别 from 专业类别表 order by 显示顺序';
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

function TZsbBm.GetBullitInfo(const RecCount: Integer=5): string;
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

function TZsbBm.GetComputerList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 名称 from 计算机等级考试类别表 order by 显示顺序';
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

function TZsbBm.GetEnglistList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 名称 from 英语等级考试类别表 order by 显示顺序';
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

function TZsbBm.GetHelpInfo: string;
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


function TZsbBm.GetBmNo: string;
var
  dm:TJxgzlSoapDM;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetBmNo;
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsInfo(const UserName: string): string;
var
  dm:TJxgzlSoapDM;
  sData,sqlstr:string;
  iCompressType:Integer;
  //ICompressType: -1: Auto, 0: Not Compress, 1: Compress
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_考生报名表_Web where UserName='+quotedstr(UserName);
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsInfoByUserName(const UserName: string): string;
var
  dm:TJxgzlSoapDM;
  sqlstr,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_考生报名表 where 登录名='+quotedstr(UserName);
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsSfzhByUserName(const UserName: string): string;
var
  sData:string;
begin
  Result := '';
  sData := GetKsInfoByUserName(UserName);
  if sData='' then Exit;
  with TClientDataSet.Create(nil) do
  try
    XMLData := sData;
    Result := Trim(FieldByName('身份证号').AsString);
  finally
    Free;
  end;
end;

function TZsbBm.GetKsUserNameByBmNo(const BmNo: string): string;
begin
  Result := GetKsBmbFieldValue('报名序号',BmNo,'登录名');
end;

function TZsbBm.GetKsKcTime(const bkLb: string): string;
var
  dm:TJxgzlSoapDM;
  sqlstr,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_考试课程表_web where bklb='+quotedstr(bkLb);
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsXz: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetKsXz;
    Result := StringReplace(Result,#13#10,'<p>',[rfReplaceAll]);
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsZkzInfo(const UserName: string): string;
var
  dm:TJxgzlSoapDM;
  sqlstr,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_准考证表_web where UserName='+quotedstr(UserName);
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetMzList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 名称 from 民族代码表 order by 显示顺序';
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

function TZsbBm.GetPhotoUrlByUserName(const UserName: string): string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  if not KsIsExistsByUserName(UserName) then Exit;

  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 照片文件名 from 考生照片表 where 报名序号='+quotedstr(GetKsBmNoByUserName(UserName));
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    Result := dm.cds_Query.Fields[0].AsString;
    dm.cds_Query.Close;
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetSchoolList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 学校名称 from 全国高校信息表 where 省份='+quotedstr('江西')+' order by 显示顺序';
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

function TZsbBm.GetKsBKInfo(const UserName: string; out ZyLb, Zy1, Zy2, Zy3,
  SfyxTj: string): Boolean;
begin
  if not KsIsExistsByUserName(UserName) then
  begin
    Result := False;
    Exit;
  end;
  with TClientDataSet.Create(nil) do
  begin
    try
      XMLData := GetKsInfoByUserName(UserName);
      ZyLb := FieldByName('报考类别').AsString;
      Zy1 := FieldByName('专业志愿一').AsString;
      Zy2 := FieldByName('专业志愿二').AsString;
      Zy3 := FieldByName('专业志愿三').AsString;
      if FieldByName('是否同意调剂').AsBoolean then
        SfyxTj := '1'
      else
        SfyxTj := '0';
      Result := True;
    finally
      Free;
    end;
  end;
end;

function TZsbBm.GetKsBmbFieldValue(const sFld,sValue,dFld:string): string;
var
  sqlstr :string;
  dm :TJxgzlSoapDM;
begin
  sqlstr := 'select '+dFld+' from view_考生报名表 where '+sFld+'='+quotedstr(sValue);
  dm := TJxgzlSoapDM.Create(nil);
  try
    with dm.DataSet_Temp do
    begin
      Close;
      CommandText := sqlstr;
      Open;
      Result := Fields[0].AsString;
    end;
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKsBMInfo(const UserName: string;out BmNo, Ksh, Sfzh, Xm, Xb,
  Mz, ZzMm, OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer,
  Tc: string): Boolean;
begin
  if not KsIsExistsByUserName(UserName) then
  begin
    Result := False;
    Exit;
  end;
  with TClientDataSet.Create(nil) do
  begin
    try
      XMLData := GetKsInfoByUserName(UserName);
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

function TZsbBm.GetKsBmNoByUserName(const UserName: string): string;
var
  sData:string;
  //cds_Temp:TClientDataSet;
begin
  Result := '';
  sData := GetKsInfoByUserName(UserName);
  if sData='' then Exit;
  with TClientDataSet.Create(nil) do
  try
    XMLData := sData;
    Result := Trim(FieldByName('报名序号').AsString);
  finally
    Free;
  end;
end;

function TZsbBm.GetKsCjInfo(const UserName: string): string;
var
  dm:TJxgzlSoapDM;
  sqlstr,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0; //不压缩
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_考生成绩表_web where username='+quotedstr(UserName)+' order by 显示顺序';
    if dm.Query_Data(sqlstr,iCompressType,sData)=S_OK then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetKshBySfzh(const Sfzh: string; out Ksh: string): string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
  i: Integer;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  if Sfzh='' then Exit;

  sqlStr := 'select * from 学生基本信息表 where 身份证号='+quotedstr(Sfzh);
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    if dm.cds_Query.RecordCount=0 then Exit;
    //Ksh := dm.cds_Query.FieldByName('考生号').AsString;
    for i := 0 to dm.cds_Query.Fields.Count - 1 do
    begin
      if (dm.cds_Query.Fields[i].FieldName='考生号') or
         (dm.cds_Query.Fields[i].FieldName='Ksh')then
        Ksh := dm.cds_Query.Fields[i].AsString;
      if dm.cds_Query.Fields[i].DataType in[ftString,ftWideString] then
        Result := Result+dm.cds_Query.Fields[i].FieldName+'：'+dm.cds_Query.Fields[i].AsString+'<br>';
    end;
    //Result := dm.cds_Query.XMLData;
    dm.cds_Query.Close;
  finally
    dm.Free;
  end;
end;

function TZsbBm.GetUserAccount: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := UserAccount;
end;

function TZsbBm.GetUserDM: string;
var
  UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string;
begin
  GetUserNetBankInfo(UserDM, UserAccount, BankSrvUrl, BankWapSrvUrl);
  Result := UserDM;
end;

function TZsbBm.GetUserNetBankInfo(out UserDM, UserAccount, BankSrvUrl,
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

function TZsbBm.GetZyList(const ZyLb:string): string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  if ZyLb='' then
    sqlStr := 'select 名称 from 招生专业表 order by 显示顺序'
  else
    sqlStr := 'select 名称 from 招生专业表 where 类别='+quotedstr(ZyLb)+' order by 显示顺序';

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

function TZsbBm.GetZzmmList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select 名称 from 政治面貌代码表 order by 显示顺序';
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

function TZsbBm.IsCanNetBm: string;
var
  dm:TJxgzlSoapDM;
begin
  Result := 'OK';
  dm := TJxgzlSoapDM.Create(nil);
  try
{
    if not IsValidIP then
    begin
      Result := '非法的IP地址！';
      Exit;
    end;
}
    if not dm.RegIsOK then
    begin
      Result := '系统未注册或注册失败！';
      Exit;
    end;

    if not dm.InNetBmTime then
    begin
      Result := '报名服务功能未开启或者不在网络报名时间段之内！';
      Exit;
    end;

  finally
    dm.Free;
  end;
end;

function TZsbBm.IsCanNetLocateCj: Boolean;
var
  sqlStr:string;
begin
  sqlStr := 'select count(*) from 网上报名时间设置表 where (成绩查询=1)';
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.IsCanNetPrintZKZ: Boolean;
var
  sqlStr:string;
begin
  sqlStr := 'select count(*) from 网上报名时间设置表 where (打印准考证=1)';
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.IsValidIP: Boolean;
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

function TZsbBm.RecordIsExists(const sqlstr: string): Boolean;
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

function TZsbBm.RegIsOK: Boolean;
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

function TZsbBm.SetPhotoUrlByBmNo(const BmNo, sUrl: string): Boolean;
var
  sqlStr:string;
begin
  Result := False;
  if not KsIsExistsByUserName(GetKsUserNameByBmNo(BmNo)) then Exit;
  
  sqlStr := 'select count(*) from 考生照片表 where 报名序号='+quotedstr(BmNo);
  if RecordIsExists(sqlstr) then
    sqlStr := 'update 考生照片表 set 照片文件名='+quotedstr(sUrl)+' where 报名序号='+quotedstr(BmNo)
  else
    sqlStr := 'Insert Into 考生照片表 (报名序号,照片文件名) values('+quotedstr(BmNo)+','+quotedstr(sUrl)+')';
  Result := ExecSql(sqlStr);
end;

function TZsbBm.SetPhotoUrlByUserName(const UserName, sUrl: string): Boolean;
var
  BmNo,sqlStr:string;
begin
  Result := False;
  if not KsIsExistsByUserName(UserName) then Exit;
  BmNo := GetKsBmNoByUserName(UserName);

  sqlStr := 'select count(*) from 考生照片表 where 报名序号='+quotedstr(BmNo);
  if RecordIsExists(sqlstr) then
    sqlStr := 'update 考生照片表 set 照片文件名='+quotedstr(sUrl)+' where 报名序号='+quotedstr(BmNo)
  else
    sqlStr := 'Insert Into 考生照片表 (报名序号,照片文件名) values('+quotedstr(BmNo)+','+quotedstr(sUrl)+')';
  Result := ExecSql(sqlStr);
end;


function TZsbBm.SrvIsOK: Boolean;
begin
  Result := RegIsOK;
end;

function TZsbBm.WriteLoginLog(const UserId, sVer: string): Boolean;
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

function TZsbBm.WriteLogoutLog(const UserId: string): Boolean;
var
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Update 操作员登录表 Set 注销时间=getdate(),注销IP='+quotedstr(sIP)+',是否在线=0 '+
            'where 操作员编号='+quotedstr(UserID)+' and 是否在线=1';
  Result := ExecSql(sqlstr);
end;

function TZsbBm.WriteSysLog(const UserId, sWhat: string): Boolean;
var
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Insert Into 操作日志表 (用户,ActionTime,内容,IP) values'+
            '('+quotedstr(UserID)+',GetDate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
  Result := ExecSql(sqlstr);          
end;

function TZsbBm.KsBK(const UserName, ZyLb, Zy1, Zy2, Zy3,
  SfyxTj: string): Boolean;
var
  sqlstr:string;
begin
  if IsCanNetBm<>'OK' then
  begin
    Result := False;
    Exit;
  end;

  if not KsIsExistsByUserName(UserName) then
  begin
    Result := False;
    Exit;
  end;
  sqlstr := ' Update 考生报名表 set '+
            ' 报考类别='+quotedstr(ZyLb)+
            ',专业志愿一='+quotedstr(Zy1)+
            ',专业志愿二='+quotedstr(Zy2)+
            ',专业志愿三='+quotedstr(Zy3)+
            ',是否同意调剂='+SfyxTj+
            ' where 登录名='+quotedstr(UserName);
  Result := ExecSql(sqlstr);
end;

function TZsbBm.KsBM(const UserName, BmNo, Ksh, Sfzh, Xm, Xb, Mz, ZzMm,
  OldSchool, OldZy, Jlqk, Addr, Yzbm, Tel, ZyZhcp, English, Computer,
  Tc: string): Boolean;
var
  sBmNo,sTemp,sqlstr:string;
begin
  if IsCanNetBm<>'OK' then
  begin
    Result := False;
    Exit;
  end;
  if not KsIsExistsByUserName(UserName) then
  begin
    Result := False;
    Exit;
  end;
  sBmNo := BmNo;
  if (sBmNo='') then
  begin
    sTemp := GetKsBmNoByUserName(UserName);
    if sTemp<>'' then
      sBmNo := sTemp
    else
      sBmNo := GetBmNo;
  end;

  sqlstr := ' Update 考生报名表 set '+
            ' 报名序号='+quotedstr(sBmNo)+
            ',考生号='+quotedstr(Ksh)+
            ',身份证号='+quotedstr(Sfzh)+
            ',姓名='+quotedstr(Xm)+
            ',性别='+quotedstr(Xb)+
            ',民族='+quotedstr(Mz)+
            ',政治面貌='+quotedstr(ZZmm)+
            ',现就读学校='+quotedstr(OldSchool)+
            ',所学专业='+quotedstr(OldZy)+
            ',受奖励情况='+quotedstr(Jlqk)+
            ',暑期通讯地址='+quotedstr(Addr)+
            ',邮政编码='+quotedstr(Yzbm)+
            ',暑期联系电话='+quotedstr(Tel)+
            ',专业综合测评情况='+quotedstr(ZyZhcp)+
            ',全省高校英语等级考试情况='+quotedstr(English)+
            ',全省高校计算机等级考试情况='+quotedstr(Computer)+
            ',特长='+quotedstr(Tc)+
            ' where 登录名='+quotedstr(UserName);
  Result := ExecSql(sqlstr);
end;

function TZsbBm.KsIsExistsBySfzh(const sfzh: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 考生报名表 where 身份证号='+quotedstr(sfzh);
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.KsIsExistsByUserName(const UserName: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 考生报名表 where 登录名='+quotedstr(UserName);
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.KsLoginByUserName(const UserName, pwd: string): Boolean;
var
  sqlstr:string;
begin
  WriteLogoutLog(UserName);
  sqlstr := 'select count(*) from 考生报名表 where 登录名='+quotedstr(UserName)+' and 密码='+quotedstr(Pwd);
  Result := RecordIsExists(sqlstr);
  if Result then
     WriteLoginLog(UserName,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web登录失败！');
  end;
end;

function TZsbBm.KsRegister(const UserName, UserPwd, Sfzh: string): Boolean;
var
  Ip,sqlstr:string;
begin
  if IsCanNetBm<>'OK' then
  begin
    Result := False;
    Exit;
  end;

  if KsIsExistsByUserName(UserName) or KsIsExistsBySfzh(Sfzh) then
  begin
    Result := False;
    Exit;
  end;

  Ip := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Insert into 考生报名表 (报名序号,登录名,密码,身份证号,报名时间,操作员,是否打印,是否缴费,Ip) '+
            'Values('+quotedstr(GetBmNo)+','+quotedstr(UserName)+','+quotedstr(UserPwd)+','+quotedstr(Sfzh)+
                    ',getdate(),'+quotedstr('NetUser')+',0,0,'+quotedstr(Ip)+')';
  Result := ExecSql(sqlstr);
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TZsbBm);
end.

