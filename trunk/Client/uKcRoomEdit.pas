unit uKcRoomEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls, CnProgressFrm,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh,
  ComCtrls;

type
  TKcRoomEdit = class(TForm)
    ds_KcRoom: TDataSource;
    cds_KcRoom: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Del: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Add: TBitBtn;
    cds_Temp: TClientDataSet;
    btn_Refresh: TBitBtn;
    pgc2: TPageControl;
    ts2: TTabSheet;
    DBGridEh_KcRoom: TDBGridEh;
    btn_Print: TBitBtn;
    btn1: TBitBtn;
    btn3: TBitBtn;
    chk_AllowEdit: TCheckBox;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_ZyLbDataChange(Sender: TObject; Field: TField);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AutoCreateClick(Sender: TObject);
    procedure ds_KcRoomDataChange(Sender: TObject; Field: TField);
    procedure chk_AllowEditClick(Sender: TObject);
    procedure DBGridEh_KcRoomEnter(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
    sFilterStr:String;
    sqlStr_Room:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  KcRoomEdit: TKcRoomEdit;

implementation
uses uDM,uAutoPkInput;
{$R *.dfm}

procedure TKcRoomEdit.btn1Click(Sender: TObject);
begin
  dm.PrintReport('�������ű�.fr3',cds_KcRoom.XMLData,1);
end;

procedure TKcRoomEdit.btn3Click(Sender: TObject);
var
  sqlstr:string;
begin
  sqlStr:= 'select * from view_׼��֤��';
  sqlStr := sqlstr+' where �������='+quotedstr(cds_KcRoom.FieldByName('�������').AsString)+' order by ׼��֤��';
  cds_Temp.XMLData := dm.OpenData(sqlStr);
  dm.PrintReport('������λ��ǩ.fr3',cds_Temp.XMLData,1);
end;

procedure TKcRoomEdit.btn_AddClick(Sender: TObject);
begin
  if not cds_KcRoom.ReadOnly then
  begin
    cds_KcRoom.Append;
    pgc2.ActivePage.SetFocus;
  end;
end;

procedure TKcRoomEdit.btn_AutoCreateClick(Sender: TObject);
begin
  if MessageBox(Handle, '���棺' + #13#10#13#10 +
    '�����Զ��ſ�������ɾ��֮ǰ���е��ſ���¼���������ۡ���' + #13#10 +
    '��Щ��¼���Զ������Ļ����ֹ�¼��Ķ����ᱻɾ����' + #13#10#13#10 +
    '��Ҫ�����Զ��ſ�������', 'ϵͳ��ʾ', MB_YESNO + MB_ICONSTOP +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  with TAutoPkInput.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
  btn_Refresh.Click;
end;

procedure TKcRoomEdit.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ���ü�¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  cds_KcRoom.Delete;
  btn_Save.Click;
end;

procedure TKcRoomEdit.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TKcRoomEdit.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('����ָʾ��ǩ.fr3',cds_KcRoom.XMLData,1);
end;

procedure TKcRoomEdit.btn_RefreshClick(Sender: TObject);
begin
  OpenTable;
end;

procedure TKcRoomEdit.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(cds_KcRoom) then
    if DM.UpdateData('id',GetOneSqlStr(sqlStr_Room),cds_KcRoom.Delta) then
      cds_KcRoom.MergeChangeLog;
end;

procedure TKcRoomEdit.chk_AllowEditClick(Sender: TObject);
begin
  DBGridEh_KcRoom.ReadOnly := not chk_AllowEdit.Checked;
  //for I := 0 to DBGridEh_KcRoom.Columns.Count - 1 do
  //  DBGridEh_KcRoom.Columns[i].ReadOnly := chk_AllowEdit.Checked;
  ds_KcRoom.OnDataChange(Sender,nil);
end;

procedure TKcRoomEdit.DBGridEh_KcRoomEnter(Sender: TObject);
begin
  DBGridEh_KcRoom.SelectedIndex := 6;
end;

procedure TKcRoomEdit.ds_KcRoomDataChange(Sender: TObject; Field: TField);
begin
  btn_Add.Enabled := (cds_KcRoom.FieldByName('���').AsString<>'') and chk_AllowEdit.Checked ;
  btn_Del.Enabled := btn_Add.Enabled;
  btn_Save.Enabled := (cds_KcRoom.State in [dsEdit,dsInsert]) or (cds_KcRoom.ChangeCount>0);
end;

procedure TKcRoomEdit.ds_ZyLbDataChange(Sender: TObject; Field: TField);
begin
  OpenTable;
end;

procedure TKcRoomEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(cds_KcRoom) then
     if MessageBox(Handle, '�������޸ĵ�δ���棬Ҫ�����𣿡���', 'ϵͳ��ʾ',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;

  Action := caFree;
end;

procedure TKcRoomEdit.FormShow(Sender: TObject);
var
  JsBH,ZwInfo:string;
begin
  OpenTable;
  DBGridEh_KcRoom.Columns[6].PickList.Clear;
  DBGridEh_KcRoom.Columns[6].KeyList.Clear;
  cds_Temp.XMLData := DM.OpenData('select ���ұ��,��ѧ¥,��λ�� from ������Ϣ�� order by ���ұ��');
  //DBGridEh_KcRoom.Columns[6].AutoDropDown := True;
  while not cds_Temp.Eof do
  begin
    JsBH := cds_Temp.FieldByName('���ұ��').AsString;
    {
    if cds_Temp.FieldByName('��λ��').AsString<>'' then
      ZwInfo := '--(��λ������'+cds_Temp.FieldByName('��λ��').AsString+')'
    else
      ZwInfo := '--(��λ������/ )';
    }
    ZwInfo := '';

    DBGridEh_KcRoom.Columns[6].PickList.Add(JsBH+ZwInfo);
    DBGridEh_KcRoom.Columns[6].KeyList.Add(JsBH);
    cds_Temp.Next;
  end;
  pgc2.ActivePage.SetFocus;
end;

procedure TKcRoomEdit.OpenTable;
begin
  sqlStr_Room := 'select * from �������ű� order by �������';
  cds_KcRoom.XMLData := dm.OpenData(sqlStr_Room);

  if Self.Showing then
    pgc2.ActivePage.SetFocus;
end;

procedure TKcRoomEdit.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
