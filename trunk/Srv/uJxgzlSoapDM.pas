Unit uJxgzlSoapDM;

interface

uses SysUtils, Classes, InvokeRegistry, Midas, SOAPMidas, SOAPDm, ADODB,
  DBClient, Provider, DB, PwdFunUnit, Rio, SOAPHTTPClient, WebBrokerSoap,
  VCLUnZip, VCLZip;

type
  IJxgzlSoapDM = interface(IAppServerSOAP)
    ['{8B5354E0-4A56-43F9-9207-1761F2E116CE}']
  end;

  TJxgzlSoapDM = class(TSoapDataModule, IJxgzlSoapDM, IAppServerSOAP, IAppServer)
    AdoConnection1: TADOConnection;
    DataSet_Query: TADODataSet;
    DataSet_Update: TADODataSet;
    DSP_Query: TDataSetProvider;
    DSP_Update: TDataSetProvider;
    cds_Query: TClientDataSet;
    cds_Update: TClientDataSet;
    DataSet_Temp: TADODataSet;
    sp_GetPayNo: TADOStoredProc;
    sp_Temp: TADOStoredProc;
    sp_GetRefundNo: TADOStoredProc;
    AdoQuery_Temp: TADOQuery;
    sp_GetPayCheckNo: TADOStoredProc;
    sp_ConfirmPayRecord: TADOStoredProc;
    sp_ExceptPayBackup: TADOStoredProc;
    sp_GetBmNo: TADOStoredProc;
    VCLZip1: TVCLZip;
    sp_GetKsCj: TADOStoredProc;
    DSP_GetKsCj: TDataSetProvider;
    cds_GetKsCj: TClientDataSet;
    procedure SoapDataModuleCreate(Sender: TObject);
    procedure SoapDataModuleDestroy(Sender: TObject);
  private
    //��xmldata�н���ѧ����Ϣ��ѧ��,���֤��,����,�Ա�,������,רҵ,״̬
    function GetKsInfo(const sData:string;var xh,sfzh,xm,xb,nj,lb,zy,state:string):Boolean;
    function GetIntfInfo(const Id:Integer;var sUrl, sUser, sPwd: string;var IsStarted:Boolean):Boolean;
    function SetIntfInfo(const Id:Integer;const sName,sUrl, sUser, sPwd: string;const IsStarted:Boolean):Boolean;
    function IntfIsOK(const sUrl, sUser, sPwd: string;var sError:String):Boolean;
  public
    //ICompressType: -1: Auto, 0: Not Compress, 1: Compress 
    function Query_Data(const SqlText: string;var iCompressType:Integer; out sData: string):Integer;
    function Update_Data(const pkField,SqlText: string; const iCompressType:Integer;
                         const sData: string; out sError:string):Boolean;

    function RegIsOK:Boolean;
    function GetUserInfo:string;//����û�����
    function GetMACInfo:string;//����û�������
    function GetUserCode:string;//����û�ע����
    function RegUserInfo(const UserName,UserCode:string):Boolean;//ע���û�

    function GetJwxtSoapInfo(var sUrl, sUser, sPwd: string;var IsStarted:Boolean): Boolean;
    function SetJwxtSoapInfo(const sUrl, sUser, sPwd: string;const IsStarted:Boolean=True): Boolean;
    function JwxtInfoIsOK(const sUrl, sUser, sPwd: string;var sError:String): Boolean;overload;
    function JwxtInfoIsOK: Boolean;overload;

    function RecordIsExists(const sSqlStr:string):Boolean;
    function ExecSqlCmd(const sSqlStr:string):Boolean;overload;
    function ExecSqlCmd(const sSqlStr:string;var sError:string):Boolean;overload;
    function InNetBmTime:Boolean;  //�Ƿ������ϱ���ʱ����ڣ�ֻ������֧�������ж�
    function IsValidIP(const sIp:string=''):Boolean;

    function GetKsBmNoBySfzh(const Sfzh:string):string; //�õ������������
    function GetKsInfoBySfzh(const Sfzh:string;out sData,sError:string):Boolean;
    function GetKsInfoByBmNo(const BmNo:string;out sData,sError:string):Boolean;

    function GetKsXz:string; //�õ�������֪
    function SetKsXz(const sValue:string):Boolean;

    function GetCurSfSetInfo(var sfxn,sfmc,startTime,endTime:string):Boolean;       //�õ��շ�������Ϣ
    
    function KsIsPaidBySfzh(const sfzh:string):Boolean;     //�Ƿ��ѽɷ�
    function KsIsPaidByBmNo(const BmNo:string):Boolean;     //�Ƿ��ѽɷ�

    function GetBmNo:string;    //�õ�������ˮ��

    function DropView(const ViewName:string):Boolean; //ɾ����ͼ
    function CreateView(const ViewName,sqlStr:string):Boolean; //������ͼ

  end;

