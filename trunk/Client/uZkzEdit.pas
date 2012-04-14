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
  sKcBH := cds_Zkz.FieldByName('考场编号').AsString;
  if Length(sKcBH)=1 then
    sKcBH := '0'+sKcBH;

  aForm.SetInfo('2605',cds_ZyLb.FieldByName('编号').AsString,cds_ZyLb.FieldByName('类别').AsString,sKcBH);
  aForm.edt_BMXH.Text := '';
  aForm.cds_Ksxx.Close;
  aForm.Show;
end;

procedure TZkzEdit.btn_AutoCreateClick(Sender: TObject);
begin
{
  if MessageBox(Handle, '警告：' + #13#10#13#10 +
    '　　自动排考操作将删除之前所有的排考记录！而且无论　　' + #13#10 +
    '这些记录是自动产生的还是手工录入的都将会被删除！' + #13#10#13#10 +
    '还要继续自动排考操作吗？', '系统提示', MB_YESNO + MB_ICONSTOP +
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
  if MessageBox(Handle, '真的要删除该记录吗？　　', '系统提示', MB_YESNO +
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
  sUrl := Trim(cds_Zkz.FieldByName('照片文件名').AsString);
  if sUrl='' then Exit;

  if LowerCase(Copy(sUrl,1,7))<>'http:// 'then
    sUrl := dm.GetWebSrvUrl+sUrl;


  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := DM.OpenData('select * from View_准考证表 where 报名序号='+quotedstr(cds_Zkz.FieldByName('报名序号').AsString));
    dm.DownLoadKsPhoto(sUrl,nil,True);
    dm.PrintReport('考生准考证.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TZkzEdit.btn_RefreshClick(Sender: TObject);
begin
  cds_ZyLb.DisableControls;
  try
    cds_ZyLb.XMLData := dm.OpenData('select * from View_已审核考生报名人数明细表 order by 编号');
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
  if not cds_ZyLb.FieldByName('类别').IsNull then
  begin
    DataSet.FieldByName('类别代码').AsString := cds_ZyLb.FieldByName('编号').AsString;
    DataSet.FieldByName('类别').AsString := cds_ZyLb.FieldByName('类别').AsString;
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
  //btn_Del.Enabled := (cds_Zkz.FieldByName('类别').AsString<>'') and chk_AllowEdit.Checked ;
  btn_Save.Enabled := (cds_Zkz.State in [dsEdit,dsInsert]) or (cds_Zkz.ChangeCount>0);
end;

procedure TZkzEdit.ds_ZyLbDataChange(Sender: TObject; Field: TField);
begin
  OpenTable;
  aForm.SetInfo('2605',cds_ZyLb.FieldByName('编号').AsString,cds_ZyLb.FieldByName('类别').AsString,'');
end;

procedure TZkzEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(cds_Zkz) then
     if MessageBox(Handle, '数据已修改但未保存，要保存吗？　　', '系统提示',
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
  sqlStr_Zkz := 'select * from view_准考证表 where 类别='+quotedstr(cds_ZyLb.FieldByName('类别').AsString)+' order by 准考证号';
  cds_Zkz.XMLData := dm.OpenData(sqlStr_Zkz);

  if Self.Showing then
    pgc2.ActivePage.SetFocus;
end;

procedure TZkzEdit.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
