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
  dm.PrintReport('�������ű�.fr3',cds_KcRoom.XMLData,1);
end;

procedure TZkzInfoBrowse.btn2Click(Sender: TObject);
begin
  dm.PrintReport('����ָʾ��ǩ.fr3',cds_KcRoom.XMLData,1);
end;

procedure TZkzInfoBrowse.btn3Click(Sender: TObject);
begin
  dm.PrintReport('������λ��ǩ.fr3',cds_Zkz.XMLData,1);
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

procedure TZkzInfoBrowse.btn_ExitClick(Sender: TObject);
begin
  //DM.ExecSql(mmo1.Text);
  Close;
end;

procedure TZkzInfoBrowse.btn_PrintClick(Sender: TObject);
var
  sUrl,sqlstr:string;
begin
  sUrl := Trim(cds_Zkz.FieldByName('��Ƭ�ļ���').AsString);
  if sUrl='' then
  begin
    if MessageBox(Handle,
      '�ÿ�������Ƭ��Ϣ�����ڣ���Ҫ��ӡ�ÿ�����׼��֤�𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;

  if (sUrl<>'') and (LowerCase(Copy(sUrl,1,7))<>'http://') then
    sUrl := dm.GetWebSrvUrl+sUrl;

  sqlstr := 'select * from View_׼��֤�� where �������='+quotedstr(cds_Zkz.FieldByName('�������').AsString);
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  if sUrl<>'' then
    dm.DownLoadKsPhoto(sUrl,nil,True);
  dm.PrintReport('����׼��֤.fr3',cds_Temp.XMLData,1);

end;

procedure TZkzInfoBrowse.btn_prnQdbClick(Sender: TObject);
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_����ǩ���� WHERE �������='+quotedstr(cds_KcRoom.FieldByName('�������').AsString)+' ORDER BY ��ʾ˳��, ׼��֤��';
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  dm.PrintReport('����ǩ����.fr3',cds_Temp.XMLData,1);
end;

procedure TZkzInfoBrowse.btn_PrnZkz2Click(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫ������ӡ��ǰ����ʾ�����п�����׼��֤�𣿡�', 
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
  begin
    dm.PrintReport('����׼��֤.fr3',cds_Zkz.XMLData,1);
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
  Photo_fn := DataSet.FieldByName('��Ƭ�ļ���').AsString;
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
  sqlStr:= 'select * from view_׼��֤��';
  if chk_1.Checked then
    sqlStr := sqlstr+' where �������='+quotedstr(cds_KcRoom.FieldByName('�������').AsString)+' order by ׼��֤��';
  cds_Zkz.XMLData := dm.OpenData(sqlStr);
end;

procedure TZkzInfoBrowse.OpenTable_KcRoom;
var
  sqlstr:string;
begin
  cds_KcRoom.DisableControls;
  try
    sqlStr := 'select * from �������ű� order by �������';
    cds_KcRoom.XMLData := dm.OpenData(sqlStr);
  finally
    cds_KcRoom.EnableControls;
  end;
end;

procedure TZkzInfoBrowse.OpenTable_KsKc;
var
  sqlstr:string;
begin
  sqlStr := 'select * from ���Կγ̱� where ���='+quotedstr(cds_KcRoom.FieldByName('���').AsString)+' order by ��ʾ˳��';
  cds_Kskc.XMLData := dm.OpenData(sqlStr);
end;

procedure TZkzInfoBrowse.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
