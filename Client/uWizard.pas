unit uWizard;
//原来的颜色值：$00BEE9EB
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Net,
  CnAAFont, CnAACtrls, UnitASButtons, RzGroupBar,
  StdCtrls, pngimage;

type
  TWizard = class(TForm)
    Image1: TImage;
    pnl_1: TPanel;
    btn_1: TASActiveButton;
    btn_2: TASActiveButton;
    btn_CkEdit: TASActiveButton;
    btn_Kccx: TASActiveButton;
    btn_4: TASActiveButton;
    btn_3: TASActiveButton;
    albl_UserInfo: TCnAALabel;
    lbl_Title: TLabel;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    Group_Left: TRzGroup;
    RzGroup3: TRzGroup;
    lbl_ver: TCnAALabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Wizard: TWizard;

implementation
uses uMain,uDM;
{$R *.dfm}

procedure TWizard.FormActivate(Sender: TObject);
begin
  if vobj_Admin.RegIsOK then
  begin
    albl_UserInfo.Font.Color := clBlue;//clLime;
    albl_UserInfo.Caption := Format('%26s',['授权给:'+vobj_Admin.GetUserInfo]);
  end else
  begin
    albl_UserInfo.Font.Color := clRed;
    albl_UserInfo.Caption := '系统未注册！请尽快注册！';
  end;
end;

procedure TWizard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Main.act_Win_Wizard.Update;
  Main.act_Win_Wizard.Checked := False;
end;

procedure TWizard.FormCreate(Sender: TObject);
begin
  Self.Top := 1;
  Self.Left := 1;
  lbl_ver.Caption := 'Ver: '+Get_Version;
end;

end.
