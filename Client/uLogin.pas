unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBClient, ExtCtrls, auAutoUpgrader,
  CnAAFont, CnAACtrls, auHTTP, jpeg, pngimage, frxpngimage;

type
  TLogin = class(TForm)
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    ClientDataSet1: TClientDataSet;
    Edit1: TComboBox;
    Edit2: TEdit;
    albl_UserPwd: TCnAALabel;
    Bevel1: TBevel;
    albl_Hint: TCnAALabel;
    Panel1: TPanel;
    Image1: TImage;
    btn_Test: TSpeedButton;
    lbl_ver: TCnAALabel;
    auAutoUpgrader1: TauAutoUpgrader;
    img1: TImage;
    albl_UserName: TCnAALabel;
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iCount : Integer;
    function ConnectAppSrvIsOK:Boolean;
    procedure GetUserList;
    procedure SaveUserList;
  public
    { Public declarations }
  end;

var
  Login: TLogin;

implementation
uses uDM,uConnSet,Net,IniFiles;

{$R *.dfm}

function TLogin.ConnectAppSrvIsOK:Boolean;
begin
  Result := AppSrvIsOK;
  if not Result then
  begin
    MessageBox(Application.Handle,PChar('应用服务器连接失败！　'),pchar('服务器或网络连接失败'),MB_OK+MB_ICONERROR);
  end;
end;

procedure TLogin.btn_OKClick(Sender: TObject);
begin
  if not ConnectAppSrvIsOK then  //连接服务器失败
     Exit;
     
  try
    while iCount<=3 do
    begin
      inc(iCount);
      //=============考生是否合法==============//
      if vobj_Admin.CzyLogin(Edit1.Text,Edit2.Text,Get_Version) = False then
      begin
        gbIsOK := false;
        Application.MessageBox(pchar('操作员编号或密码错误！请核对后重新输入！　　'),'登录失败',MB_OK+MB_ICONERROR);
        Edit2.SetFocus;
        Exit;
      end
      else
      begin
        gb_Czy_ID := Edit1.Text;
        gb_Czy_NAME := vobj_Admin.GetCzyName(gb_Czy_ID);
        gb_Czy_Level := vobj_Admin.GetCzyLevel(gb_Czy_ID);
        gbIsOK := true;
        SaveUserList;
        Break;
      end;
    end; //end while ....
  finally
    if gbIsOK or (iCount>3) then
      Self.Close;
    //vobj := nil;
  end;
end;

procedure TLogin.btn_TestClick(Sender: TObject);
begin
  with TConnSet.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
end;

procedure TLogin.FormCreate(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('楷体')<>-1 then
  begin
    albl_Hint.Font.Name := '楷体';
    albl_UserName.Font.Name := '楷体';
    albl_UserPwd.Font.Name := '楷体';
  end;

  Self.Caption := Application.Title+'登录';
  gbIsOK := False;
  lbl_ver.Caption := 'Ver: '+Get_Version;
  iCount := 1;

  GetUserList;

  if not vobj_Admin.RegIsOK then //没有注册的话，就不会自动升级
    Exit;
    
  with Self do
  begin
    auAutoUpgrader1.AutoCheck := False;
    auAutoUpgrader1.VersionNumber := Get_Version;
    auAutoUpgrader1.InfoFileURL := vobj_Admin.GetClientAutoUpdateUrl;
    auAutoUpgrader1.ShowMessages := [mAskUpgrade];
    auAutoUpgrader1.CheckUpdate;
  end;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  if Edit1.Text='' then
    Edit1.SetFocus
  else
    Edit2.SetFocus;
end;

procedure TLogin.GetUserList;
var
  fn,str:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    str := ReadString('LoginSet','UserList','');
    Edit1.Items.Delimiter := '|';
    Edit1.Items.StrictDelimiter := True;
    Edit1.Items.DelimitedText := str;
    Edit1.Text := ReadString('LoginSet','LastUser','');
  end;
end;

procedure TLogin.SaveUserList;
var
  fn,str:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  try
    if Edit1.Items.IndexOf(Edit1.Text)=-1 then
      Edit1.Items.Add(Edit1.Text);

    Edit1.Items.Delimiter := '|';
    Edit1.Items.StrictDelimiter := True;
    str := Edit1.Items.DelimitedText;
    WriteString('LoginSet','UserList',str);
    WriteString('LoginSet','LastUser',Edit1.Text);
  finally
    Free;
  end;
end;

procedure TLogin.auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
begin
  gbIsOK := False;
  gbCanClose := True;
  Close;
end;

procedure TLogin.btn_ExitClick(Sender: TObject);
begin
  gbIsOK := false;
  Close;
end;

procedure TLogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLogin.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     Edit2.SetFocus;
end;

procedure TLogin.Edit2Change(Sender: TObject);
begin
  btn_OK.Enabled := (Edit1.Text<>'') and (Edit2.Text<>'');
end;

procedure TLogin.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13  then
  begin
    if btn_OK.CanFocus then
       btn_OK.SetFocus;
    btn_OK.Click;
  end;
end;

procedure TLogin.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btn_OK.SetFocus;
end;

procedure TLogin.Edit1Change(Sender: TObject);
begin
  btn_OK.Enabled := (Edit1.Text<>'') and (Edit2.Text<>'');
end;

end.
