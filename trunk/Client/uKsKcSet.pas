unit uKsKcSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh;

type
  TKsKcSet = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Del: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Add: TBitBtn;
    DBGridEh1: TDBGridEh;
    ds_ZyLb: TDataSource;
    cds_ZyLb: TClientDataSet;
    btn_Refresh: TBitBtn;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ds_ZyLbDataChange(Sender: TObject; Field: TField);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    sFilterStr:String;
    sqlStr:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  KsKcSet: TKsKcSet;

implementation
uses uDM;
{$R *.dfm}

procedure TKsKcSet.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    ClientDataSet1.Append;
    DBGrid1.SetFocus;
  end;
end;

procedure TKsKcSet.btn_DelClick(Sender: TObject);
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

procedure TKsKcSet.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TKsKcSet.btn_RefreshClick(Sender: TObject);
begin
  cds_ZyLb.DisableControls;
  try
    cds_ZyLb.XMLData := dm.OpenData('select * from רҵ���� order by ��ʾ˳��');
  finally
    cds_ZyLb.EnableControls;
  end;
end;

procedure TKsKcSet.btn_SaveClick(Sender: TObject);
begin
  if not DataSetNoSave(ClientDataSet1) then
    Exit;

  try
    if DM.UpdateData('id',sqlStr,ClientDataSet1.Delta,False) then
      ClientDataSet1.MergeChangeLog;
  finally
    //cds_Temp.Free;
  end;
end;

procedure TKsKcSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  if not cds_ZyLb.FieldByName('���').IsNull then
    DataSet.FieldByName('���').AsString := cds_ZyLb.FieldByName('���').AsString;
  DataSet.FieldByName('��ʾ˳��').AsInteger := DataSet.RecordCount+1;
end;

procedure TKsKcSet.ds_ZyLbDataChange(Sender: TObject; Field: TField);
begin
  if Self.Showing then
    btn_Save.Click;
    
  btn_Add.Enabled := cds_ZyLb.FieldByName('���').AsString<>'';
  OpenTable;
end;

procedure TKsKcSet.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TKsKcSet.FormShow(Sender: TObject);
begin
  btn_Refresh.Click;
end;

procedure TKsKcSet.OpenTable;
begin
  sqlStr := 'select * from ���Կγ̱� where ���='+quotedstr(cds_ZyLb.FieldByName('���').AsString)+'order by ��ʾ˳��';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

procedure TKsKcSet.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
