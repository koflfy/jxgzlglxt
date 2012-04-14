unit uIIS;

{=======================================================
Unit Name: uIIS
Comment: ��IIS���пؼ�һ�麯������Ҫ��WebSite����Ϣ�Ļ�ȡ��ֹͣ����������ͣ��
         ����Ŀ¼���½����޸ġ�ɾ�����Ƿ���ڵ��жϣ�IIS��ֹͣ����������ͣ��
         ����ִ������ĺ���ִ�в��ɹ�ʱ��������ʾ�Ի��򣬶�ִ�гɹ�ʱ��Ӧ��
         ��������߾����Ƿ����ִ�гɹ�����ʾ
Author: xieyunc http://xieyunc.jxstnu.edu.cn/
Date: 2008.10.31
========================================================}
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj,ShellAPI;

  function GetFirstWebSite:String;
  function GetWebSiteList(slWebSiteList:TStrings):Integer;
  function GetWebSitePath(const iWebSiteIndex:Integer=1):string;
  function GetWebSiteIP(const iWebSiteIndex:Integer=1):string;
  function VirtualDirIsExists(const strVirtualDir:string;
                              const iWebSiteIndex:Integer=1):Boolean;

  function CreateVirtualDir(const strVirtualDir,strDir,AppName:string;
                            const iWebSiteIndex:Integer=1;const bAllowExec:Boolean=True):Boolean;
  function DeleteVirtualDir(const strVirtualDir: string;
                            const iWebSiteIndex:Integer=1): Boolean;
  function DeleteVirtualDirApp(const strVirtualDir: string;
                               const iWebSiteIndex:Integer=1): Boolean;

  function StopWebServer(const iWebSiteIndex:Integer=1):Boolean;
  function StartWebServer(const iWebSiteIndex:Integer=1):Boolean;
  function PauseWebServer(const iWebSiteIndex:Integer=1):Boolean;
  //��εõ�WEBվ�������״̬�� 2������,4��ֹͣ,6����ͣ
  function GetWebServerState(const iWebSiteIndex:Integer=1):Integer;

  function ControlIIS(const strAction:string='restart'):Boolean;
                            //����  /restart   ֹͣ����������INTERNET����
                            //      /start     ��������INTERNET   ����
                            //      /stop      ֹͣ����INTERNET����
                            //      /reboot    ��������
                            //      /Status    ��ʾ����INTERNET����״̬�ȵ�

implementation

function GetFirstWebSite:String;
var
  WebSite, WebServer: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    //iCount�õ��ڼ���վ�����Ϣ
    WebServer := WebSite.GetObject('IIsWebServer', '1');//��һ��Web Site
    Result :=  WebServer.ServerComment;
  except
    Result := '';
  end;
end;

function GetWebSiteList(slWebSiteList:TStrings):Integer;
var
  WebSite, WebServer: Variant;
  iCount: Integer;
begin
  Result := 0;
  iCount :=1;

  slWebSiteList.Clear;
  while True do
  begin
    try
      WebSite :=CreateOLEObject('IISNamespace');
      WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
      //iCount�õ��ڼ���վ�����Ϣ
      WebServer := WebSite.GetObject('IIsWebServer', InttoStr(iCount));
      slWebSiteList.Add(WebServer.ServerComment);
      Result := iCount;
      Inc(iCount);
    except
      Break;
    end;
  end;
end;

function GetWebSitePath(const iWebSiteIndex:Integer=1):string;
var
  WebSite, WebServer, WebRoot: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    Result := WebRoot.Path; //����ǵ�ַ,C\Inetpub\wwwroot ��D:\Inetpub\wwwroot
  except
    Result := '';
  end;
end;

function GetWebSiteIP(const iWebSiteIndex:Integer=1):string;
var
  WebSite, WebServer: Variant;
  ar: array of variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    ar :=    WebServer.ServerBindings;   //��IIS����վ��󶨵�IP���˿ڡ�������ֵ��������
    Result := ar[0];
   except
   end;
end;

