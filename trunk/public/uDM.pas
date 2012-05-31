unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, SOAPConn, Rio, SOAPHTTPClient,GridsEh,
  Messages, IniFiles, Windows,Forms, DBGridEh,DBCtrlsEh, Dialogs,DBGridEhImpExp,
  uJxgzlIntf,uAdminIntf,EhLibCDS, jpeg,IdMultipartFormData,IdGlobal,GIFImg,
  PrnDbgEH,Graphics, frxChart, frxDesgn, StdActns, ActnList,StrUtils,DateUtils,
  Menus, ImgList, Controls, frxClass, frxDBSet, CnProgressFrm, InvokeRegistry,
  frxExportPDF, frxExportHTML, frxExportRTF, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,ExtCtrls, VCLUnZip, VCLZip;

type
  TMessageHandler = class     //ʹ�ûس���Ϣת����Tab��Ϣ
    class procedure AppMessage(var Msg:TMsg;var Handled:Boolean);
  end;

  TDM = class(TDataModule)
    HTTPRIO1: THTTPRIO;
    SoapConnection1: TSoapConnection;
    SaveDialog1: TSaveDialog;
    frxDesigner1: TfrxDesigner;
    frxChartObject1: TfrxChartObject;
    actlst1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    PopupMenu1: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N1: TMenuItem;
    mi_Export: TMenuItem;
    ImageList_pm: TImageList;
    act_DataExport: TAction;
    act_Locate: TAction;
    L1: TMenuItem;
    N2: TMenuItem;
    fds_Delta: TfrxDBDataset;
    fds_Master: TfrxDBDataset;
    frxReport1: TfrxReport;
    cds_Master: TClientDataSet;
    cds_Delta: TClientDataSet;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    act_DataExportByButton: TAction;
    IdHTTP1: TIdHTTP;
    VCLZip1: TVCLZip;
    ds_Master: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure SaveDialog1TypeChange(Sender: TObject);
    procedure act_DataExportExecute(Sender: TObject);
    procedure act_LocateExecute(Sender: TObject);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
    procedure cds_MasterAfterScroll(DataSet: TDataSet);
    procedure act_DataExportByButtonExecute(Sender: TObject);
  private
    { Private declarations }
    ii:Integer;
    function  SaveAsUrlImage(const sUrl,sFileName:string):Boolean;
    function  DownloadUrlImage(const sUrl:string;img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UploadUrlImage(const BmNo,sFileName:string):Boolean;
    function  GetSfxmJe(const Id,sfxm:string):string;
    procedure GetListFromTable(const sqlstr:string;out sList:TStrings);
    function  GetDeltaTableSqlText(const RepFileName:string):string;
    function  GetDeltaRepSetInfo(const RepFileName:string;
              out sDeltaTableName,sMasterFieldName,sDeltaFieldName:string):Boolean;
    function  HaveDeltaTable(const RepFileName:string):Boolean;
  public
    { Public declarations }
    procedure SetConnInfo(const sUrl:string);
    function  GetConnInfo:string;

    function  GetPrintBH:string;
    function  GetNextPrintBH(const Number:string):string;
    function  SetPrintBH(const Number:string):Boolean;

    function  GetSkyName:string; //�տ�Ա
    function  SetSkyName(const sName:string):Boolean;
    function  GetKpyName:string; //��ƱԱ
    function  SetKpyName(const sName:string):Boolean;

    function  OpenData(const sSqlStr:string):string;
    function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant;const ShowMsgBox:Boolean=True):Boolean;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    //function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant):Boolean;overload;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    function  UpdateData2(const sKey,sSqlStr,sDelta:string):Boolean;//��ת��DeltaΪXML��ʽ�ٴ�����
    function  ExecSql(const sSqlStr:string):Boolean;
    function  GetJjList(var JjList:TStrings):Boolean; //�õ������б�
    function  GetSrvAutoUpdateUrl:string;
    function  GetClientAutoUpdateUrl:string;

    function  _PrintReport(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  _PrintReport2(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const Page:Integer):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer=1;const ShowDialog:Boolean=True):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  ExportReport(const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer=3;const ShowDialog:Boolean=True):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintSFD(const sId:string;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD(const sIdList:Tstrings;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD2(const sId:string;const Page:Integer):Boolean;
    function  UpdatePrintBH(const ID:string):Boolean;

    function  UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean=False): Boolean;
    function  DownLoadReportFile(const Id:Integer;var ReportFileName:string;
                                 const ShowSelectFolder:Boolean=False):Boolean;
    procedure UpdateReportFile(const IsOver:Boolean=True);
    procedure DBGridEh1DrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    procedure ExportDBEditEH(const MyDBGridEH:TDBGridEh);

    function  DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UpLoadKsPhoto(const BmNo,sFileName: string):Boolean;

    procedure GetXnList(out sList:TStrings);
    procedure GetXyList(out sList:TStrings);
    procedure GetHsgzTypeXyList(out sList:TStrings); //�����������
    procedure GetSchoolList(const sf:string;out sList:TStrings);
    procedure GetEnglishDjKsList(out sList:TStrings);
    procedure GetJsjDjKsList(out sList:TStrings);
    procedure GetZzMmList(out sList:TStrings);
    procedure GetMzList(out sList:TStrings);
    procedure GetZyLbList(out sList:TStrings);
    procedure GetZyList(const ZyLb:string;out sList:TStrings);
    procedure GetKsKcList(const bkLb:string;out sList:TStrings);
    function  GetWebSrvUrl:string;
    procedure GetCurrentXnXq;
    function  GetHsgzWhere(const HsgzType:string):string;
  end;

{$DEFINE WAD_DEBUG}
const
  GbConnSrvFileName = 'ConnjxgzlSrvSet.ini';
{$IFNDEF WAD_DEBUG}
  Admin_SOAP_NAME   = 'jxgzlWebSrv.DLL/soap/IAdmin';
  jxgzl_SOAP_NAME  = 'jxgzlWedSrv.DLL/soap/Ijxgzl';
{$ELSE}
//����ʱ������������л�ʱ����Build�Ա��ؽ���Դ
  Admin_SOAP_NAME   = 'jxgzlWadSrv.jxgzl/soap/IAdmin';
  jxgzl_SOAP_NAME  = 'jxgzlWabSrv.jxgzl/soap/Ijxgzl';
{$ENDIF}

var
  gbIsOK,gbCanClose:Boolean;
  gb_Czy_ID,gb_Czy_Name,gb_Czy_Level:String;
  gb_Cur_Xn,gb_Cur_Xq,gb_Cur_Sfmc,gb_Cur_StartTime,gb_Cur_EndTime:string; //��ǰ�շ�����,��ʼʱ��,����ʱ��

  gb_Last_PrintBH:string; //�ϴ��ù��Ĵ�ӡ���
  DM: TDM;
  function vobj_jxgzl: Ijxgzl;//�ٴη�װGetIjxgzl�ӿں���
  function vobj_Admin:  IAdmin;//�ٴη�װGetIAccount�ӿں���

  function AppSrvIsOK: Boolean;
  function GetOneSqlStr(const sSql:string):string;
  function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
  function IsModified(cds:TClientDataSet):Boolean;
  function GetAutoUpdateInfo:string;
  procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:Tform;APageHeader:string='';
                          ALineType:TPageColontitleLineType=pcltSingleLine);
  function  LowerJeToUpper(const je:Real):string; //Сд���ת��Ϊ��д���
  procedure SaveLog(const sMsg:string);
  procedure InitXnList(sList:TDBComboBoxEh);
  function  GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
  function  DataSetNoSave(const ClientDataSet1:TClientDataSet):Boolean;
  function  ValidatePID(const APID: string): string;
  function  PosRight(const subStr,S:string):Integer;

