unit uCjBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TCjBrowse = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp1: TGroupBox;
    cbb_ksKc: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    grp2: TGroupBox;
    cbb_bkLb: TDBComboBoxEh;
    rg_Post: TRadioGroup;
    btn_Export: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_ksKcChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_SaveClick(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure cbb_bkLbChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure rg_PostClick(Sender: TObject);
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
  CjBrowse: TCjBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TCjBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TCjBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TCjBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCjBrowse.btn_ExportClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TCjBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCjBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('id','select top 1 * from view_�����ɼ���',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TCjBrowse.btn_SearchClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := edt_Value.Text<>'';
end;

procedure TCjBrowse.cbb_bkLbChange(Sender: TObject);
begin
  GetKsKcList;
end;

procedure TCjBrowse.cbb_ksKcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TCjBrowse.ClientDataSet1AfterPost(DataSet: TDataSet);
var
  zkzh,cj,sqlstr:string;
begin
  zkzh := DataSet.FieldByName('׼��֤��').AsString;
  cj := DataSet.FieldByName('�ɼ�').AsString;

  if DataSet.FieldByName('Id').IsNull then
    sqlstr := 'Insert into �����ɼ��� (׼��֤��,���Կγ�,�ɼ�,¼��Ա,�Ƿ��ύ) '+
              'Values('+quotedstr(Zkzh)+','+quotedstr(cbb_ksKc.Text)+','+cj+',0)'
  else
    sqlstr := 'update �����ɼ��� set �ɼ�='+cj+',¼��Ա='+quotedstr(gb_Czy_Id)+
    ' where Id='+DataSet.FieldByName('Id').AsString;
  if dm.ExecSql(sqlstr) then
    ClientDataSet1.MergeChangeLog;
end;

procedure TCjBrowse.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  //DataSet.FieldByName('���Կγ�').AsString := cbb_ksKc.Text;
  DataSet.FieldByName('¼��Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('¼��ʱ��').AsDateTime := Now;
  DataSet.FieldByName('�Ƿ��ύ').AsBoolean := False;
end;

procedure TCjBrowse.ClientDataSet1FilterRecord(DataSet: TDataSet; var Accept:
    Boolean);
begin
  Accept := Pos(edt_Value.Text,DataSet.FieldByName(cbb_Field.Text).AsString)>0;
end;

procedure TCjBrowse.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  //DataSet.FieldByName('׼��֤��').AsString := Zkzh;
  DataSet.FieldByName('���Կγ�').AsString := cbb_ksKc.Text;
  DataSet.FieldByName('¼��Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('�Ƿ��ύ').AsBoolean := False;
end;

procedure TCjBrowse.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
  btn_Search.Click;
end;

procedure TCjBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCjBrowse.FormShow(Sender: TObject);
begin
  GetbkLbList;
end;

function TCjBrowse.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �������='+quotedstr(cbb_bkLb.Text);
  sWhere := sWhere+' and ���Կγ�='+quotedstr(cbb_kskc.Text);
  sWhere := sWhere+' and �Ƿ��ύ='+IntTostr(rg_Post.ItemIndex);
  Result := sWhere;
end;

procedure TCjBrowse.GetbkLbList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_bkLb.Items.Clear;
    dm.GetZyLbList(sList);
    cbb_bkLb.Items.Assign(sList);
    cbb_bkLb.ItemIndex := 0;
    GetKsKcList;
  finally
    sList.Free;
  end;
end;

procedure TCjBrowse.GetKsKcList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_ksKc.Items.Clear;
    cbb_ksKc.Text := '';
    dm.GetKsKcList(cbb_bkLb.Text,sList);
    cbb_ksKc.Items.Assign(sList);
    cbb_ksKc.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TCjBrowse.Open_Table;
var
  sqlstr:string;
begin
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'select * from view_�����ɼ��� '+GetWhere+' order by ׼��֤��';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
    if Self.Showing then
    begin
      DBGridEh1.SetFocus;
      DBGridEh1.SelectedIndex := 8;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCjBrowse.rg_PostClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCjBrowse.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TCjBrowse.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
end;

end.
