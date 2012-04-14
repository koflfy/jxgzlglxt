unit uKsBmConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls, uKsInfo,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, DBFieldComboBox,
  Mask, DBCtrlsEh, Menus;

type
  TKsBmConfirm = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Filter: TBitBtn;
    grp_Sf: TGroupBox;
    cbb_ZyLb: TComboBox;
    GroupBox1: TGroupBox;
    cbb_Zy: TComboBox;
    chk_Check: TCheckBox;
    pm1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mi_SetJf: TMenuItem;
    mi_CancelJf: TMenuItem;
    N5: TMenuItem;
    N3: TMenuItem;
    mi_SetAllJf: TMenuItem;
    mi_CancelAllJf: TMenuItem;
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure cbb_ZyLbChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure btn_FilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure cbb_FieldChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chk_CheckClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure mi_CancelAllJfClick(Sender: TObject);
    procedure mi_SetJfClick(Sender: TObject);
    procedure mi_CancelJfClick(Sender: TObject);
    procedure mi_SetAllJfClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
  private
    { Private declarations }
    aForm:TKsInfo;
    sqlStr:String;
    function GetSqlWhere:string;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  KsBmConfirm: TKsBmConfirm;

implementation
uses uDM;
{$R *.dfm}

procedure TKsBmConfirm.btn_DelClick(Sender: TObject);
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

procedure TKsBmConfirm.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TKsBmConfirm.btn_FilterClick(Sender: TObject);
begin
  if edt_Value.Text='' then
    ClientDataSet1.Filtered := False
  else
  begin
    ClientDataSet1.Filtered := False;
    ClientDataSet1.Filtered := True;
  end;
end;

procedure TKsBmConfirm.btn_SaveClick(Sender: TObject);
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

procedure TKsBmConfirm.cbb_FieldChange(Sender: TObject);
begin
  edt_Value.SetFocus;
end;

procedure TKsBmConfirm.cbb_ZyChange(Sender: TObject);
begin
  OpenTable;
  if Self.Showing then
    DBGrid1.SetFocus;
end;

procedure TKsBmConfirm.cbb_ZyLbChange(Sender: TObject);
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
    cbb_Zy.ItemIndex := -1;
    cbb_Zy.Items.Add('==����==');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;

  finally
    sList.Free;
  end;
  cbb_ZyChange(Self);
end;

procedure TKsBmConfirm.chk_CheckClick(Sender: TObject);
begin
  OpenTable
end;

procedure TKsBmConfirm.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := Pos(UpperCase(edt_Value.Text),UpperCase(DataSet.FieldByName(cbb_Field.Text).AsString))=1;
end;

procedure TKsBmConfirm.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if aForm.Showing then
    aForm.img_Photo.Picture := nil;
end;

procedure TKsBmConfirm.DBGrid1DblClick(Sender: TObject);
begin
  aForm.Show;
end;

procedure TKsBmConfirm.edt_ValueChange(Sender: TObject);
begin
  btn_Filter.Click;
end;

procedure TKsBmConfirm.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TKsBmConfirm.FormCreate(Sender: TObject);
begin
  aForm := TKsInfo.Create(Self);
  aForm.DataSource1.DataSet := Self.ClientDataSet1;
end;

procedure TKsBmConfirm.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TKsBmConfirm.FormShow(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetZyLbList(sList);
    cbb_ZyLb.Items.Clear;
    cbb_ZyLb.ItemIndex := -1;
    cbb_ZyLb.Items.Add('==����==');
    cbb_ZyLb.Items.AddStrings(sList);

    cbb_ZyLb.ItemIndex := 0;
    
    OpenTable;

  finally
    sList.Free;
  end;
end;

function TKsBmConfirm.GetSqlWhere: string;
begin
  if cbb_ZyLb.Text<>'==����==' then
    Result := ' where �������='+quotedstr(cbb_ZyLb.Text)
  else
    Result := ' where 1>0';
  if cbb_Zy.Text<>'==����==' then
    Result := Result+' and '+quotedstr(cbb_Zy.Text)+' in (רҵ־Ըһ,רҵ־Ը��,רҵ־Ը��)';

  Result := Result+' and רҵ־Ըһ is not null ';
  if chk_Check.Checked then
    Result := Result+' and ���� is not null and ������ is not null and �־Ͷ�ѧУ is not null ';
end;

procedure TKsBmConfirm.mi_CancelAllJfClick(Sender: TObject);
var
  sOk:string;
begin
  if MessageBox(Handle, '���Ҫ�ѵ�ǰ���еĿ�������Ϊδ�ɷ��𣿡�',
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDNO then
  begin
    Exit;
  end;
  if not InputQuery('����ȷ��','�����롾OK�������ַ���ȷ�ϣ�',sOK) then Exit;
  if UpperCase(sOk)<>'OK' then Exit;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean := False;
    ClientDataSet1.Post;
    ClientDataSet1.Next;
  end;
  MessageBox(Handle, '������ɣ���ǰ���еĿ����ѱ�����Ϊδ�ɷѣ���',
    'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TKsBmConfirm.mi_SetJfClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean then
  begin
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean := True;
    ClientDataSet1.Post;
  end;
end;

procedure TKsBmConfirm.mi_CancelJfClick(Sender: TObject);
begin
  if ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean then
  begin
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean := False;
    ClientDataSet1.Post;
  end;
end;

procedure TKsBmConfirm.mi_SetAllJfClick(Sender: TObject);
var
  sOk:string;
begin
  if MessageBox(Handle, '���Ҫ�ѵ�ǰ���еĿ�������Ϊ�ѽɷ��𣿡�',
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDNO then
  begin
    Exit;
  end;
  if not InputQuery('����ȷ��','�����롾OK�������ַ���ȷ�ϣ�',sOK) then Exit;
  if UpperCase(sOk)<>'OK' then Exit;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean := True;
    ClientDataSet1.Post;
    ClientDataSet1.Next;
  end;
  MessageBox(Handle, '������ɣ���ǰ���еĿ����ѱ�����Ϊ�ѽɷѣ���',
    'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TKsBmConfirm.OpenTable;
begin
  sqlStr := 'select * from view_���������� '+GetSqlWhere+' order by �������';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
end;

procedure TKsBmConfirm.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

procedure TKsBmConfirm.pm1Popup(Sender: TObject);
begin
  mi_SetJf.Enabled := ( not ClientDataSet1.FieldByName('�������').IsNull) and
                      ( not ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean);
  mi_CancelJf.Enabled := ( not ClientDataSet1.FieldByName('�������').IsNull) and
                         ( ClientDataSet1.FieldByName('�Ƿ�ɷ�').AsBoolean);
end;

end.
