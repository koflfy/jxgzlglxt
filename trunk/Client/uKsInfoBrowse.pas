unit uKsInfoBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBFieldComboBox, GridsEh, DBGridEh, DB,
  DBClient, ExtCtrls, ComCtrls, uKsInfo,frxClass, 
  StatusBarEx, Rio, SOAPHTTPClient, RzPanel, RzRadGrp, InvokeRegistry, pngimage,
  DBGridEhGrouping, Mask, DBCtrlsEh, Menus;

type
  TKsInfoBrowse = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    pnl1: TPanel;
    cbb_Value: TEdit;
    btn_Exit: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    grp1: TGroupBox;
    DBGridEh1: TDBGridEh;
    cbb_Field: TDBFieldComboBox;
    lbl1: TLabel;
    grp_Sf: TGroupBox;
    cbb_ZyLb: TComboBox;
    grp2: TGroupBox;
    cbb_SfJf: TComboBox;
    cds_Photo: TClientDataSet;
    btn_KsInfo: TBitBtn;
    pm1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    N3: TMenuItem;
    btn_Print: TBitBtn;
    chk_Check: TCheckBox;
    N4: TMenuItem;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mi_SelectAllClick(Sender: TObject);
    procedure ClientDataSet1CalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cbb_ZyLbChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure cbb_ValueChange(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure btn_KsInfoClick(Sender: TObject);
    procedure chk_CheckClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    aForm:TKsInfo;
    function  GetWhere:string;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  KsInfoBrowse: TKsInfoBrowse;

implementation
uses uDM,uAdminIntf;//,EhLibCDS;
{$R *.dfm}

procedure TKsInfoBrowse.btn_PrintClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := DM.OpenData('select * from view_考生报名表 where 报名序号='+quotedstr(ClientDataSet1.FieldByName('报名序号').AsString));
    //aForm.DownLoadPhotoFromUrl(ClientDataSet1.FieldByName('照片文件名').AsString,nil,False);
    dm.PrintReport('考生报名表.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsInfoBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse.btn_KsInfoClick(Sender: TObject);
begin
  aForm.Show;
end;

procedure TKsInfoBrowse.cbb_ValueChange(Sender: TObject);
begin
  ClientDataSet1.Filter := '';
  ClientDataSet1.Filtered := False;
  if cbb_Value.Text<>'' then
    ClientDataSet1.Filtered := True;
end;

procedure TKsInfoBrowse.cbb_ZyLbChange(Sender: TObject);
begin
  if self.Showing then
    Open_Table;
end;

procedure TKsInfoBrowse.chk_CheckClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TKsInfoBrowse.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  //DataSet.FieldValues['bj'] := DataSet.FieldValues['nj']+DataSet.FieldValues['zy']+'（'+DataSet.FieldValues['lb']+'）';
end;

procedure TKsInfoBrowse.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  S:string;
begin
  S := LowerCase(DataSet.FieldByName(cbb_Field.Text).AsString);
  Accept := Pos(LowerCase(cbb_Value.Text),S)>0;
end;

procedure TKsInfoBrowse.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if aForm.Showing then
    aForm.img_Photo.Picture := nil;
end;

procedure TKsInfoBrowse.DBGridEh1DblClick(Sender: TObject);
begin
  aForm.Show;
end;

procedure TKsInfoBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsInfoBrowse.FormCreate(Sender: TObject);
begin
  aForm := TKsInfo.Create(Self);
  aForm.DataSource1.DataSet := Self.ClientDataSet1;
end;

procedure TKsInfoBrowse.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TKsInfoBrowse.FormShow(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetZyLbList(sList);
    cbb_ZyLb.Items.Clear;
    cbb_ZyLb.Items.Add('==不限==');
    cbb_ZyLb.Items.AddStrings(sList);
  finally
    sList.Free;
  end;
  Open_Table;
end;

function TKsInfoBrowse.GetWhere: string;
begin
  Result := ' where 1=1 ';
  if cbb_ZyLb.Text<>'==不限==' then
     Result := Result+' and 报考类别='+quotedstr(cbb_ZyLb.Text);
  case cbb_SfJf.ItemIndex of
    1:
      Result := Result + ' and 是否缴费=1';
    2:
      Result := Result + ' and 是否缴费=0';
  end;
  if chk_Check.Checked then
    Result := Result+' and 考生号 is not null and 专业志愿一 is not null and 姓名 is not null and 现就读学校 is not null ';
end;

procedure TKsInfoBrowse.mi_SelectAllClick(Sender: TObject);
begin
  if (ActiveControl is TDBGridEh) then
    with TDBGridEh(ActiveControl) do
      if CheckSelectAllAction and (geaSelectAllEh in EditActions) then
        Selection.SelectAll;
end;

procedure TKsInfoBrowse.N3Click(Sender: TObject);
begin
  aForm.Show;
end;

procedure TKsInfoBrowse.Open_Table;
begin
  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.XMLData := dm.OpenData('select * from view_考生报名表 '+GetWhere+' order by 报名序号');
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

end.
