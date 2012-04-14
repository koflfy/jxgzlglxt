unit uInitKsCjb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls, DB, DBClient, ComCtrls;

type
  TInitKsCjb = class(TForm)
    pnl_Title: TPanel;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Exit: TBitBtn;
    chk_Delete: TCheckBox;
    cds_1: TClientDataSet;
    cds_2: TClientDataSet;
    pnl2: TPanel;
    btn_Start: TBitBtn;
    pb1: TProgressBar;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TInitKsCjb.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TInitKsCjb.btn_StartClick(Sender: TObject);
var
  iCount :Integer;
  zkzh,kskc,str:string;
  bl:Boolean;
begin
  if chk_Delete.Checked then
    str := '�����ڳ�ʼ��֮ǰ��ճɼ���'
  else
    str := '';
  if MessageBox(Handle, PChar('���Ҫ��ʼ�������ɼ�¼���'+str+'�𣿡�'), 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if chk_Delete.Checked then
  begin
    iCount := vobj_Admin.GetRecordCount('�����ɼ���');
    if iCount>0 then
    begin
       if MessageBox(Handle,
         PChar('��ǰ�ɼ���������'+IntToStr(iCount)+'���ɼ���¼�����Ҫɾ�������𣿡�'),
         'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) =
         IDNO then
       begin
         Exit;
       end;
      dm.ExecSql('delete from �����ɼ���');
    end;
  end;

  Screen.Cursor := crHourGlass;
  try
    cds_1.XMLData := DM.OpenData('select ׼��֤��,���Կγ� from view_����ǩ����');
    cds_2.XMLData := dm.OpenData('select * from �����ɼ���');
    pb1.Max := cds_1.RecordCount;
    iCount := 0;
    while not cds_1.Eof do
    begin
      pb1.Position := cds_1.RecNo;
      Application.ProcessMessages;
      zkzh := cds_1.FieldByName('׼��֤��').AsString;
      kskc := cds_1.FieldByName('���Կγ�').AsString;
      if not cds_2.Locate('׼��֤��;���Կγ�',varArrayOf([zkzh,kskc]),[]) then
      begin
        cds_2.Append;
        cds_2.FieldByName('׼��֤��').AsString := zkzh;
        cds_2.FieldByName('���Կγ�').AsString := kskc;
        cds_2.FieldByName('�Ƿ��ύ').AsBoolean := False;
        cds_2.FieldByName('״̬').AsString := '����';
        cds_2.Post;
        Inc(iCount);
      end;
      cds_1.Next;
    end;

    bl := True;
    if DataSetNoSave(cds_2) then
      bl := dm.UpdateData('Id','select top 1 * from �����ɼ���',cds_2.Delta);

    if bl then
      MessageBox(Handle, PChar('������ɣ����С�'+IntToStr(cds_2.RecordCount)+'������¼����ʼ��������������¼'+IntToStr(iCount)+'������'), 'ϵͳ��ʾ',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TInitKsCjb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

end.