implementation
uses uDbConnect,Net,uAdminIntf,EncdDecdEx;

{$R *.DFM}

procedure TJxgzlSoapDMCreateInstance(out obj: TObject);
begin
 obj := TJxgzlSoapDM.Create(nil);
end;

function TJxgzlSoapDM.CreateView(const ViewName, sqlStr: string): Boolean;
var
  adoqry:TADOQuery;
  sList:TStrings;
begin
  sList := TStringList.Create;
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := ADOConnection1;

  DropView(ViewName);

  sList.Add('CREATE VIEW '+ViewName+' AS ');
  sList.Add(sqlStr);
  //sList.Add('go');
  try
    try
      adoqry.SQL.Assign(sList);
      adoqry.ExecSQL;
      sList.Text := 'update ����������ͱ� set Ĭ�ϼ�������='+quotedstr(sqlStr)+' where ��������='+quotedstr(ViewName);
      Result := ExecSqlCmd(sList.Text);
    except
      on e:Exception do
      begin
        Result := False;
      end;
    end;
  finally
    sList.Free;
    FreeAndNil(adoqry);
  end;
end;

function TJxgzlSoapDM.DropView(const ViewName: string): Boolean;
var
  adoqry:TADOQuery;
  sList:TStrings;
begin
  sList := TStringList.Create;
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := ADOConnection1;
  sList.Add('IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID('+quotedstr(ViewName)+'))');
  sList.Add('drop view '+ViewName);
  //sList.Add('go');

  try
    try
      adoqry.SQL.Assign(sList);
      adoqry.ExecSQL;
      Result := True;
    except
      on e:Exception do
      begin
        Result := False;
      end;
    end;
  finally
    sList.Free;
    FreeAndNil(adoqry);
  end;
end;

function TJxgzlSoapDM.ExecSqlCmd(const sSqlStr: string;var sError:string): Boolean;
var
  adoqry:TADOQuery;
begin
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := ADOConnection1;
  try
    try
      adoqry.SQL.Text := sSqlStr;
      adoqry.ExecSQL;
      Result := True;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(adoqry);
  end;
end;

