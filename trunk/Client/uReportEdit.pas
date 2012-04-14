unit uReportEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, DB, DBClient, ADODB;

type
  TReportEdit = class(TForm)
    GroupBox1: TGroupBox;
    pnl1: TPanel;
    lbl1: TLabel;
    dbedt_ReportName: TDBEdit;
    lbl2: TLabel;
    dbedt_Filename: TDBEdit;
    lbl3: TLabel;
    dbedt_LastModifiedTime: TDBEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    btn_LoadFromFile: TBitBtn;
    btn_SaveToFile: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Cancel: TBitBtn;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    dbcbb_Master: TDBComboBox;
    dbcbb_Delta: TDBComboBox;
    lbl7: TLabel;
    dbcbb_FldMaster: TDBComboBox;
    lbl8: TLabel;
    dbcbb_FldDelta: TDBComboBox;
    lbl4: TLabel;
    lbl9: TLabel;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbcbb_FldMasterDropDown(Sender: TObject);
    procedure dbcbb_FldDeltaDropDown(Sender: TObject);
    procedure dbcbb_DeltaChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetTableList(sTableList: TStrings);
    procedure GetFieldList(const sTableName:string;sFieldList: TStrings);
  public
    { Public declarations }
    sPath:string;
  end;

var
  ReportEdit: TReportEdit;

implementation
uses uDM,uReportDesign;
{$R *.dfm}

//==================================================
//Purpose   :   Get   the   last   file   access   time
//Params     :   FileName         the   File   Name
//                     AFlag     1.   the   file   creation   time
//                               2.   the   file   last   access   time
//                               3.   the   file   last   write   time
//Return     :   TDateTime
//Author     :   ePing
//Date         :   2000-08-03
//==================================================
function GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
var
    WFD:   TWin32FindData;
    FileTime:   TFileTime;
    hFile:   THandle;
    DFT:   DWORD;
begin
  try
    hFile   :=   FindFirstFile(PChar(FileName),   WFD);
    if   hFile   <>   INVALID_HANDLE_VALUE   then
    begin
      case   AFlag   of
        1:   FileTimeToLocalFileTime(WFD.ftCreationTime,   FileTime);
        2:   FileTimeToLocalFileTime(WFD.ftLastAccessTime,   FileTime);
        3:   FileTimeToLocalFileTime(WFD.ftLastWriteTime,   FileTime);
      end;
      FileTimeToDosDateTime(FileTime,   LongRec(DFT).HI,   LongRec(DFT).LO);
      Result   :=   FileDateToDateTime(DFT);
    end;
  finally
    //FindClose(hFile);
  end;
end;

procedure TReportEdit.btn_CancelClick(Sender: TObject);
begin
  dbedt_Filename.DataSource.DataSet.Cancel;
  TClientDataSet(dbedt_Filename.DataSource.DataSet).MergeChangeLog;
end;

procedure TReportEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TReportEdit.btn_SaveClick(Sender: TObject);
var
  sSqlStr:string;
begin
  if dbedt_Filename.DataSource.DataSet.State in [dsInactive,dsEdit] then
     dbedt_Filename.DataSource.DataSet.Post;
  if TClientDataSet(dbedt_Filename.DataSource.DataSet).ChangeCount>0 then
  begin
    sSqlStr := 'select top 1 * from 报表模板表 ';
    if DM.UpdateData('id',sSqlStr,TClientDataSet(dbedt_Filename.DataSource.DataSet).Delta) then
      TClientDataSet(dbedt_Filename.DataSource.DataSet).MergeChangeLog;
  end;
end;

procedure TReportEdit.dbcbb_DeltaChange(Sender: TObject);
begin
  lbl7.Enabled := TDBComboBox(Sender).Text<>'';
  lbl8.Enabled := lbl7.Enabled;
  dbcbb_FldMaster.Enabled := TDBComboBox(Sender).Text<>'';
  dbcbb_FldDelta.Enabled := TDBComboBox(Sender).Text<>'';
end;

procedure TReportEdit.dbcbb_FldDeltaDropDown(Sender: TObject);
begin
  GetFieldList(dbcbb_Delta.Text,dbcbb_FldDelta.Items);
end;

procedure TReportEdit.dbcbb_FldMasterDropDown(Sender: TObject);
begin
  GetFieldList(dbcbb_Master.Text,dbcbb_FldMaster.Items);
end;

procedure TReportEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //ReportDesign.cds_Report.AfterScroll(ReportDesign.cds_Report);
end;

procedure TReportEdit.FormCreate(Sender: TObject);
begin
  sPath := ExtractFilePath(ParamStr(0))+'RepDesign\';
  if not DirectoryExists(sPath) then
     ForceDirectories(sPath);
  dlgOpen1.InitialDir := sPath;
  dlgSave1.InitialDir := sPath;
  GetTableList(dbcbb_Master.Items);
  dbcbb_Delta.Items.Clear;
  dbcbb_Delta.Items.AddStrings(dbcbb_Master.Items);
  dbcbb_Delta.OnChange(Self);
end;

procedure TReportEdit.GetTableList(sTableList: TStrings);
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
  finally
    cds_Temp.Free;
  end;
end;

procedure TReportEdit.GetFieldList(const sTableName: string;
  sFieldList: TStrings);
var
  cds_Temp:TClientDataSet;
  i: Integer;
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

end.
