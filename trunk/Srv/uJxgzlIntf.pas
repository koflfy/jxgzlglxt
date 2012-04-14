//==================================================================//
//    ���ϱ����ӿ�������Ԫ��
//    ����������Ϊ��ʵ�ֿ��������������ɷѶ����õĽӿڡ�
//    �ӿ����ƣ�IZsbBm
//    �ӿ����ã�http://url/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm
//            ���ߣ�http://url/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm
//==================================================================//
{ Invokable interface IZsbBmSrv }

unit uJxgzlIntf;

interface

uses InvokeRegistry, Types, SOAPHTTPClient;

type

  { Invokable interfaces must derive from IInvokable }
  IZsbBm = interface(IInvokable)
  ['{FDC1B1DE-71B9-4064-9A4E-D2AA07E02A72}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
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
    function GetKsXz:string;stdcall;    //������֪

    function KsIsExistsByUserName(const UserName:string):Boolean;stdcall;//ͨ����������жϿ����Ƿ����
    function KsIsExistsBySfzh(const sfzh:string):Boolean;stdcall;//ͨ�����֤���жϿ����Ƿ����

    function KsLoginByUserName(const UserName,pwd:string):Boolean; stdcall;//���뱨����ź�������֤���е�¼

    function GetBmNo: string;stdcall; //�õ�һ���������

    //ͨ��������ȡ�����ı�����ţ�����string����ֵ
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

function GetIZsbBm(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IZsbBm;

implementation

function GetIZsbBm(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IZsbBm;
const
  defWSDL = 'http://localhost/ZsbBm/ZsbBmWebSrv.dll/wsdl/IZsbBm';
  defURL  = 'http://localhost/ZsbBm/ZsbBmWebSrv.dll/soap/IZsbBm';
  defSvc  = 'IZsbBmservice';
  defPrt  = 'IZsbBmPort';
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
    Result := (RIO as IZsbBm);
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
  InvRegistry.RegisterInterface(TypeInfo(IZsbBm));

end.
