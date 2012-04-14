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
    function GetUserInfo:string;stdcall;//��ȡ�����û�����
    function GetMACInfo:string;stdcall;//��ȡ����MAC��Ϣ
    function GetUserCode:string;stdcall;//��ȡ�����û�ע����
    function RegUserInfo(const UserName,UserCode:string):Boolean;stdcall;
    function RegIsOK:Boolean;stdcall;//ϵͳ�Ƿ�ע��
    function SrvIsOK:Boolean;stdcall;

    function CzyLogin(const Czy_ID,Czy_Pwd:string;const sVersion:string=''):Boolean;stdcall;//��¼
    function CzyLogout(const Czy_ID:string):Boolean;stdcall;//�˳�
    function IsLogined(const Czy_ID:string):Boolean;stdcall;//�Ƿ��ѵ�¼
    function GetCzyName(const Czy_ID:string):string;stdcall;
    function GetCzyLevel(const Czy_ID:string):string;stdcall;
    function ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd:string):Boolean;stdcall;
    function RecordIsExists(const sWhere,sTable:string):Boolean;stdcall;
    function ReleaseLoginLog(const Czy_ID:string):Boolean ;stdcall; //��յ�¼��־
    function ReleaseLog(const Czy_ID:string):Boolean ;stdcall; //��ղ�����־

    function GetSrvAutoUpdateUrl:string;stdcall;      //�õ����������µ�ַ
    function GetClientAutoUpdateUrl:string;stdcall;   //�õ��ͻ��˸��µ�ַ

    function SetCzyRight(const Czy_ID:string;const iMenuID:Integer;const bEnabled,bVisibled:Boolean):Boolean;stdcall; //���ò���ԱȨ��
    function UploadKsPhoto(const fn, sData:string;const MS:TMemoryStream):Boolean;stdcall;

    //ͨ��ѧ�Ż�ȡ������Ϣ������XML��ʽ��DataSetֵ
    function GetKsInfoByBmNo(const BmNo:string):string;overload;stdcall;
    function GetKsInfoByBmNo(const BmNo:string;out sData,sError:string):Boolean;overload;stdcall;
    //ͨ�����֤�Ż�ȡ������Ϣ������XML��ʽ��DataSetֵ
    function GetKsInfoBySfzh(const sfzh:string):string;overload;stdcall;
    function GetKsInfoBySfzh(const sfzh:string;out sData,sError:string):Boolean;overload;stdcall;

    //ͨ��������Ż�ȡ���������֤�ţ�����string����ֵ
    function GetKsSfzhByBmNo(const BmNo:string):string;stdcall;
    function GetKsBmNoBySfzh(const Sfzh:string):string;stdcall;

    function GetBmNo: string;stdcall; //�õ�һ���������

    function KsIsPaidBySfzh(const sfzh:string):Boolean;stdcall; //�Ƿ��ѱ���
    function KsIsPaidByBmNo(const BmNo:string):Boolean;stdcall; //�Ƿ��ѱ���

    function GetHintMessage:string;stdcall; //�õ���ʾ��Ϣ

    function SetPrintBHById(const sId,sPrintBH:string):Boolean;stdcall;
    function GetPrintBHById(const sId:string):string;stdcall;
    function GetNetPayQueryUrl:string;stdcall;  //�õ�B2C�̻���½ҳ��URL(�ɲ�ѯ�������׼�¼)

    function GetWebSrvUrl:string;stdcall; //Web��������ַ���磺http://zsbbm.jxstnu.edu.cn/
    function GetUploadProcessFile:string;stdcall; //�ϴ��ű������ļ�����http·�������磺http://zsbbm.jxstnu.edu.cn/Upfile_Photo.asp
    function GetUploadVirtualDir:string;stdcall;  //�ϴ��ļ����Ŀ¼�����·�������磺UploadFiles/
    function GetKsXz:string;stdcall;    //�õ�������֪����
    function GetKsCj(const bkLb:string):string;stdcall; //�õ������ɼ������б䵥��֮��Ľ��
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
    sqlstr := 'Insert Into ������־�� (�û�,ActionTime,����,IP) values'+
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
    sqlstr := 'Insert Into ����Ա��¼�� (����Ա���,��¼ʱ��,��¼IP,SrvHost,�Ƿ�����,�ͻ��˰汾) values'+
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
    sqlstr := 'Update ����Ա��¼�� Set ע��ʱ��=getdate(),ע��IP='+quotedstr(sIP)+',�Ƿ�����=0 '+
              'where ����Ա���='+quotedstr(UserID)+' and �Ƿ�����=1';
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
    sqlstr := 'select top 1 �Ƿ�����,��¼IP from ����Ա��¼�� where �û�='+quotedstr(Czy_ID)+' order by ID desc';
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
  WriteSysLog(Czy_ID,'��������');
  try
    sqlstr := 'update ����Ա�� set ����='+quotedstr(newPwd)+
              ' where ����Ա���='+quotedstr(Czy_ID);
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
    DM.DataSet_Temp.CommandText := 'select ClientUrl from �Զ����µ�ַ�� ';
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
    DM.DataSet_Temp.CommandText := 'select �ȼ� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
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
    DM.DataSet_Temp.CommandText := 'select ����Ա���� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
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
  sSqlStr := 'select * from view_��������������';
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
    DM.DataSet_Temp.CommandText := 'select ���׼�¼URL from �û�������Ϣ��';
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
    DM.DataSet_Temp.CommandText := 'select ��ӡ���� from �ɷѼ�¼�� where Id='+quotedstr(sId);
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
    DM.DataSet_Temp.CommandText := 'select SrvUrl from �Զ����µ�ַ�� ';
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
    DM.DataSet_Temp.CommandText := 'select UploadProcessFile from ���ϱ���ʱ�����ñ� ';
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
    DM.DataSet_Temp.CommandText := 'select UploadVirtualDir from ���ϱ���ʱ�����ñ� ';
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
      Result := 'δ����ϵͳ�û���Ϣ';
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
    DM.DataSet_Temp.CommandText := 'select WebSrvUrl from ���ϱ���ʱ�����ñ� ';
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
    //DM.DataSet_Temp.CommandText := 'select count(*) from ����Ա�� '+
    //                               ' where cast(����Ա��� as varbinary)=cast('''+Czy_ID+''' as varbinary)'+
    //                               ' and cast(���� as varbinary)=cast('''+Czy_Pwd+''' as varbinary)';
    DM.DataSet_Temp.CommandText := 'select count(*) from ����Ա�� '+
                                   ' where ����Ա���='+#39+Czy_ID+#39+
                                   ' and ����='+#39+Czy_Pwd+#39;
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsInteger>0;
    if Result then
    begin
       WriteLoginLog(Czy_ID,'Ver:'+sVersion);
       //WriteLog(Czy_ID,'�û���¼�ɹ���Ver:'+sVersion);
    end
    else
    begin
       WriteSysLog(Czy_ID,'�û���¼ʧ�ܣ�Ver:'+sVersion);
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TAdmin.CzyLogOut(const Czy_ID: string): Boolean;
begin
  WriteLogoutLog(Czy_ID);
  //WriteLog(Czy_ID,'�û�ע��');
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
    ii := -1; //�Զ������Ƿ�ѹ��
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
  sqlstr := 'delete from ������־��';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := 'ɾ��������־��OK��'
  else
    sError := 'ɾ��������־ʧ�ܣ�'+sError;
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
  sqlstr := 'delete from ����Ա��¼��';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := 'ɾ����¼��־��OK��'
  else
    sError := 'ɾ����¼��־ʧ�ܣ�'+sError;
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
    sSqlStr := 'update �ɷѼ�¼�� set ��ӡ����='+quotedstr(sPrintBH)+' where Id='+quotedstr(sId);
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
    if Update_Data('�������','select * from ������Ƭ�� where 1=0',0,sData,sError) then
    begin
      MS.Position := 0;
      MS.SaveToFile(fn);
      //TBlobField(cds_Temp.FieldByName('��Ƭ')).SaveToFile(fn);
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

