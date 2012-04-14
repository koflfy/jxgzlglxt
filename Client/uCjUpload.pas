unit uCjUpload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TCjUpload = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    btn_Export: TBitBtn;
    GroupBox1: TGroupBox;
    DBGridEh1: TDBGridEh;
    cbb_BkLb: TDBComboBoxEh;
    ds_bkLb: TDataSource;
    cds_bkLb: TClientDataSet;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_bkLbChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure rg_PostClick(Sender: TObject);
    procedure ds_bkLbDataChange(Sender: TObject; Field: TField);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetbkLbList;
    procedure GetKsKcList;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
    procedure SetFieldValue(const iCjIndex:Integer;const sCjField,sCzyField:string);
  end;

var
  CjUpload: TCjUpload;

implementation
uses uDM;
{$R *.dfm}

procedure TCjUpload.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TCjUpload.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TCjUpload.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCjUpload.btn_ExportClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TCjUpload.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCjUpload.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('id','select top 1 * from view_考生成绩表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TCjUpload.btn_SearchClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := edt_Value.Text<>'';
end;

procedure TCjUpload.cbb_bkLbChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TCjUpload.ClientDataSet1AfterOpen(DataSet: TDataSet);
var
  i: Integer;
begin
  DBGridEh1.Columns[0].Visible := False;
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    DBGridEh1.Columns[i].Title.TitleButton := True;
    DBGridEh1.Columns[i].Title.SortMarker := smNoneEh;

    if (DBGridEh1.Columns[i].FieldName = '报名序号') then
       DBGridEh1.Columns[i].Width := 80
    else if (DBGridEh1.Columns[i].FieldName = '身份证号') or
            (DBGridEh1.Columns[i].FieldName = '推荐学校') or
            (DBGridEh1.Columns[i].FieldName = '考生号') then
       DBGridEh1.Columns[i].Width := 130
    else if (DBGridEh1.Columns[i].FieldName = '姓名') then
       DBGridEh1.Columns[i].Width := 60
    else if (DBGridEh1.Columns[i].FieldName = '性别') then
       DBGridEh1.Columns[i].Width := 40
    else if DBGridEh1.Columns[i].Field.DataType in [ftFloat,ftBCD] then
    begin
      DBGridEh1.Columns[i].Width := 60;
      DBGridEh1.Columns[i].DisplayFormat := '0.0';
    end
    else
      DBGridEh1.Columns[i].Width := 70;
  end;
end;

procedure TCjUpload.ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept:
    Boolean);
begin
  Accept := Pos(edt_Value.Text,DataSet.FieldByName(cbb_Field.Text).AsString)>0;
end;

procedure TCjUpload.ds_bkLbDataChange(Sender: TObject; Field: TField);
var
  bkLb:string;
begin
  Screen.Cursor := crHourGlass;
  try
    bkLb := cds_bkLb.FieldByName('类别').AsString;
    Self.Caption := bkLb+'考生合成成绩查询';
    GroupBox1.Caption := '【'+bkLb+'】考生成绩：';
    DBGridEh1.ShowHint := True;
    DBGridEh1.Hint := '【'+bkLb+'】考生合成成绩';
    ClientDataSet1.XMLData := vobj_Admin.GetKsCj(bkLb);
  finally
    Screen.Cursor := crDefault;
    if DBGridEh1.CanFocus then
      DBGridEh1.SetFocus;
  end;
end;

procedure TCjUpload.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
  btn_Search.Click;
end;

procedure TCjUpload.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCjUpload.FormShow(Sender: TObject);
begin
  //GetbkLbList;
  Open_Table;
end;

function TCjUpload.GetWhere: string;
begin
end;

procedure TCjUpload.GetbkLbList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    DM.GetZyLbList(sList);
    cbb_BkLb.Items.Clear;
    cbb_BkLb.Items.Add('不限类别');
    cbb_BkLb.Items.AddStrings(sList);
    cbb_BkLb.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TCjUpload.GetKsKcList;
begin
end;

procedure TCjUpload.Open_Table;
begin
  Screen.Cursor := crHourGlass;
  try
    DBGridEh1.ShowHint := True;
    DBGridEh1.Hint := '【报盘格式】考生成绩';
    ClientDataSet1.XMLData := vobj_Admin.GetKsCj('');
  finally
    Screen.Cursor := crDefault;
    if DBGridEh1.CanFocus then
      DBGridEh1.SetFocus;
  end;
end;

procedure TCjUpload.rg_PostClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCjUpload.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TCjUpload.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
end;

end.
