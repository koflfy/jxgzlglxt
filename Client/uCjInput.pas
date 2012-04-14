unit uCjInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping, Menus;

type
  TCjInput = class(TForm)
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
    cbb_ksKc: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    btn_Save: TBitBtn;
    lbl_Len: TLabel;
    btn_Post: TBitBtn;
    grp2: TGroupBox;
    cbb_bkLb: TDBComboBoxEh;
    rg_Post: TRadioGroup;
    chk_Error: TCheckBox;
    pm1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mi_CancelPost: TMenuItem;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_ksKcChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_SaveClick(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure btn_PostClick(Sender: TObject);
    procedure cbb_bkLbChange(Sender: TObject);
    procedure chk_ErrorClick(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mi_CancelPostClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure rg_PostClick(Sender: TObject);
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

var
  CjInput: TCjInput;

implementation
uses uDM;
{$R *.dfm}

procedure TCjInput.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TCjInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TCjInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCjInput.btn_PostClick(Sender: TObject);
var
  sWhere,sqlstr:string;
begin
  if MessageBox(Handle, '成绩上传后将不能再进行修改了！还要上传吗？　',
    '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    if ((ClientDataSet1.FieldByName('状态').AsString='正常') and
       (ClientDataSet1.FieldByName('成绩').AsString<>'')) or
       (ClientDataSet1.FieldByName('状态').AsString<>'正常') then
    begin
      sWhere := sWhere+','+ClientDataSet1.FieldByName('Id').AsString;
      //ClientDataSet1.Edit;
      //ClientDataSet1.FieldByName('是否提交').AsBoolean := True;
      //ClientDataSet1.Post;
    end;
    ClientDataSet1.Next;
  end;
  if sWhere[1] = ',' then
    sWhere := Copy(sWhere,2,Length(sWhere));
  if sWhere <> '' then
    sWhere := 'where Id in ('+sWhere+')'
  else
    sWhere := 'where 1=0';
  sqlstr := 'update 考生成绩表 set 是否提交=1 '+sWhere;

  //btn_Save.Click;

  if dm.ExecSql(sqlstr) then //vobj_Admin.PostCj(fCjIndex,fyx,fSf,fKm) then
  begin
    Open_Table;
    MessageBox(Handle, '成绩数据上传成功，该科目成绩不能再进行修改了！　',
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    //Close;
{
  end else
  begin
    MessageBox(Handle, '成绩数据上传失败，请检查是否漏录了考生成绩！　',
      '系统提示', MB_OK + MB_ICONERROR + MB_TOPMOST);
}
  end;
end;

procedure TCjInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCjInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('id','select top 1 * from view_考生成绩表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TCjInput.btn_SearchClick(Sender: TObject);
//var
//  ksh:string;
begin
{
  ksh := Trim(edt_Value.Text);
  if ksh='' then Exit;
  if ClientDataSet1.Locate(cbb_Field.Text,ksh,[]) then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.SelectedIndex := 8;
  end else
  begin
    MessageBox(Handle, PChar(cbb_Field.Text+'为【'+edt_Value.Text+'】'+'的考生不存在！　　' + #13#10 + '请检查后重新查询！'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_Value.SetFocus;
  end;
}
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := edt_Value.Text<>'';
end;

procedure TCjInput.cbb_bkLbChange(Sender: TObject);
begin
  if Self.Showing then
    GetKsKcList;
end;

procedure TCjInput.cbb_ksKcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TCjInput.chk_ErrorClick(Sender: TObject);
begin
  DBGridEh1.Columns[9].ReadOnly := not chk_Error.Checked;
end;

procedure TCjInput.ClientDataSet1AfterPost(DataSet: TDataSet);
var
  zkzh,cj,sqlstr:string;
begin
  zkzh := DataSet.FieldByName('准考证号').AsString;
  cj := DataSet.FieldByName('成绩').AsString;

  if DataSet.FieldByName('Id').IsNull then
    sqlstr := 'Insert into 考生成绩表 (准考证号,考试课程,成绩,录入员,是否提交) '+
              'Values('+quotedstr(Zkzh)+','+quotedstr(cbb_ksKc.Text)+','+cj+',0)'
  else
    sqlstr := 'update 考生成绩表 set 成绩='+cj+',录入员='+quotedstr(gb_Czy_Id)+
    ' where Id='+DataSet.FieldByName('Id').AsString;
  if dm.ExecSql(sqlstr) then
    ClientDataSet1.MergeChangeLog;
end;

procedure TCjInput.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  //DataSet.FieldByName('考试课程').AsString := cbb_ksKc.Text;
  DataSet.FieldByName('录入员').AsString := gb_Czy_ID;
  DataSet.FieldByName('录入时间').AsDateTime := Now;
  DataSet.FieldByName('是否提交').AsBoolean := False;
end;

procedure TCjInput.ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept:
    Boolean);
begin
  Accept := Pos(edt_Value.Text,DataSet.FieldByName(cbb_Field.Text).AsString)>0;
end;

procedure TCjInput.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  //DataSet.FieldByName('准考证号').AsString := Zkzh;
  DataSet.FieldByName('考试课程').AsString := cbb_ksKc.Text;
  DataSet.FieldByName('录入员').AsString := gb_Czy_ID;
  DataSet.FieldByName('是否提交').AsBoolean := False;
end;

procedure TCjInput.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
  btn_Search.Click;
end;

procedure TCjInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCjInput.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ClientDataSet1.Active and DataSetNoSave(ClientDataSet1) then
  begin
    if MessageBox(Handle, '成绩记录已修改但尚未保存，要保存吗？　',
      '系统提示', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      btn_Save.Click;
    end;
  end;
end;

procedure TCjInput.FormShow(Sender: TObject);
begin
  GetbkLbList;
end;

function TCjInput.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 报考类别='+quotedstr(cbb_bkLb.Text);
  sWhere := sWhere+' and 考试课程='+quotedstr(cbb_kskc.Text);
  sWhere := sWhere+' and 是否提交='+IntTostr(rg_Post.ItemIndex);
  Result := sWhere;
end;

procedure TCjInput.GetbkLbList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_bkLb.Items.Clear;
    dm.GetZyLbList(sList);
    cbb_bkLb.Items.Assign(sList);
    cbb_bkLb.ItemIndex := 0;
    //GetKsKcList;
  finally
    sList.Free;
  end;
end;

procedure TCjInput.GetKsKcList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_ksKc.Items.Clear;
    cbb_ksKc.Text := '';
    dm.GetKsKcList(cbb_bkLb.Text,sList);
    cbb_ksKc.Items.Assign(sList);
    cbb_ksKc.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TCjInput.mi_CancelPostClick(Sender: TObject);
begin
  if gb_Czy_Level<>'-1' then Exit;
  
  if MessageBox(Handle, '真的要撤消当前所显示的全部成绩记录的上传状态吗？　',
    '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    //if ClientDataSet1.FieldByName('成绩').AsString<>'' then
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('是否提交').AsBoolean := False;
      ClientDataSet1.Post;
    end;
    ClientDataSet1.Next;
  end;

  btn_Save.Click;

  if True then //vobj_Admin.PostCj(fCjIndex,fyx,fSf,fKm) then
  begin
    Open_Table;
    MessageBox(Handle, '成绩上传状态撤消成功，该科目成绩已进入可修改状态！　',
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    //Close;
  end;
end;

procedure TCjInput.Open_Table;
var
  sqlstr:string;
begin
  if ClientDataSet1.Active and DataSetNoSave(ClientDataSet1) then
  begin
    if MessageBox(Handle, '成绩记录已修改但尚未保存，要保存吗？　',
      '系统提示', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      btn_Save.Click;
    end;
  end;
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'select * from view_考生成绩表 '+GetWhere+' order by 准考证号';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
    if Self.Showing then
    begin
      DBGridEh1.SetFocus;
      DBGridEh1.SelectedIndex := 8;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCjInput.pm1Popup(Sender: TObject);
begin
  mi_CancelPost.Visible := (gb_Czy_Level='-1') and (rg_Post.ItemIndex=1);
end;

procedure TCjInput.rg_PostClick(Sender: TObject);
begin
  DBGridEh1.ReadOnly := rg_Post.ItemIndex=0;
  btn_Post.Enabled := rg_Post.ItemIndex=0;
  btn_Save.Click;
  Open_Table;
end;

procedure TCjInput.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TCjInput.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
end;

end.
