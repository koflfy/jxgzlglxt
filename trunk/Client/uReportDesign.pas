unit uReportDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, GridsEh, ShellAPI, 
  DBGridEh, ExtCtrls, DBCtrls, Mask, DBGridEhGrouping;

type
  TReportDesign = class(TForm)
    grp_Left: TGroupBox;
    pnl_Bottom: TPanel;
    dbgrdh1: TDBGridEh;
    btn_Exit: TBitBtn;
    cds_Report: TClientDataSet;
    ds_Report: TDataSource;
    cds_ReportID: TAutoIncField;
    cds_ReportWideStringField: TWideStringField;
    cds_ReportWideStringField2: TWideStringField;
    cds_ReportDateTimeField: TDateTimeField;
    cds_ReportActionTime: TDateTimeField;
    cds_ReportField: TIntegerField;
    cds_ReportWideStringField3: TWideStringField;
    cds_ReportWideStringField4: TWideStringField;
    cds_ReportWideStringField5: TWideStringField;
    cds_ReportWideStringField6: TWideStringField;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    btn_Save: TBitBtn;
    btn_Cancel: TBitBtn;
    btn_Add: TBitBtn;
    btn_Delete: TBitBtn;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl4: TLabel;
    lbl9: TLabel;
    dbedt_ReportName: TDBEdit;
    dbedt_Filename: TDBEdit;
    dbedt_LastModifiedTime: TDBEdit;
    btn_LoadFromFile: TBitBtn;
    btn_SaveToFile: TBitBtn;
    dbcbb_Master: TDBComboBox;
    dbcbb_Delta: TDBComboBox;
    dbcbb_FldMaster: TDBComboBox;
    dbcbb_FldDelta: TDBComboBox;
    btn_DesignReport: TBitBtn;
    btn_PrivewReport: TBitBtn;
    lbl_RepDesign: TLabel;
    procedure cds_ReportCalcFields(DataSet: TDataSet);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DesignReportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdh1Columns4EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure dbgrdh1Columns4EditButtons1Click(Sender: TObject;
      var Handled: Boolean);
    procedure btn_LoadFromFileClick(Sender: TObject);
    procedure btn_SaveToFileClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure dbcbb_FldMasterDropDown(Sender: TObject);
    procedure dbcbb_FldDeltaDropDown(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cds_ReportBeforePost(DataSet: TDataSet);
    procedure lbl_RepDesignClick(Sender: TObject);
    procedure lbl_RepDesignMouseEnter(Sender: TObject);
    procedure lbl_RepDesignMouseLeave(Sender: TObject);
  private
    { Private declarations }
    sPath:string;
    procedure Open_ReportTable;
    procedure GetTableList(sTableList: TStrings);
    procedure GetFieldList(const sTableName:string;sFieldList: TStrings);
  public
    { Public declarations }
  end;

var
  ReportDesign: TReportDesign;

implementation
uses uDM;
{$R *.dfm}

procedure TReportDesign.btn_AddClick(Sender: TObject);
begin
  Case TBitBtn(Sender).Tag of
    0: //Add
    begin
      with cds_Report do
      begin
        Append;
        FieldByName('ActionTime').Value := Now;
        FieldByName('��������').AsString := '�����뱨������';
        FieldByName('�����ļ���').AsString := '�뵼�������±���';
        FieldByName('����޸�����').AsString := '1900-01-01 00��00��00';
        FieldByName('����').AsString := '�ɷѼ�¼��';
        //DataSet.FieldByName('Delta_SQL').AsString := 'select top 100 * from �ɷѼ�¼��ϸ�� where pid=';
        Post;
      end;
      if dm.UpdateData('id','select top 1 * from ����ģ���',cds_Report.Delta,False) then
      begin
        //cds_Report.MergeChangeLog;
        Open_ReportTable;
        cds_Report.Last;
      end;
    end;
    1: //Edit
    begin
      //cds_Report.Edit;
      //ReportEdit.ShowModal;
    end;
    2:
    begin
      if Application.MessageBox('ɾ������ģ����Ϣʱ����ģ���ļ�ͬʱҲ�ᱻɾ��������'
        + #13#10 + '���Ҫɾ����', 'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING +
        MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
      begin
        cds_Report.Delete;
        if dm.UpdateData('id','select top 1 * from ����ģ���',cds_Report.Delta) then
          cds_Report.MergeChangeLog;
      end;
    end;
  End;
end;

procedure TReportDesign.btn_CancelClick(Sender: TObject);
begin
  cds_Report.Cancel;
end;

procedure TReportDesign.btn_DesignReportClick(Sender: TObject);
var
  sfn,sSqlStr,sData:string;
begin
  sSqlStr := cds_Report.FieldByName('����').AsString;
  if sSqlStr = '' then
    sSqlStr := 'select top 5 * from �ɷѼ�¼��'
  else
    sSqlStr := 'select top 5 * from '+sSqlStr;
  sData := dm.OpenData(sSqlStr);

  sfn := cds_Report.FieldByName('�����ļ���').AsString;
  dm._PrintReport(sPath,sfn,sData,TButton(Sender).Tag,False);
end;

procedure TReportDesign.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TReportDesign.btn_LoadFromFileClick(Sender: TObject);
var
  sfn :string;
  LastModifideTime:TDateTime;
begin
  if CompareText(ExtractFileExt(dbedt_FileName.Text),'.fr3')=0 then
    sfn := sPath+dbedt_FileName.Text;
  if dm.UpLoadReportFile(cds_Report.FieldByName('Id').AsInteger,sfn,LastModifideTime,True) then
  begin
    //Application.MessageBox('������ɣ�����ģ���ļ�����ɹ�������', 'ϵͳ��ʾ',
    //  MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    cds_Report.Edit;
    cds_Report.FieldByName('�����ļ���').AsString := sfn;
    cds_Report.FieldByName('����޸�����').AsDateTime := LastModifideTime;
    cds_Report.Post;
  end;
end;

procedure TReportDesign.btn_SaveClick(Sender: TObject);
var
  sSqlStr:string;
begin
  if cds_Report.State in [dsInactive,dsEdit] then
     cds_Report.Post;
  if cds_Report.ChangeCount>0 then
  begin
    sSqlStr := 'select top 1 * from ����ģ��� ';
    if DM.UpdateData('id',sSqlStr,cds_Report.Delta) then
      cds_Report.MergeChangeLog;
  end;
end;

procedure TReportDesign.btn_SaveToFileClick(Sender: TObject);
var
  sfn:string;
begin
  if CompareText(ExtractFileExt(dbedt_FileName.Text),'.fr3')=0 then
    sfn := sPath+dbedt_FileName.Text;
  if dm.DownLoadReportFile(cds_Report.FieldByName('Id').AsInteger,sfn,True) then
    Application.MessageBox('������ɣ�����ģ���ļ������ɹ�������', 'ϵͳ��ʾ',
    MB_OK + MB_ICONINFORMATION + MB_TOPMOST);

end;

procedure TReportDesign.cds_ReportBeforePost(DataSet: TDataSet);
begin
  if (dbedt_ReportName.Text='') or
     (dbedt_Filename.Text='') or
     (dbcbb_Master.Text='') then
  begin
      Application.MessageBox('�����������ļ����ƺ������ݱ���Ϊ�գ�����' +
      #13#10 + '�������벻ȫ���޷����棡', 'ϵͳ��ʾ', MB_OK + MB_ICONWARNING + MB_TOPMOST);
      Abort;
  end;
end;

procedure TReportDesign.cds_ReportCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('���').Value := DataSet.RecNo;
end;

procedure TReportDesign.dbcbb_FldDeltaDropDown(Sender: TObject);
begin
  GetFieldList(dbcbb_Delta.Text,dbcbb_FldDelta.Items);
end;

procedure TReportDesign.dbcbb_FldMasterDropDown(Sender: TObject);
begin
  GetFieldList(dbcbb_Master.Text,dbcbb_FldMaster.Items);
end;

procedure TReportDesign.dbgrdh1Columns4EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  btn_LoadFromFile.Click;
end;

procedure TReportDesign.dbgrdh1Columns4EditButtons1Click(Sender: TObject;
  var Handled: Boolean);
begin
  btn_SaveToFile.Click;
end;

procedure TReportDesign.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportDesign.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if cds_Report.State in [dsInsert,dsEdit] then
    cds_Report.Post;
  if cds_Report.ChangeCount>0 then
    if Application.MessageBox('���ݼ�¼���޸ģ�����δ���棡Ҫ�����𣿡���', 
      'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDNO then
    begin
      CanClose := True
    end else
    begin
      CanClose := False;
      btn_Save.Click;
    end;
end;

procedure TReportDesign.FormCreate(Sender: TObject);
begin
  sPath := ExtractFilePath(ParamStr(0))+'RepDesign\';
  if not DirectoryExists(sPath) then
     ForceDirectories(sPath);
  lbl_RepDesign.Caption := '����ģ���ļ�����Ŀ¼��'+sPath;

  Open_ReportTable;

  dlgOpen1.InitialDir := sPath;
  dlgSave1.InitialDir := sPath;
  GetTableList(dbcbb_Master.Items);
  dbcbb_Delta.Items.Clear;
  dbcbb_Delta.Items.AddStrings(dbcbb_Master.Items);
  //dbcbb_Delta.OnChange(Self);
end;

procedure TReportDesign.GetFieldList(const sTableName: string;
  sFieldList: TStrings);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sFieldList.Clear;
    if sTableName='' then Exit;
    cds_Temp.XMLData := dm.OpenData('Select Name FROM SysColumns Where id=Object_Id('+quotedstr(sTableName)+')');
    sFieldList.Add('');
    while not cds_Temp.Eof do
    begin
      sFieldList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TReportDesign.GetTableList(sTableList: TStrings);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select name from sysobjects where type = N'+quotedstr('U')+
                                    ' order by name');
    sTableList.Clear;
    sTableList.Add('');
    while not cds_Temp.Eof do
    begin
      sTableList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    cds_Temp.XMLData := dm.OpenData('select name from sysobjects where type = N'+quotedstr('V')+
                                    ' order by name');
    while not cds_Temp.Eof do
    begin
      sTableList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TReportDesign.lbl_RepDesignClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar(sPath),nil,nil,SW_NORMAL);
end;

procedure TReportDesign.lbl_RepDesignMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style+[fsUnderline];
end;

procedure TReportDesign.lbl_RepDesignMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style-[fsUnderline];
end;

procedure TReportDesign.Open_ReportTable;
var
  sSqlStr :string;
begin
  Screen.Cursor := crHourGlass;
  cds_Report.DisableControls;
  try
    sSqlStr := 'select ID,��������,�����ļ���,����޸�����,����,�ӱ�,��������ֶ�,�ӱ�����ֶ�,ActionTime from ����ģ���';
    cds_Report.XMLData := dm.OpenData(sSqlStr);
  finally
    cds_Report.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

end.