implementation
uses PwdFunUnit,EncdDecdEx;
{$R *.dfm}

{ TDM }

function  PosRight(const subStr,S:string):Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Length(S) downto 0 do
    if S[i]=subStr then
    begin
      Result := i;
      Break;
    end;
end;

function vobj_jxgzl:Ijxgzl;//�ٴη�װGetIjxgzl�ӿں���
var
  UseWsdl:Boolean;
  SoapURL:string;
begin
  SoapURL := DM.GetConnInfo;
  SoapURL := SoapURL+jxgzl_SOAP_NAME;
  UseWsdl := Pos('/wsdl',LowerCase(SoapURL))>0;
  Result := GetIjxgzl(UseWsdl,SoapURL);
end;

function vobj_Admin:IAdmin;//�ٴη�װGetIAdmin�ӿں���
var
  UseWsdl:Boolean;
  SoapURL:string;
begin
  SoapURL := DM.GetConnInfo;
  SoapURL := SoapURL+Admin_SOAP_NAME;
  UseWsdl := Pos('/wsdl',LowerCase(SoapURL))>0;
  Result := GetIAdmin(UseWsdl,SoapURL);
end;

//==============================================================================
// linetypeȡֵ{pcltDoubleLine;pcltsingleline;pcltnon}
// AOwner:TForm TPrintDBGridEh.Create(AOwner); ����TPrintDBGridEh�����FREE
// TPrinterOrientation = (poPortrait, poLandscape); ֽ��������
//==============================================================================

procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:TForm;APageHeader:string='';
                        ALineType:TPageColontitleLineType=pcltSingleLine);
var
  prn:TPrintDBGridEh;
begin
  if AGrid.DataSource.DataSet.IsEmpty then Exit;
  prn:=TPrintDBGridEh.Create(AOwner);
  prn.Page.TopMargin := 1.5; //cm
  with prn.PageHeader do
  begin
    Font.Name:='����';
    Font.Size:=16;
    Font.Style:=[fsBold];
    LineType:=ALineType;
    CenterText.Text:=APageHeader;
  end;
  with prn.PageFooter do
  begin
    Font.Name:='����';
    Font.Size:=12;
    LeftText.Clear;
    CenterText.Add('��&[Page]ҳ��&[Pages]ҳ');
    LeftText.Add('��ӡ���ڣ�&[date]&[time]');
  end;
  prn.DBGridEh:=AGrid;
  prn.Preview;
end;

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
        2:   FileTimeToLocalFileTime(WFD.ftLastAccessTime,  FileTime);
        3:   FileTimeToLocalFileTime(WFD.ftLastWriteTime,   FileTime);
      end;
      FileTimeToDosDateTime(FileTime,   LongRec(DFT).HI,   LongRec(DFT).LO);
      Result   :=   FileDateToDateTime(DFT);
    end;
  finally
    //FindClose(hFile);
  end;
end;

function GetFirstWB(const sStr:string;const KeyLength:Integer=4):string;
begin
  Result := '';
end;

function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
begin
  if sType='PY' then
    Result := ''//GetFirstPY(sStr,KeyLength)
  else
    Result := GetFirstWB(sStr,KeyLength);
end;

function GetOneSqlStr(const sSql:string):string;
var
  sStr:string;
begin
  sStr := LowerCase(TrimLeft(sSql));
  if (Copy(sStr,1,6)='select') and (Pos(' top ',sStr)=0) then
    sStr := 'select top 0 '+copy(sSql,7,Length(sSql)-6)
  else
    sStr := sSql;
  Result := sStr;
end;

function IsModified(cds:TClientDataSet):Boolean;
begin
  if cds.State in [dsEdit,dsInsert] then
    cds.Post;
  Result := cds.ChangeCount>0;
end;

procedure TDM.act_DataExportByButtonExecute(Sender: TObject);
begin
  act_DataExport.OnExecute(Self);
end;

procedure TDM.act_DataExportExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    ExportDBEditEH(MyDBGridEH);
  end;
end;

procedure TDM.act_LocateExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    MyDBGridEH.SetFocus;
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), 0, 0);               //����Ctrl��
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), 0, 0);                   //����F��
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), KEYEVENTF_KEYUP, 0);     //�ſ�F��
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), KEYEVENTF_KEYUP, 0); //�ſ�Ctrl��
  end;
end;

procedure TDM.cds_MasterAfterScroll(DataSet: TDataSet);
{
var
  id,sSqlStr,sWhere,sTemp:string;
begin
  if DataSet.FieldList.IndexOf('ID')<>-1 then
  begin
    id := DataSet.FieldByName('Id').AsString;
    sTemp := ' and �ɷ���Ŀ not in ('+QuotedStr('ѧ��')+','+quotedstr('���Է�')+','+quotedstr('ס�޷�')+')';//+','+quotedstr('�̲ķ�')+')';
    sWhere := 'where pid='+quotedstr(id)+sTemp;
    sSqlStr := 'select * from �ɷѼ�¼��ϸ�� '+sWhere;
    cds_Delta.XMLData := dm.OpenData(sSqlStr);
  end;
end;
}
var
  RepFileName,sSqlStr:string;
begin
  RepFileName := frxReport1.FileName;
  sSqlStr := GetDeltaTableSqlText(RepFileName);
  if sSqlStr<>'' then
  begin
    cds_Delta.XMLData := dm.OpenData(sSqlStr);
    //ShowMessage(cds_Master.FieldByName('׼��֤��').AsString+','+cds_Delta.FieldByName('���Կγ�').AsString);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  SoapConnection1.Connected := False;
  GetConnInfo;
  frxDesigner1.OpenDir := ExtractFilePath(ParamStr(0))+'Rep';
  frxDesigner1.SaveDir := frxDesigner1.OpenDir;
