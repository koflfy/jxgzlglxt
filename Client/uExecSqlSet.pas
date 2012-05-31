unit uExecSqlSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, DB, DBClient, Buttons,StrUtils,
  ExtCtrls, GridsEh, DBGridEh, MyDBNavigator, DBCtrlsEh, DBGridEhGrouping, Menus,
  frxpngimage, pngimage;

type
  TExecSqlSet = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    grp2: TGroupBox;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    GroupBox1: TGroupBox;
    cbb_Mode: TDBComboBoxEh;
    dxgrd_1: TDBGridEh;
    Splitter1: TSplitter;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBMemo2: TDBMemo;
    btn_Test: TBitBtn;
    edt_BH: TDBEdit;
    lbl1: TLabel;
    cbb_XsLb: TDBComboBoxEh;
    lbl2: TLabel;
    DBMemo1: TDBMemo;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cbb_TypeChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure DBMemo2Change(Sender: TObject);
    procedure cbb_XsLbChange(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    sqlWhere:String;
    function FormatSql(var sqlText:string):Boolean;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  ExecSqlSet: TExecSqlSet;

implementation
uses uDM;
{$R *.dfm}

procedure TExecSqlSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TExecSqlSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TExecSqlSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前配置项目吗？　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;

end;

procedure TExecSqlSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TExecSqlSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
  dxgrd_1.SetFocus;
end;

procedure TExecSqlSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 系数配置表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TExecSqlSet.btn_TestClick(Sender: TObject);
var
  sql:string;
begin
  if Trim(DBMemo1.Text)='' then
  begin
    ClientDataSet1.Close;
    Exit;
  end;
  sql := DBMemo1.Text;
  if not FormatSql(sql) then
    Exit;

  if dm.ExecSql(sql) then
  begin
    MessageBox(Handle, 'SQL命令格式测试通过！　', '系统提示', MB_OK + 
      MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TExecSqlSet.cbb_XsLbChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    sqlWhere := DM.GetHsgzWhere(cbb_Mode.Text);
    Open_Table;
    dxgrd_1.SetFocus;
  end;
end;

procedure TExecSqlSet.cbb_TypeChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TExecSqlSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('规则类型').AsString := cbb_Mode.Text;//gb_System_Mode;
  //ClientDataSet1.FieldByName('系数类别').AsString := cbb_XsLb.Value;
end;

procedure TExecSqlSet.DBMemo2Change(Sender: TObject);
begin
  btn_Test.Enabled := DBMemo2.Text<>'';
  DBMemo1.Text := DBMemo2.Text+' where '+sqlWhere;
end;

function TExecSqlSet.FormatSql(var sqlText: string): Boolean;
var
  sql:string;
begin
  Result := False;
  sql := sqlText;
  sql := Trim(LowerCase(sql));
  if LeftStr(sql,7)<>'update ' then
  begin
    MessageBox(Handle, 'SQL语句命令错误，配置命令必须是update格式命令！　',
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    DBMemo1.SetFocus;
    Exit;
  end;
  Result := True;
  if Pos(' where ',sql)>0 then
  begin
    sqlText := ReplaceStr(sql,' where ',' where 1=0 and ');
  end else
    sqlText := sql+' where 1=0';
end;

procedure TExecSqlSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '设置信息已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TExecSqlSet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  //cbb_Mode.Text := gb_System_Mode;
  sList := TStringList.Create;
  try
    dm.GetHsgzTypeXyList(sList);
    cbb_Mode.Items.Assign(sList);
    if cbb_Mode.Items.Count>0 then
      cbb_Mode.ItemIndex := 0;
    sqlWhere := DM.GetHsgzWhere(cbb_XsLb.Text);
    Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TExecSqlSet.N2Click(Sender: TObject);
begin
  DBMemo1.SelectAll;
end;

procedure TExecSqlSet.Open_Table;
var
  sqlstr :string;
begin
  sqlstr := 'select * from 核算规则配置表 where 规则类型='+quotedstr(cbb_Mode.Text)+
            ' order by 系数类别,执行顺序';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
