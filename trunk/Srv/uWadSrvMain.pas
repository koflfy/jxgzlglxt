unit uWadSrvMain;

interface

uses
  SysUtils, Classes, Forms, Controls, CnAAFont, CnAACtrls, RzStatus,
  ExtCtrls, RzPanel, Menus, CoolTrayIcon, ShellAPI, 
  Windows;

type
  TWadSrvMain = class(TForm)
    albl_SysName: TCnAALabel;
    albl_Dwmc: TCnAALabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mi_DbSet: TMenuItem;
    mi_Hide: TMenuItem;
    N5: TMenuItem;
    mi_Exit: TMenuItem;
    N6: TMenuItem;
    I1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    A1: TMenuItem;
    RzStatusBar1: TRzStatusBar;
    RzImage_msg: TRzGlyphStatus;
    sp_Time: TRzStatusPane;
    RzStatusPane1: TRzStatusPane;
    PopupMenu1: TPopupMenu;
    pi_Show: TMenuItem;
    pi_ShowHint: TMenuItem;
    pi_Exit: TMenuItem;
    CoolTrayIcon1: TCoolTrayIcon;
    IIS1: TMenuItem;
    N2: TMenuItem;
    procedure mi_DbSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mi_HideClick(Sender: TObject);
    procedure pi_ShowClick(Sender: TObject);
    procedure pi_ExitClick(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure IIS1Click(Sender: TObject);
    procedure mi_ExitClick(Sender: TObject);
  private
    { Private declarations }
    function RegIsOK:Boolean;
  public
    { Public declarations }
  end;

const
  SYS_TITLE = '学员收缴费管理系统';

var
  WadSrvMain: TWadSrvMain;
  gbCanClose: Boolean;

implementation

uses Net,SockApp,uDbInfoSet,uJxgzlSoapDM;

{$R *.dfm}

procedure TWadSrvMain.CoolTrayIcon1DblClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

procedure TWadSrvMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  Resize := False;
end;

procedure TWadSrvMain.FormCreate(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('楷体')<>-1 then
  begin
    albl_SysName.Font.Name := '楷体';
    albl_Dwmc.Font.Name := '楷体';
  end;
  gbCanClose := False;
  Application.ShowMainForm := False;
  sp_Time.Caption := DateTimeToStr(Now);
  Self.Caption := Application.Title+' Ver '+Get_Version;
  CoolTrayIcon1.Hint := Application.Title;
  //albl_SysName.Caption := Self.Caption;
  if RegIsOK then
    Caption := Caption + ' [已注册版本]'
  else
    Caption := Caption + ' [未注册版本]';
end;

procedure TWadSrvMain.IIS1Click(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://xieyunc.jxstnu.edu.cn/',nil,nil,1);
end;

procedure TWadSrvMain.mi_DbSetClick(Sender: TObject);
begin
  TDbInfoSet.Create(nil).ShowModal;
end;

procedure TWadSrvMain.mi_ExitClick(Sender: TObject);
begin
  gbCanClose := True;
  Close;
end;

procedure TWadSrvMain.mi_HideClick(Sender: TObject);
begin
  CoolTrayIcon1.HideMainForm;
end;

procedure TWadSrvMain.N2Click(Sender: TObject);
begin
  //TServiceSet.Create(nil).ShowModal;
end;

procedure TWadSrvMain.pi_ExitClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('真的要退出'+Application.Title+'吗？　　'), '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    gbCanClose := True;
    Close;
  end;
end;

procedure TWadSrvMain.pi_ShowClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

function TWadSrvMain.RegIsOK: Boolean;
var
  dm:TJxgzlSoapDM;
begin
  dm := TJxgzlSoapDM.Create(nil);
  try
    Result := dm.RegIsOK;
  finally
    dm.Free;
  end;
end;

initialization
  TWebAppSockObjectFactory.Create('jxgzl')

end.
