unit uSchoolSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh;

type
  TSchoolSet = class(TForm)
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
    grp_Sf: TGroupBox;
    cbb_Sf: TDBComboBoxEh;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure cbb_SfChange(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    sqlStr:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  SchoolSet: TSchoolSet;

implementation
uses uDM;
{$R *.dfm}

procedure TSchoolSet.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    ClientDataSet1.Append;
    DBGrid1.SetFocus;
  end;
end;

procedure TSchoolSet.btn_DelClick(Sender: TObject);
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

procedure TSchoolSet.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TSchoolSet.btn_SaveClick(Sender: TObject);
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

procedure TSchoolSet.cbb_SfChange(Sender: TObject);
begin
  OpenTable;
  if Self.Showing then
    DBGrid1.SetFocus;
end;

procedure TSchoolSet.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('省份').AsString='' then
    MessageBox(Handle, '省份不能为空，请输入省份信息！　', '系统提示', MB_OK +
      MB_ICONWARNING + MB_TOPMOST);

end;

procedure TSchoolSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('显示顺序').AsInteger := DataSet.RecordCount+1;
  if cbb_Sf.ItemIndex<>0 then
    DataSet.FieldByName('省份').AsString := cbb_Sf.Text;
end;

procedure TSchoolSet.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TSchoolSet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetSfList(sList);

    cbb_Sf.Items.Clear;
    cbb_Sf.Items.Add('==不限==');
    cbb_Sf.Items.AddStrings(sList);
    cbb_Sf.Text := '江西';

    DBGrid1.Columns[1].PickList.Assign(sList);
  finally
    sList.Free;
  end;
  OpenTable;
end;

procedure TSchoolSet.OpenTable;
begin
  if cbb_Sf.Text='==不限==' then
    sqlStr := 'select * from 全国高校信息表 order by 省份,显示顺序'
  else
    sqlstr := 'select * from 全国高校信息表 where 省份='+quotedstr(cbb_Sf.Text)+'order by 省份,显示顺序';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

procedure TSchoolSet.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
