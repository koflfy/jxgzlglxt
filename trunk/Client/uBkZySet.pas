unit uBkZySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh;

type
  TBkZySet = class(TForm)
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
    procedure ClientDataSet1BeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    sFilterStr:String;
    sqlStr:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  BkZySet: TBkZySet;

implementation
uses uDM;
{$R *.dfm}

procedure TBkZySet.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    ClientDataSet1.Append;
    DBGrid1.SetFocus;
  end;
end;

procedure TBkZySet.btn_DelClick(Sender: TObject);
begin
  if ClientDataSet1.ReadOnly then Exit;
  
  if MessageBox(Handle, '真的要删除该记录吗？　　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet1.Delete;
  btn_Save.Click;
end;

procedure TBkZySet.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TBkZySet.btn_RefreshClick(Sender: TObject);
begin
  cds_ZyLb.DisableControls;
  try
    cds_ZyLb.XMLData := dm.OpenData('select * from 专业类别表 order by 显示顺序');
  finally
    cds_ZyLb.EnableControls;
  end;
end;

procedure TBkZySet.btn_SaveClick(Sender: TObject);
begin
  if not DataSetNoSave(ClientDataSet1) then
    Exit;

  try
    if DM.UpdateData('id',sqlStr,ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
  finally
    //cds_Temp.Free;
  end;
end;

procedure TBkZySet.ClientDataSet1BeforeClose(DataSet: TDataSet);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      btn_Save.Click;
    end;
end;

procedure TBkZySet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  if not cds_ZyLb.FieldByName('类别').IsNull then
    DataSet.FieldByName('类别').AsString := cds_ZyLb.FieldByName('类别').AsString;
  DataSet.FieldByName('显示顺序').AsInteger := DataSet.RecordCount+1;
end;

procedure TBkZySet.ds_ZyLbDataChange(Sender: TObject; Field: TField);
begin
  btn_Add.Enabled := cds_ZyLb.FieldByName('类别').AsString<>'';
  OpenTable;
end;

procedure TBkZySet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;

  if DataSetNoSave(ClientDataSet1) then
     if MessageBox(Handle, '数据已修改但未保存，要保存吗？　　', '系统提示',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;

  Action := caFree;
end;

procedure TBkZySet.FormShow(Sender: TObject);
begin
  btn_Refresh.Click;
end;

procedure TBkZySet.OpenTable;
begin
  sqlStr := 'select * from 招生专业表 where 类别='+quotedstr(cds_ZyLb.FieldByName('类别').AsString)+' order by 显示顺序';

  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

procedure TBkZySet.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
