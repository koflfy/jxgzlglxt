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
    //����������WebService�в��ܴ���MemoryStream �ڴ���
    //function UploadKsPhoto(const fn, sData:string;const MS:TMemoryStream):Boolean;stdcall;

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

    function GetWebSrvUrl:string;stdcall; //Web��������ַ���磺http://jxgzl.jxstnu.edu.cn/
    function GetUploadProcessFile:string;stdcall; //�ϴ��ű������ļ�����http·�������磺http://jxgzl.jxstnu.edu.cn/Upfile_Photo.asp
    function GetUploadVirtualDir:string;stdcall;  //�ϴ��ļ����Ŀ¼�����·�������磺UploadFiles/
    function GetKsXz:string;stdcall;    //�õ�������֪����
    function GetKsCj(const bkLb:string):string;stdcall; //�õ������ɼ������б䵥��֮��Ľ��

    function ReadHsgzLxData:string;stdcall; //�õ���������������ݱ�����
    function WriteHsgzLxData(const sData:string;out sError:string):Boolean;stdcall; //�����������������ݱ�����
    function DropView(const ViewName:string):Boolean;stdcall; //������ͼ
    function CreateView(const ViewName,sqlStr:string):Boolean;stdcall; //������ͼ
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
