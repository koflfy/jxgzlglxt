//==================================================================//
//    ����֧���ӿ�ʵ�ֵ�Ԫ��
//    ����������Ϊ��ʵ�ֿ��������������ɷѶ����õĽӿڡ�
//    �ӿ����ƣ�IZsbBm
//    �ӿ����ã�http://url/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm
//            ���ߣ�http://url/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm
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
    //ͨ��������Ż�ȡ�������û���������string����ֵ
    function GetKsUserNameByBmNo(const BmNo:string):string;
  public
    function RegIsOK:Boolean;stdcall;//ϵͳ�Ƿ�ע��
    function SrvIsOK:Boolean;stdcall; //�������Ƿ�׼����/�Ƿ����
    //�ж�WEB Server�Ƿ�Ϊ�Ϸ����û����������IP(��WEB������IP��֤)
    function IsValidIP:Boolean;stdcall;

    //�жϷ�������ǰ�Ƿ���Խ������ϱ���������������ϱ����򷵻��ַ�����OK ������������򷵻ز������ԭ�������رա�IP����ȷ�����ڱ���ʱ���ڵȵ�
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
    //�������û�����������ţ������ţ����֤�ţ��������Ա����壬������ò���־Ͷ�ѧУ����רҵ�����������
    //     ���ڵ�ַ���������룬���ڵ绰��רҵ�ۺϲ��������Ӣ��ȼ����ԣ�������ȼ����ԣ��س�
    function KsBM(const UserName,BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,
                  Addr,Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;
    //�������û�����רҵ���־Ը1��2��3���Ƿ��������==>1������0��������
    function KsBK(const UserName,ZyLb,Zy1,Zy2,Zy3,SfyxTj:string):Boolean;stdcall;

    function GetKsBMInfo(const UserName:string;out BmNo,Ksh,Sfzh,Xm,Xb,Mz,ZzMm,OldSchool,OldZy,Jlqk,Addr,
                         Yzbm,Tel,ZyZhcp,English,Computer,Tc:string):Boolean;stdcall;

    function GetKsBKInfo(const UserName:string;
                         out ZyLb,Zy1,Zy2,Zy3,SfyxTj:string):Boolean;stdcall;

    //��ѯ��У�����Ŀ�����
    function GetKshBySfzh(const Sfzh:string;out Ksh:string):string;stdcall;
    //ͨ���û�����ȡ������Ϣ������XML��ʽ��DataSetֵ
    function GetKsInfo(const UserName:string):string;stdcall;
    //ͨ���û�����ȡ������Ϣ������XML��ʽ��DataSetֵ
    function GetKsZkzInfo(const UserName:string):string;stdcall;
    //ͨ���û�����ȡ�����ɼ���Ϣ������XML��ʽ��DataSetֵ
    function GetKsCjInfo(const UserName:string):string;stdcall;

    function GetKsKcTime(const bkLb:string):string;stdcall; //�õ����Կγ̺Ϳ���ʱ��
    function GetKsXz:string;stdcall;    //�õ�������֪��Ϣ

    function KsIsExistsByUserName(const UserName:string):Boolean;stdcall;//ͨ����������жϿ����Ƿ����
    function KsIsExistsBySfzh(const sfzh:string):Boolean;stdcall;//ͨ�����֤���жϿ����Ƿ����

    function KsLoginByUserName(const UserName,pwd:string):Boolean; stdcall;//���뱨����ź�������֤���е�¼

    function GetBmNo: string;stdcall; //�õ�һ���������

    //ͨ���û�����ȡ�����ı�����ţ�����string����ֵ
    function GetKsBmNoByUserName(const UserName:string):string;stdcall;
    //ͨ��������ȡ���������֤�ţ�����string����ֵ
    function GetKsSfzhByUserName(const UserName:string):string;stdcall;

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
  sqlStr := 'select ��� from רҵ���� order by ��ʾ˳��';
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

function TZsbBm.GetComputerList: string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  sqlStr := 'select ���� from ������ȼ��������� order by ��ʾ˳��';
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
  sqlStr := 'select ���� from Ӣ��ȼ��������� order by ��ʾ˳��';
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
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_����������_Web where UserName='+quotedstr(UserName);
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
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_���������� where ��¼��='+quotedstr(UserName);
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
    Result := Trim(FieldByName('���֤��').AsString);
  finally
    Free;
  end;
end;

function TZsbBm.GetKsUserNameByBmNo(const BmNo: string): string;
begin
  Result := GetKsBmbFieldValue('�������',BmNo,'��¼��');
end;

function TZsbBm.GetKsKcTime(const bkLb: string): string;
var
  dm:TJxgzlSoapDM;
  sqlstr,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_���Կγ̱�_web where bklb='+quotedstr(bkLb);
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
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_׼��֤��_web where UserName='+quotedstr(UserName);
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
  sqlStr := 'select ���� from �������� order by ��ʾ˳��';
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
  sqlStr := 'select ��Ƭ�ļ��� from ������Ƭ�� where �������='+quotedstr(GetKsBmNoByUserName(UserName));
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
  sqlStr := 'select ѧУ���� from ȫ����У��Ϣ�� where ʡ��='+quotedstr('����')+' order by ��ʾ˳��';
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
      ZyLb := FieldByName('�������').AsString;
      Zy1 := FieldByName('רҵ־Ըһ').AsString;
      Zy2 := FieldByName('רҵ־Ը��').AsString;
      Zy3 := FieldByName('רҵ־Ը��').AsString;
      if FieldByName('�Ƿ�ͬ�����').AsBoolean then
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
  sqlstr := 'select '+dFld+' from view_���������� where '+sFld+'='+quotedstr(sValue);
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
    Result := Trim(FieldByName('�������').AsString);
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
  iCompressType := 0; //��ѹ��
  dm := TJxgzlSoapDM.Create(nil);
  try
    sqlstr := 'select * from view_�����ɼ���_web where username='+quotedstr(UserName)+' order by ��ʾ˳��';
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

  sqlStr := 'select * from ѧ��������Ϣ�� where ���֤��='+quotedstr(Sfzh);
  try
    dm.cds_Query.Close;
    dm.cds_Query.CommandText := sqlStr;
    dm.cds_Query.Open;
    if dm.cds_Query.RecordCount=0 then Exit;
    //Ksh := dm.cds_Query.FieldByName('������').AsString;
    for i := 0 to dm.cds_Query.Fields.Count - 1 do
    begin
      if (dm.cds_Query.Fields[i].FieldName='������') or
         (dm.cds_Query.Fields[i].FieldName='Ksh')then
        Ksh := dm.cds_Query.Fields[i].AsString;
      if dm.cds_Query.Fields[i].DataType in[ftString,ftWideString] then
        Result := Result+dm.cds_Query.Fields[i].FieldName+'��'+dm.cds_Query.Fields[i].AsString+'<br>';
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

function TZsbBm.GetZyList(const ZyLb:string): string;
var
  dm:TJxgzlSoapDM;
  sqlStr:string;
begin
  Result := '';
  dm := TJxgzlSoapDM.Create(nil);
  if ZyLb='' then
    sqlStr := 'select ���� from ����רҵ�� order by ��ʾ˳��'
  else
    sqlStr := 'select ���� from ����רҵ�� where ���='+quotedstr(ZyLb)+' order by ��ʾ˳��';

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
  sqlStr := 'select ���� from ������ò����� order by ��ʾ˳��';
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
      Result := '�Ƿ���IP��ַ��';
      Exit;
    end;
}
    if not dm.RegIsOK then
    begin
      Result := 'ϵͳδע���ע��ʧ�ܣ�';
      Exit;
    end;

    if not dm.InNetBmTime then
    begin
      Result := '����������δ�������߲������籨��ʱ���֮�ڣ�';
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
  sqlStr := 'select count(*) from ���ϱ���ʱ�����ñ� where (�ɼ���ѯ=1)';
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.IsCanNetPrintZKZ: Boolean;
var
  sqlStr:string;
