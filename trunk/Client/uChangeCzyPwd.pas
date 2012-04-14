unit uChangeCzyPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzTabs, Buttons;

type
  TChangeCzyPwd = class(TForm)
    RzPageControl1: TRzPageControl;
    btn_OK: TBitBtn;
    btn_Exit: TBitBtn;
    TabSheet1: TRzTabSheet;
    lbledt_CzyID: TLabeledEdit;
    lbledt_OldPwd: TLabeledEdit;
    lbledt_newPwd1: TLabeledEdit;
    lbledt_newPwd2: TLabeledEdit;
    lbl_New1Hint: TLabel;
    lbl_New2Hint: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbledt_newPwd1Change(Sender: TObject);
    procedure lbledt_newPwd2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChangeCzyPwd: TChangeCzyPwd;

implementation
uses uDM;
{$R *.dfm}

procedure TChangeCzyPwd.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TChangeCzyPwd.btn_OKClick(Sender: TObject);
begin
  if lbledt_newPwd1.Text<>lbledt_newPwd2.Text then
  begin
    MessageBox(Handle, '�������������벻һ�£�����������޸ģ�����',
      'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
    lbledt_newPwd1.SetFocus;
    Exit;
  end;

  try
    if vobj_Admin.ChangeCzyPwd(lbledt_CzyID.Text,lbledt_OldPwd.Text,lbledt_newPwd1.Text) then
      MessageBox(Handle, '����Ա�����޸ĳɹ������ס��������룡����',
        'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION)
    else
    begin
      MessageBox(Handle, '����Ա�����޸�ʧ�ܣ�����������޸ģ�����',
        'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
      lbledt_OldPwd.SetFocus;
    end;
  finally
    //vobj := nil;
  end;
end;

procedure TChangeCzyPwd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TChangeCzyPwd.FormCreate(Sender: TObject);
begin
  lbledt_CzyID.Text := gb_Czy_ID;
end;

procedure TChangeCzyPwd.lbledt_newPwd1Change(Sender: TObject);
begin
  if TLabeledEdit(Sender).Text<>'' then
    lbl_New1Hint.Caption := '('+IntToStr(Length(TLabeledEdit(Sender).Text))+')'
  else
    lbl_New1Hint.Caption := '(*)';
end;

procedure TChangeCzyPwd.lbledt_newPwd2Change(Sender: TObject);
begin
  if TLabeledEdit(Sender).Text<>'' then
    lbl_New2Hint.Caption := '('+IntToStr(Length(TLabeledEdit(Sender).Text))+')'
  else
    lbl_New2Hint.Caption := '(*)';
end;

end.
