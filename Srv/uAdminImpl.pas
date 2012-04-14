{ Invokable implementation File for TAdmin which implements IAdmin }

unit uAdminImpl;

interface

uses InvokeRegistry, SysUtils, Classes,Types, uAdminIntf, DB, ADODB, WebBrokerSOAP,DBClient;

type

  { TAdmin }
  TAdmin = class(TInvokableClass, IAdmin)
  public
    function Query_Data(const SqlText: string;out iCompressType:Integer; out sData: string):Integer; stdcall;
    function Update_Data(const pkField,SqlText: string;const iCompressType:Integer;
                         const sData: string; out sError:string):Boolean; stdcall;
    function GetRecordCount(const sTableName:string):Integer; stdcall;
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
    function UploadKsPhoto(const fn, sData:string;const MS:TMemoryStream):Boolean;stdcall;

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

    function GetWebSrvUrl:string;stdcall; //Web服务器网址，如：http://zsbbm.jxstnu.edu.cn/
    function GetUploadProcessFile:string;stdcall; //上传脚本处理文件（含http路径），如：http://zsbbm.jxstnu.edu.cn/Upfile_Photo.asp
    function GetUploadVirtualDir:string;stdcall;  //上传文件存放目录（相对路径），如：UploadFiles/
    function GetKsXz:string;stdcall;    //得到考生须知内容
    function GetKsCj(const bkLb:string):string;stdcall; //得到考生成绩，多行变单行之后的结果
  end;

implementation
uses uJxgzlSoapDM,uJxgzlIntf,uJxgzlImpl;


{ TAdmin }

procedure WriteSysLog(const UserID,sWhat:string);
var
  dm:TJxgzlSoapDM;
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'Insert Into 操作日志表 (用户,ActionTime,内容,IP) values'+
              '('+quotedstr(UserID)+',GetDate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
    dm.ADOConnection1.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLoginLog(const UserID,sVer:string);
var
  dm:TJxgzlSoapDM;
  sIP,sSrvHost,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sSrvHost := GetSOAPWebModule.Request.RemoteHost;
  //GetSOAPWebModule.Request.URL ==> /ZsbBm/ZsbBmWebSrv.dll
  //GetSOAPWebModule.Request.PathInfo ==> /soap/IAdmin
  //GetLocalHostName(); // //GetSOAPWebModule.Request.RemoteHost;
  if Length(sSrvHost)>30 then
    sSrvHost := Copy(sSrvHost,1,30);
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'Insert Into 操作员登录表 (操作员编号,登录时间,登录IP,SrvHost,是否在线,客户端版本) values'+
              '('+quotedstr(UserID)+',GetDate(),'+quotedstr(sIP)+',host_name(),1,'+quotedstr(sVer)+')';
    dm.ADOConnection1.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLogoutLog(const UserID:string);
var
  dm:TJxgzlSoapDM;
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'Update 操作员登录表 Set 注销时间=getdate(),注销IP='+quotedstr(sIP)+',是否在线=0 '+
              'where 操作员编号='+quotedstr(UserID)+' and 是否在线=1';
    dm.ADOConnection1.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

function TAdmin.IsAutoIncField(const sFieldName, sTableName: string): Boolean;
var
  dm:TJxgzlSoapDM;
  sqlstr:String;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select top 1 '+sFieldName+' from '+sTableName;
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].DataType in [ftAutoInc];
  finally
    dm.Free;
  end;
end;

function TAdmin.IsLogined(const Czy_ID: string): Boolean;
var
  dm:TJxgzlSoapDM;
  sIP,sLoginedIP,sqlstr:String;
  bIsOnline:Boolean;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select top 1 是否在线,登录IP from 操作员登录表 where 用户='+quotedstr(Czy_ID)+' order by ID desc';
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    bIsOnline := dm.DataSet_Temp.Fields[0].AsBoolean;
    sLoginedIP := dm.DataSet_Temp.Fields[1].AsString;
    sIP := GetSOAPWebModule.Request.RemoteAddr;
    Result := bIsOnline and (sIP=sLoginedIP);
  finally
    dm.Free;
  end;
end;

