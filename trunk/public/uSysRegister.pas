unit uSysRegister;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzTabs, DB, DBClient, Mask, DBCtrls,
  DBCtrlsEh;

type
  TSysRegister = class(TForm)
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
    ClientDataSet1: TClientDataSet;
    ClientDataSet1WideStringField: TWideStringField;
    ClientDataSet1WideStringField2: TWideStringField;
    ClientDataSet1WideStringField3: TWideStringField;
    ClientDataSet1WideStringField4: TWideStringField;
    ClientDataSet1WideStringField5: TWideStringField;
    ClientDataSet1WideStringField6: TWideStringField;
    ClientDataSet1WideStringField7: TWideStringField;
    ClientDataSet1WideStringField8: TWideStringField;
    ClientDataSet1WideStringField9: TWideStringField;
    ClientDataSet1WideStringField10: TWideStringField;
    ClientDataSet1WideStringField11: TWideStringField;
    DataSource1: TDataSource;
    edt_SrvCode: TDBEditEh;
    Label3: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_RegClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    function RegUserInfo(const UserName,UserCode:string):Boolean;
  public
    { Public declarations }
  end;

var
  SysRegister: TSysRegister;

implementation
uses uDM;
{$R *.dfm}

procedure TSysRegister.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSysRegister.btn_RegClick(Sender: TObject);
begin
  try
    RegUserInfo(edt_User.Text,edt_Code.Text);

    if vobj_Admin.RegIsOK then
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

  finally
    //vobj := nil;
  end;
end;

procedure TSysRegister.FormActivate(Sender: TObject);
begin
  edt_Code.SelLength := 0;
  edt_Code.SelStart := Length(edt_Code.Text);
end;

procedure TSysRegister.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSysRegister.FormCreate(Sender: TObject);
begin
  try
    edt_User.Text := vobj_Admin.GetUserInfo;
    edt_SrvCode.Text := vobj_Admin.GetMacInfo;
    edt_Code.Text := vobj_Admin.GetUserCode;
    if vobj_Admin.RegIsOK then
      lbl_RegMsg.Caption := '��ϵͳ��ע��'
    else
      lbl_RegMsg.Caption := '��ϵͳδע��';

  finally
    //vobj := nil;
  end;
end;

function TSysRegister.RegUserInfo(const UserName, UserCode: string): Boolean;
begin
  try
    Result := vobj_Admin.RegUserInfo(UserName,UserCode);
    if Result then
        Result :=  vobj_Admin.RegIsOK;
  finally
    //vobj := nil;
  end;
end;

end.
