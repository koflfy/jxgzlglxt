unit uDataImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, ADODB, DBClient, ComCtrls, IniFiles,
  StatusBarEx, Grids, ValEdit;

type
  TDataImport = class(TForm)
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    OpenDialog1: TOpenDialog;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    StatusBarEx1: TStatusBarEx;
    vl_Field: TValueListEditor;
    GroupBox1: TGroupBox;
    edt_Excel: TEdit;
    btn_Open: TBitBtn;
    cbb_Tb: TComboBox;
    Panel1: TPanel;
    btn_Auto: TBitBtn;
    btn_Import: TBitBtn;
    ProgressBar1: TProgressBar;
    lbl_Hint: TLabel;
    btn_Stop: TBitBtn;
    cds_Delete: TClientDataSet;
    cds_Temp: TClientDataSet;
    pnl1: TPanel;
    lbl1: TLabel;
    cb_IdField: TComboBox;
    chk_Fast: TCheckBox;
    lbl2: TLabel;
    edt_Year: TEdit;
    lbl3: TLabel;
    edt_Xq: TEdit;
    btn_Exit: TBitBtn;
    chk_Delete: TCheckBox;
    procedure btn_OpenClick(Sender: TObject);
    procedure btn_ImportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AddClick(Sender: TObject);
    procedure vl_FieldGetPickList(Sender: TObject; const KeyName: string;
      Values: TStrings);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_AutoClick(Sender: TObject);
    procedure cbb_TbClick(Sender: TObject);
    procedure edt_ExcelChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_StopClick(Sender: TObject);
    procedure chk_FastClick(Sender: TObject);
    procedure chk_DeleteClick(Sender: TObject);
    procedure cds_TempBeforePost(DataSet: TDataSet);
    procedure cds_TempReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    MyiniFile:string;
    sField :TStrings;
    isStop :Boolean;
    Sqlstr :string;
    procedure Init_Desc;
    procedure Init_Source;
    procedure DeleteKsRecord;
    procedure Open_Desc_Table;
    function  GetRecordCount:Integer;
    procedure LoadIni;
    procedure SaveIni;
  public
    { Public declarations }
    Desc_Table:string;
    Desc_IdField:string;
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TDataImport.btn_AddClick(Sender: TObject);
begin
//  vl_Field.Strings[vl_Field.]
end;

procedure TDataImport.btn_AutoClick(Sender: TObject);
var
  i: Integer;
  ss:string;
begin
  LoadIni;
  for i := 0 to vl_Field.Strings.Count-1 do
  begin
    ss := vl_Field.Strings.ValueFromIndex[i];
    if (sField.IndexOf(ss)=-1) or
       (ss='<����>') then //������Ϣ���Ҳ���Ҫƥ�������
    begin
      if (sField.IndexOf(vl_Field.Keys[i])<>-1) then
        vl_Field.Values[vl_Field.Keys[i]] := sField.Strings[sField.IndexOf(vl_Field.Keys[i])]
      else
        vl_Field.Values[vl_Field.Keys[i]] := '<����>';
    end;
  end;
  vl_Field.DeleteRow(i);
end;

procedure TDataImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TDataImport.btn_ImportClick(Sender: TObject);
var
  i,Total_Count:integer;
  sSql,sWhere,ss,dd:string;
  s_IdField,s_IdValue:string;//ѧ�Ŷ�Ӧ��Դ�ֶ���
