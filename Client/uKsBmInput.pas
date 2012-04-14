unit uKsBmInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, DBCtrls, Mask, DBCtrlsEh, Buttons, ExtCtrls,
  ExtDlgs, Menus, Jpeg, uPhotoProcess, pngimage,StrUtils, GIFImg;

type
  TKsBmInput = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Id: TAutoIncField;
    ClientDataSet1StringField: TStringField;
    ClientDataSet1StringField2: TStringField;
    ClientDataSet1StringField3: TStringField;
    ClientDataSet1StringField4: TStringField;
    ClientDataSet1StringField5: TStringField;
    ClientDataSet1StringField6: TStringField;
    ClientDataSet1StringField7: TStringField;
    ClientDataSet1StringField8: TStringField;
    ClientDataSet1StringField9: TStringField;
    ClientDataSet1StringField10: TStringField;
    ClientDataSet1StringField11: TStringField;
    ClientDataSet1StringField12: TStringField;
    ClientDataSet1StringField13: TStringField;
    ClientDataSet1StringField14: TStringField;
    ClientDataSet1StringField15: TStringField;
    ClientDataSet1StringField16: TStringField;
    ClientDataSet1StringField17: TStringField;
    ClientDataSet1StringField18: TStringField;
    ClientDataSet1StringField19: TStringField;
    ClientDataSet1StringField20: TStringField;
    ClientDataSet1StringField21: TStringField;
    ClientDataSet1StringField22: TStringField;
    ClientDataSet1StringField23: TStringField;
    ClientDataSet1BooleanField: TBooleanField;
    ClientDataSet1StringField24: TStringField;
    ClientDataSet1DateTimeField: TDateTimeField;
    ClientDataSet1Ip: TStringField;
    ClientDataSet1BooleanField2: TBooleanField;
    ClientDataSet1BooleanField3: TBooleanField;
    grp_1: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    edt_Ksh: TDBEditEh;
    dbedt3: TDBEditEh;
    cbb_xb: TDBComboBoxEh;
    cbb_Mz: TDBComboBoxEh;
    edt_Sfzh: TDBEditEh;
    cbb_Zzmm: TDBComboBoxEh;
    cbb_School: TDBComboBoxEh;
    dbedt10: TDBEditEh;
    dbedt11: TDBEditEh;
    dbedt12: TDBEditEh;
    dbedt13: TDBEditEh;
    dbedt14: TDBEditEh;
    dbedt15: TDBEditEh;
    cbb_English: TDBComboBoxEh;
    cbb_Jsj: TDBComboBoxEh;
    dbedt18: TDBEditEh;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    pnl_photo: TPanel;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Close: TBitBtn;
    grp_2: TGroupBox;
    lbl38: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl24: TLabel;
    lbl23: TLabel;
    lbl34: TLabel;
    lbl35: TLabel;
    lbl36: TLabel;
    lbl37: TLabel;
    DBEditEh1: TDBEditEh;
    cbb_ZyLb: TDBComboBoxEh;
    cbb_Zy1: TDBComboBoxEh;
    cbb_Zy3: TDBComboBoxEh;
    cbb_Zy2: TDBComboBoxEh;
    dbchk1: TDBCheckBox;
    dbedt_BmNo: TDBEditEh;
    lbl39: TLabel;
    edt_BmNo: TDBEditEh;
    lbl1: TLabel;
    lbl40: TLabel;
    bvl1: TBevel;
    btn_Priv: TBitBtn;
    btn_Next: TBitBtn;
    lbl42: TLabel;
    btn_UploadPhoto: TBitBtn;
    img_Photo: TImage;
    btn1: TButton;
    N3: TMenuItem;
    N4: TMenuItem;
    cds_Photo: TClientDataSet;
    dlgOpen: TOpenDialog;
    dbtxt_Photo: TDBText;
    lbl6: TLabel;
    ds_Photo: TDataSource;
    lbl25: TLabel;
    lbl26: TLabel;
    edt_UserName: TDBEditEh;
    edt_UserPwd: TDBEditEh;
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbb_SchoolEnter(Sender: TObject);
    procedure cbb_Zy1Enter(Sender: TObject);
    procedure btn_PrivClick(Sender: TObject);
    procedure btn_NextClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btn_UploadPhotoClick(Sender: TObject);
    procedure cds_PhotoAfterOpen(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure cds_PhotoBeforePost(DataSet: TDataSet);
    procedure btn1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure edt_KshExit(Sender: TObject);
    procedure cbb_xbExit(Sender: TObject);
    procedure edt_KshChange(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    //fIsAdd:Boolean;
    sWebSrvUrl:string;
    aForm :TPhotoProcess;
    procedure FillComboBox;
    function  SaveKsBmInfo:Boolean;
    function  SaveKsPhoto:Boolean;
    procedure ModifyImageData(ImageField: TBlobField;   AImg: TImage);
    function  CheckFieldValue(const aEdit:TDBEditEH):Boolean;
    function  CheckFieldValue2(const aEdit:TDBComboBoxEh):Boolean;
  public
    { Public declarations }
    procedure SetDataSet(cds_Source:TClientDataSet);
  end;

var
  KsBmInput: TKsBmInput;

implementation
uses uDM,Net;
{$R *.dfm}

procedure TKsBmInput.btn_UploadPhotoClick(Sender: TObject);
begin
{
  with TPhotoProcess.Create(nil) do
  begin
    ShowModal;
    Free;
  end;
}
  if dlgOpen.Execute then
  begin
    try
      img_Photo.Picture := nil;
      img_Photo.Picture.LoadFromFile(dlgOpen.FileName);
      img_Photo.Hint := dlgOpen.FileName;
      if dm.UpLoadKsPhoto(edt_BmNo.Text,dlgOpen.FileName) then
         Application.MessageBox('考生照片上传成功！　','系统提示', MB_OK + MB_ICONINFORMATION)
      else
         Application.MessageBox('考生照片存储失败！可能是照片格式不正确！　','系统提示', MB_OK + MB_ICONSTOP);
    except
      on e:Exception do
       Application.MessageBox(PChar('照片文件读取错误！可能是照片格式不正确！　'+#13+e.Message),'系统提示', MB_OK + MB_ICONSTOP);
    end;
  end;
end;

procedure TKsBmInput.btn1Click(Sender: TObject);
begin
  SaveKsPhoto;
end;

procedure TKsBmInput.btn_CloseClick(Sender: TObject);
begin
  if DataSetNoSave(TClientDataSet(DataSource1.DataSet)) or DataSetNoSave(cds_Photo) then
  begin
    if Application.MessageBox('真的要取消报名吗？这一操作将清除已修改的内容！　',
      '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
    begin
      Self.Close;
    end;
  end else
    Self.Close;
end;

procedure TKsBmInput.btn_NextClick(Sender: TObject);
begin
  grp_2.Visible := True;
  grp_1.Visible := False;
  btn_Priv.Enabled := True;
  btn_Next.Enabled := False;
  btn_Save.Enabled := True;
end;

procedure TKsBmInput.btn_PrivClick(Sender: TObject);
begin
  grp_1.Visible := True;
  grp_2.Visible := False;
  btn_Priv.Enabled := False;
  btn_Next.Enabled := True;
  btn_Save.Enabled := False;
end;

procedure TKsBmInput.btn_SaveClick(Sender: TObject);
begin
  if SaveKsBmInfo then // and SaveKsPhoto then
  begin
    Application.MessageBox('报名完成！教学工作量信息已提交！　',
        '系统提示', MB_OK + MB_ICONINFORMATION);
    Self.Close;
  end;
end;

procedure TKsBmInput.cbb_SchoolEnter(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetSchoolList('江西',sList);
    cbb_School.Text := '';
    cbb_School.Items.Assign(sList);
  finally
    sList.Free;
  end;
end;

procedure TKsBmInput.cbb_Zy1Enter(Sender: TObject);
var
  sList :TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetZyList(cbb_ZyLb.Text,sList);
    TDBComboBoxEh(Sender).Items.Assign(sList);
  finally
    sList.Free;
  end;
end;

procedure TKsBmInput.cbb_xbExit(Sender: TObject);
var
  aEdit:TDBComboBoxEh;
begin
  if Pos('TDBCOMBOBOXEH',UpperCase(Sender.ClassName))=1 then
  begin
    aEdit := Sender as TDBComboBoxEh;
    CheckFieldValue2(aEdit);
  end;
end;

procedure TKsBmInput.cds_PhotoAfterOpen(DataSet: TDataSet);
var
  fn:string;
  Photo_Url:string;
  ii:Integer;
begin
  Photo_Url := cds_Photo.FieldByName('照片文件名').AsString;
  if (Photo_Url<>'') then
  begin
    if LowerCase(Copy(Photo_Url,1,7))<>'http:// 'then
      Photo_Url := sWebSrvUrl+Photo_Url;

    img_Photo.Picture := nil;
    dm.DownLoadKsPhoto(Photo_Url,img_Photo);
  end;
end;

procedure TKsBmInput.cds_PhotoBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('报名序号').IsNull then
  begin
    if dbedt_BmNo.Text='' then
    begin
      dbedt_BmNo.Text := vobj_Admin.GetBmNo;
      edt_BmNo.Text := dbedt_BmNo.Text;
    end;
    DataSet.FieldByName('报名序号').AsString := edt_BmNo.Text;
  end;
  DataSet.FieldByName('照片文件名').AsString := edt_BmNo.Text+ExtractFileExt(img_Photo.Hint);
end;

function TKsBmInput.CheckFieldValue(const aEdit: TDBEditEH): Boolean;
var
  sHint,sTemp:string;
begin
  Result := aEdit.Text<>'';
  sHint := aEdit.Field.FieldName;
  if not result then
  begin
    MessageBox(Handle, PChar(sHint+'字段不能为空！　'), '系统提示', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
    aEdit.SetFocus;
    Exit;
  end;
  if UpperCase(aEdit.Name) = 'EDT_SFZH' then
  begin
    sTemp := ValidatePID(aEdit.Text);
    if sTemp<>'' then
    begin
      MessageBox(Handle, PChar(sTemp+'　'), '系统提示', MB_OK + MB_ICONSTOP +
        MB_TOPMOST);
      Result := False;
    end else
      Result := True;
  end;
end;

function TKsBmInput.CheckFieldValue2(const aEdit: TDBComboBoxEh): Boolean;
var
  sHint:string;
begin
  Result := aEdit.Text<>'';
  sHint := aEdit.Field.FieldName;
  if not Result then
  begin
    MessageBox(Handle, PChar(sHint+'字段不能为空！　'), '系统提示', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
    aEdit.SetFocus;
  end;
end;

procedure TKsBmInput.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('报名序号').IsNull then
  begin
    DataSet.FieldByName('报名序号').AsString := vobj_Admin.GetBmNo;
  end;
end;

procedure TKsBmInput.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('报名序号').AsString := vobj_Admin.GetBmNo;
  DataSet.FieldByName('报名时间').AsDateTime := Now;
  DataSet.FieldByName('操作员').AsString := gb_Czy_ID;
  DataSet.FieldByName('是否同意调剂').AsBoolean := False;
  DataSet.FieldByName('是否打印').AsBoolean := False;
  DataSet.FieldByName('是否缴费').AsBoolean := False;
  DataSet.FieldByName('Ip').AsString := GetLocalIpStr;
end;

procedure TKsBmInput.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  cds_Photo.XMLData := DM.OpenData('select 报名序号,照片文件名 from 考生照片表 where 报名序号='+quotedstr(ClientDataSet1.FieldByName('报名序号').AsString));
end;

procedure TKsBmInput.edt_KshChange(Sender: TObject);
begin
  btn_Next.Enabled := TDBEditEh(Sender).Text<>'';
end;

procedure TKsBmInput.edt_KshExit(Sender: TObject);
var
  aEdit:TDBEditEH;
begin
  if Pos('TDBEDITEH',UpperCase(Sender.ClassName))=1 then
  begin
    aEdit := Sender as TDBEditEH;
    CheckFieldValue(aEdit);
  end;
end;

procedure TKsBmInput.FillComboBox;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetMzList(sList);
    cbb_Mz.Items.Assign(sList);

    dm.GetZzMmList(sList);
    cbb_Zzmm.Items.Assign(sList);

    dm.GetEnglishDjKsList(sList);
    cbb_English.Items.Assign(sList);

    dm.GetJsjDjKsList(sList);
    cbb_Jsj.Items.Assign(sList);

    dm.GetZylbList(sList);
    cbb_ZyLb.Items.Assign(sList);

  finally
    sList.Free;
  end;

end;

procedure TKsBmInput.FormCreate(Sender: TObject);
begin
  sWebSrvUrl := vobj_Admin.GetWebSrvUrl;
  if RightStr(sWebSrvUrl,1)<>'/' then
    sWebSrvUrl := sWebSrvUrl+'/';
  FillComboBox;
end;

procedure TKsBmInput.FormShow(Sender: TObject);
begin
  grp_1.Visible := True;
  grp_2.Visible := False;
  img_Photo.Picture := nil;
  btn_Next.Enabled := True;
  btn_Priv.Enabled := False;
  btn_Save.Enabled := False;

  if edt_BmNo.Text='' then
  begin
    DataSource1.DataSet.Append;
    edt_BmNo.Text := dbedt_BmNo.Text;
    edt_Ksh.SetFocus;
  end;
  cds_Photo.XMLData := DM.OpenData('select * from 考生照片表 where 报名序号='+quotedstr(edt_BmNo.Text));
end;

procedure TKsBmInput.ModifyImageData(ImageField: TBlobField; AImg: TImage);
var
  MS:TMemoryStream;
  aJpeg :TJPEGImage;
  bmp : TBitMap;
begin
  //if dlgOpen.Execute then
  begin
      AImg.Picture.LoadFromFile(dlgOpen.FileName);
      bmp := TBitmap.Create;
      aJpeg := TJPEGImage.Create;
      MS := TMemoryStream.Create;
      try
          AImg.Picture.Graphic.SaveToStream(MS);
          MS.Position := 0;
          //cds_Photo.Edit;
          aJpeg.LoadFromStream(MS);
          bmp.Canvas.StretchDraw(rect(0,0,AImg.Width,AImg.Height),aJpeg);
          aJpeg.Assign(bmp);
          MS.Position := 0;
          aJpeg.SaveToStream(MS);
          MS.Position := 0;
          ImageField.LoadFromStream(MS);
          //cds_Photo.Post;
          //DM.UpdateData('报名序号','select * from 考生照片表 where 1=0',cds_Photo.Delta);
      finally
          bmp.Free;
          aJpeg.Free;
          MS.Free;
      end;
  end;
end;

procedure TKsBmInput.N1Click(Sender: TObject);
var
  fn:string;
begin
  fn := cds_Photo.FieldByName('照片文件名').AsString;
  if (fn<>'') then // and (img_Photo.Picture.Graphic<>nil) then
  begin
    fn := StringReplace(fn,'/','\',[rfReplaceAll]);
    SavePictureDialog1.FileName := ExtractFileName(fn);
    if SavePictureDialog1.Execute then
      img_Photo.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TKsBmInput.N4Click(Sender: TObject);
begin
  img_Photo.Picture := nil;
  //dm.ExecSql('update 考生照片表 set 照片=null where 报名序号='+quotedstr(edt_BmNo.Text));
  cds_Photo.Delete;
  dm.ExecSql('delete from 考生照片表  where 报名序号='+quotedstr(edt_BmNo.Text));
end;

function TKsBmInput.SaveKsBmInfo: Boolean;
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    Result := dm.UpdateData('Id','select * from 考生报名表 where 1=0',ClientDataSet1.Delta);
    if Result then
      ClientDataSet1.MergeChangeLog;
  end else
    Result := True;
end;

function TKsBmInput.SaveKsPhoto:Boolean;
begin
end;

procedure TKsBmInput.SetDataSet(cds_Source: TClientDataSet);
begin
  //ClientDataSet1.XMLData := cds_Source.XMLData;
  ClientDataSet1 := cds_Source;
  DataSource1.DataSet := cds_Source;
  DataSource1.DataSet.OnNewRecord := ClientDataSet1NewRecord;
end;

end.