function VirtualDirIsExists(const strVirtualDir:string;
                            const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer, WebRoot, VDir: Variant;
begin
  Result := False;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    vdir := WebRoot.GetObject('IIsWebVirtualDir', strVirtualDir);
    Result := True;
  except
    on e:Exception do
    begin
      //���������������ڴ�����Ŀ¼;
      //MessageBox(0, '����Ŀ¼�����ڣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
      //ShowMessage(e.Message);
      Result := False;
    end;
  end;
end;

//���ɾ������Ŀ¼[/color]
function DeleteVirtualDir(const strVirtualDir: string;
                          const iWebSiteIndex:Integer=1): Boolean;
var
  WebSite, WebServer, WebRoot: Variant;
begin
  Result := True;
  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    WebRoot.Delete('IIsWebVirtualDir',strVirtualDir);
    //MessageBox(0, '����Ŀ¼ɾ���ɹ�������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
  except
    MessageBox(0, '����Ŀ¼ɾ��ʧ�ܣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//��δ��� IIS ����Ŀ¼��[/color]
function CreateVirtualDir(const strVirtualDir,strDir,AppName:string;
                          const iWebSiteIndex:Integer=1;const bAllowExec:Boolean=True):Boolean;
var
  WebSite, WebServer, WebRoot, VDir: Variant;
begin
  if VirtualDirIsExists(strVirtualDir,iWebSiteIndex) then
    DeleteVirtualDir(strVirtualDir,iWebSiteIndex);
    
  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebServer.SetInfo;
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    VDir := WebRoot.Create('IIsWebVirtualDir', strVirtualDir);
    //����Ŀ¼Ȩ������
    VDir.AccessRead := True;   //��ȡ
    VDir.AccessWrite := False;  //д��
    VDir.AccessScript := True;   //���ű�
    VDir.AccessExecute := bAllowExec;  //True //�ű��Ϳ�ִ���ļ�
    VDir.EnableDirBrowsing := False; //Ŀ¼���
    VDir.Path := strDir;
    VDir.AppCreate(True);  //���û�����Ļ�,����Ŀ¼��Ҫ��Ϊ���ֹ�����Ӧ�ó�����
    VDir.AppFriendlyName :=AppName; //Ӧ�ó�����
    VDir.SetInfo;
    //MessageBox(0,'����Ŀ¼�����ɹ�������','ϵͳ��ʾ', MB_OK +MB_ICONINFORMATION);
    Result := True;
  except
    MessageBox(0, '����Ŀ¼����ʧ�ܣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;
//������Ŀ¼�����ԣ�
//����������Ϊʲôǰ��Ĵ�������Ŀ¼������ִ��Ȩ�޶����ޣ�����һ���Լ�д�Σ�ȷʵ��һЩ����û�����ã�������һЩ�������Թ��ο�
{
  VDir.AccessRead := True;   //��ȡ
  VDir.AccessWrite := True;  //д��
  VDir.AccessExecute := True;  //�ű��Ϳ�ִ���ļ�
  VDir.AccessScript := True;   //���ű�
  VDir.EnableDirBrowsing := True; //Ŀ¼���
  VDir.Path := 'F:&#92;VariantTest'; //·��
  VDir.AppCreate(True);
  VDir.AppFriendlyName :='VariantTest'; //Ӧ�ó�����
}

//���ɾ������Ŀ¼Ӧ�ó�����[/color]
function DeleteVirtualDirApp(const strVirtualDir: string;
                             const iWebSiteIndex:Integer=1): Boolean;
var
  WebSite, WebServer, WebRoot,vdir: Variant;
begin
  Result := True;
  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    vdir :=WebRoot.GetObject('IIsWebVirtualDir', strVirtualDir);
    vdir.AppDelete;
    vdir.SetInfo;
    //MessageBox(0, '����Ŀ¼Ӧ�ó�������ɾ���ɹ�������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
  except
    MessageBox(0, '����Ŀ¼Ӧ�ó�������ɾ��ʧ�ܣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//���ͨ���������Ĭ��WEBվ�������,����״̬2������,4��ֹͣ,6����ͣ[/color]
//ֹͣWEBվ��
function StopWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(WebServer.ServerState)='2' then
    begin
      WebServer.Stop;
      //MessageBox(Application.Handle, 'Webվ�������ֹͣ������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Webվ�����ֹͣʧ�ܣ������ԣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//����WEBվ��
function StartWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(webserver.ServerState) ='4' then
    begin
      WebServer.Start;
      //MessageBox(0, 'Webվ�����������������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Webվ������ʧ�ܣ������ԣ�����', 'ϵͳ��ʾ', MB_OK +
      MB_ICONSTOP);
    Result := False;
  end;
end;

//��ͣWEBվ��
function PauseWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(WebServer.ServerState) ='2' then
    begin
      WebServer.Pause;
      //MessageBox(Application.Handle, 'Webվ������ͣ������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Webվ����ͣʧ�ܣ������ԣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//��εõ�WEBվ�������״̬�� 2������,4��ֹͣ,6����ͣ
function GetWebServerState(const iWebSiteIndex:Integer=1):Integer;
var
  WebSite, WebServer: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    Result := WebServer.ServerState;
  except
    MessageBox(0, '��ȡWebվ�����״̬ʧ�ܣ������ԣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := -1;
  end;
end;

//Q: �������IIS  A:��IISRESET /? ����
//����  /restart   ֹͣ����������INTERNET����
//      /start     ��������INTERNET   ����
//      /stop      ֹͣ����INTERNET����
//      /reboot    ��������
//      /Status    ��ʾ����INTERNET����״̬�ȵ�
function ControlIIS(const strAction:string='restart'):Boolean;
var
  sCmd:string;
begin
  if strAction[1]<>'/' then
    sCmd := '/'+strAction
  else
    sCmd := strAction;
  try
    //WinExec(pchar('iisReset'+sCmd),SW_HIDE); //��WinExecִ��ʱ����������
    //WinExec(pchar('iisReset'+sCmd),SW_SHOW); //��WinExecִ��ʱ����������
    ShellExecute(Application.Handle,'open','IISReset',PChar(sCmd),nil,SW_Hide);
    Result := True;
    //MessageBox(Application.Handle, '������ɣ�����ִ�гɹ�������', 'ϵͳ��ʾ', MB_OK +
    //    MB_ICONINFORMATION);
  except
    MessageBox(0, 'IIS��������ִ��ʧ�ܣ������ԣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;


end.
