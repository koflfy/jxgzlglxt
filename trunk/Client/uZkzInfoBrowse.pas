unit uZkzInfoBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls, CnProgressFrm,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage, Mask, DBCtrlsEh,
  ComCtrls, uKsInfo;

type
  TZkzInfoBrowse = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Exit: TBitBtn;
    ds_KcRoom: TDataSource;
    cds_KcRoom: TClientDataSet;
    btn_Refresh: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ds_Zkz: TDataSource;
    cds_Zkz: TClientDataSet;
    btn_Print: TBitBtn;
    DBGridEh_KcRoom: TDBGridEh;
    spl1: TSplitter;
    spl2: TSplitter;
    ds_KsKc: TDataSource;
    cds_Kskc: TClientDataSet;
    cds_Temp: TClientDataSet;
    pnl2: TPanel;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn1: TBitBtn;
    btn_PrnZkz2: TBitBtn;
    chk_1: TCheckBox;
    pnl3: TPanel;
    pgc2: TPageControl;
    ts3: TTabSheet;
    DBGridEh_Zkz: TDBGridEh;
    pgc3: TPageControl;
    ts2: TTabSheet;
    DBGridEh_KsKc: TDBGridEh;
    DBGridEh1: TDBGridEh;
    btn_prnQdb: TBitBtn;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ds_KcRoomDataChange(Sender: TObject; Field: TField);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AutoCreateClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure chk_1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure cds_TempCalcFields(DataSet: TDataSet);
    procedure btn_prnQdbClick(Sender: TObject);
    procedure btn_PrnZkz2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh_ZkzDblClick(Sender: TObject);
  private
    { Private declarations }
    aForm :TKsInfo;
    procedure OpenTable;
    procedure OpenTable_KcRoom;
    procedure OpenTable_KsKc;
  public
    { Public declarations }
  end;

var
  ZkzInfoBrowse: TZkzInfoBrowse;

implementation
uses uDM,uAutoPkInput;
{$R *.dfm}

procedure TZkzInfoBrowse.btn1Click(Sender: TObject);
begin
  dm.PrintReport('考场安排表.fr3',cds_KcRoom.XMLData,1);
end;

procedure TZkzInfoBrowse.btn2Click(Sender: TObject);
begin
  dm.PrintReport('考场指示标签.fr3',cds_KcRoom.XMLData,1);
end;

procedure TZkzInfoBrowse.btn3Click(Sender: TObject);
begin
  dm.PrintReport('考场座位标签.fr3',cds_Zkz.XMLData,1);
end;

procedure TZkzInfoBrowse.btn_AddClick(Sender: TObject);
begin
  if not cds_Zkz.ReadOnly then
  begin
    cds_Zkz.Append;
    pgc2.ActivePage.SetFocus;
  end;
end;

procedure TZkzInfoBrowse.btn_AutoCreateClick(Sender: TObject);
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

procedure TZkzInfoBrowse.btn_ExitClick(Sender: TObject);
begin
  //DM.ExecSql(mmo1.Text);
  Close;
end;

procedure TZkzInfoBrowse.btn_PrintClick(Sender: TObject);
var
  sUrl,sqlstr:string;
begin
  sUrl := Trim(cds_Zkz.FieldByName('照片文件名').AsString);
  if sUrl='' then
  begin
    if MessageBox(Handle,
      '该考生的照片信息不存在！还要打印该考生的准考证吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;

  if (sUrl<>'') and (LowerCase(Copy(sUrl,1,7))<>'http://') then
    sUrl := dm.GetWebSrvUrl+sUrl;

  sqlstr := 'select * from View_准考证表 where 报名序号='+quotedstr(cds_Zkz.FieldByName('报名序号').AsString);
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  if sUrl<>'' then
    dm.DownLoadKsPhoto(sUrl,nil,True);
  dm.PrintReport('考生准考证.fr3',cds_Temp.XMLData,1);

end;

procedure TZkzInfoBrowse.btn_prnQdbClick(Sender: TObject);
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_考生签到表 WHERE 考场编号='+quotedstr(cds_KcRoom.FieldByName('考场编号').AsString)+' ORDER BY 显示顺序, 准考证号';
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  dm.PrintReport('考生签到表.fr3',cds_Temp.XMLData,1);
end;

procedure TZkzInfoBrowse.btn_PrnZkz2Click(Sender: TObject);
begin
  if MessageBox(Handle, '真的要批量打印当前所显示的所有考生的准考证吗？　', 
    '系统提示', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    dm.PrintReport('考生准考证.fr3',cds_Zkz.XMLData,1);
  end;
end;

procedure TZkzInfoBrowse.btn_RefreshClick(Sender: TObject);
begin
  OpenTable_KcRoom;
end;

procedure TZkzInfoBrowse.cds_TempCalcFields(DataSet: TDataSet);
var
  Photo_fn:string;
begin
  Photo_fn := DataSet.FieldByName('照片文件名').AsString;
  if Photo_fn='' then Exit;
  Photo_fn := Copy(Photo_fn,Pos('/',Photo_fn)+1,Length(Photo_fn));
  Photo_fn := ExtractFilePath(ParamStr(0))+'Kszp\'+Photo_fn;
  DataSet.FieldByName('sPhotoFileName').AsString := Photo_fn;
end;

procedure TZkzInfoBrowse.chk_1Click(Sender: TObject);
begin
  OpenTable;
end;

procedure TZkzInfoBrowse.DBGridEh_ZkzDblClick(Sender: TObject);
begin
  aForm.Show;
end;

procedure TZkzInfoBrowse.ds_KcRoomDataChange(Sender: TObject; Field: TField);
begin
  OpenTable_KsKc;
  OpenTable;
end;

procedure TZkzInfoBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZkzInfoBrowse.FormCreate(Sender: TObject);
begin
  aForm := TKsInfo.Create(Self);
  aForm.DataSource1.DataSet := Self.cds_Zkz;
end;

procedure TZkzInfoBrowse.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TZkzInfoBrowse.FormShow(Sender: TObject);
begin
  OpenTable_KcRoom;
end;

procedure TZkzInfoBrowse.OpenTable;
var
  sqlstr:string;
begin
  sqlStr:= 'select * from view_准考证表';
  if chk_1.Checked then
    sqlStr := sqlstr+' where 考场编号='+quotedstr(cds_KcRoom.FieldByName('考场编号').AsString)+' order by 准考证号';
  cds_Zkz.XMLData := dm.OpenData(sqlStr);
end;

procedure TZkzInfoBrowse.OpenTable_KcRoom;
var
  sqlstr:string;
begin
  cds_KcRoom.DisableControls;
  try
    sqlStr := 'select * from 考场编排表 order by 考场编号';
    cds_KcRoom.XMLData := dm.OpenData(sqlStr);
  finally
    cds_KcRoom.EnableControls;
  end;
end;

procedure TZkzInfoBrowse.OpenTable_KsKc;
var
  sqlstr:string;
begin
  sqlStr := 'select * from 考试课程表 where 类别='+quotedstr(cds_KcRoom.FieldByName('类别').AsString)+' order by 显示顺序';
  cds_Kskc.XMLData := dm.OpenData(sqlStr);
end;

procedure TZkzInfoBrowse.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