end;

procedure TDM.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  //if gdSelected in State then Exit;
  if gdFocused in State then Exit;

  //if (Column.FieldName<>'����״̬') and (Column.FieldName<>'�ɷѽ��') then Exit;

  if (Column.FieldName='�ɷѽ��') or (Column.FieldName='���') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsFloat<0 then
    begin
      Font.Color := clRed
      //Brush.Color := clRed
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName='����״̬') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='���׿���' then
    begin
      //  Font.Color := clRed
      Brush.Color := clRed
    end
    else if Column.Field.AsString='���������' then
    begin
      Font.Color := clRed;
      Brush.Color := clYellow;
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName = '��ӡ����') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='' then
    begin
      //Font.Color := clRed;
      Brush.Color := clRed;
    end;
  end;
  {else if (Column.FieldName = '�Ƿ����') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsBoolean then
    begin
      Font.Color := clRed;
      //Brush.Color := clSilver;
    end;
  end;
  }
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

function TDM.DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True): Boolean;
var
  sPath,fn :string;
begin
  if sUrl='' then Exit;
  Result := DownloadUrlImage(sUrl,img,OverPhoto);
end;

function TDM.DownLoadReportFile(const Id: Integer; var ReportFileName: string;const ShowSelectFolder:Boolean): Boolean;
var
  bl :Boolean;
  sSqlStr,sfn :string;
  sLastTime,sLastTime2:TDateTime;
  cds_Temp:TClientDataSet;
