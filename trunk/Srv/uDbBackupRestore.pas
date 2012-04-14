unit uDbBackupRestore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RzTabs;

type
  TDbBackupRestore = class(TForm)
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPageControl2: TRzPageControl;
    TabSheet2: TRzTabSheet;
    lbledt_Backup: TLabeledEdit;
    btn_Browse: TSpeedButton;
    chk_Auto: TCheckBox;
    btn_Backup: TBitBtn;
    lbledt_Restore: TLabeledEdit;
    btn_FileName: TSpeedButton;
    btn_Restore: TBitBtn;
    lbl1: TLabel;
    btn_Exit: TBitBtn;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    lbl_Hint: TLabel;
    lbledt_BakPath: TLabeledEdit;
    btn_Dir: TSpeedButton;
    btn_SetBakPath: TBitBtn;
    procedure btn_FileNameClick(Sender: TObject);
    procedure btn_RestoreClick(Sender: TObject);
    procedure btn_BackupClick(Sender: TObject);
    procedure btn_BrowseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbledt_RestoreChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chk_AutoClick(Sender: TObject);
    procedure btn_SetBakPathClick(Sender: TObject);
    procedure btn_DirClick(Sender: TObject);
    procedure lbledt_BakPathChange(Sender: TObject);
    procedure lbledt_BackupChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uSQLBackupRestore,Net;
{$R *.dfm}
{
function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer stdcall;
begin
    if (uMsg = BFFM_INITIALIZED) and (lpData <> 0) then
    SendMessage(Wnd, BFFM_SETSELECTION, Integer(True), lpdata);
    result := 0;
end;

function SelectFolder(const Caption: string; const Root: WideString;
    var Directory: string): boolean;
var
  WindowList: Pointer;
  BrowseInfo: TBrowseInfo;
  Buffer: PChar;
  OldErrorMode: Cardinal;
  RootItemIDList, ItemIDList: PItemIDList;
  ShellMalloc: IMalloc;
  IDesktopFolder: IShellFolder;
  Eaten, Flags: LongWord;
begin
  Result := False;
  if not DirectoryExists(Directory) then
    Directory := '';
  FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      RootItemIDList := nil;
      if Root <> '' then
      begin
        SHGetDesktopFolder(IDesktopFolder);
        IDesktopFolder.ParseDisplayName(Application.Handle, nil,
        POleStr(Root), Eaten, RootItemIDList, Flags);
      end;
      with BrowseInfo do
      begin
        hwndOwner := Application.Handle;
        pidlRoot := RootItemIDList;
        pszDisplayName := Buffer;
        lpszTitle := PChar(Caption);
        ulFlags := BIF_RETURNONLYFSDIRS;
        if Directory <> '' then
        begin
          lpfn := SelectDirCB;
          lParam := Integer(PChar(Directory));
        end;
      end;
      WindowList := DisableTaskWindows(0);
      OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
      try
        ItemIDList := ShBrowseForFolder(BrowseInfo);
      finally
        SetErrorMode(OldErrorMode);
        EnableTaskWindows(WindowList);
      end;
      Result := ItemIDList <> nil;
      if Result then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Directory := Buffer;
      end;
    finally
        ShellMalloc.Free(Buffer);
    end;
  end;
end;
}
procedure TDbBackupRestore.btn_BackupClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('ע�⣡'+#13+'�������ڱ����ļ��Ǵ����MS SQL Server���ݿ�������еģ�����' +
    #13#10 + '�ʱ���ȷ�������ݿ���������Ѵ�����������ļ��У�' + #13#10+ExtractFileDir(lbledt_Backup.Text)+#13+#13+ '�������ڻ�Ҫ�����������ݱ��ݲ�����'),
    'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDYES then
  begin
    BackupSQLDB(lbledt_Backup.Text,True);
  end;
end;

procedure TDbBackupRestore.btn_BrowseClick(Sender: TObject);
var
  vdir:String;
begin
  vdir := ExtractFilePath(lbledt_Backup.Text);
  dlgSave1.InitialDir := vdir;
  dlgSave1.FileName := FormatDateTime('yyy-mm-dd',Date)+'����.dbk';
  if dlgSave1.Execute then
  //if SelectFolder('��ѡ��Ҫ��ű����ļ���Ŀ¼','',vdir) then
  begin
    lbledt_Backup.Text := dlgSave1.FileName;
  end;
end;

procedure TDbBackupRestore.btn_DirClick(Sender: TObject);
var
  sBakPath:string;
begin
  sBakPath := ReadBakPath;
  SelectFolder('Ĭ�ϱ���Ŀ¼ѡ��','',sBakPath);
  lbledt_BakPath.Text := sBakPath;
end;

procedure TDbBackupRestore.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure TDbBackupRestore.btn_FileNameClick(Sender: TObject);
begin
  if lbledt_Restore.Text<>'' then
    dlgOpen1.InitialDir := ExtractFilePath(lbledt_Restore.Text)
  else
    dlgOpen1.InitialDir := ExtractFilePath(lbledt_Backup.Text);
    
  if dlgOpen1.Execute then
  begin
    lbledt_Restore.Text := dlgOpen1.FileName;
  end;
end;

procedure TDbBackupRestore.btn_RestoreClick(Sender: TObject);
begin
  RestoreSQLDB(lbledt_Restore.Text,True);
end;

procedure TDbBackupRestore.btn_SetBakPathClick(Sender: TObject);
begin
  WriteBakPath(lbledt_BakPath.Text);
end;

procedure TDbBackupRestore.chk_AutoClick(Sender: TObject);
begin
  WriteAutoBackup(chk_Auto.Checked);
end;

procedure TDbBackupRestore.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDbBackupRestore.FormCreate(Sender: TObject);
var
  sBakPath,fn:string;
begin
  btn_Browse.Enabled := CurHostIsDBSrvHost; //��ǰ������Ƿ�������ݿ���������ڵĻ���
  sBakPath := ReadBakPath;
  lbledt_BakPath.Text := sBakPath;
  lbledt_Backup.Text := sBakPath+FormatDateTime('yyy-mm-dd',Date)+'����.dbk';
  if not DirectoryExists(sBakPath) then
    CreateDir(sBakPath);

  chk_Auto.Checked := ReadAutoBackup;
end;

procedure TDbBackupRestore.lbledt_BackupChange(Sender: TObject);
begin
  btn_Backup.Enabled := lbledt_Backup.Text<>'';
end;

procedure TDbBackupRestore.lbledt_BakPathChange(Sender: TObject);
begin
  btn_SetBakPath.Enabled := lbledt_BakPath.Text<>'';
end;

procedure TDbBackupRestore.lbledt_RestoreChange(Sender: TObject);
begin
  btn_Restore.Enabled := lbledt_Restore.Text<>'';
end;

end.
