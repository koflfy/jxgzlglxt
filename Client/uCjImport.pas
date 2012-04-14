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
  if (ValueListEditor1.Values['准考证号']='') or
     (ValueListEditor1.Values['考试课程']='') or
     (ValueListEditor1.Values['成绩']='') then
  begin
    MessageBox(Handle, '数据验证失败！准考证号、考试课程、成绩字段不能为空！　', '系统提示', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  if MessageBox(Handle, '导入成绩时将替换已存在的该考生的所选课程成绩！　' +
    #13#10 + '还要继续导入考生成绩吗？　', '系统提示', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if UpperCase(InputBox('导入确认','请输入【OK】确认操作：',sMsg))<>'OK' then
     Exit
  else
     sMsg := '';

  Screen.Cursor := crHourGlass;
  btn_Import.Enabled := False;
  btn_Exit.Enabled := False;
  ErrorList := TStringList.Create;
  ErrorList.Add(DateTimeToStr(Now)+' 已忽略考生记录：');
  fn := ExtractFilePath(ParamStr(0))+'成绩导入日志.txt';
  DeleteFile(fn);
  iSucessedCount := 0;
  iErrorCount := 0;
  try
    //ClientDataSet1.XMLData := dm.OpenData('select * from 考生成绩表');

    AdoDataSet1.Close;
    AdoDataSet1.CommandText := 'select * from ['+cbb_Tb.Text+']';
    AdoDataSet1.Open;

    ShowProgress('正在更新考生成绩',ADODataSet1.RecordCount);

    AdoDataSet1.First;
    while not AdoDataSet1.Eof do
    begin
      UpdateProgress(ADODataSet1.RecNo);
      zkzh := Trim(ADODataSet1.FieldByName(ValueListEditor1.Values['准考证号']).AsString);
      kcmc := Trim(ADODataSet1.FieldByName(ValueListEditor1.Values['考试课程']).AsString);
      cj := ADODataSet1.FieldByName(ValueListEditor1.Values['成绩']).AsFloat;

      sWhere := ' where 准考证号='+quotedstr(zkzh)+' and 考试课程='+quotedstr(kcmc);
      sqlstr := 'update 考生成绩表 set 成绩='+FloatTostr(cj)+sWhere+' and 是否提交=0';
      if vobj_Admin.RecordIsExists(sWhere,'考生成绩表') and dm.ExecSql(sqlstr) then
        Inc(iSucessedCount)
      else
      begin
        Inc(iErrorCount);
        ErrorList.Add(IntToStr(iErrorCount)+':'+zkzh+','+kcmc+','+FloatToStr(cj)+',考生该课程不存在或已上传！');
      end;
      AdoDataSet1.Next;
    end;
    HideProgress;
    sMsg := 'Excel共有'+IntToStr(ADODataSet1.RecordCount)+'条记录，本次成功更新'+IntToStr(iSucessedCount)+'条，忽略'+IntTostr(iErrorCount)+'条！';
    ErrorList.Insert(0,sMsg);

    if iSucessedCount>0 then
    begin
      MessageBox(Handle,pchar('操作完成！'+sMsg),'操作完成',MB_OK+MB_ICONINFORMATION);
    end else
    begin
      ErrorList.Clear;
      ErrorList.Add('成绩导入失败！0条记录被更新！');
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
  //ValueListEditor1.ItemProps['准考证号'].PickList.Assign(sFieldList);

  if (sFieldList.IndexOf('准考证号')<>-1) then
    ValueListEditor1.Values['准考证号'] := '准考证号'
  else
    ValueListEditor1.Values['准考证号'] := '';

  if (sFieldList.IndexOf('考试课程')<>-1) then
    ValueListEditor1.Values['考试课程'] := '考试课程'
  else
    ValueListEditor1.Values['考试课程'] := '';

  if (sFieldList.IndexOf('成绩')<>-1) then
    ValueListEditor1.Values['成绩'] := '成绩'
  else
    ValueListEditor1.Values['成绩'] := '';
    
end;

procedure TCjImport.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  //DataSet.FieldByName('状态').Value := '正常';
  DataSet.FieldByName('录入员').Value := gb_Czy_ID;
  DataSet.FieldByName('录入时间').Value := Now;
  DataSet.FieldByName('是否提交').Value := 0;
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
        Application.MessageBox(PChar('Excel文件连接失败！请确认此文件是否Excel97/2000格式！　'+#13+'你可以尝试用Excel97/2000软件打开并保存一次再来操作！'),'测试失败',MB_OK+MB_ICONERROR);
        Exit;
      end;

      //Application.MessageBox('连接Excel文件成功！','测试成功',MB_OK+MB_ICONINFORMATION);

    except
      Application.MessageBox('连接Excel文件时发生错误！请确保此文件在外部没有被任何程序使用或打开！请检查后重试！','测试失败',MB_OK+MB_ICONERROR);
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
    ValueListEditor1.RowHeights[i] := 25; // 标题栏高度
    ValueListEditor1.ItemProps[1].ReadOnly := True; // 只读
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
    //sFieldList.Add('<忽略>');
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
  ValueListEditor1.Values['准考证号'] := '';
  ValueListEditor1.RowHeights[1] := 25;
  ValueListEditor1.ItemProps['准考证号'].EditStyle := esPickList;

  ValueListEditor1.Values['考试课程'] := '';
  ValueListEditor1.RowHeights[2] := 25;
  ValueListEditor1.ItemProps['考试课程'].EditStyle := esPickList;

  ValueListEditor1.Values['成绩'] := '';
  ValueListEditor1.RowHeights[3] := 25;
  ValueListEditor1.ItemProps['成绩'].EditStyle := esPickList;

  ValueListEditor1.Values['状态'] := '';//QuotedStr('正常');
  ValueListEditor1.RowHeights[4] := 25;
  ValueListEditor1.ItemProps['状态'].EditStyle := esPickList;//esSimple;

  ValueListEditor1.Values['录入员'] := QuotedStr(gb_Czy_ID);
  ValueListEditor1.RowHeights[5] := 25;
  ValueListEditor1.ItemProps['录入员'].EditStyle := esSimple;

  ValueListEditor1.Values['录入时间'] := QuotedStr(DateTimeToStr(Now));
  ValueListEditor1.RowHeights[6] := 25;
  ValueListEditor1.ItemProps['录入时间'].EditStyle := esSimple;

  ValueListEditor1.Values['是否提交'] := QuotedStr('否');
  ValueListEditor1.RowHeights[7] := 25;
  ValueListEditor1.ItemProps['是否提交'].EditStyle := esSimple;

  for i := 0 to 7 do
  begin
    ValueListEditor1.RowHeights[0] := 25; // 标题栏高度
    ValueListEditor1.ItemProps[1].ReadOnly := True; // 只读
  end;
end;

procedure TCjImport.ValueListEditor1GetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  if (KeyName='准考证号') or (KeyName='考试课程') or (KeyName='成绩') or (KeyName='状态') then
  begin
    //if Self.Showing then
    //  GetSourceFieldList;
    Values.Assign(sFieldList);
  end;
end;

end.
