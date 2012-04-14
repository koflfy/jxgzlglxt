unit uSysRegBySrv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzTabs, DB, DBClient, Mask, DBCtrls,
  DBCtrlsEh, ADODB;

type
  TSysRegBySrv = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    Label1: TLabel;
    lbl_RegMsg: TLabel;
    btn_Reg: TBitBtn;
    btn_Exit: TBitBtn;
    edt_Code: TDBEditEh;
    Label11: TLabel;
    edt_User: TDBEditEh;
    Label2: TLabel;
    DataSource1: TDataSource;
    qry_Temp: TADOQuery;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_RegClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function RegIsOK(const UserName,UserCode:string):Boolean;
  public
    { Public declarations }
  end;

implementation
uses uDbConnect,PwdFunUnit;
{$R *.dfm}

procedure TSysRegBySrv.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSysRegBySrv.btn_RegClick(Sender: TObject);
begin
  try
    if qry_Temp.State in [dsInsert,dsEdit] then
       qry_Temp.Post;

    if RegIsOK(edt_User.Text,edt_Code.Text) then
    begin
      lbl_RegMsg.Caption := '��ϵͳ��ע��';
       MessageBox(Handle, 'ϵͳע��ɹ�������', 'ϵͳ��ʾ', MB_OK +
         MB_ICONINFORMATION);
    end
    else
    begin
      lbl_RegMsg.Caption := '��ϵͳδע��';
       MessageBox(Handle, 'ע�������ע��ʧ�ܣ���������ԣ�����', 'ע��ʧ��',
         MB_OK + MB_ICONSTOP);
    end;

  except
    MessageBox(Handle, '���ݿ����������ʧ�ܣ���������ԣ�����', 'ϵͳ��ʾ',
         MB_OK + MB_ICONSTOP);
  end;
end;

procedure TSysRegBySrv.FormActivate(Sender: TObject);
begin
  edt_Code.SelLength := 0;
  edt_Code.SelStart := Length(edt_Code.Text);
end;

procedure TSysRegBySrv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSysRegBySrv.FormCreate(Sender: TObject);
var
  UserName,UserCode:string;
begin
  try
    qry_Temp.close;
    qry_Temp.ConnectionString := GetConnectString;
    qry_Temp.SQL.Text := 'select �û�����,ע���� from ������Ϣ��';
    qry_Temp.Open;
    UserName := edt_User.Text;
    UserCode := edt_Code.Text;
    if RegIsOK(UserName,UserCode) then
      lbl_RegMsg.Caption := '��ϵͳ��ע��'
    else
      lbl_RegMsg.Caption := '��ϵͳδע��';
  except;
    lbl_RegMsg.Caption := '��ϵͳδע��';
  end;
end;

function TSysRegBySrv.RegIsOK(const UserName, UserCode: string): Boolean;
begin
  Result := UserCode = EnCrypt(UserName);
end;

end.
