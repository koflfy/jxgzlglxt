unit uCjImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, CnButtonEdit, DB, DBClient, Mask,CnProgressFrm,
  DBCtrlsEh, pngimage, ExtCtrls, Buttons, ADODB, frxpngimage, DBGrids,ShellAPI;

type
  TCjImport = class(TForm)
    Panel1: TPanel;
    btn_Exit: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    ClientDataSet1: TClientDataSet;
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    ValueListEditor1: TValueListEditor;
    GroupBox1: TGroupBox;
    cbb_Tb: TComboBox;
    edt_Excel: TCnButtonEdit;
    OpenDialog1: TOpenDialog;
    btn_Import: TBitBtn;
    lbl1: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure edt_ExcelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ValueListEditor1GetPickList(Sender: TObject;
      const KeyName: string; Values: TStrings);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_TbChange(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_ImportClick(Sender: TObject);
  private
    { Private declarations }
    sFieldList:TStrings;
    procedure GetSourceFieldList;
    procedure InitValueListEditor;
  public
    { Public declarations }
  end;

var
  CjImport: TCjImport;

implementation
uses uDM;
{$R *.dfm}

procedure TCjImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCjImport.btn_ImportClick(Sender: TObject);
var
  iSucessedCount,iErrorCount:Integer;
  sMsg,zkzh,kcmc,sqlstr,sWhere:string;
  cj:Double;
  ErrorList:TStrings;
  fn:string;
begin
  if (ValueListEditor1.Values['׼��֤��']='') or
     (ValueListEditor1.Values['���Կγ�']='') or
     (ValueListEditor1.Values['�ɼ�']='') then
  begin
    MessageBox(Handle, '������֤ʧ�ܣ�׼��֤�š����Կγ̡��ɼ��ֶβ���Ϊ�գ���', 'ϵͳ��ʾ', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  if MessageBox(Handle, '����ɼ�ʱ���滻�Ѵ��ڵĸÿ�������ѡ�γ̳ɼ�����' +
    #13#10 + '��Ҫ�������뿼���ɼ��𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if UpperCase(InputBox('����ȷ��','�����롾OK��ȷ�ϲ�����',sMsg))<>'OK' then
     Exit
  else
     sMsg := '';

  Screen.Cursor := crHourGlass;
  btn_Import.Enabled := False;
  btn_Exit.Enabled := False;
  ErrorList := TStringList.Create;
  ErrorList.Add(DateTimeToStr(Now)+' �Ѻ��Կ�����¼��');
  fn := ExtractFilePath(ParamStr(0))+'�ɼ�������־.txt';
  DeleteFile(fn);
  iSucessedCount := 0;
  iErrorCount := 0;
  try
    //ClientDataSet1.XMLData := dm.OpenData('select * from �����ɼ���');

    AdoDataSet1.Close;
    AdoDataSet1.CommandText := 'select * from ['+cbb_Tb.Text+']';
    AdoDataSet1.Open;

    ShowProgress('���ڸ��¿����ɼ�',ADODataSet1.RecordCount);

    AdoDataSet1.First;
    while not AdoDataSet1.Eof do
    begin
      UpdateProgress(ADODataSet1.RecNo);
      zkzh := Trim(ADODataSet1.FieldByName(ValueListEditor1.Values['׼��֤��']).AsString);
      kcmc := Trim(ADODataSet1.FieldByName(ValueListEditor1.Values['���Կγ�']).AsString);
      cj := ADODataSet1.FieldByName(ValueListEditor1.Values['�ɼ�']).AsFloat;

      sWhere := ' where ׼��֤��='+quotedstr(zkzh)+' and ���Կγ�='+quotedstr(kcmc);
      sqlstr := 'update �����ɼ��� set �ɼ�='+FloatTostr(cj)+sWhere+' and �Ƿ��ύ=0';
      if vobj_Admin.RecordIsExists(sWhere,'�����ɼ���') and dm.ExecSql(sqlstr) then
        Inc(iSucessedCount)
      else
      begin
        Inc(iErrorCount);
        ErrorList.Add(IntToStr(iErrorCount)+':'+zkzh+','+kcmc+','+FloatToStr(cj)+',�����ÿγ̲����ڻ����ϴ���');
      end;
      AdoDataSet1.Next;
    end;
    HideProgress;
    sMsg := 'Excel����'+IntToStr(ADODataSet1.RecordCount)+'����¼�����γɹ�����'+IntToStr(iSucessedCount)+'��������'+IntTostr(iErrorCount)+'����';
    ErrorList.Insert(0,sMsg);

    if iSucessedCount>0 then
    begin
      MessageBox(Handle,pchar('������ɣ�'+sMsg),'�������',MB_OK+MB_ICONINFORMATION);
    end else
    begin
      ErrorList.Clear;
      ErrorList.Add('�ɼ�����ʧ�ܣ�0����¼�����£�');
    end;
    
    ErrorList.SaveToFile(fn);
    if FileExists(fn) then
      ShellExecute(Handle,'open',PChar(fn),nil,nil,SW_SHOWNORMAL);
  finally
    HideProgress;
    adoDataSet1.Close;
    btn_Import.Enabled := True;
    btn_Exit.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCjImport.cbb_TbChange(Sender: TObject);
begin
  GetSourceFieldList;
  InitValueListEditor;
  //ValueListEditor1.ItemProps['׼��֤��'].PickList.Assign(sFieldList);

  if (sFieldList.IndexOf('׼��֤��')<>-1) then
    ValueListEditor1.Values['׼��֤��'] := '׼��֤��'
  else
    ValueListEditor1.Values['׼��֤��'] := '';

  if (sFieldList.IndexOf('���Կγ�')<>-1) then
    ValueListEditor1.Values['���Կγ�'] := '���Կγ�'
  else
    ValueListEditor1.Values['���Կγ�'] := '';

  if (sFieldList.IndexOf('�ɼ�')<>-1) then
    ValueListEditor1.Values['�ɼ�'] := '�ɼ�'
  else
    ValueListEditor1.Values['�ɼ�'] := '';
    
end;

procedure TCjImport.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  //DataSet.FieldByName('״̬').Value := '����';
  DataSet.FieldByName('¼��Ա').Value := gb_Czy_ID;
  DataSet.FieldByName('¼��ʱ��').Value := Now;
  DataSet.FieldByName('�Ƿ��ύ').Value := 0;
end;

procedure TCjImport.edt_ExcelButtonClick(Sender: TObject);
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
      cbb_TbChange(Self);

      if (cbb_Tb.Text = '') then
      begin
        Application.MessageBox(PChar('Excel�ļ�����ʧ�ܣ���ȷ�ϴ��ļ��Ƿ�Excel97/2000��ʽ����'+#13+'����Գ�����Excel97/2000����򿪲�����һ������������'),'����ʧ��',MB_OK+MB_ICONERROR);
        Exit;
      end;

      //Application.MessageBox('����Excel�ļ��ɹ���','���Գɹ�',MB_OK+MB_ICONINFORMATION);

    except
      Application.MessageBox('����Excel�ļ�ʱ����������ȷ�����ļ����ⲿû�б��κγ���ʹ�û�򿪣���������ԣ�','����ʧ��',MB_OK+MB_ICONERROR);
    end;
  finally
    cbb_Tb.Enabled := ADOConnection1.Connected;
    ValueListEditor1.Enabled := ADOConnection1.Connected;
    btn_Import.Enabled := ADOConnection1.Connected;

    if ValueListEditor1.Enabled then
      ValueListEditor1.Color := clWindow
    else
      ValueListEditor1.Color := clBtnFace;

    edt_Excel.SetFocus;

    //ADOConnection1.Close;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCjImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCjImport.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  sFieldList := TStringList.Create;
  //InitValueListEditor;
  for i := 0 to 7 do
  begin
    ValueListEditor1.RowHeights[i] := 25; // �������߶�
    ValueListEditor1.ItemProps[1].ReadOnly := True; // ֻ��
  end;
end;

procedure TCjImport.FormDestroy(Sender: TObject);
begin
  sFieldList.Free;
end;

procedure TCjImport.GetSourceFieldList;
var
  i:integer;
begin
  with AdoDataSet1 do
  begin
    Close;
    CommandText := 'select * from ['+cbb_Tb.Text+'] where 1=0';
    Open;
    sFieldList.Clear;
    //sFieldList.Add('<����>');
    for i:=0 to FieldCount-1 do
    begin
      sFieldList.Add(Fields[i].FieldName);
    end;
    Close;
  end;
end;

procedure TCjImport.InitValueListEditor;
var
  i: Integer;
begin
  ValueListEditor1.Values['׼��֤��'] := '';
  ValueListEditor1.RowHeights[1] := 25;
  ValueListEditor1.ItemProps['׼��֤��'].EditStyle := esPickList;

  ValueListEditor1.Values['���Կγ�'] := '';
  ValueListEditor1.RowHeights[2] := 25;
  ValueListEditor1.ItemProps['���Կγ�'].EditStyle := esPickList;

  ValueListEditor1.Values['�ɼ�'] := '';
  ValueListEditor1.RowHeights[3] := 25;
  ValueListEditor1.ItemProps['�ɼ�'].EditStyle := esPickList;

  ValueListEditor1.Values['״̬'] := '';//QuotedStr('����');
  ValueListEditor1.RowHeights[4] := 25;
  ValueListEditor1.ItemProps['״̬'].EditStyle := esPickList;//esSimple;

  ValueListEditor1.Values['¼��Ա'] := QuotedStr(gb_Czy_ID);
  ValueListEditor1.RowHeights[5] := 25;
  ValueListEditor1.ItemProps['¼��Ա'].EditStyle := esSimple;

  ValueListEditor1.Values['¼��ʱ��'] := QuotedStr(DateTimeToStr(Now));
  ValueListEditor1.RowHeights[6] := 25;
  ValueListEditor1.ItemProps['¼��ʱ��'].EditStyle := esSimple;

  ValueListEditor1.Values['�Ƿ��ύ'] := QuotedStr('��');
  ValueListEditor1.RowHeights[7] := 25;
  ValueListEditor1.ItemProps['�Ƿ��ύ'].EditStyle := esSimple;

  for i := 0 to 7 do
  begin
    ValueListEditor1.RowHeights[0] := 25; // �������߶�
    ValueListEditor1.ItemProps[1].ReadOnly := True; // ֻ��
  end;
end;

procedure TCjImport.ValueListEditor1GetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  if (KeyName='׼��֤��') or (KeyName='���Կγ�') or (KeyName='�ɼ�') or (KeyName='״̬') then
  begin
    //if Self.Showing then
    //  GetSourceFieldList;
    Values.Assign(sFieldList);
  end;
end;

end.
