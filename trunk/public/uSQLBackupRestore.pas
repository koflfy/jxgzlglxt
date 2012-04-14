unit uSQLBackupRestore;

interface
uses SysUtils,Windows,ADODB,Controls,Forms,Dialogs,IniFiles;

var
  sSaConnStr:string;

function ReadBakPath:string;
function WriteBakPath(const sBakPath:string):Boolean;
function WriteAutoBackup(const Value:Boolean=True):Boolean;
function ReadAutoBackup:Boolean;

function BackupSQLDB(const bkfn:string='';const IsPrompt:Boolean=False):Boolean;
function RestoreSQLDB(const bkfn:string;const IsPrompt:Boolean=False):Boolean;
function CurHostIsDBSrvHost:Boolean;

implementation
uses uDbConnect,uInputSAPwd,Net;

function ReadBakPath:string;
var
  sBakPath,fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'DbBakSet.ini';
  with TIniFile.Create(fn) do
  try
    sBakPath := ReadString('SRVSET','BAKPATH','');
    if sBakPath='' then
    begin
      if DirectoryExists('D:\') then
        sBakPath := 'D:\PayDB_BAK\'
      else if DirectoryExists('E:\') then
        sBakPath := 'E:\PayDB_BAK\'
      else if DirectoryExists('F:\') then
        sBakPath := 'F:\PayDB_BAK\'
      else if DirectoryExists('G:\') then
        sBakPath := 'G:\PayDB_BAK\'
      else if DirectoryExists('H:\') then
        sBakPath := 'H:\PayDB_BAK\'
      else
        sBakPath := ExtractFilePath(ParamStr(0))+'PayDB_BAK\';
      WriteBakPath(sBakPath);
    end;
    if sBakPath[Length(sBakPath)]<>'\' then sBakPath := sBakPath+'\';
    Result := sBakPath;
  finally
    Free;
  end;
end;

function WriteBakPath(const sBakPath:string):Boolean;
var
  sPath,fn:string;
begin
  sPath := sBakPath;
  fn := ExtractFilePath(ParamStr(0))+'DbBakSet.ini';
  with TIniFile.Create(fn) do
  try
    if sPath='' then  sPath := ExtractFilePath(ParamStr(0))+'BAK\';
    if sPath[Length(sPath)]<>'\' then sPath := sPath+'\';
    WriteString('SRVSET','BAKPATH',sPath);
    if not DirectoryExists(sPath) then
      CreateDir(sPath);
    Result := True;
  finally
    Free;
  end;
end;

function WriteAutoBackup(const Value:Boolean=True):Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SrvSet.ini';
  with TIniFile.Create(fn) do
  try
    WriteBool('SRVSET','AUTOBACK',Value);
    Result := True;
  finally
    Free;
  end;
end;

function ReadAutoBackup:Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SrvSet.ini';
  with TIniFile.Create(fn) do
  try
    Result := ReadBool('SRVSET','AUTOBACK',True);
  finally
    Free;
  end;
end;

//1) ����ʽ�ı������ݿ⵽�ļ�
function BackupSQLDB(const bkfn:string='';const IsPrompt:Boolean=False):Boolean;
var
  adoConnStr,vHost,vDb,vSa,vPwd,vMode:string;
  adoConn_Temp:TADOConnection;
  sBakPath,old_fn,fn,sqlstr:string;
begin
  fn := bkfn;
  sBakPath := ReadBakPath;
  if not DirectoryExists(sBakPath) then
    CreateDir(sBakPath);

  if fn = '' then
    fn := sBakPath+FormatDateTime('yyyy-mm-dd',Date)+'����.dbk';

  old_fn := sBakPath+FormatDateTime('yyyy-mm-dd',Date-3)+'����.dbk';

  adoConnStr := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
  Result := False;
  if adoConnStr='' then Exit;

  if IsPrompt then
  begin
    if FileExists(fn) then
    begin
      if MessageBox(0, '�����ļ��Ѵ��ڣ�Ҫ�������𣿡���', 'ϵͳ��ʾ',
        MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        Exit;
      end;
    end;
    if MessageBox(0, '���ݿⱸ�ݲ�������Ҫ���������������Ӳ��ȡ���' +
      #13#10 + '��ʱ�䣡��Ҫ�������ݱ��ݲ����𣿡���', 'ϵͳ��ʾ', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;

  Result := DbSrvIsOK;
  if not Result then
    Exit;

  if FileExists(old_fn) then//ɾ������֮ǰ�ı��ݣ����ⱸ���ļ�����
     DeleteFile(PChar(old_fn));
  if FileExists(fn) then
     DeleteFile(PChar(fn));

  adoConn_Temp := TADOConnection.Create(nil);
  adoConn_Temp.ConnectionString := adoConnStr;
  adoConn_Temp.LoginPrompt := False;
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'BACKUP DATABASE '+vDb+' TO DISK = '+quotedstr(fn)+' WITH INIT';
    try
      adoConn_Temp.Execute(sqlstr);
      if IsPrompt then
         MessageBox(0, '������ɣ������ѳɹ����ݣ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      Result := True;
    except
      Result := False;
      if IsPrompt then
         MessageBox(0, '���ݱ���ʧ�ܣ�������̿ռ��Ƿ���㣡����', 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end;
  finally
    adoConn_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

//2) ���ݻָ�
function RestoreSQLDB(const bkfn:string;const IsPrompt:Boolean=False):Boolean;
var
  adoConn_Temp:TADOConnection;
  sqlstr:string;
  vHost,vDb,vSa,vPwd,vMode:string;
begin
  Result := False;
  //if IsPrompt then
  begin
    if MessageBox(0, '���ݻָ�������ɾ����ǰ���ݿ���е����м�¼������' +
      #13#10 + '��Ҫ�������ݻָ������𣿡���', 'ϵͳ��ʾ', MB_YESNO +
      MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

    if not FileExists(bkfn) then
    begin
      MessageBox(0, '�����ļ������ڣ���ѡ��Ҫ�ָ��ı����ļ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
    sSaConnStr := '';
    TInputSaPwd.Create(nil).ShowModal;
    if sSaConnStr='' then
      Exit;

    if MessageBox(0, '���ݻָ�������ɾ����ǰ���ݿ���е����м�¼������' +
      #13#10 + 'ȷ��Ҫ�������ݻָ������𣿡���', '�ٴ�ȷ��', MB_YESNO +
      MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

  end;

  if ReadConnInfo(vHost,vDb,vSa,vPwd,vMode)='' then Exit;
  adoConn_Temp := TADOConnection.Create(nil);
  adoConn_Temp.ConnectionString := sSaConnStr;
  adoConn_Temp.LoginPrompt := False;
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'USE MASTER'+#13+
              'ALTER DATABASE '+vDb+' SET OFFLINE WITH ROLLBACK IMMEDIATE'+#13+
              'RESTORE DATABASE '+vDb+' FROM DISK = '+quotedstr(bkfn)+' WITH RECOVERY'+#13+
              'ALTER DATABASE '+vDb+' SET ONLINE WITH ROLLBACK IMMEDIATE';
    try
      adoConn_Temp.Execute('USE MASTER');
      adoConn_Temp.BeginTrans;
      adoConn_Temp.Execute('ALTER DATABASE '+vDb+' SET OFFLINE WITH ROLLBACK IMMEDIATE');
      adoConn_Temp.Execute('RESTORE DATABASE '+vDb+' FROM DISK = '+quotedstr(bkfn)+' WITH REPLACE');
      adoConn_Temp.Execute('ALTER DATABASE '+vDb+' SET ONLINE WITH ROLLBACK IMMEDIATE');
      adoConn_Temp.CommitTrans;
      Result := True;
      if IsPrompt then
        MessageBox(0, '������ɣ������ѳɹ��ָ�������', 'ϵͳ��ʾ', MB_OK +  MB_ICONINFORMATION + MB_TOPMOST);
    except
      on e:Exception do
      begin
        adoConn_Temp.RollbackTrans;
        if IsPrompt then
          MessageBox(0, PChar('���ݻָ�ʧ�ܣ��������ݿ�������Ƿ���ѶϿ�������'+#13+e.Message+'����'),'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Result := False;
      end;
    end;
  finally
    adoConn_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function CurHostIsDBSrvHost:Boolean;
var
  vHost,vDb,vSa,vPwd,vMode:string;
begin
  Result := False;
  if ReadConnInfo(vHost,vDb,vSa,vPwd,vMode)='' then Exit;
  vHost := LowerCase(vHost);
  Result := (vHost='(local)') or (vHost='localhost') or
            (vHost='127.0.0.1') or (vHost='.') or
            (vHost=LowerCase(GetLocalHostName)) or
            (vHost=GetLocalIpStr);
end;

end.