begin
  Result := False;
  sfn := ReportFileName;
  //if (sfn<>'') and (not FileExists(sfn)) then
  //   Exit;

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select �����ļ���,��������,����޸����� from ����ģ��� where Id='+IntToStr(Id);
    sSqlStr := DM.OpenData(sSqlStr);
    if sSqlStr='' then
      Exit
    else
      cds_Temp.XMLData := sSqlStr;

    if (sfn='') or ShowSelectFolder then
    begin
      if sfn<>'' then
        dlgSave1.FileName := sfn
      else
        dlgSave1.FileName := cds_Temp.Fields[0].AsString;
      if dlgSave1.Execute then
      begin
        sfn := dlgSave1.FileName;
      end else
        Exit;
    end;

    if cds_Temp.FieldByName('��������').IsNull then
    begin
      if (ReportFileName='') then
        Application.MessageBox('���ݿ��еı���ģ��Ϊ�գ��ļ���������ʧ�ܣ�����',
          'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Exit;
    end;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('����޸�����').AsDateTime;
    if (ReportFileName='') and (sLastTime2<sLastTime) then
    begin
      if Application.MessageBox(PChar('�����ļ������ݿ��еı����ļ����ݻ�Ҫ�£�����'+#13+
                                      '���Ҫ�滻���ص��ļ���'), 'ϵͳ��ʾ',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
      begin
        bl := False;
        Exit;
      end;
    end else
      bl := True;

    if bl then
    begin
      DeleteFile(PChar(sfn));
      TBlobField(cds_Temp.FieldByName('��������')).SaveToFile(sfn);
    end;
    ReportFileName := ExtractFileName(sfn);
    Result := True;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.DownloadUrlImage(const sUrl: string; img: TImage;const OverPhoto:Boolean=True): Boolean;
var
  ImageStream:TMemoryStream;
  sPath,fn:string;
begin
  if img<>nil then
  begin
    img.Picture := nil;
  end;

  ii := PosRight('/',sUrl);
  fn := Copy(sUrl,ii+1,Length(sUrl));
  sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  fn := sPath+fn;
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  if OverPhoto and FileExists(fn) then
    DeleteFile(PChar(fn));

  if FileExists(fn) and (img<>nil) then
  begin
    img.Picture.LoadFromFile(fn);
    Result := True;
    Exit;
  end;

  ImageStream := TMemoryStream.Create();
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    Result := ImageStream.Size>0;
    if Result then
    begin
      ImageStream.Position := 0;
      ImageStream.SaveToFile(fn);
      try
        if img<>nil then
          img.Picture.LoadFromFile(fn);
      except
        Result := False;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

function TDM._PrintReport(const sPath, ReportFileName, cds_Master_XMLData: String;
                          const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  DeltaTableSqlStr,fn,sTempPath,sHint:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sTempPath) then
    ForceDirectories(sTempPath);

  fn := sTempPath+ReportFileName;
  if (not FileExists(fn)) and (OperateType<>2) then
  begin
    MessageBox(0, PChar('����ģ���ļ�δ�ҵ�����������ԣ������ļ�Ϊ������'+#13+fn+'����'), 'ϵͳ��ʾ',
    MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Result := False;
    Exit;
  end;
  case OperateType of
    0:
      sHint := '�������Ҫ��ӡ�𣿡���';
    1:
      sHint := '���Ҫ��ӡԤ���𣿡���';
    2:
      sHint := '���Ҫ���б�������𣿡���';
    3:
      sHint := '���Ҫ�������������𣿡���';
  end;
  if ShowDialog and (OperateType<>1) then
     if Application.MessageBox(PChar(sHint), 'ϵͳ��ʾ', MB_YESNO +
       MB_ICONQUESTION + MB_TOPMOST) = IDNO then
     begin
       Exit;
     end;

  frxReport1.ReportOptions.Name := ReportFileName;
  frxReport1.FileName := ReportFileName;
  frxReport1.OnGetValue := frxReport1GetValue;

  if cds_Master_XMLData<>'' then
    cds_Master.XMLData := cds_Master_XMLData;

  if HaveDeltaTable(ReportFileName) then
  begin
    cds_Master.AfterScroll := cds_MasterAfterScroll;
    if CompareText(ReportFileName,'�ɷѵ�.fr3')=0 then
      frxReport1.OnPrintPage := frxReport1PrintPage;
  end else
  begin
    cds_Delta.CommandText := '';
    cds_Master.AfterScroll := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    frxReport1.LoadFromFile(fn);
    frxReport1.Variables.Clear;
    frxReport1.Variables[' User_Var'] := ''; //������������
    frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
    frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
    frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
    frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //����Ա����
    frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //��ƱԱ
    frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //�տ�Ա
    frxReport1.Variables.AddVariable('User_Var','rmb_str','');
    frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //ѧ��
    frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //���Է�
    frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //ס�޷�
    frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //�̲ķѣ�����û����
    frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //��Ʊ���
    frxReport1.Variables.AddVariable('User_Var','photo_path',QuotedStr(ExtractFilePath(ParamStr(0))+'kszp\'));  //��Ƭ�ļ���
    frxReport1.Variables.AddVariable('User_Var','ksxz','');  //������֪

    case OperateType of
      0:
      begin
        frxReport1.PrintOptions.ShowDialog := False;
        frxReport1.PrepareReport;
        frxReport1.Print;
        //frxreport1.PrintPreparedReportDlg;
      end;
      1:
      begin
        frxReport1.PrintOptions.ShowDialog := False;
        frxReport1.ShowReport;
      end;
      2:
      begin
        frxReport1.DesignReport;
      end;
      3:
      begin
      {
        frxPDFExport1.ShowDialog := False;
        frxPDFExport1.FileName := ExtractFilePath(ParamStr(0))+Copy(ReportFileName,1,Length(ReportFileName)-4)+'.pdf';
        frxReport1.PrintOptions.ShowDialog := False;
        frxReport1.PrepareReport(True);
        frxReport1.Export(frxPDFExport1);
        //frxReport1.Export(frxRTFExport1);
      }
      end;
    end;
    Result := True;
  end else
  begin
    if OperateType=2 then
        frxReport1.DesignReport
    else
    begin
      MessageBox(0, PChar('��ӡģ���ļ�δ�ҵ�����������ԣ�����'+#13+fn+'����'), 'ϵͳ��ʾ',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM._PrintReport2(const sPath, ReportFileName, cds_Master_XMLData: String; const Page: Integer): Boolean;
var
  fn,sTempPath:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';

  fn := sTempPath+ReportFileName;
  frxReport1.ReportOptions.Name := ReportFileName;
  if CompareText(ReportFileName,'�ɷѵ�.fr3')=0 then
  begin
    frxReport1.OnGetValue := frxReport1GetValue;
    frxReport1.OnPrintPage := frxReport1PrintPage;
  end
  else
  begin
    //frxReport1.OnGetValue := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    if Page<>-1 then
    begin
      frxReport1.LoadFromFile(fn);
      frxReport1.Variables.Clear;
      frxReport1.Variables[' User_Var'] := ''; //������������
      frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
      frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
      frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
      frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //����Ա����
      frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //��ƱԱ
      frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //�տ�Ա
      frxReport1.Variables.AddVariable('User_Var','rmb_str','');
      frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //ѧ��
      frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //���Է�
      frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //ס�޷�
      frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //�̲ķѣ����ڲ�������
      frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //��Ʊ���
    end;
    case Page of
      -1:
        frxReport1.ShowPreparedReport;
      1:
        frxReport1.PrepareReport;
      else
        frxReport1.PrepareReport(False);
    end;
    Result := True;
  end else
  begin
    begin
      MessageBox(0, PChar('��ӡģ���ļ�δ�ҵ�����������ԣ�����'+#13+fn+'����'), 'ϵͳ��ʾ',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM.ExecSql(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  try
    Result := vobj_Admin.ExecSql(sSqlStr,sError) ;

    if sError<>'' then
    begin
        sError := '����ִ��ʧ�ܣ����������ִ�У����ܵ�ԭ��Ϊ������'+#13+sError;
        MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end;//else
    //  MessageBox(0, '�����ύ�����棩�ɹ�������', 'ϵͳ��ʾ', MB_OK
    //    + MB_ICONINFORMATION);
  finally
    //vobj := nil;
  end;
end;

procedure TDM.ExportDBEditEH(const MyDBGridEH: TDBGridEh);
var
  ExpClass:TDBGridEhExportClass;
  fn,mfn,Ext:String;
begin
  if MyDBGridEH.Owner is TForm then
    SaveDialog1.FileName := TForm(MyDBGridEH.Owner).Caption+FormatDateTime('(yyyy-mm-dd)',Now)//+'.xls'
  else
    SaveDialog1.FileName := '���ݵ���'+FormatDateTime('(yyyy-mm-dd)',Now);//.xls';

  if SaveDialog1.Execute then
  begin
    fn := SaveDialog1.FileName;
    Ext := ExtractFileExt(fn);
    mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
    case SaveDialog1.FilterIndex of
      1: begin ExpClass := TDBGridEhExportAsText; Ext := '.txt'; end;
      2: begin ExpClass := TDBGridEhExportAsCSV; Ext := '.csv'; end;
      3: begin ExpClass := TDBGridEhExportAsHTML; Ext := '.htm'; end;
      4: begin ExpClass := TDBGridEhExportAsRTF; Ext := '.rtf'; end;
      5: begin ExpClass := TDBGridEhExportAsXLS; Ext := '.xls'; end;
    else
      ExpClass := nil; Ext := '';
    end;
    if ExpClass <> nil then
    begin
      SaveDialog1.FileName := mfn + Ext;
      if FileExists(SaveDialog1.FileName) then
        if MessageBox(0,
          PChar('���棡��ǰ�ļ����´���ͬ���ļ�����ͬ���ļ���Ϊ��������'
          + #13#10 +'��'+ ExtractFileName(SaveDialog1.FileName)+'������'+#13+#13+'Ҫ������һͬ���ļ���'), 'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING
          + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
        begin
          Exit;
        end;

      Screen.Cursor := crHourGlass;
      try
        SaveDBGridEhToExportFile(ExpClass,MyDBGridEh, SaveDialog1.FileName,True);
        //SaveDBGridEhToExportFile(ExpClass,DBGridEh1, dlgSave1.FileName,False);
      finally
        MyDBGridEh.SetFocus;
        Screen.Cursor := crDefault;
      end;
    end;
  end;
end;

function TDM.ExportReport(const ReportFileName, cds_Master_XMLData: String;
  const OperateType: Integer; const ShowDialog: Boolean): Boolean;
begin
  Result := _PrintReport('',ReportFileName,cds_Master_XMLData,OperateType,ShowDialog);
end;

procedure TDM.frxReport1GetValue(const VarName: string; var Value: Variant);
var
  sPath,Photo_fn:String;
  sUrl,sqlstr:string;
begin
  if VarName='ksxz' then
     Value := vobj_Admin.Getksxz;
  if VarName='photo_path' then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'kszp\';
    Value := sPath;

    Photo_fn := '';
    if (cds_Master.FieldList.IndexOf('��Ƭ�ļ���')<>-1) then
    begin
      sUrl := Trim(cds_Master.FieldByName('��Ƭ�ļ���').AsString);

      if sUrl='' then
      begin
        //if MessageBox(0,'�ÿ�������Ƭ��Ϣ�����ڣ���Ҫ��ӡ�ÿ�����׼��֤�𣿡�', 'ϵͳ��ʾ',
        //  MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
          Exit;
      end;

      Photo_fn := sUrl;
      Photo_fn := Copy(Photo_fn,Pos('/',Photo_fn)+1,Length(Photo_fn));
      Photo_fn := sPath+Photo_fn;

      if (sUrl<>'') and (LowerCase(Copy(sUrl,1,7))<>'http://') then
        sUrl := GetWebSrvUrl+sUrl;

      if not FileExists(Photo_fn) then
        dm.DownLoadKsPhoto(sUrl,nil,True);
      //{
      try
        if FileExists(Photo_fn) then
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := Photo_fn;
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture.LoadFromFile(Photo_fn);
        end else
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := '';
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture := nil;
        end;
      except
      end;
      //}
    end;
  end;
end;

procedure TDM.frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
var
  Id,xm:string;
begin
  //if CompareText(frxReport1.ReportOptions.Name,'�ɷѵ�.fr3')=0 then
  begin
    xm := fds_Master.DataSet.FieldByName('����').AsString;
    Id := fds_Master.DataSet.FieldByName('Id').AsString;
    UpdatePrintBH(Id);
    SaveLog(id+','+xm);
  end;
  fds_Master.Next;
end;

function GetAutoUpdateInfo: string;
var
  fn,url:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      url := ReadString('SrvSet','UpdateUrl','');
      if LowerCase(Copy(url,1,7))<>'http://' then
        url := 'http://'+url;
      Result := url;
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetZyLbList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select ��� from רҵ���� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

function TDM.GetClientAutoUpdateUrl: string;
begin
  Result := vobj_Admin.GetClientAutoUpdateUrl;
end;

function TDM.GetConnInfo:string;
var
  fn,url:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      {$IFNDEF WAD_DEBUG}
        url := ReadString('SrvSet','SoapUrl','');
      {$ELSE}
        url := ReadString('SrvSet','DebugSoapUrl','http://localhost:8081/');
      {$ENDIF}
      if LowerCase(Copy(url,1,7))<>'http://' then
        url := 'http://'+url;
      if Copy(url,Length(url),1)<>'/' then
        url := url+'/';
      Result := url;
      //url := url+SOAP_NAME;
      {
      if Pos('/wsdl',LowerCase(url))>0 then
         HTTPRIO1.WSDLLocation := url
      else
        HTTPRIO1.URL := url;
      SoapConnection1.URL := url;
      }
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetCurrentXnXq;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ѧ��,ѧ�� from ��ǰѧ��ѧ�ڱ�';
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    gb_Cur_Xn := cds_Temp.FieldByName('ѧ��').AsString;
    gb_Cur_Xq := cds_Temp.FieldByName('ѧ��').AsString;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaRepSetInfo(const RepFileName: string; out sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
begin

  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('�ӱ�').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('�ӱ�').AsString;
    sMasterFieldName := cds_Temp.FieldByName('��������ֶ�').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('�ӱ�����ֶ�').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    sqlstr := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaTableSqlText(const RepFileName: string): string;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := '';
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('�ӱ�').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('�ӱ�').AsString;
    sMasterFieldName := cds_Temp.FieldByName('��������ֶ�').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('�ӱ�����ֶ�').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    Result := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetEnglishDjKsList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select ���� from Ӣ��ȼ��������� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

procedure TDM.GetHsgzTypeXyList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select �������� from ����������ͱ� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

function TDM.GetHsgzWhere(const HsgzType: string): string;
var
  sData:string;
  cds_Temp:TClientDataSet;
  iCompressType:Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    vobj_Admin.Query_Data('select Ĭ�ϼ������� from ����������ͱ� where ��������='+quotedstr(HsgzType),iCompressType,sData);

    if iCompressType=1 then
    begin
      sData := VCLZip1.ZLibDecompressString(sData);
      sData := DecodeString(sData);
    end;

    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetJjList(var JjList: TStrings): Boolean;
var
  sData:string;
  cds_Temp:TClientDataSet;
  iCompressType:Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    vobj_Admin.Query_Data('select * from ���ڱ� order by ����',iCompressType,sData);

    if iCompressType=1 then
    begin
      sData := VCLZip1.ZLibDecompressString(sData);
      sData := DecodeString(sData);
    end;

    cds_Temp.XMLData := sData;
    JjList.Clear;
    while not cds_Temp.Eof do
    begin
      JjList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    Result := True;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetJsjDjKsList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select ���� from ������ȼ��������� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

function TDM.GetKpyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','KpyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetKsKcList(const bkLb: string; out sList: TStrings);
var
  sqlstr:string;
begin
  if bkLb<>'' then
    sqlstr := 'select ���Կγ� from ���Կγ̱� where ���='+quotedstr(bkLb)+' order by ���,��ʾ˳��'
  else
    sqlstr := 'select distinct ���Կγ� from ���Կγ̱� where 1=1 order by ���,��ʾ˳��';

  GetListFromTable(sqlstr,sList);
end;

procedure TDM.GetListFromTable(const sqlstr: string; out sList: TStrings);
var
  cds_Temp:TClientDataSet;
  I: Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetMzList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select ���� from �������� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

function TDM.GetNextPrintBH(const Number: string): string;
var
  Num :Integer;
  PrintNumber :string;
begin
  PrintNumber := Number;
  if Number='' then
    PrintNumber := 'FA09860001';
  Num := StrToIntDef(RightStr(PrintNumber,6),0)+1;
  PrintNumber := Copy(PrintNumber,1,4)+Format('%.6d',[Num]);
  Result := PrintNumber;
end;

function TDM.GetPrintBH: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','StartPrintBH','');
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetSchoolList(const sf: string; out sList: TStrings);
var
  sqlstr:string;
begin
  if sf<>'' then
    sqlstr := 'select ѧУ���� from ȫ����У��Ϣ�� where ʡ��='+quotedstr(Sf)+' order by ʡ��,��ʾ˳��'
  else
    sqlstr := 'select ѧУ���� from ȫ����У��Ϣ�� where 1=1 order by ʡ��,��ʾ˳��';

  GetListFromTable(sqlstr,sList);
end;

procedure TDM.GetXnList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select distinct ѧ�� from �������ܱ� order by ѧ��';
  GetListFromTable(sqlstr,sList);
end;

procedure TDM.GetXyList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select distinct ����ѧԺ from �������ܱ� order by ����ѧԺ';
  GetListFromTable(sqlstr,sList);
end;

function TDM.GetSfxmJe(const Id, sfxm: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select ��� from �ɷѼ�¼��ϸ�� where Pid='+quotedstr(Id)+' and �ɷ���Ŀ='+quotedstr(sfxm);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '0.00';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := FormatFloat('0.00',Abs(cds_Temp.Fields[0].AsFloat));
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetSkyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','SkyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

function TDM.GetSrvAutoUpdateUrl: string;
begin
  Result := vobj_Admin.GetSrvAutoUpdateUrl;
end;

function TDM.GetWebSrvUrl: string;
begin
  Result := vobj_Admin.GetWebSrvUrl;
  if RightStr(Result,1)<>'/' then
    Result := Result+'/';
end;

procedure TDM.GetZyList(const ZyLb: string; out sList: TStrings);
var
  sqlstr:string;
begin
  if ZyLb<>'' then
    sqlstr := 'select ���� from ����רҵ�� where ���='+quotedstr(ZyLb)+' order by ���,��ʾ˳��'
  else
    sqlstr := 'select ���� from ����רҵ�� where 1=1 order by ���,��ʾ˳��';

  GetListFromTable(sqlstr,sList);
end;

procedure TDM.GetZzMmList(out sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select ���� from ������ò����� order by ��ʾ˳��';
  GetListFromTable(sqlstr,sList);
end;

function TDM.HaveDeltaTable(const RepFileName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := False;
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    Result := (cds_Temp.FieldByName('�ӱ�').AsString<>'') and
              (cds_Temp.FieldByName('��������ֶ�').AsString<>'') and
              (cds_Temp.FieldByName('�ӱ�����ֶ�').AsString<>'');
  finally
    cds_Temp.Free;
  end;
end;

procedure InitXnList(sList: TDBComboBoxEh);
var
  i,curYear:Integer;
begin
  curYear := YearOf(Now);
  sList.Items.Clear;
  sList.KeyItems.Clear;
  for i:=curYear-5 to curYear+1 do
  begin
    sList.Items.Add(Format('%4d����',[i]));
    sList.KeyItems.Add(Format('%4d����',[i]));
    sList.Items.Add(Format('%4d�＾',[i]));
    sList.KeyItems.Add(Format('%4d�＾',[i]));
    //sList.Items.Add(Format('%4d~%4dѧ��',[i,i+1]));
    //sList.KeyItems.Add(Format('%4d~%4d',[i,i+1]));
  end;
end;

function TDM.OpenData(const sSqlStr: string): string;
var
  sData:string;
  iCompressType:Integer;
begin
  try
    vobj_Admin.Query_Data(sSqlStr,iCompressType,sData);
    if iCompressType=1 then
    begin
      sData := DecodeString(sData);
      sData := VCLZip1.ZLibDecompressString(sData);
    end;
    Result := sData;
  except
    Result := '';
  end;
end;

function TDM.SaveAsUrlImage(const sUrl, sFileName: string): Boolean;
var
  ImageStream:TMemoryStream;
begin
  ImageStream := TMemoryStream.Create();
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    Result := ImageStream.Size>0;
  finally
    ImageStream.Free;
  end;
end;

procedure TDM.SaveDialog1TypeChange(Sender: TObject);
var
  fn,mfn,Ext:string;
begin
  fn := SaveDialog1.FileName;
  Ext := ExtractFileExt(fn);
  mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
  case SaveDialog1.FilterIndex of
    1: begin Ext := '.txt'; end;
    2: begin Ext := '.csv'; end;
    3: begin Ext := '.htm'; end;
    4: begin Ext := '.rtf'; end;
    5: begin Ext := '.xls'; end;
  else
    Ext := '';
  end;
  SaveDialog1.FileName := mfn+Ext;
  SaveDialog1.DefaultExt := Ext;
end;

procedure TDM.SetConnInfo(const sUrl:string);
var
  fn,url,sTemp:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  url := sUrl;

  if LowerCase(Copy(url,1,7))<>'http://' then
    url := 'http://'+url;
  if Copy(url,Length(url),1)<>'/' then
    url := url+'/';

  with TIniFile.Create(fn) do
  begin
    try
      {$IFNDEF WAD_DEBUG}
        sTemp := ReadString('SrvSet','SoapUrl','');
      {$ELSE}
        sTemp := ReadString('SrvSet','DebugSoapUrl','');
      {$ENDIF}

      if sTemp<>url then
      begin
        {$IFNDEF WAD_DEBUG}
          WriteString('SrvSet','SoapUrl',Url);
        {$ELSE}
          WriteString('SrvSet','DebugSoapUrl',Url);
        {$ENDIF}
      end;
      if Pos('/wsdl',LowerCase(url))>0 then
         HTTPRIO1.WSDLLocation := url
      else
         HTTPRIO1.URL := url;
      SoapConnection1.URL := url;
    finally
      Free;
    end;
  end;
end;

function TDM.SetKpyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','KpyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

function TDM.SetPrintBH(const Number: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','StartPrintBH',Number);
      Result := True;
    finally
      Free;
    end;
  end;
end;

function TDM.SetSkyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+GbConnSrvFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','SkyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

function TDM.UpdateData2(const sKey, sSqlStr, sDelta: string): Boolean;
var
  sError:string;
  iCompressType:Integer;
  sData:string;
begin
  sData := sDelta;

  try
    if Length(sData)>100*1024 then //׼��ѹ��
      iCompressType := 1
    else
      iCompressType := 0;

    if iCompressType=1 then
    begin
      sData := VCLZip1.ZLibCompressString(sData);
      sData := EncodeString(sData);
    end;

    Result := vobj_Admin.Update_Data(sKey,sSqlStr,iCompressType,sData,sError) ;

    if sError<>'' then
    begin
        sError := '���ݱ���ʧ�ܣ���������±��棡���ܵ�ԭ��Ϊ������'+#13+sError;
        MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end;
    //else
    //  MessageBox(0, '�����ύ�����棩�ɹ�������', 'ϵͳ��ʾ', MB_OK
    //    + MB_ICONINFORMATION);
  finally
    //vobj := nil;
  end;
end;

function TDM.UpdatePrintBH(const ID:string): Boolean;
var
  sError,sSqlStr,PrintNumber:string;
  Num:Integer;
begin
  PrintNumber := GetPrintBH;
  if PrintNumber='' then
    PrintNumber := 'δ֪';
  sSqlStr := 'update �ɷѼ�¼�� set ��ӡ����='+quotedstr(PrintNumber)+' where Id='+quotedstr(Id);
  Result := vobj_Admin.ExecSql(sSqlStr,sError);
  if Result then
  begin
    SetPrintBH(GetNextPrintBH(PrintNumber));
  end else
    SaveLog('Error:'+Id);
end;

procedure TDM.UpdateReportFile(const IsOver:Boolean);
var
  sSqlStr,sPath:string;
  cds_Temp:TClientDataSet;
  Id:Integer;
  ReportName:String;
begin
  sPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  sSqlStr := 'select Id,�����ļ��� from ����ģ���';
  try
    try
      cds_Temp.XMLData := OpenData(sSqlStr);
      if cds_Temp.XMLData='' then Exit;
      if cds_Temp.RecordCount=0 then Exit;

      ShowProgress('�������ر���ģ��',cds_Temp.RecordCount);
      while not cds_Temp.Eof do
      begin
        Id := cds_Temp.FieldByName('Id').AsInteger;
        ReportName := cds_Temp.FieldByName('�����ļ���').AsString;
        if ReportName='' then ReportName := 'δ��������.fr3';
        ReportName := sPath+ReportName;
        UpdateProgress(cds_Temp.RecNo);
        if (not IsOver) and FileExists(ReportName) then
        begin
          Sleep(500);
          cds_Temp.Next
        end else
        begin
          DownLoadReportFile(Id,ReportName);
          cds_Temp.Next;
        end;
      end;
    except
    end;
  finally
    HideProgress;
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;

end;

function TDM.UpLoadKsPhoto(const BmNo,sFileName: string): Boolean;
begin
  if not FileExists(sFileName) then Exit;
  Result := UploadUrlImage(BmNo,sFileName);
end;

function TDM.UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean): Boolean;
var
  bl:Boolean;
  sSqlStr,sData,sfn,sHint:string;
  cds_Temp:TClientDataSet;
  sLastTime,sLastTime2:TDateTime;
begin
  Result := False;
  sfn := ReportFileName;
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    if (not ShowSelectFolder) and (sfn<>'') and (not FileExists(sfn)) then Exit;

    sSqlStr := 'select Id,�����ļ���,��������,����޸����� from ����ģ��� where Id='+IntToStr(Id);
    sData := DM.OpenData(sSqlStr);
    if sData='' then
      Exit
    else
      cds_Temp.XMLData := sData;

    if (sfn='') then  sfn := cds_Temp.FieldByName('�����ļ���').AsString;

    dlgOpen1.FileName := sfn;
    if (ReportFileName='') or ShowSelectFolder then
    begin
      if dlgOpen1.Execute then
      begin
        sfn := dlgOpen1.FileName;
      end else
        Exit;
    end;

    if not FileExists(sfn) then Exit;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('����޸�����').AsDateTime;
    if (ReportFileName='') and (not cds_Temp.FieldByName('��������').IsNull) then
    begin
       if (sLastTime2>sLastTime) then
          sHint := '���ݿ��еı����ļ���Ҫ�ϴ������ݻ�Ҫ�£�'+#13+
                   '���Ҫ�����ڱ����ļ��滻ԭ���ı���ģ���𣿡���'
       else
          sHint := '���Ҫ�����ڱ����ļ��滻ԭ���ı���ģ���𣿡���';

       if Application.MessageBox(PChar(sHint), 'ϵͳ��ʾ',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
        bl := False;
    end else
      bl := True;

    if bl then
    begin
      cds_Temp.Edit;
      cds_Temp.FieldByName('�����ļ���').AsString := ExtractFileName(sfn);
      TBlobField(cds_Temp.FieldByName('��������')).LoadFromFile(sfn);
      cds_Temp.FieldByName('����޸�����').AsDateTime := sLastTime;
      cds_Temp.Post;
      Result := dm.UpdateData('Id',sSqlStr,cds_Temp.Delta,ReportFileName='');
      LastModifideTime := sLastTime;
      ReportFileName := ExtractFileName(sfn);
    end;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.UploadUrlImage(const BmNo, sFileName: string): Boolean;
var
  obj : TIdMultiPartFormDataStream;
  sResult,Url: String;
begin
  if not FileExists(sFileName) then Exit;

  obj := TIdMultiPartFormDataStream.Create;
  try
    obj.AddFormField('BmNo',BmNo);
    obj.AddFile('aFileName',sFileName, GetMIMETypeFromFile(sFileName));
    IdHTTP1.Request.ContentType := obj.RequestContentType;
    obj.Position := 0;
    //Url := GetConnInfo+'Upfile_Photo.asp';  //���ҳ�渺������ļ�
    Url := vobj_Admin.GetUploadProcessFile;   //���ҳ�渺������ļ�
    try
      sResult := IdHTTP1.Post(Url, obj);    //�᷵��һ�������ύ��Ľ������
      Result := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('�ϴ��ļ�ʧ�ܣ�����ԭ��' + E.Message), ('����'), MB_OK + MB_ICONERROR);
        Result := False;
      end;
    end;
  finally
    obj.Free;
  end;
end;

function TDM.UpdateData(const sKey, sSqlStr: string;const vDelta: OleVariant;const ShowMsgBox:Boolean=True): Boolean;
var
  sError:string;
  cds_Temp:TClientDataSet;
  sData:string;
  iCompressType:Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;

    if Length(sData)>100*1024 then //׼��ѹ��
      iCompressType := 1
    else
      iCompressType := 0;

    if iCompressType=1 then
    begin
      sData := VCLZip1.ZLibCompressString(sData);
      sData := EncodeString(sData);
    end;

    Result := vobj_Admin.Update_Data(sKey,GetOneSqlStr(sSqlStr),iCompressType,sData,sError) ;

    //if not ShowMsgBox then Exit;

    if (not Result) or (sError<>'') then
    begin
      sError := '���ݱ���ʧ�ܣ���������±��棡���ܵ�ԭ��Ϊ������'+#13+sError;
      MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end else if ShowMsgBox then
      MessageBox(0, '�����ύ�����棩�ɹ�������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
  finally
    //vobj := nil;
    cds_Temp.Free;
  end;
end;

function AppSrvIsOK:Boolean;
begin
  try
    Result := vobj_Admin.SrvIsOK;
  except
    Result := False;
  end;
end;

{ TMessageHandler }

class procedure TMessageHandler.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
{  if Msg.message=WM_KEYDOWN then
    if (Msg.wParam=VK_RETURN ) and
      (
        (Screen.ActiveForm.ActiveControl is TEdit) or
        (Screen.ActiveForm.ActiveControl is TComboBox) or
        (Screen.ActiveForm.ActiveControl is TCheckBox) or
        (Screen.ActiveForm.ActiveControl is TRadioButton) or
        (Screen.ActiveForm.ActiveControl is TLabeledEdit) or
        (Screen.ActiveForm.ActiveControl is TDBEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBComboBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBCheckBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBNumberEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBDateTimeEditEh)
              //���������Ҫ�Ŀؼ�
      )
    then
    begin
      Msg.wParam:=VK_TAB;
    end
}{    else if (Msg.wParam=VK_RETURN) and
      (
       (Screen.ActiveForm.ActiveControl is TDBGrid)
      )
    then
    begin
      with Screen.ActiveForm.ActiveControl do
      begin
        //if Selectedindex<(FieldCount-1) then
        //  Selectedindex:=Selectedindex+1  // �ƶ�����һ�ֶ�
        //else
        //  Selectedindex:=0;
      end;
    end;
}
end;

function  LowerJeToUpper(const je:Real):string; //Сд���ת��Ϊ��д���
begin
  Result := NumToUpper(je);
end;

function TDM.PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                         const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Print 1:Privew 2:Design
begin
  Result := _PrintReport('',ReportFileName,cds_Master_XMLData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sId: string; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sData,fn:string;
begin
  sData := dm.OpenData('select * from �ɷѼ�¼�� where id='+quotedstr(sId));
  fn := '�ɷѵ�.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sIdList: Tstrings; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sWhere,sData,fn:string;
  i: Integer;
begin
  for i := 0 to sIdList.Count - 1 do
  begin
    sWhere := sWhere+quotedstr(sIdList[i])+',';
  end;
  if sWhere='' then Exit;

  if sWhere[Length(sWhere)]=',' then
    sWhere := Copy(sWhere,1,Length(sWhere)-1);

  sWhere := 'select * from �ɷѼ�¼�� where id in ('+sWhere+')';
  sData := dm.OpenData(sWhere);
  fn := '�ɷѵ�.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD2(const sId: string; const Page: Integer): Boolean;
var
  fn,sData:string;
begin
  sData := dm.OpenData('select * from �ɷѼ�¼�� where id='+quotedstr(sId));
  fn := '�ɷѵ�.fr3';
  Result := _PrintReport2('',fn,sData,Page);
end;

procedure SaveLog(const sMsg:string);
var
  sfn:string;
  sList:TStrings;
begin
  sfn := ExtractFilePath(ParamStr(0))+'jxgzlLog.Txt';
  sList := TStringList.Create;
  try
    if FileExists(sfn) then
    begin
      sList.LoadFromFile(sfn);
      if sList.Count>1000 then
        sList.Clear;
    end;
    sList.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS',Now)+' '+sMsg);
    sList.SaveToFile(sfn);
  finally
    sList.Free;
  end;
end;

function DataSetNoSave(const ClientDataSet1:TClientDataSet):Boolean;
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;
  Result := ClientDataSet1.ChangeCount>0;
end;

function ValidatePID(const APID: string): string;
  {�ڲ�����,ȡ���֤��У��λ,���һλ,��18λ��Ч}
  function GetVerifyBit(sIdentityNum: string): Char;
  var
    nNum: Integer;
  begin
    Result := #0;
    nNum := StrToInt(sIdentityNum[1]) * 7 +
            StrToInt(sIdentityNum[2]) * 9 +
            StrToInt(sIdentityNum[3]) * 10 +
            StrToInt(sIdentityNum[4]) * 5 +
            StrToInt(sIdentityNum[5]) * 8 +
            StrToInt(sIdentityNum[6]) * 4 +
            StrToInt(sIdentityNum[7]) * 2 +
            StrToInt(sIdentityNum[8]) * 1 +
            StrToInt(sIdentityNum[9]) * 6 +
            StrToInt(sIdentityNum[10]) * 3 +
            StrToInt(sIdentityNum[11]) * 7 +
            StrToInt(sIdentityNum[12]) * 9 +
            StrToInt(sIdentityNum[13]) * 10 +
            StrToInt(sIdentityNum[14]) * 5 +
            StrToInt(sIdentityNum[15]) * 8 +
            StrToInt(sIdentityNum[16]) * 4 +
            StrToInt(sIdentityNum[17]) * 2;
    nNum := nNum mod 11;
    case nNum of
      0: Result := '1';
      1: Result := '0';
      2: Result := 'X';
      3: Result := '9';
      4: Result := '8';
      5: Result := '7';
      6: Result := '6';
      7: Result := '5';
      8: Result := '4';
      9: Result := '3';
      10: Result := '2';
    end;
  end;
var
  L : Integer;
  sCentury : string;
  sYear2Bit : string;
  sMonth : string;
  sDate : string;
  iCentury : Integer;
  iMonth : Integer;
  iDate : Integer;
  CRCFact : string;//18λ֤�ŵ�ʵ��ֵ
  CRCTh : string; //18λ֤�ŵ�����ֵ
  FebDayAmt: Byte;//2������
begin
  L := Length(APID);
  if (L in [15, 18]) = False then
  begin
     Result := Format('���֤�Ų���15λ��18λ(%0:s, ʵ��λ��:%1:d)', [APID, L]);
     Exit;
  end;
  CRCFact := '';
  if L = 18 then
  begin
     sCentury := Copy(APID, 7, 2);
     iCentury := StrToInt(sCentury);
     if (iCentury in [18..20]) = False then
     begin
        Result := Format('���֤������Ч:18λ֤�ŵ����ǰ��λ������18-20֮��(%0:S)', [sCentury]);
        Exit;
     end;
     sYear2Bit := Copy(APID, 9, 2);
     sMonth := Copy(APID, 11, 2);
     sDate := Copy(APID, 13, 2);
     CRCFact := Copy(APID, 18, 1);
  end else
  begin
     sCentury := '19';
     sYear2Bit := Copy(APID, 7, 2);
     sMonth := Copy(APID, 9, 2);
     sDate := Copy(APID, 11, 2);
  end;
  iMonth := StrToInt(sMonth);
  iDate := StrToInt(sDate);
  if (iMonth in [01..12]) = False then
  begin
     Result := Format('���֤������Ч:�·ݱ�����01-12֮��(%0:s)', [sMonth]);
     Exit;
  end;
  if (iMonth in [1, 3, 5, 7, 8, 10, 12]) then
  begin
     if (iDate in [01..31]) = False then
     begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if (iMonth in [4, 6, 9, 11]) then
  begin
     if (iDate in [01..30]) = False then
     begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if IsLeapYear(StrToInt(sCentury + sYear2Bit)) = True then
  begin
     FebDayAmt := 29;
  end else
  begin
     FebDayAmt := 28;
  end;
  if (iMonth in [2]) then
  begin
     if (iDate in [01..FebDayAmt]) = False then
     begin
        Result := Format('���֤������Ч:������Ч,����Ϊ��򳬳��������ֵ(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if CRCFact <> '' then
  begin
     CRCTh := GetVerifyBit(APID);
     if CRCFact <> CRCTh then
     begin
        Result := Format('���֤������Ч:У��λ(��18λ)��:(%0:s)', [APID]);
        Exit;
     end;
  end;
end;

end.
