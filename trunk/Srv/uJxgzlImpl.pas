//==================================================================//
//    ����֧���ӿ�ʵ�ֵ�Ԫ��
//    ����������Ϊ��ʵ�ֿ��������������ɷѶ����õĽӿڡ�
//    �ӿ����ƣ�Ijxgzl
//    �ӿ����ã�http://url/jxgzl/jxgzlWebSrv.dll/soap/Ijxgzl
//            ���ߣ�http://url/jxgzl/jxgzlWebSrv.dll/wsdl/Ijxgzl
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
    function RegIsOK:Boolean;stdcall;//ϵͳ�Ƿ�ע��
    function SrvIsOK:Boolean;stdcall; //�������Ƿ�׼����/�Ƿ����
    //�ж�WEB Server�Ƿ�Ϊ�Ϸ����û����������IP(��WEB������IP��֤)
    function IsValidIP:Boolean;stdcall;

    //�жϷ�������ǰ�Ƿ���Խ������ϱ���������������ϱ����򷵻��ַ�����OK ������������򷵻ز������ԭ�������رա�IP����ȷ�����ڱ���ʱ���ڵȵ�
    function IsCanNetPrintZKZ:Boolean;stdcall;

    function GetXnXqList:string;stdcall;

    //ͨ��ְ���ź�ѧ��ѧ�ڻ�ȡ��������Ϣ������XML��ʽ��DataSetֵ
    function GetJxgzlInfo(const sNo,sXnxq:string):string;stdcall;
    //�õ���ѧ��������Ϣ
    function GetJxgzlInfo2(const sNo,sXnxq:string;out BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,Addr,
                         Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;

    function TeacherLoginByNo(const sNo,sXM:string):Boolean;stdcall;//ͨ��ְ���ŵ�¼
    function TeacherLoginBySfzh(const sfzh,sXM:string):Boolean;stdcall;//ͨ�����֤�ŵ�¼

    //��ȡ����֪ͨ��RecCountΪϣ����ȡ�ļ�¼��Ŀ���������XML��ʽ��DataSetֵ��
    function GetBullitInfo(const  RecCount:Integer=5):string;stdcall;
    //��ȡ������Ϣ�����ؽ��Ϊһ�����е��ַ���ֵ��������֮���ûس����з��ָ�����ͨ����#13#10��
    function GetHelpInfo:string;stdcall;
    //��ȡ�û�������������Ϣ��UserDM:�̻����� UserAccount:�̻��ʺ�,BankSrvUrl:����֧���ӿڵ�ַ,BankWapSrvUrl:�ֻ�֧���ӿڵ�ַ
    //��ȡ�ɹ�����True�����򷵻�False
    function GetUserNetBankInfo(out UserDM,UserAccount,BankSrvUrl,BankWapSrvUrl:string):Boolean;stdcall;
    //�õ��û����̻�������
    function GetUserDM:string;stdcall;
    //�õ��û����̻����ʺ�
    function GetUserAccount:string;stdcall;
    //�õ�����֧���ӿ���ַ
    function GetBankSrvUrl:string;stdcall;
    //�õ��ֻ�֧���ӿ���ַ
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
  sqlStr := 'select top '+IntToStr(RecCount)+' ID,����,ActionTime from ����֪ͨ�� order by �Ƿ��ö� desc,ActionTime desc';
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
  sqlStr := 'select ������Ϣ from ��վ������Ϣ��';
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
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from �������ܱ�_Web where gzh='+quotedstr(sNo);
    if sXnxq<>'' then
      sqlstr := sqlstr+' and xnxq='+quotedstr(sXnxq);
    sqlstr := sqlstr+' order by �����';
    
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
      BmNo := FieldByName('�������').AsString;
      Ksh := FieldByName('������').AsString;
      Sfzh := FieldByName('���֤��').AsString;
      Xm := FieldByName('����').AsString;
      Xb := FieldByName('�Ա�').AsString;
      Mz := FieldByName('����').AsString;
      ZzMm := FieldByName('������ò').AsString;
      OldSchool := FieldByName('�־Ͷ�ѧУ').AsString;
      OldZy := FieldByName('��ѧרҵ').AsString;
      Jlqk := FieldByName('�ܽ������').AsString;
      Addr := FieldByName('����ͨѶ��ַ').AsString;
      Yzbm := FieldByName('��������').AsString;
      Tel := FieldByName('������ϵ�绰').AsString;
      ZyZhcp := FieldByName('רҵ�ۺϲ������').AsString;
      English := FieldByName('ȫʡ��УӢ��ȼ��������').AsString;
      Computer := FieldByName('ȫʡ��У������ȼ��������').AsString;
      Tc := FieldByName('�س�').AsString;
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
  sqlStr := 'select �̻�����,�̻��ʺ�,��վ֧��URL,�ֻ�֧��URL from �û�������Ϣ��';
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
  sqlStr := 'select distinct xnxq from �������ܱ�_Web order by xnxq';
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
  sqlStr := 'select count(*) from ���ϱ���ʱ�����ñ� where (��ӡ׼��֤=1)';
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
  sqlstr := 'select count(*) from �������ܱ�_Web where zgh='+quotedstr(sNo);
  if sXnxq<>'' then
    sqlstr := sqlstr+' and xnxq='+quotedstr(sXnxq);
  Result := RecordIsExists(sqlstr);
end;

function Tjxgzl.TeacherLoginByNo(const sNo, sXM: string): Boolean;
var
  sqlstr:string;
begin
  //WriteLogoutLog(sNo);
  sqlstr := 'select count(*) from �������ܱ� where ��ʦְ����='+quotedstr(sNo)+' and ��ʦ����='+quotedstr(sXM);
  Result := RecordIsExists(sqlstr);
{
  if Result then
     WriteLoginLog(sNo,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web��¼ʧ�ܣ�');
  end;
}
end;

function Tjxgzl.TeacherLoginBySfzh(const sfzh,sXM: string): Boolean;
var
  sqlstr:string;
begin
  //WriteLogoutLog(sNo);
  sqlstr := 'select count(*) from �������ܱ� where ���֤��='+quotedstr(sfzh)+' and ��ʦ����='+quotedstr(sXM);
  Result := RecordIsExists(sqlstr);
{
  if Result then
     WriteLoginLog(sNo,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web��¼ʧ�ܣ�');
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
  sqlstr := 'Insert Into ����Ա��¼�� (����Ա���,��¼ʱ��,��¼IP,SrvHost,�Ƿ�����,�ͻ��˰汾) values'+
            '('+quotedstr('WebUser')+',GetDate(),'+quotedstr(sIP)+','+quotedstr(sSrvHost)+',1,'+quotedstr(sVer)+')';
  Result := ExecSql(sqlstr);
end;

function Tjxgzl.WriteLogoutLog(const UserId: string): Boolean;
var
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Update ����Ա��¼�� Set ע��ʱ��=getdate(),ע��IP='+quotedstr(sIP)+',�Ƿ�����=0 '+
            'where ����Ա���='+quotedstr(UserID)+' and �Ƿ�����=1';
  Result := ExecSql(sqlstr);
end;

function Tjxgzl.WriteSysLog(const UserId, sWhat: string): Boolean;
var
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Insert Into ������־�� (�û�,ActionTime,����,IP) values'+
            '('+quotedstr(UserID)+',GetDate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
  Result := ExecSql(sqlstr);
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(Tjxgzl);
end.

