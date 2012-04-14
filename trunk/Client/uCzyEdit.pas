unit uCzyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GridsEh, DBGridEh, DB,
  DBClient, Buttons, DBCtrls, MyDBNavigator, pngimage, DBGridEhGrouping,
  frxpngimage;

type
  TCzyEdit = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    edt1: TEdit;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    DBGridEh1: TDBGridEh;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    MyDBNavigator1: TMyDBNavigator;
    btn_Save: TBitBtn;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_RightSetClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    sSqlStr:String;
  public
    { Public declarations }
  end;

var
  CzyEdit: TCzyEdit;

implementation
uses uDM,uCzyRightSet;
{$R *.dfm}

procedure TCzyEdit.btn_RightSetClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  with TCzyRightSet.Create(Self) do
  begin
    Top := t-50;
    Left := l-80;
    ShowModal;
  end;
end;

procedure TCzyEdit.btn_SaveClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  if ClientDataSet1.ChangeCount<1 then
    Exit;

  cds_Temp := TClientDataSet.Create(nil);
  try
    if dm.UpdateData('操作员编号',sSqlStr,ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
  finally
    cds_Temp.Free;
  end;
end;

procedure TCzyEdit.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('注册日期').Value := Now;
end;

procedure TCzyEdit.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCzyEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCzyEdit.FormCreate(Sender: TObject);
var
  sData:String;
begin
  if gb_Czy_Level='-1' then
    sSqlStr := 'select * from 操作员表'
  else if gb_Czy_Level='0' then
    sSqlStr := 'select * from 操作员表 where 操作员编号='+quotedstr(gb_Czy_ID)+' OR 等级>'+gb_Czy_Level
  else
    sSqlStr := 'select * from 操作员表 where 操作员编号='+quotedstr(gb_Czy_ID);

  //btn_RightSet.Enabled := gb_Czy_Level='-1';
  sData := dm.OpenData(sSqlStr);
  ClientDataSet1.XMLData := sData;
end;

end.
