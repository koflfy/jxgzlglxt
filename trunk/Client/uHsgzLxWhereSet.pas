unit uHsgzLxWhereSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, DBCtrls;

type
  THsgzLxWhereSet = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Del: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Add: TBitBtn;
    img_Hint: TImage;
    ClientDataSet2: TClientDataSet;
    DataSource2: TDataSource;
    pnl_Right: TGroupBox;
    Panel1: TPanel;
    btn_Privew: TButton;
    DBMemo1: TDBMemo;
    DBGridEh1: TDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_PrivewClick(Sender: TObject);
    procedure DBMemo1Change(Sender: TObject);
  private
    { Private declarations }
    sFilterStr:String;
    sqlStr:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  HsgzLxWhereSet: THsgzLxWhereSet;

implementation
uses uDM;
{$R *.dfm}

procedure THsgzLxWhereSet.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    ClientDataSet1.Append;
    DBGrid1.SetFocus;
  end;
end;

procedure THsgzLxWhereSet.btn_DelClick(Sender: TObject);
begin
  if ClientDataSet1.ReadOnly then Exit;
  
  if MessageBox(Handle, '���Ҫɾ���ü�¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet1.Delete;
  btn_Save.Click;
end;

procedure THsgzLxWhereSet.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure THsgzLxWhereSet.btn_PrivewClick(Sender: TObject);
begin
  //ClientDataSet2.XMLData := dm.OpenData('select ���,ѧ��,�γ̴���,�γ�����,��ʦְ����,��ʦ����,����ѧԺ from ����������� where '+DBMemo1.Text);
  ClientDataSet2.XMLData := dm.OpenData(DBMemo1.Text);
end;

procedure THsgzLxWhereSet.btn_SaveClick(Sender: TObject);
var
  sqlStr,sError:string;
begin
  if not DataSetNoSave(ClientDataSet1) then
    Exit;

  try
    //if DM.UpdateData('id',sqlStr,ClientDataSet1.Delta) then
    if vobj_Admin.WriteHsgzLxData(ClientDataSet1.XMLData,sError) then
      ClientDataSet1.MergeChangeLog
    else
      MessageBox(Handle, PAnsiChar('���ݱ���ʧ�ܣ�ԭ��Ϊ��'+sError+'��'), 'ϵͳ��ʾ', MB_OK +
        MB_ICONSTOP + MB_TOPMOST);
  finally
    //cds_Temp.Free;
  end;
end;

procedure THsgzLxWhereSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('��ʾ˳��').AsInteger := DataSet.RecordCount+1;
end;

procedure THsgzLxWhereSet.DBMemo1Change(Sender: TObject);
begin
  btn_Privew.Enabled := DBMemo1.Text<>'';
end;

procedure THsgzLxWhereSet.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure THsgzLxWhereSet.FormCreate(Sender: TObject);
begin
  OpenTable;
end;

procedure THsgzLxWhereSet.OpenTable;
var
  i: Integer;
begin
  sqlStr := 'select * from  ����������ͱ� order by ��ʾ˳��';
  ClientDataSet1.XMLData := vobj_Admin.ReadHsgzLxData;// dm.OpenData(sqlStr);
end;

procedure THsgzLxWhereSet.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
