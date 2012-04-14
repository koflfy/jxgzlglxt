unit uZkzEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls, CnProgressFrm,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh,
  ComCtrls, uZkzInput;

type
  TZkzEdit = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Del: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Add: TBitBtn;
    ds_ZyLb: TDataSource;
    cds_ZyLb: TClientDataSet;
    btn_Refresh: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    DBGridEh_ZyLb: TDBGridEh;
    pgc2: TPageControl;
    ts3: TTabSheet;
    ds_Zkz: TDataSource;
    cds_Zkz: TClientDataSet;
    DBGridEh_Zkz: TDBGridEh;
    btn_Print: TBitBtn;
    btn_AutoCreate: TBitBtn;
    btn_Edit: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure cds_KcRoomNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ds_ZyLbDataChange(Sender: TObject; Field: TField);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AutoCreateClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure chk_AllowEditClick(Sender: TObject);
    procedure ds_ZkzDataChange(Sender: TObject; Field: TField);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
    //sFilterStr:String;
    aForm:TZkzInput;
    sqlStr_Zkz:String;
  public
    { Public declarations }
    procedure OpenTable;
  end;

var
  ZkzEdit: TZkzEdit;

implementation
uses uDM,uAutoPkInput;
{$R *.dfm}

procedure TZkzEdit.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TZkzEdit.FormCreate(Sender: TObject);
begin
  aForm := TZkzInput.Create(Self);
end;

procedure TZkzEdit.btn_AddClick(Sender: TObject);
var
  sKcBH:string;
begin
  cds_Zkz.Last;
  sKcBH := cds_Zkz.FieldByName('�������').AsString;
  if Length(sKcBH)=1 then
    sKcBH := '0'+sKcBH;

  aForm.SetInfo('2605',cds_ZyLb.FieldByName('���').AsString,cds_ZyLb.FieldByName('���').AsString,sKcBH);
  aForm.edt_BMXH.Text := '';
  aForm.cds_Ksxx.Close;
  aForm.Show;
end;

procedure TZkzEdit.btn_AutoCreateClick(Sender: TObject);
begin
{
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
}
end;

procedure TZkzEdit.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ���ü�¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  cds_Zkz.Delete;
  btn_Save.Click;
end;

procedure TZkzEdit.btn_EditClick(Sender: TObject);
begin
  DBGridEh_Zkz.ReadOnly := False;
end;

procedure TZkzEdit.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TZkzEdit.btn_PrintClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
  sUrl:string;
begin
  sUrl := Trim(cds_Zkz.FieldByName('��Ƭ�ļ���').AsString);
  if sUrl='' then Exit;

  if LowerCase(Copy(sUrl,1,7))<>'http:// 'then
    sUrl := dm.GetWebSrvUrl+sUrl;


  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := DM.OpenData('select * from View_׼��֤�� where �������='+quotedstr(cds_Zkz.FieldByName('�������').AsString));
    dm.DownLoadKsPhoto(sUrl,nil,True);
    dm.PrintReport('����׼��֤.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TZkzEdit.btn_RefreshClick(Sender: TObject);
begin
  cds_ZyLb.DisableControls;
  try
    cds_ZyLb.XMLData := dm.OpenData('select * from View_����˿�������������ϸ�� order by ���');
  finally
    cds_ZyLb.EnableControls;
  end;
end;

procedure TZkzEdit.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(cds_Zkz) then
    if DM.UpdateData('id',sqlStr_Zkz,cds_Zkz.Delta) then
      cds_Zkz.MergeChangeLog;
end;

procedure TZkzEdit.cds_KcRoomNewRecord(DataSet: TDataSet);
begin
  if not cds_ZyLb.FieldByName('���').IsNull then
  begin
    DataSet.FieldByName('������').AsString := cds_ZyLb.FieldByName('���').AsString;
    DataSet.FieldByName('���').AsString := cds_ZyLb.FieldByName('���').AsString;
  end;
end;

procedure TZkzEdit.chk_AllowEditClick(Sender: TObject);
begin
  //DBGridEh_Zkz.ReadOnly := not chk_AllowEdit.Checked;
  ds_Zkz.OnDataChange(Sender,nil);
end;

procedure TZkzEdit.ds_ZkzDataChange(Sender: TObject; Field: TField);
begin
  btn_Add.Enabled := True;
  //btn_Del.Enabled := (cds_Zkz.FieldByName('���').AsString<>'') and chk_AllowEdit.Checked ;
  btn_Save.Enabled := (cds_Zkz.State in [dsEdit,dsInsert]) or (cds_Zkz.ChangeCount>0);
end;

procedure TZkzEdit.ds_ZyLbDataChange(Sender: TObject; Field: TField);
begin
  OpenTable;
  aForm.SetInfo('2605',cds_ZyLb.FieldByName('���').AsString,cds_ZyLb.FieldByName('���').AsString,'');
end;

procedure TZkzEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(cds_Zkz) then
     if MessageBox(Handle, '�������޸ĵ�δ���棬Ҫ�����𣿡���', 'ϵͳ��ʾ',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;

  Action := caFree;
end;

procedure TZkzEdit.FormShow(Sender: TObject);
begin
  btn_Refresh.Click;
  pgc2.ActivePageIndex := 0;
  pgc2.ActivePage.SetFocus;
end;

procedure TZkzEdit.OpenTable;
begin
  sqlStr_Zkz := 'select * from view_׼��֤�� where ���='+quotedstr(cds_ZyLb.FieldByName('���').AsString)+' order by ׼��֤��';
  cds_Zkz.XMLData := dm.OpenData(sqlStr_Zkz);

  if Self.Showing then
    pgc2.ActivePage.SetFocus;
end;

procedure TZkzEdit.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