function TJxgzlSoapDM.ExecSqlCmd(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  Result := ExecSqlCmd(sSqlStr,sError);
end;

function TJxgzlSoapDM.GetBmNo: string;
begin
  sp_GetBmNo.ExecProc;
  Result := sp_GetBmNo.Parameters.ParamByName('@res_No').Value;
end;

function TJxgzlSoapDM.GetCurSfSetInfo(var sfxn,sfmc, startTime,
  endTime: string): Boolean;
begin
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := 'select ��ǰѧ��,�շ�����,��ʼʱ��,����ʱ�� from �շ����ñ� ';
    DataSet_Temp.Active := True;
    Result := DataSet_Temp.RecordCount>0;
    if not Result then Exit;
    sfxn := DataSet_Temp.Fields[0].AsString;
    sfmc := DataSet_Temp.Fields[1].AsString;
    startTime := FormatDateTime('yyyy-mm-dd',DataSet_Temp.Fields[2].AsDateTime);
    endTime := FormatDateTime('yyyy-mm-dd',DataSet_Temp.Fields[3].AsDateTime);
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.GetIntfInfo(const Id: Integer; var sUrl, sUser,
  sPwd: string;var IsStarted:Boolean): Boolean;
var
  sqlText :string;
  //DataSet_Temp:TADODataSet;
begin
  sqlText := 'select �ӿ�����,�ӿڵ�ַ,��֤�û���,��֤����,�Ƿ����� from �ӿ����ñ� where Id='+IntTostr(Id);
  //DataSet_Temp := TADODataSet.Create(nil);
  try
    //DataSet_Temp.Connection := Self.ADOConnection1;
    DataSet_Temp.Active := False;
    DataSet_Temp.CommandText := SqlText;
    DataSet_Temp.Active := True;

    if DataSet_Temp.RecordCount>0 then
    begin
      //sIntfName  := DataSet_Temp.Fields[0].AsString;
      sUrl       := DataSet_Temp.Fields[1].AsString;
      sUser      := DataSet_Temp.Fields[2].AsString;
      sPwd       := DataSet_Temp.Fields[3].AsString;
      IsStarted  := DataSet_Temp.Fields[4].AsBoolean;
    end;
    Result := True;
  finally
    DataSet_Temp.Active := False;
    //DataSet_Temp.Free;
  end;
end;

function TJxgzlSoapDM.GetJwxtSoapInfo(var sUrl, sUser, sPwd: string;
  var IsStarted: Boolean): Boolean;
begin

end;

function TJxgzlSoapDM.GetMACInfo: string;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select MAC from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.GetKsInfo(const sData: string; var xh, sfzh, xm, xb, nj,
  lb, zy, state: string): Boolean;
var
  cds_Temp:TClientDataSet;
begin
  Result := False;
  if sData='' then Exit;
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := sData;
    xh := Trim(cds_Temp.FieldByName('xh').AsString);
    sfzh := Trim(cds_Temp.FieldByName('sfzh').AsString);
    xm := Trim(cds_Temp.FieldByName('xm').AsString);
    xb := Trim(cds_Temp.FieldByName('xb').AsString);
    nj := Trim(cds_Temp.FieldByName('nj').AsString);
    lb := Trim(cds_Temp.FieldByName('lb').AsString);
    zy := Trim(cds_Temp.FieldByName('zy').AsString);
    state := Trim(cds_Temp.FieldByName('state').AsString);
    Result := True;
  finally
    cds_Temp.Close;
    cds_Temp.Free;
  end;
end;

function TJxgzlSoapDM.GetKsInfoByBmNo(const BmNo: string;out sData,sError:string): Boolean;
var
  sqlstr:string;
begin
  Result := False;
  try
    sqlstr := 'select * from ���������� where �������='+quotedstr(BmNo);
    try
      cds_Query.Close;
      cds_Query.CommandText := sqlstr;
      cds_Query.Open;
      sData := cds_Query.XMLData;
    except
      on e:Exception do
      begin
        sData := '';
        sError := e.Message;
      end;
    end;
  finally
    cds_Query.Close;
  end;
end;

function TJxgzlSoapDM.GetKsInfoBySfzh(const Sfzh: string;out sData,sError:string): Boolean;
var
  BmNo:string;
begin
  BmNo := GetKsBmNoBySfzh(Sfzh);
  if BmNo<>'' then
    Result := GetKsInfoByBmNo(BmNo,sData,sError);
end;

function TJxgzlSoapDM.GetKsXz: string;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select ������֪ from ������֪��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.GetKsBmNoBySfzh(const Sfzh: string): string;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select ������� from ���������� where ���֤��='+quotedstr(Sfzh);
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.GetUserCode: string;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select ע���� from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.GetUserInfo: string;
var
  UserName:string;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û����� from ������Ϣ��';
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      Result := UserName;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.InNetBmTime: Boolean;
var
  sqlStr:string;
begin
  sqlStr := 'select count(*) from ���ϱ���ʱ�����ñ� where (getdate() between ��ʼʱ�� and ����ʱ��) and (���籨��=1)';
  Result := RecordIsExists(sqlStr);
end;

function TJxgzlSoapDM.IntfIsOK(const sUrl, sUser, sPwd: string;
  var sError: String): Boolean;
begin
end;

function TJxgzlSoapDM.IsValidIP(const sIp: string): Boolean;
begin
  Result := True;
end;

function TJxgzlSoapDM.JwxtInfoIsOK: Boolean;
var
  sUrl,sUser,sPwd,sError:string;
  IsStarted:Boolean;
begin
  Result := GetJwxtSoapInfo(sUrl,sUser,sPwd,IsStarted);
  if (not Result) or (not IsStarted) then Exit;
  Result := JwxtInfoIsOK(sUrl,sUser,sPwd,sError);
end;

function TJxgzlSoapDM.Query_Data(const SqlText: string;var iCompressType:Integer;
  out sData: string): Integer;
    //ICompressType: -1: Auto, 0: Not Compress, 1: Compress
var
  sTempData:String;
begin
  try
    cds_Query.Active := False;
    cds_Query.CommandText := SqlText;
    cds_Query.Active := True;
    sData := cds_Query.XMLData;

    if (iCompressType=-1) and (Length(sData)>100*1024) then //�����ϵͳ�����Ƿ�ѹ���Ļ��������ݴ���100Kb�Ļ���ѹ��
      iCompressType := 1
    else
      iCompressType := 0;

    if iCompressType=1 then //ѹ������
    begin
      sTempData := VCLZip1.ZLibCompressString(sData);
      sData := EncodeString(sTempData);
    end;

  finally
    cds_Query.Active := False;
    Result := S_OK;
  end;
end;

function TJxgzlSoapDM.JwxtInfoIsOK(const sUrl, sUser, sPwd: string;var sError:String): Boolean;
begin
end;

function TJxgzlSoapDM.RecordIsExists(const sSqlStr: string): Boolean;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := ADOConnection1;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := sSqlStr;
    try
      DataSet_Temp.Open;
      Result := DataSet_Temp.Fields[0].AsInteger>0;
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Close;
    DataSet_Temp.Free;
  end;
end;

function TJxgzlSoapDM.RegIsOK: Boolean;
var
  UserName,RegCode,sMac:string;
  sqlText:String;
begin
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û�����,MAC,ע���� from ������Ϣ��';
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      sMac := DataSet_Temp.Fields[1].AsString;
      RegCode := DataSet_Temp.Fields[2].AsString;
      if sMac<>GetMACAddress then
      begin
        sMac := GetMACAddress;
        sqlText := 'update ������Ϣ�� set MAC='+quotedstr(sMac);
        ADOConnection1.Execute(SqlText);
      end;
      if RegCode<>'' then
        RegCode := DeCrypt(RegCode); //��ע������н����Ի�ԭ�û�����
      //RegCode := EnCrypt(UserName);
      //Result := (RegCode = DataSet_Temp.Fields[1].AsString) and (DataSet_Temp.Fields[1].AsString<>'');
      Result := (RegCode = UserName) and (RegCode<>'');
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Active := False;
  end;
end;

function TJxgzlSoapDM.RegUserInfo(const UserName, UserCode: string): Boolean;
var
  sqlstr:string;
begin
  with adoquery_Temp do
  begin
    Active := False;
    sql.Text := 'select �û�����,ע���� from ������Ϣ��';
    Active := True;
    if RecordCount=0 then
      sqlstr := 'Insert into ������Ϣ�� (�û�����,ע����) values('+quotedstr(UserName)+','+quotedstr(UserCode)
    else
      sqlstr := 'update ������Ϣ�� set �û�����='+quotedstr(UserName)+',ע����='+quotedstr(UserCode);

    try
      close;
      sql.Text := sqlstr;
      ExecSql;
      Result := True;//RegIsOK;
    except
      Result := False;
    end;
  end;
end;

function TJxgzlSoapDM.SetIntfInfo(const Id: Integer; const sName, sUrl, sUser,
  sPwd: string;const IsStarted:Boolean): Boolean;
var
  sqlText :string;
  sIntfId,sIntfName,sStarted:string;
begin
  sIntfId := Inttostr(Id);
  sIntfName := quotedstr(sName);
  if IsStarted then
    sStarted := '1'
  else
    sStarted := '0';

  sqlText := 'select count(*) from �ӿ����ñ� where Id='+sIntfId;
  if RecordIsExists(sqlText) then
    sqlText := 'update �ӿ����ñ� set �ӿ�����='+sIntfName+','+
                                     '�ӿڵ�ַ='+quotedstr(sUrl)+','+
                                     '��֤�û���='+quotedstr(sUser)+','+
                                     '��֤����='+quotedstr(sPwd)+','+
                                     '�Ƿ�����='+sStarted+' '+
               'where Id='+sIntfId
  else
    sqlText := 'Insert into �ӿ����ñ� (Id,�ӿ�����,�ӿڵ�ַ,��֤�û���,��֤����,�Ƿ�����) '+
               'Values('+sIntfId+','+sIntfName+','+quotedstr(sUrl)+','+quotedstr(sUser)+','+quotedstr(sPwd)+','+sStarted+')';
  Result := ExecSqlCmd(sqlText);
end;

function TJxgzlSoapDM.SetJwxtSoapInfo(const sUrl, sUser,
  sPwd: string;const IsStarted:Boolean=True): Boolean;
begin
end;

function TJxgzlSoapDM.SetKsXz(const sValue: string): Boolean;
var
  sqlstr:string;
begin
  if RecordIsExists('select count(*) from ������֪��') then
    sqlstr := 'update ������֪�� set ������֪='+quotedstr(sValue)
  else
    sqlstr := 'Insert into ������֪�� (������֪) values('+quotedstr(sValue)+')';
  Result := ExecSqlCmd(sqlstr);
end;

procedure TJxgzlSoapDM.SoapDataModuleCreate(Sender: TObject);
var
  vHost,vSa,vPwd,vDb,vMode:string;
begin
  ADOConnection1.Connected := False;
  ADOConnection1.ConnectionString := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
  //ADOConnection1.Connected := True;
end;

procedure TJxgzlSoapDM.SoapDataModuleDestroy(Sender: TObject);
begin
  ADOConnection1.Connected := False;
end;

function TJxgzlSoapDM.KsIsPaidBySfzh(const sfzh: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from �����ɷѱ� where ���֤��='+quotedstr(Sfzh)+' and �Ƿ�ɷ�=1';
  Result := RecordIsExists(sqlstr);
end;

function TJxgzlSoapDM.KsIsPaidByBmNo(const BmNo: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from �����ɷѱ� where �������='+quotedstr(BmNo)+' and �Ƿ�ɷ�=1';
  Result := RecordIsExists(sqlstr);
end;

function TJxgzlSoapDM.Update_Data(const pkField,SqlText: string; const iCompressType:Integer;
                         const sData: string; out sError:string):Boolean;
    //ICompressType: -1: Auto, 0: Not Compress, 1: Compress
var
  i:Integer;
  sTempData:string;
begin
  Result := False;
  try
    DataSet_Update.Close;
    DataSet_Update.CommandText := SqlText;

    if iCompressType=1 then
    begin
      sTempData := DecodeString(sData);
      sTempData := VCLZip1.ZLibDecompressString(sTempData);
    end else
      sTempData := sData;

    cds_Update.XMLData := sTempData;

    for i := 0 to cds_Update.FieldCount - 1 do
    begin
      cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags-[pfInWhere,pfInKey];

      if cds_Update.Fields[i].DataType in [ ftDate, ftTime, ftDateTime ] then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInWhere ]
      else if cds_Update.Fields[i].DataType = ftAutoInc then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInUpdate ];
    end;


    DataSet_Update.Open;
    with DataSet_Update.FieldByName(pkField) do //����������AdoDataSet�����ã�������ClientDataSet������
      ProviderFlags := ProviderFlags + [ pfInKey,pfInWhere ];

    try
      cds_Update.ApplyUpdates(0);
      Result := True;
    except
      on e:Exception do
      begin
        sError := e.Message;
        //Result := False;
      end;
    end;
  finally
    cds_Update.Active := False;
  end;
end;

initialization
   InvRegistry.RegisterInvokableClass(TJxgzlSoapDM, TJxgzlSoapDMCreateInstance);
   InvRegistry.RegisterInterface(TypeInfo(IJxgzlSoapDM));
end.
