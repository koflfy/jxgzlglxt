unit uABOUT;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, CnAAFont, CnAACtrls,ShellAPI, dxGDIPlusClasses;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    btn_Reg: TButton;
    albl_Title: TCnAALabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SrvCode: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_RegClick(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses Net,uDM;
{$R *.dfm}

procedure TAboutBox.btn_RegClick(Sender: TObject);
var
  fn :string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SysReg.exe';
  if FileExists(fn) then
  begin
    //ShellExecute(Application.Handle,'open',PChar(fn),nil,nil,SW_SHOW)
    RunAndWait(fn,SW_SHOW);
    //Self.Close;
  end else
    MessageBox(Handle, 'ϵͳע�Ṥ�ߣ�SysReg.exe δ�ҵ�������', 'ϵͳ��ʾ',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('����')<>-1 then
    albl_Title.Font.Name := '����';
    
  if ParamCount>0 then
    Version.Caption := 'Version '+ParamStr(1)
  else
    Version.Caption := 'Version '+Get_Version;

  Screen.Cursor := crHourGlass;
  try
    Comments.Caption := vobj_Admin.GetUserInfo;
    SrvCode.Caption := vobj_Admin.GetMacInfo;
    if vobj_Admin.RegIsOK then
      Comments.Caption := vobj_Admin.GetUserInfo+'[��ע��汾]'
    else
      Comments.Caption := vobj_Admin.GetUserInfo+'[δע��汾]'
  finally
    //vobj := nil;
    Screen.Cursor := crDefault;
  end;

end;

procedure TAboutBox.Label2Click(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(TLabel(Sender).Caption),nil,nil,SW_SHOW);
end;

procedure TAboutBox.Label2MouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TAboutBox.Label2MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := [];
end;

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Close;
end;

end.
 