begin
  Open_Desc_Table;
  if (not cds_Temp.Active) then Exit;

  if (chk_Fast.Checked) and (cb_IdField.ItemIndex = -1) then
  begin
    Application.MessageBox('Դ�ļ���Ψһ�ֶ�û��ѡ����ѡ��Ҫ�����ļ���Ψһ�ֶΣ�����',
      'ϵͳ��ʾ', MB_OK + MB_ICONWARNING);
    cb_IdField.SetFocus;
    Exit;
  end;

  s_IdField := cb_IdField.Text;
  btn_Import.Enabled := False;
  btn_Stop.Enabled := True;
  isStop := False;

  s_IdValue := '';
  Total_Count := 0;

  Screen.Cursor := crHourGlass;
  try
    try
      //cds_Temp.Connection.BeginTrans;
      if chk_Delete.Checked then
      begin
        DeleteKsRecord;
        Screen.Cursor := crHourGlass;
      end;

      StatusBarEx1.Panels.Items[0].Text := '���ڵ���:';
      ProgressBar1.Max := GetRecordCount;
      ProgressBar1.Position := 1;
      while not isStop do
      begin
        if s_IdValue = '' then
          sWhere := ''
        else
          sWhere := ' where '+s_IdField+'>'+s_IdValue;

        AdoDataSet1.Close;
        if chk_Fast.Checked then
          sSql := 'select top 1000 * from ['+cbb_Tb.Text+']'+sWhere+' order by '+s_IdField
        else
          sSql := 'select * from ['+cbb_Tb.Text+']'+sWhere;

        AdoDataSet1.CommandText := sSql;
        AdoDataSet1.Open;
        if AdoDataSet1.RecordCount=0 then
          Break;

        if chk_Fast.Checked then
        begin
          AdoDataSet1.Last;
          if ADODataSet1.FieldByName(s_IdField).DataType in [ftString,ftWideString,ftDate,ftDateTime,ftTime] then
            s_IdValue := QuotedStr(ADODataSet1.FieldByName(s_IdField).AsString)
          else
            s_IdValue := ADODataSet1.FieldByName(s_IdField).AsString;
        end;

        Open_Desc_Table;

        AdoDataSet1.First;
        while not AdoDataSet1.eof do
        begin
          ProgressBar1.Position := Total_Count+AdoDataSet1.RecNo;
          Application.ProcessMessages;
          lbl_Hint.Caption := Inttostr(ProgressBar1.Position)+'/'+IntToStr(ProgressBar1.Max);
          cds_Temp.Append;

          cds_Temp.FieldByName('ѧ��').AsString := edt_Year.Text;
          cds_Temp.FieldByName('ѧ��').AsString := edt_Xq.Text;

          for i:=1 to vl_Field.Strings.Count do
          begin
            dd := vl_Field.Keys[i];
            ss := vl_Field.Values[dd];
            if (ss<>'') and (ss<>'<����>') then // and (cds_Temp.FieldByName(dd).DataType<>ftAutoInc) then
            begin
              if (ss[1]='''') and (ss[Length(ss)]='''') then
                 cds_Temp.FieldByName(dd).Value := Copy(ss,2,Length(ss)-2)
              else
                cds_Temp.FieldByName(dd).Value := AdoDataSet1.Fieldbyname(ss).Value;
            end;
          end;
          //-------------------------------------------------------------//
          if cds_Temp.FieldByName('��ѡ����').AsInteger<=0 then
            cds_Temp.Cancel
          else
            cds_Temp.Post;
          //-------------------------------------------------------------//
          AdoDataSet1.Next;
        end;
        if isStop  then
        begin
          cds_Temp.Close;
          cds_Temp.Open;
          Application.MessageBox(pchar('�û�ȡ�������ݵ��룡'+InttoStr(Total_Count)+'����¼�����룡'),'ϵͳ��ʾ',MB_OK+MB_ICONINFORMATION);
        end else
        begin
          if cds_Temp.ChangeCount>0 then
            //cds_Temp.ApplyUpdates(0);
            isStop := not DM.UpdateData(Desc_IdField,Sqlstr,cds_Temp.Delta,False);
        end;
        Total_Count := Total_Count + ADODataSet1.RecordCount;

        if not chk_Fast.Checked then
           Break;

        //cds_Temp.Connection.CommitTrans;
      end;   // end while (True) ...
      if not isStop  then
      begin
        Application.MessageBox(pchar('���ݵ�����ɣ�����'+IntToStr(Total_Count)+'����¼�ɹ����룡'),'���ݵ������',MB_OK+MB_ICONINFORMATION);
        ProgressBar1.Position := ProgressBar1.Max;
      end;
    Except
      //cds_Temp.Connection.RollbackTrans;
      Application.MessageBox(pchar('���ݵ���ʧ�ܣ�������¼�����룡'),'���ݵ���ʧ��',MB_OK+MB_ICONERROR);
    end;
  finally
    Screen.Cursor := crDefault;
    isStop := True;
    btn_Stop.Enabled := False;
    btn_Import.Enabled := True;
  end;
end;

procedure TDataImport.btn_OpenClick(Sender: TObject);
var
  s:string;
begin
  if OpenDialog1.Execute then
  begin
    edt_Excel.Text:=Opendialog1.FileName;
  end else
    Exit;

  s := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+edt_Excel.Text
       +';Extended Properties=Excel 8.0;Persist Security Info=False';

  AdoConnection1.Close;
  AdoConnection1.ConnectionString := s;

  if (edt_Excel.Text = '') then
     Exit;
     
  Screen.Cursor := crHourGlass;
  try
    try
      AdoConnection1.Connected := True;

      cbb_Tb.Items.Clear;
      ADOConnection1.GetTableNames(cbb_Tb.Items);
      cbb_Tb.ItemIndex := 0;

      if (cbb_Tb.Text = '') then
      begin
        ADOConnection1.Close;
        Application.MessageBox(PChar('Excel�ļ�����ʧ�ܣ���ȷ�ϴ��ļ��Ƿ�Excel97/2000��ʽ����'+#13+'����Գ�����Excel97/2000����򿪲�����һ������������'),'����ʧ��',MB_OK+MB_ICONERROR);
        Exit;
      end;

      Init_Source;
      Init_Desc;

      //Application.MessageBox('����Excel�ļ��ɹ���','���Գɹ�',MB_OK+MB_ICONINFORMATION);

    except
      Application.MessageBox('����Excel�ļ�ʱ����������ȷ�����ļ����ⲿû�б��κγ���ʹ�û�򿪣���������ԣ�','����ʧ��',MB_OK+MB_ICONERROR);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TDataImport.btn_StopClick(Sender: TObject);
begin
  if Application.MessageBox('���Ҫȡ�����ݵ�������𣿡���', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    isStop := True;
  end;
end;

procedure TDataImport.cbb_TbClick(Sender: TObject);
begin
  if cbb_Tb.Text<>'' then
    Init_Source;
end;

procedure TDataImport.cds_TempBeforePost(DataSet: TDataSet);
var
  xkh,jszgh,ss:string;
begin
//  DataSet.FieldByName('�����').AsString := DataSet.FieldByName('ѧ��').AsString+
//                                            DataSet.FieldByName('ѧ��').AsString+
//                                            DataSet.FieldByName('��ʦְ����').AsString+
//                                            DataSet.FieldByName('�γ̴���').AsString;
  xkh := DataSet.FieldByName('ѡ�οκ�').AsString;
  ss := '-000000000-';
  if Pos(ss,xkh)>0 then
  begin
    jszgh := '-'+DataSet.FieldByName('��ʦְ����').AsString+'-';
    xkh := StringReplace(xkh,ss,jszgh,[rfReplaceAll]);
  end;
  DataSet.FieldByName('�����').AsString := xkh;
end;

procedure TDataImport.cds_TempReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  MessageBox(Handle, PAnsiChar('���ݵ���ʧ�ܣ�ԭ��Ϊ����'+E.Message), 'ϵͳ��ʾ', MB_OK + 
    MB_ICONSTOP + MB_TOPMOST);
end;

procedure TDataImport.chk_DeleteClick(Sender: TObject);
begin
  if chk_Delete.Checked then
    if Application.MessageBox('����ǰ��Ҫɾ��Ŀ�����ԭ�е������𣿡���', 
      'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) = IDNO then
    begin
      chk_Delete.Checked := False;
    end;
end;

procedure TDataImport.chk_FastClick(Sender: TObject);
begin
  pnl1.Visible := chk_Fast.Checked;
end;

procedure TDataImport.DeleteKsRecord;
var
//  sID:string;
  sDeleteSql:string;
begin
  StatusBarEx1.Panels.Items[0].Text := '����ɾ��:';
  Screen.Cursor := crHourGlass;
  try
    ProgressBar1.Max := vobj_Admin.GetRecordCount(Desc_Table);
    //sID := '';
    while True do
    begin
      Application.ProcessMessages;
      if isStop then
         Exit;

      if chk_Fast.Checked then
         sDeleteSql := 'select top 100 '+Desc_IdField+' from '+Desc_Table
      else
         sDeleteSql := 'select '+Desc_IdField+' from '+Desc_Table;

      cds_Delete.XMLData := dm.OpenData(sDeleteSql);

      if cds_Delete.RecordCount=0 then
        break;

      cds_Delete.Last;
      while not cds_Delete.Bof do
      begin
        Application.ProcessMessages;
        if isStop then
           Exit;

        lbl_Hint.Caption := Inttostr(ProgressBar1.Position)+'/'+IntToStr(ProgressBar1.Max);
        ProgressBar1.Position := ProgressBar1.Position+1;
        cds_Delete.Delete;
      end;
      if cds_Delete.ChangeCount>0 then
        //cds_Delete.ApplyUpdates(0);
        dm.UpdateData(Desc_IdField,sDeleteSql,cds_Delete.Delta,False);
      if not chk_Fast.Checked then
         break;
    end;
  finally
    StatusBarEx1.Panels.Items[0].Text := 'ɾ����ɣ�';
    cds_Delete.Close;
    Screen.Cursor := crDefault;
  end;
end;

procedure TDataImport.edt_ExcelChange(Sender: TObject);
begin
  cbb_Tb.Enabled := edt_Excel.Text<>'';
end;

procedure TDataImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AdoDataSet1.Close;
  cds_Temp.Close;
  AdoConnection1.Close;
  SaveIni;
  Action := caFree;
end;

procedure TDataImport.FormCreate(Sender: TObject);
begin
  MyiniFile := ExtractFilePath(ParamStr(0))+'ImportFieldSet.ini';
  edt_Year.Text := gb_Cur_Xn;
  edt_Xq.Text := gb_Cur_Xq;

  sField := TStringList.Create;
  Desc_Table := '��ѧ�����';
  Desc_IdField := 'Id';
end;

procedure TDataImport.FormDestroy(Sender: TObject);
begin
  sField.Free;
end;

function TDataImport.GetRecordCount: Integer;
begin
  Result := ADOConnection1.Execute('select count(*) from ['+cbb_Tb.Text+']').Fields[0].Value;
end;

procedure TDataImport.Init_Desc;
var
  i:integer;
begin
  cds_Temp.XMLData := DM.OpenData('select top 0 * from '+Desc_Table);
  cds_Temp.First;
  with cds_Temp do
  begin
    vl_Field.Strings.Clear;
    for i:=0 to FieldCount-1 do
    begin
      if (Fields[i].FieldName='ѧ��') or (Fields[i].FieldName='ѧ��') or
         (Fields[i].FieldName='��������') or (Fields[i].FieldName='�����') or
         (Fields[i].DataType = ftAutoInc) then
        Continue;
      if Fields[i].DataType = ftAutoInc then
        vl_Field.Strings.Add(Fields[i].FieldName+'=<����>')
      else
        vl_Field.Strings.Add(Fields[i].FieldName+'=');
    end;
  end;
end;

procedure TDataImport.Init_Source;
var
  i:integer;
begin
  with AdoDataSet1 do
  begin
    Close;
    CommandText := 'select * from ['+cbb_Tb.Text+'] where 1=0';
    Open;
    sField.Clear;
    cb_IdField.Items.Clear;
    sField.Add('<����>');
    for i:=0 to FieldCount-1 do
    begin
      sField.Add(Fields[i].FieldName);
    end;
    cb_IdField.Items.Addstrings(sField);
    Close;
  end;
end;

procedure TDataImport.LoadIni;
var
  i,ii:Integer;
  skey,sValue:string;
  sList:TStringList;
begin
  sList := TStringList.Create;
  try
    if FileExists(MyiniFile) then
      sList.LoadFromFile(MyiniFile);
    for i := 0 to vl_Field.Strings.Count-1 do
    begin
      sKey := vl_Field.Keys[i];
      //sValue := vl_Field.Values[i];
      ii := sList.IndexOfName(skey);
      if ii=-1 then
        vl_Field.Values[skey] := '<����>'
      else
      begin
        if sField.IndexOf(sList.ValueFromIndex[ii])<>-1 then
          vl_Field.Values[skey] := sList.ValueFromIndex[ii]
        else
          vl_Field.Values[skey] := '<����>';
      end;
    end;
  finally
    sList.Free;
  end;
end;

procedure TDataImport.Open_Desc_Table;
begin
  Sqlstr := 'select * from '+Desc_Table;
  cds_Temp.XMLData := DM.OpenData(Sqlstr);
end;

procedure TDataImport.SaveIni;
begin
  vl_Field.Strings.SaveToFile(MyiniFile);
end;

procedure TDataImport.vl_FieldGetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  if not vobj_Admin.IsAutoIncField(KeyName,Desc_Table) then
    Values.Assign(sField)
  else
  begin
    Values.Clear;
  end;
end;

end.
