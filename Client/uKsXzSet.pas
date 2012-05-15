unit uKsXzSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBClient, GridsEh, DBGridEh, Buttons,
  DBCtrls, Mask, DBCtrlsEh, frxpngimage, ComCtrls, pngimage, DBGridEhGrouping,
  dxGDIPlusClasses, OleCtnrs;

type
  TKsXzSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    ds2: TDataSource;
    cds_2: TClientDataSet;
    OleContainer1: TOleContainer;
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ds1StateChange(Sender: TObject);
  private
    { Private declarations }
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  KsXzSet: TKsXzSet;

implementation
uses uDM;
{$R *.dfm}

procedure TKsXzSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsXzSet.btn_RefreshClick(Sender: TObject);
begin
  btn_Update.Click;
  Self.OnCreate(Self);
end;

procedure TKsXzSet.btn_UpdateClick(Sender: TObject);
begin
  if DataSetNoSave(cds_2) then
    if dm.UpdateData('ID','select * from 制度文件表',cds_2.Delta,True) then
      cds_2.MergeChangeLog;
end;

procedure TKsXzSet.ds1StateChange(Sender: TObject);
begin
  btn_Update.Enabled := (cds_2.ChangeCount>0) or (cds_2.State in [dsInsert,dsEdit]);
end;

procedure TKsXzSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsXzSet.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  IsModified:Boolean;
begin
  IsModified := DataSetNoSave(cds_2);
  if IsModified and (MessageBox(Handle, '数据已修改但是还未保存！要保存吗？　　',
    '系统提示', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES) then
  begin
    btn_Update.Click;
  end
end;

procedure TKsXzSet.FormCreate(Sender: TObject);
begin
  OpenTable;
end;

procedure TKsXzSet.OpenTable;
begin
  cds_2.XMLData := dm.OpenData('select * from 制度文件表');
end;

end.