function TAdmin.KsIsPaidBySfzh(const sfzh: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.KsIsPaidBySfzh(sfzh);
  finally
    dm.Free;
  end;
end;

function TAdmin.KsIsPaidByBmNo(const BmNo: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.KsIsPaidByBmNo(BmNo);
  finally
    dm.Free;
  end;
end;



function TAdmin.ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd: string): Boolean;
var
  dm:TJxgzlSoapDM;
  sqlstr:String;
begin
  dm := TJxgzlSoapDM.Create(nil);
  Result := CzyLogin(Czy_ID,Old_Pwd,'');
  if not Result then
    Exit;
  WriteSysLog(Czy_ID,'更改密码');
  try
    sqlstr := 'update 操作员表 set 密码='+quotedstr(newPwd)+
              ' where 操作员编号='+quotedstr(Czy_ID);
    dm.ADOConnection1.Execute(sqlstr);
    Result := True;
  finally
    dm.Free;
  end;
end;

function TAdmin.GetBmNo: string;
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

function TAdmin.GetClientAutoUpdateUrl: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select ClientUrl from 自动更新地址表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'http://vir.jxstnu.edu.cn/ZsbBm/download/ClientAutoUpdate.inf';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetCzyLevel(const Czy_ID: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 等级 from 操作员表 where 操作员编号='+quotedstr(Czy_ID);
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetCzyName(const Czy_ID: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 操作员姓名 from 操作员表 where 操作员编号='+quotedstr(Czy_ID);
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetHintMessage: string;
var
{
  ZsbBmCount,
  PosPayCount,
  MoneyPayCount,
  RefundPayCount,
  ExceptPayCount:Integer;
  ZsbBmJe,
  PosPayJe,
  MoneyPayJe,
  RefundPayJe,
  ExceptPayJe:Double;
}
  sSqlStr:string;
  dm:TJxgzlSoapDM;
begin
  sSqlStr := 'select * from view_考生报名人数表';
  dm := TJxgzlSoapDM.Create(nil);
  try
    dm.cds_Query.CommandText := sSqlStr;
    try
      dm.cds_Query.Open;
      Result := dm.cds_Query.XMLData;
    except
      Result := '';
    end;
  finally
    dm.Free;
  end;
end;

function TAdmin.GetKsInfoBySfzh(const sfzh: string; out sData,
  sError: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetKsInfoBySfzh(sfzh,sData,sError);
  finally
    dm.Free;
  end;
end;

{
function TAdmin.GetJwxtSoapAddr: string;
begin

end;
}


function TAdmin.GetMACInfo: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetMACInfo;
    if Result='' then
      Result := '';
  finally
    dm.Free;
  end;
end;

function TAdmin.GetNetPayQueryUrl: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 交易记录URL from 用户网银信息表';
    try
      DM.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetPrintBHById(const sId: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 打印单号 from 缴费记录表 where Id='+quotedstr(sId);
    try
      DM.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetRecordCount(const sTableName: string): Integer;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select count(*) from '+sTableName;
    try
      DM.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetSrvAutoUpdateUrl: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select SrvUrl from 自动更新地址表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'http://vir.jxstnu.edu.cn/ZsbBm/download/SrvAutoUpdate.inf';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetKsInfoBySfzh(const sfzh: string): string;
var
  dm:TJxgzlSoapDM;
  sData,sError:string;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    if dm.GetKsInfoBySfzh(sfzh,sData,sError) then
      Result := sData
    else
      Result := '';
  finally
    dm.Free;
  end;
end;

function TAdmin.GetUploadProcessFile: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select UploadProcessFile from 网上报名时间设置表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'Upfile_Photo.asp';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetUploadVirtualDir: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select UploadVirtualDir from 网上报名时间设置表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'UploadFiles/';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.GetUserCode: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetUserCode;
    if Result='' then
      Result := '';
  finally
    dm.Free;
  end;
end;

function TAdmin.GetUserInfo: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetUserInfo;
    if Result='' then
      Result := '未输入系统用户信息';
  finally
    dm.Free;
  end;
end;

function TAdmin.GetWebSrvUrl: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select WebSrvUrl from 网上报名时间设置表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'http://zsbbm.jxstnu.edu.cn/';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.RecordIsExists(const sWhere, sTable: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select count(*) from '+sTable+' '+sWhere;
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsInteger>0;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.CzyLogin(const Czy_ID, Czy_Pwd:string;const sVersion:string=''): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  CzyLogOut(Czy_ID);
  dm := TJxgzlSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    //DM.DataSet_Temp.CommandText := 'select count(*) from 操作员表 '+
    //                               ' where cast(操作员编号 as varbinary)=cast('''+Czy_ID+''' as varbinary)'+
    //                               ' and cast(密码 as varbinary)=cast('''+Czy_Pwd+''' as varbinary)';
    DM.DataSet_Temp.CommandText := 'select count(*) from 操作员表 '+
                                   ' where 操作员编号='+#39+Czy_ID+#39+
                                   ' and 密码='+#39+Czy_Pwd+#39;
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsInteger>0;
    if Result then
    begin
       WriteLoginLog(Czy_ID,'Ver:'+sVersion);
       //WriteLog(Czy_ID,'用户登录成功！Ver:'+sVersion);
    end
    else
    begin
       WriteSysLog(Czy_ID,'用户登录失败！Ver:'+sVersion);
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.CzyLogOut(const Czy_ID: string): Boolean;
begin
  WriteLogoutLog(Czy_ID);
  //WriteLog(Czy_ID,'用户注销');
  Result := True;
end;

function TAdmin.ExecSql(const SqlText: string; out sError: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.ExecSqlCmd(SqlText,sError);
  finally
    dm.Free;
  end;
end;

function TAdmin.Query_Data(const SqlText: string;out iCompressType:Integer; out sData: string):Integer;
var
  dm:TJxgzlSoapDM;
  ii:Integer;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    ii := -1; //自动决定是否压缩
    Result := dm.Query_Data(SqlText,ii,sData);
    iCompressType := ii;
  finally
    dm.Free;
  end;
end;

function TAdmin.RegIsOK: Boolean;
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

function TAdmin.RegUserInfo(const UserName, UserCode: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.RegUserInfo(UserName,UserCode);
  finally
    dm.adoquery_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.ReleaseLog(const Czy_ID: string): Boolean;
var
  sqlstr,sError:string;
begin
  if GetCzyLevel(Czy_ID)<>'-1' then
  begin
    Result := False;
    Exit;
  end;
  sqlstr := 'delete from 操作日志表';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := '删除操作日志！OK！'
  else
    sError := '删除操作日志失败！'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteSysLog(Czy_ID,sError);
end;

function TAdmin.ReleaseLoginLog(const Czy_ID: string): Boolean;
var
  sqlstr,sError:string;
begin
  if GetCzyLevel(Czy_ID)<>'-1' then
  begin
    Result := False;
    Exit;
  end;
  sqlstr := 'delete from 操作员登录表';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := '删除登录日志！OK！'
  else
    sError := '删除登录日志失败！'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteSysLog(Czy_ID,sError);
end;

function TAdmin.SetCzyRight(const Czy_ID: string; const iMenuID: Integer;
  const bEnabled, bVisibled: Boolean): Boolean;
begin
  Result := True;
end;

function TAdmin.SetPrintBHById(const sId, sPrintBH: string): Boolean;
var
  dm:TJxgzlSoapDM;
  sSqlStr:string;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    sSqlStr := 'update 缴费记录表 set 打印单号='+quotedstr(sPrintBH)+' where Id='+quotedstr(sId);
    Result := DM.ExecSqlCmd(sSqlStr);
  finally
    dm.Free;
  end;
end;

function TAdmin.SrvIsOK: Boolean;
begin
  Result := True;
end;

function TAdmin.Update_Data(const pkField,SqlText:string;const iCompressType:Integer;
  const sData: string;  out sError:string):Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.Update_Data(pkField,SqlText,iCompressType, sData,sError);
  finally
    dm.Free;
  end;
end;

function TAdmin.UploadKsPhoto(const fn, sData: string;const MS:TMemoryStream): Boolean;
var
  cds_Temp:TClientDataSet;
  sPath,sError:string;
begin
  Result := False;
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := sData;
    sPath := ExtractFilePath(fn);
    if not DirectoryExists(sPath) then
      ForceDirectories(sPath);
    if Update_Data('报名序号','select * from 考生照片表 where 1=0',0,sData,sError) then
    begin
      MS.Position := 0;
      MS.SaveToFile(fn);
      //TBlobField(cds_Temp.FieldByName('照片')).SaveToFile(fn);
      Result := True;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TAdmin.GetKsBmNoBySfzh(const Sfzh: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetKsBmNoBySfzh(Sfzh);
  finally
    dm.Free;
  end;
end;

function TAdmin.GetKsCj(const bkLb: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    dm.sp_GetKsCj.Parameters.ParamByName('@bkLb').Value := bkLb;
    dm.sp_GetKsCj.ExecProc;
    dm.cds_GetKsCj.Active := True;
    Result := dm.cds_GetKsCj.XMLData;
  finally
    dm.cds_GetKsCj.Active := False;
    dm.sp_GetKsCj.Close;
    dm.Free;
  end;
end;

function TAdmin.GetKsInfoByBmNo(const BmNo: string; out sData,
  sError: string): Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetKsInfoByBmNo(BmNo,sData,sError);
  finally
    dm.Free;
  end;
end;

function TAdmin.GetKsInfoByBmNo(const BmNo: string): string;
var
  dm:TJxgzlSoapDM;
  sData,sError:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  try
    if dm.GetKsInfoByBmNo(BmNo,sData,sError) then
      Result := sData;
  finally
    dm.Free;
  end;
end;

function TAdmin.GetKsSfzhByBmNo(const BmNo: string): string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    //Result := dm.GetKsSfzhByBmNo(BmNo);
  finally
    dm.Free;
  end;
end;

function TAdmin.GetKsXz: string;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.GetKsXz;
  finally
    dm.Free;
  end;
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TAdmin);
end.

