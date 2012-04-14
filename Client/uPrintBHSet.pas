unit uPrintBHSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, pngimage;

type
  TPrintBHSet = class(TForm)
    grp1: TGroupBox;
    pnl1: TPanel;
    btn_OK: TBitBtn;
    lbl1: TLabel;
    edt_NewBH: TEdit;
    lbl2: TLabel;
    edt_Sky: TEdit;
    pnl_Title: TPanel;
    img_Title: TImage;
    img1: TImage;
    lbl_Title: TLabel;
    btn_Exit: TBitBtn;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    procedure btn_OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure edt_NewBHChange(Sender: TObject);
    procedure edt_SkyDblClick(Sender: TObject);
  private
    { Private declarations }
    Old_BH:string;
  public
    { Public declarations }
  end;

var
  PrintBHSet: TPrintBHSet;

implementation
uses uDM;
{$R *.dfm}

procedure TPrintBHSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TPrintBHSet.btn_OKClick(Sender: TObject);
begin
  if edt_NewBH.Text<>Old_BH then
    dm.SetPrintBH(edt_NewBH.Text);
  if edt_Sky.Text<>dm.GetKpyName then
    dm.SetKpyName(edt_Sky.Text);
  Close;
end;

procedure TPrintBHSet.edt_NewBHChange(Sender: TObject);
begin
  lbl6.Caption := '('+IntToStr(Length(TEdit(Sender).Text))+')';
end;

procedure TPrintBHSet.edt_SkyDblClick(Sender: TObject);
begin
  TEdit(Sender).Text := gb_Czy_Name;
  if gb_Czy_Name<>dm.GetSkyName then
    dm.SetSkyName(gb_Czy_Name);
  if gb_Czy_Name<>dm.GetKpyName then
    dm.SetKpyName(gb_Czy_Name);
end;

procedure TPrintBHSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintBHSet.FormShow(Sender: TObject);
begin
  Old_BH := dm.GetPrintBH;
  edt_NewBH.Text := Old_BH;
  //edt_Sky.Text := dm.GetSkyName;
  edt_Sky.Text := dm.GetKpyName; //开票员
  if Old_BH='' then
  begin
    Application.MessageBox('收费发票的起始编号为空，请设置本机的收费发票的起始编号！　　',
      '系统提示', MB_OK + MB_ICONWARNING + MB_TOPMOST);
    edt_NewBH.SetFocus;
  end else
    btn_Exit.SetFocus;
end;

end.
