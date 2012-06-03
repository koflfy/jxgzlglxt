unit ujxGzlInitialize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TjxGzlInitialize = class(TForm)
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
    btn_Initialize: TBitBtn;
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
    procedure chk_DisplayErrorRecordClick(Sender: TObject);
    procedure chk_AllowEditClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_InitializeClick(Sender: TObject);
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
uses uDM,CnProgressFrm;
{$R *.dfm}

procedure TjxGzlInitialize.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TjxGzlInitialize.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TjxGzlInitialize.btn_DeleteClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO + 
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
  end;
end;

procedure TjxGzlInitialize.btn_EditClick(Sender: TObject);
begin
  DBGridEh1.SetFocus;
end;

procedure TjxGzlInitialize.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TjxGzlInitialize.btn_ExportClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TjxGzlInitialize.btn_InitializeClick(Sender: TObject);
var
  cds_s,cds_d:TClientDataSet;
  i,ii:Integer;
  ss,dd,kk,zxs1,zxs2:string;
begin
  if MessageBox(Handle, '真的要生成工作量核算格式的数据吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  cds_s := TClientDataSet.Create(nil);
  cds_d := TClientDataSet.Create(nil);
  Screen.Cursor := crHourGlass;
  ShowProgress('正在打开源数据...');
  try
    if not DM.ExecSql('delete from 工作量总表 where 学年='+quotedstr(cbb_Xy.Text)+' and 学期='+quotedstr(cbb_Xq.Value)) then Exit;
    cds_s.XMLData := DM.OpenData('select * from 教学任务表 order by 规则号');
    UpdateProgressTitle('正在打开目标数据...');
    cds_d.XMLData := dm.OpenData('select * from 工作量核算表 order by 规则号');
    UpdateProgressMax(cds_s.RecordCount);
    while not cds_s.Eof do
    begin
      UpdateProgress(cds_s.RecNo);
      kk := cds_s.FieldByName('周学时').AsString;
      ii := Pos('-',kk);
      if ii>0 then
      begin
        zxs1 := Copy(kk,1,ii-1);
        zxs2 := Copy(kk,ii+1,10);
      end else
      begin
        zxs1 := Copy(kk,1,10);
        zxs2 := '0.0';
      end;

      if StrToFloatDef(zxs1,0)>0 then
      begin
        cds_d.Append;
        for i := 0 to cds_d.Fields.Count - 1 do
        begin
          dd := cds_d.Fields[i].FieldName;
          if (cds_d.Fields[i].DataType<>ftAutoInc) and (cds_s.FieldList.IndexOf(dd)<>-1) then
            cds_d.Fields[i].Value := cds_s.FieldByName(dd).Value;
        end;
        cds_d.Post;
      end;
      if StrToFloatDef(zxs2,0)>0 then
      begin
        cds_d.Append;
        for i := 0 to cds_d.Fields.Count - 1 do
        begin
          dd := cds_d.Fields[i].FieldName;
          if (cds_d.Fields[i].DataType<>ftAutoInc) and (cds_s.FieldList.IndexOf(dd)<>-1) then
            cds_d.Fields[i].Value := cds_s.FieldByName(dd).Value;
        end;
        cds_d.Post;
      end;

      cds_s.Next;
    end;
    if dm.UpdateData('id','select top 0 * from 工作量核算表',cds_d.Delta) then
      ClientDataSet1.XMLData := cds_d.XMLData;
    UpdateProgress(cds_s.RecordCount);
  finally
    HideProgress;
    cds_s.Free;
    cds_d.Free;
    Screen.Cursor := crDefault;
  end;

end;

procedure TjxGzlInitialize.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxGzlInitialize.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('id','select top 0 * from 工作核算表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TjxGzlInitialize.btn_SearchClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := edt_Value.Text<>'';
end;

procedure TjxGzlInitialize.cbb_XqChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TjxGzlInitialize.chk_AllowEditClick(Sender: TObject);
begin
  DBGridEh1.ReadOnly := not TCheckBox(Sender).Checked;
  ClientDataSet1.ReadOnly := DBGridEh1.ReadOnly;
  btn_Edit.Visible := TCheckBox(Sender).Checked;
  btn_Delete.Visible := TCheckBox(Sender).Checked;
  btn_Save.Visible := TCheckBox(Sender).Checked;
end;

procedure TjxGzlInitialize.chk_DisplayErrorRecordClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxGzlInitialize.ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept:
    Boolean);
begin
  Accept := Pos(edt_Value.Text,DataSet.FieldByName(cbb_Field.Text).AsString)>0;
end;

procedure TjxGzlInitialize.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('学年').AsString := cbb_Xn.Value;
  DataSet.FieldByName('学期').AsString := cbb_Xq.Value;
  DataSet.FieldByName('开课学院').AsString := cbb_Xy.Text;
end;

procedure TjxGzlInitialize.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
  btn_Search.Click;
end;

procedure TjxGzlInitialize.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TjxGzlInitialize.FormCreate(Sender: TObject);
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

function TjxGzlInitialize.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Xy.Text<>'不限' then
    sWhere := ' and 开课学院='+quotedstr(cbb_Xy.Text);
  sWhere := sWhere+' and 学年='+quotedstr(cbb_Xn.Text);
  sWhere := sWhere+' and 学期='+quotedstr(cbb_Xq.Value);
  Result := sWhere;
end;

procedure TjxGzlInitialize.GetbkLbList;
begin
end;

procedure TjxGzlInitialize.GetKsKcList;
begin
end;

procedure TjxGzlInitialize.Open_Table;
var
  sqlstr:string;
begin
  Screen.Cursor := crHourGlass;
  try
    if chk_DisplayErrorRecord.Checked then
      sqlStr := 'select * from 工作量核算表 where 规则号+授课对象 in '+
                '(select 规则号+授课对象 from 教学任务表 group by 规则号+授课对象 having count(*)>1)'+
                GetWhere+' order by 规则号'
    else
      sqlstr := 'select * from 工作量核算表 where 1>0 '+GetWhere+' order by 规则号';
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

procedure TjxGzlInitialize.rg_PostClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TjxGzlInitialize.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TjxGzlInitialize.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
end;

end.
