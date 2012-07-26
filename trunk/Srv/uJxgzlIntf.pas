//==================================================================//
//    ���������ϲ�ѯ�ӿ�������Ԫ��
//    ����������Ϊ��ʵ�ֽ�ʦ������������ѯ�Լ��Ĺ����������õĽӿڡ�
//    �ӿ����ƣ�Ijxgzl
//    �ӿ����ã�http://url/jxgzl/jxgzlWebSrv.dll/soap/Ijxgzl
//            ���ߣ�http://url/jxgzl/jxgzlWebSrv.dll/wsdl/Ijxgzl
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
    function RegIsOK:Boolean;stdcall;//ϵͳ�Ƿ�ע��
    function SrvIsOK:Boolean;stdcall; //�������Ƿ�׼����/�Ƿ����
    //�ж�WEB Server�Ƿ�Ϊ�Ϸ����û����������IP(��WEB������IP��֤)
    function IsValidIP:Boolean;stdcall;

    //�жϷ�������ǰ�Ƿ���Խ������ϱ���������������ϱ����򷵻��ַ�����OK ������������򷵻ز������ԭ�������رա�IP����ȷ�����ڱ���ʱ���ڵȵ�
    function IsCanNetPrintZKZ:Boolean;stdcall;

    function GetXnXqList:string;stdcall;

    //ͨ��ְ���ź�ѧ��ѧ�ڻ�ȡ��������Ϣ������XML��ʽ��DataSetֵ
    function GetJxgzlInfo(const sNo,sXnxq:string;const iRecCount,iPage:Integer):string;stdcall;
    function GetJxgzlRecordCount(const sNo,sXnxq:string):Integer;stdcall;
    //�õ���ѧ��������Ϣ
    function GetJxgzlDelta(const id:string):string;stdcall;

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
