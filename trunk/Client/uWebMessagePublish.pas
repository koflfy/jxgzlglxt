unit uWebMessagePublish;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient, GridsEh, DBGridEh, Buttons,
  DBCtrls, Mask, DBCtrlsEh, frxpngimage, ComCtrls, pngimage, DBGridEhGrouping;

type
  TWebMessagePublish = class(TForm)
    ds1: TDataSource;
    cds_1: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    grp1: TGroupBox;
    DBGridEh1: TDBGridEh;
    GroupBox1: TGroupBox;
    pnl1: TPanel;
    btn_Add: TBitBtn;
    btn_Update: TBitBtn;
    btn_Del: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    dbmmo2: TDBMemo;
    ds2: TDataSource;
    cds_2: TClientDataSet;
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cds_1NewRecord(DataSet: TDataSet);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ds1StateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cds_1CalcFields(DataSet: TDataSet);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  WebMessagePublish: TWebMessagePublish;

implementation
uses uDM;
{$R *.dfm}

procedure TWebMessagePublish.btn_AddClick(Sender: TObject);
begin
  cds_1.Append;
  DBGridEh1.SetFocus;
end;

procedure TWebMessagePublish.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前公告记录吗？　　', '系统提示', MB_YESNO
    + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  cds_1.Delete;
  btn_Update.Click;
end;

procedure TWebMessagePublish.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TWebMessagePublish.btn_RefreshClick(Sender: TObject);
var
  book:TBookmark;
begin
  btn_Update.Click;
  book := cds_1.GetBookmark;
  Self.OnCreate(Self);
  cds_1.GotoBookmark(book);
end;

procedure TWebMessagePublish.btn_UpdateClick(Sender: TObject);
begin
  if cds_1.State in [dsInsert,dsEdit] then
    cds_1.Post;
  if cds_1.ChangeCount>0 then
    if dm.UpdateData('ID','select * from 公告通知表',cds_1.Delta,False) then
      cds_1.MergeChangeLog;

  if cds_2.State in [dsInsert,dsEdit] then
    cds_2.Post;
  if cds_2.ChangeCount>0 then
    if dm.UpdateData('ID','select * from 网站帮助信息表',cds_2.Delta,False) then
      cds_2.MergeChangeLog;
end;

procedure TWebMessagePublish.cds_1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('序号').AsInteger := DataSet.RecNo;
end;

procedure TWebMessagePublish.cds_1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('操作员').AsString := gb_Czy_ID;
  DataSet.FieldByName('ActionTime').Value := Now;
  DataSet.FieldByName('是否启用').Value := True;
  DataSet.FieldByName('是否置顶').Value := False;
end;

procedure TWebMessagePublish.DBGridEh1CellClick(Column: TColumnEh);
begin
  if Column.Index=0 then
    Column.Index := 1;
end;

procedure TWebMessagePublish.ds1StateChange(Sender: TObject);
begin
    btn_Update.Enabled := (cds_1.ChangeCount>0) or (cds_1.State in [dsInsert,dsEdit]) or
                          (cds_2.ChangeCount>0) or (cds_2.State in [dsInsert,dsEdit]);
end;

procedure TWebMessagePublish.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TWebMessagePublish.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  IsModified:Boolean;
begin
  IsModified := (cds_1.State in [dsInsert,dsEdit]) or (cds_1.ChangeCount>0) or
                (cds_2.State in [dsInsert,dsEdit]) or (cds_2.ChangeCount>0);
  if IsModified and (MessageBox(Handle, '数据已修改但是还未保存！要保存吗？　　',
    '系统提示', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES) then
  begin
    btn_Update.Click;
  end
end;

procedure TWebMessagePublish.FormCreate(Sender: TObject);
begin
  OpenTable;
  PageControl1.ActivePageIndex := 0;
end;

procedure TWebMessagePublish.FormShow(Sender: TObject);
begin
  if PageControl1.ActivePageIndex=0 then
    DBGridEh1.SetFocus;
end;

procedure TWebMessagePublish.OpenTable;
begin
  cds_1.XMLData := dm.OpenData('select * from 公告通知表 order by ActionTime desc');
  cds_2.XMLData := dm.OpenData('select * from 网站帮助信息表');
end;

procedure TWebMessagePublish.PageControl1Change(Sender: TObject);
begin
  btn_Add.Enabled := PageControl1.ActivePageIndex=0;
  btn_Del.Enabled := PageControl1.ActivePageIndex=0;
  if PageControl1.ActivePageIndex=0 then
    btn_Update.Enabled := (cds_1.ChangeCount>0) or (cds_1.State in [dsInsert,dsEdit])
  else
    btn_Update.Enabled := (cds_2.ChangeCount>0) or (cds_2.State in [dsInsert,dsEdit]);
  btn_Refresh.Enabled := not btn_Update.Enabled;
end;

end.
