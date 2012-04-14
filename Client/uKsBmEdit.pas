unit uKsBmEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls, uKsBmInput,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, DBFieldComboBox,
  Mask, DBCtrlsEh;

type
  TKsBmEdit = class(TForm)
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
    btn_Print: TBitBtn;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    grp_Sf: TGroupBox;
    cbb_ZyLb: TComboBox;
    GroupBox1: TGroupBox;
    cbb_Zy: TComboBox;
    btn_Edit: TBitBtn;
    btn_Filter: TBitBtn;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure cbb_ZyLbChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure cbb_FieldChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
    aForm:TKsBmInput;
    sqlStr:String;
    function GetSqlWhere:string;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  KsBmEdit: TKsBmEdit;

implementation
uses uDM;
{$R *.dfm}

procedure TKsBmEdit.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    aForm.SetDataSet(ClientDataSet1);
    aForm.edt_BmNo.Text := '';
    aForm.Show;//Modal;
    //DBGrid1.SetFocus;
  end;
end;

procedure TKsBmEdit.btn_DelClick(Sender: TObject);
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

procedure TKsBmEdit.btn_EditClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    aForm.SetDataSet(ClientDataSet1);
    aForm.edt_BmNo.Text := ClientDataSet1.FieldByName('报名序号').AsString;
    aForm.Show;//Modal;
  end;
end;

procedure TKsBmEdit.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TKsBmEdit.btn_PrintClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := DM.OpenData('select * from view_考生报名表 where 报名序号='+quotedstr(ClientDataSet1.FieldByName('报名序号').AsString));
    dm.PrintReport('考生报名表.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsBmEdit.btn_SaveClick(Sender: TObject);
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

procedure TKsBmEdit.cbb_FieldChange(Sender: TObject);
begin
  edt_Value.SetFocus;
end;

procedure TKsBmEdit.cbb_ZyChange(Sender: TObject);
begin
  OpenTable;
  if Self.Showing then
    DBGrid1.SetFocus;
end;

procedure TKsBmEdit.cbb_ZyLbChange(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    if (cbb_ZyLb.ItemIndex<>0) and (cbb_ZyLb.Text<>'') then
      dm.GetZyList(cbb_ZyLb.Text,sList)
    else
      dm.GetZyList('',sList);

    cbb_Zy.Items.Clear;
    cbb_Zy.Items.Add('==不限==');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
  end;
  cbb_ZyChange(Self);
end;

procedure TKsBmEdit.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := Pos(UpperCase(edt_Value.Text),UpperCase(DataSet.FieldByName(cbb_Field.Text).AsString))=1;
end;

procedure TKsBmEdit.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if aForm.Showing then
    aForm.img_Photo.Picture := nil;
end;

procedure TKsBmEdit.DBGrid1DblClick(Sender: TObject);
begin
  btn_Edit.Click;
end;

procedure TKsBmEdit.edt_ValueChange(Sender: TObject);
begin
  if edt_Value.Text='' then
    ClientDataSet1.Filtered := False
  else
  begin
    ClientDataSet1.Filtered := False;
    ClientDataSet1.Filtered := True;
  end;
end;

procedure TKsBmEdit.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TKsBmEdit.FormCreate(Sender: TObject);
begin
  aForm := TKsBmInput.Create(Self);
end;

procedure TKsBmEdit.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TKsBmEdit.FormShow(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetZyLbList(sList);
    cbb_ZyLb.Items.Clear;
    cbb_ZyLb.ItemIndex := -1;
    cbb_ZyLb.Items.Add('==不限==');
    cbb_ZyLb.Items.AddStrings(sList);

    cbb_ZyLb.ItemIndex := 0;
    
    OpenTable;

  finally
    sList.Free;
  end;
end;

function TKsBmEdit.GetSqlWhere: string;
begin
  if cbb_ZyLb.Text<>'==不限==' then
    Result := ' where 报考类别='+quotedstr(cbb_ZyLb.Text)
  else
    Result := ' where 1>0';
  if cbb_Zy.Text<>'==不限==' then
    Result := Result+' and '+quotedstr(cbb_Zy.Text)+' in (专业志愿一,专业志愿二,专业志愿三)';
end;

procedure TKsBmEdit.OpenTable;
begin
  sqlStr := 'select * from 考生报名表 '+GetSqlWhere+' order by 报名序号';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

procedure TKsBmEdit.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