begin
  sqlStr := 'select count(*) from ���ϱ���ʱ�����ñ� where (��ӡ׼��֤=1)';
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
  
  sqlStr := 'select count(*) from ������Ƭ�� where �������='+quotedstr(BmNo);
  if RecordIsExists(sqlstr) then
    sqlStr := 'update ������Ƭ�� set ��Ƭ�ļ���='+quotedstr(sUrl)+' where �������='+quotedstr(BmNo)
  else
    sqlStr := 'Insert Into ������Ƭ�� (�������,��Ƭ�ļ���) values('+quotedstr(BmNo)+','+quotedstr(sUrl)+')';
  Result := ExecSql(sqlStr);
end;

function TZsbBm.SetPhotoUrlByUserName(const UserName, sUrl: string): Boolean;
var
  BmNo,sqlStr:string;
begin
  Result := False;
  if not KsIsExistsByUserName(UserName) then Exit;
  BmNo := GetKsBmNoByUserName(UserName);

  sqlStr := 'select count(*) from ������Ƭ�� where �������='+quotedstr(BmNo);
  if RecordIsExists(sqlstr) then
    sqlStr := 'update ������Ƭ�� set ��Ƭ�ļ���='+quotedstr(sUrl)+' where �������='+quotedstr(BmNo)
  else
    sqlStr := 'Insert Into ������Ƭ�� (�������,��Ƭ�ļ���) values('+quotedstr(BmNo)+','+quotedstr(sUrl)+')';
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
  sqlstr := 'Insert Into ����Ա��¼�� (����Ա���,��¼ʱ��,��¼IP,SrvHost,�Ƿ�����,�ͻ��˰汾) values'+
            '('+quotedstr('WebUser')+',GetDate(),'+quotedstr(sIP)+','+quotedstr(sSrvHost)+',1,'+quotedstr(sVer)+')';
  Result := ExecSql(sqlstr);
