unit ujxDataEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TjxDataEdit = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp1: TGroupBox;
    cbb_Xq: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    grp2: TGroupBox;
    cbb_Xn: TDBComboBoxEh;
    btn_Export: TBitBtn;
    grp3: TGroupBox;
    cbb_Xy: TDBComboBoxEh;
    btn_Save: TBitBtn;
    chk_DisplayErrorRecord: TCheckBox;
    chk_AllowEdit: TCheckBox;
    btn_Delete: TBitBtn;
    btn_Edit: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_XqChange(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure rg_PostClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_DisplayErrorRecordClick(Sender: TObject);
    procedure chk_DisplayErrorRecordClick(Sender: TObject);
    procedure chk_AllowEditClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetbkLbList;
    procedure GetKsKcList;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
    procedure SetFieldValue(const iCjIndex:Integer;const sCjField,sCzyField:string);
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TjxDataEdit.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TjxDataEdit.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TjxDataEdit.btn_DeleteClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO + 
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
  end;
end;

procedure TjxDataEdit.btn_DisplayErrorRecordClick(Sender: TObject);
var
  sqlStr:string;
begin
  sqlStr := 'select * from 教学任务表 where 规则号 in (select 规则号 from 教学任务表 group by 规则号 having count(*)>1)';
end;

procedure TjxDataEdit.btn_EditClick(Sender: TObject);
begin
  DBGridEh1.SetFocus;
end;

procedure TjxDataEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TjxDataEdit.btn_ExportClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TjxDataEdit.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxDataEdit.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('id','select top 0 * from 教学任务表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TjxDataEdit.btn_SearchClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := edt_Value.Text<>'';
end;

procedure TjxDataEdit.cbb_XqChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TjxDataEdit.chk_AllowEditClick(Sender: TObject);
begin
  DBGridEh1.ReadOnly := not TCheckBox(Sender).Checked;
  ClientDataSet1.ReadOnly := DBGridEh1.ReadOnly;
  btn_Edit.Visible := TCheckBox(Sender).Checked;
  btn_Delete.Visible := TCheckBox(Sender).Checked;
  btn_Save.Visible := TCheckBox(Sender).Checked;
end;

procedure TjxDataEdit.chk_DisplayErrorRecordClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxDataEdit.ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept:
    Boolean);
begin
  Accept := Pos(edt_Value.Text,DataSet.FieldByName(cbb_Field.Text).AsString)>0;
end;

procedure TjxDataEdit.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('学年').AsString := cbb_Xn.Value;
  DataSet.FieldByName('学期').AsString := cbb_Xq.Value;
  DataSet.FieldByName('开课学院').AsString := cbb_Xy.Text;
end;

procedure TjxDataEdit.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
  btn_Search.Click;
end;

procedure TjxDataEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TjxDataEdit.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Xn.Items.Clear;
    dm.GetXnList(sList);
    cbb_Xn.Items.Assign(sList);
    cbb_Xn.Text := gb_Cur_Xn;
    cbb_Xq.Value := gb_Cur_Xq;

    cbb_Xy.Items.Clear;
    DM.GetXyList(sList);
    cbb_Xy.Items.Add('不限');
    cbb_Xy.Items.AddStrings(sList);

    if cbb_Xy.Items.Count>0 then
      cbb_Xy.ItemIndex := 0;
      
    Open_Table;
  finally
    sList.Free;
  end;
end;

function TjxDataEdit.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Xy.Text<>'不限' then
    sWhere := ' and 开课学院='+quotedstr(cbb_Xy.Text);
  sWhere := sWhere+' and 学年='+quotedstr(cbb_Xn.Text);
  sWhere := sWhere+' and 学期='+quotedstr(cbb_Xq.Value);
  Result := sWhere;
end;

procedure TjxDataEdit.GetbkLbList;
begin
end;

procedure TjxDataEdit.GetKsKcList;
begin
end;

procedure TjxDataEdit.Open_Table;
var
  sqlstr:string;
begin
  Screen.Cursor := crHourGlass;
  try
    if chk_DisplayErrorRecord.Checked then
      sqlStr := 'select * from 教学任务表 where 规则号+授课对象 in '+
                '(select 规则号+授课对象 from 教学任务表 group by 规则号+授课对象 having count(*)>1)'+
                GetWhere+' order by 规则号'
    else
      sqlstr := 'select * from 教学任务表 where 1>0 '+GetWhere+' order by 规则号';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
    if Self.Showing then
    begin
      DBGridEh1.SetFocus;
      //DBGridEh1.SelectedIndex := 8;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TjxDataEdit.rg_PostClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxDataEdit.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TjxDataEdit.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
end;

end.
