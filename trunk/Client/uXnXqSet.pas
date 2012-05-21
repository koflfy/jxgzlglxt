unit uXnXqSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, pngimage, ExtCtrls, Mask, DBCtrls,
  DBCtrlsEh;

type
  TXnXqSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Id: TAutoIncField;
    ClientDataSet1StringField: TStringField;
    ClientDataSet1StringField2: TStringField;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_Xn: TDBEditEh;
    Label2: TLabel;
    cbb_Xq: TDBComboBoxEh;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
    sqlStr:string;
    procedure OpenTable;
  public
    { Public declarations }
  end;


implementation
uses uDM,uMain;
{$R *.dfm}

procedure TXnXqSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXnXqSet.btn_SaveClick(Sender: TObject);
begin
  if not DataSetNoSave(ClientDataSet1) then
    Exit;

  try
    if DM.UpdateData('id',sqlStr,ClientDataSet1.Delta) then
    begin
      ClientDataSet1.MergeChangeLog;
      dm.GetCurrentXnXq;
      Main.Status_CurXnXq.Caption := gb_Cur_Xn+'ѧ���'+gb_Cur_Xq+'ѧ��';
    end;
  finally
    //cds_Temp.Free;
  end;
end;

procedure TXnXqSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;

  if DataSetNoSave(ClientDataSet1) then
     if MessageBox(Handle, '�������޸ĵ�δ���棬Ҫ�����𣿡���', 'ϵͳ��ʾ',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;

  Action := caFree;
end;

procedure TXnXqSet.FormCreate(Sender: TObject);
begin
  OpenTable;
end;

procedure TXnXqSet.OpenTable;
begin
  sqlStr := 'select * from ��ǰѧ��ѧ�ڱ�';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

end.