end;

function TZsbBm.WriteLogoutLog(const UserId: string): Boolean;
var
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Update ����Ա��¼�� Set ע��ʱ��=getdate(),ע��IP='+quotedstr(sIP)+',�Ƿ�����=0 '+
            'where ����Ա���='+quotedstr(UserID)+' and �Ƿ�����=1';
  Result := ExecSql(sqlstr);
end;

function TZsbBm.WriteSysLog(const UserId, sWhat: string): Boolean;
var
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sqlstr := 'Insert Into ������־�� (�û�,ActionTime,����,IP) values'+
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
  sqlstr := ' Update ���������� set '+
            ' �������='+quotedstr(ZyLb)+
            ',רҵ־Ըһ='+quotedstr(Zy1)+
            ',רҵ־Ը��='+quotedstr(Zy2)+
            ',רҵ־Ը��='+quotedstr(Zy3)+
            ',�Ƿ�ͬ�����='+SfyxTj+
            ' where ��¼��='+quotedstr(UserName);
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

  sqlstr := ' Update ���������� set '+
            ' �������='+quotedstr(sBmNo)+
            ',������='+quotedstr(Ksh)+
            ',���֤��='+quotedstr(Sfzh)+
            ',����='+quotedstr(Xm)+
            ',�Ա�='+quotedstr(Xb)+
            ',����='+quotedstr(Mz)+
            ',������ò='+quotedstr(ZZmm)+
            ',�־Ͷ�ѧУ='+quotedstr(OldSchool)+
            ',��ѧרҵ='+quotedstr(OldZy)+
            ',�ܽ������='+quotedstr(Jlqk)+
            ',����ͨѶ��ַ='+quotedstr(Addr)+
            ',��������='+quotedstr(Yzbm)+
            ',������ϵ�绰='+quotedstr(Tel)+
            ',רҵ�ۺϲ������='+quotedstr(ZyZhcp)+
            ',ȫʡ��УӢ��ȼ��������='+quotedstr(English)+
            ',ȫʡ��У������ȼ��������='+quotedstr(Computer)+
            ',�س�='+quotedstr(Tc)+
            ' where ��¼��='+quotedstr(UserName);
  Result := ExecSql(sqlstr);
end;

function TZsbBm.KsIsExistsBySfzh(const sfzh: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from ���������� where ���֤��='+quotedstr(sfzh);
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.KsIsExistsByUserName(const UserName: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from ���������� where ��¼��='+quotedstr(UserName);
  Result := RecordIsExists(sqlstr);
end;

function TZsbBm.KsLoginByUserName(const UserName, pwd: string): Boolean;
var
  sqlstr:string;
begin
  WriteLogoutLog(UserName);
  sqlstr := 'select count(*) from ���������� where ��¼��='+quotedstr(UserName)+' and ����='+quotedstr(Pwd);
  Result := RecordIsExists(sqlstr);
  if Result then
     WriteLoginLog(UserName,'Ver: 1.0.0.3')
  else
  begin
    if KsIsExistsByUserName(UserName) then
       WriteSysLog(UserName,'Web��¼ʧ�ܣ�');
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
  sqlstr := 'Insert into ���������� (�������,��¼��,����,���֤��,����ʱ��,����Ա,�Ƿ��ӡ,�Ƿ�ɷ�,Ip) '+
            'Values('+quotedstr(GetBmNo)+','+quotedstr(UserName)+','+quotedstr(UserPwd)+','+quotedstr(Sfzh)+
                    ',getdate(),'+quotedstr('NetUser')+',0,0,'+quotedstr(Ip)+')';
  Result := ExecSql(sqlstr);
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TZsbBm);
end.

