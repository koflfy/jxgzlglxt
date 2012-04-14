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
      lbl_RegMsg.Caption := '本系统已注册';
       MessageBox(Handle, '系统注册成功！　　', '系统提示', MB_OK +
         MB_ICONINFORMATION);
    end
    else
    begin
      lbl_RegMsg.Caption := '本系统未注册';
       MessageBox(Handle, '注册码错误，注册失败！请检查后重试！　　', '注册失败',
         MB_OK + MB_ICONSTOP);
    end;

  except
    MessageBox(Handle, '数据库服务器连接失败！请检查后重试！　　', '系统提示',
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
    qry_Temp.SQL.Text := 'select 用户名称,注册码 from 机主信息表';
    qry_Temp.Open;
    UserName := edt_User.Text;
    UserCode := edt_Code.Text;
    if RegIsOK(UserName,UserCode) then
      lbl_RegMsg.Caption := '本系统已注册'
    else
      lbl_RegMsg.Caption := '本系统未注册';
  except;
    lbl_RegMsg.Caption := '本系统未注册';
  end;
end;

function TSysRegBySrv.RegIsOK(const UserName, UserCode: string): Boolean;
begin
  Result := UserCode = EnCrypt(UserName);
end;

end.
