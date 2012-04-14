unit uWebMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxpngimage, ExtCtrls, StdCtrls, Mask, RzEdit, RzBtnEdt, Buttons, pngimage;

type
  TWebMain = class(TForm)
    grp1: TGroupBox;
    btn_Install: TBitBtn;
    btn_Close: TBitBtn;
    edt_LocalDir: TRzButtonEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt_VirualDir: TRzEdit;
    img1: TImage;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_LocalDirButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebMain: TWebMain;

implementation
uses uIIS;
{$R *.dfm}

procedure TWebMain.btn_CloseClick(Sender: TObject);
begin
  Close;
end;


procedure TWebMain.edt_LocalDirButtonClick(Sender: TObject);
begin
  edt_LocalDir.Text := 'd:\NetPay_Web';
end;

procedure TWebMain.FormCreate(Sender: TObject);
begin
  if ParamCount=3 then
  begin
    edt_LocalDir.Text := ParamStr(1);
    edt_VirualDir.Text := ParamStr(2);
    edt_LocalDir.Enabled := False;
    edt_VirualDir.Enabled := False;
  end;
end;

end.
