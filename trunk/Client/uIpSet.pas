unit uIpSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBCtrls, ExtCtrls, DBClient,
  GridsEh, DBGridEh, MyDBNavigator, pngimage, DBGridEhGrouping;

type
  TIpSet = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    ClientDataSet1: TClientDataSet;
    MyDBNavigator1: TMyDBNavigator;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    DBGridEh1: TDBGridEh;
    pnl1: TPanel;
    Label21: TLabel;
    Label1: TLabel;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1StateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientDataSet1BeforeDelete(DataSet: TDataSet);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  IpSet: TIpSet;

implementation
uses uDM,Net;
{$R *.dfm}

procedure TIpSet.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('�ͻ���IP���ñ�',ClientDataSet1.XMLData,1);
end;

procedure TIpSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('ID','select * from �ͻ���IP��',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TIpSet.ClientDataSet1BeforeDelete(DataSet: TDataSet);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO
    + MB_ICONQUESTION + MB_DEFBUTTON3 + MB_TOPMOST) = IDNO then
    begin
      Abort;
    end else
    begin
      btn_Save.Enabled := True;
    end;
end;

procedure TIpSet.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  sIP :string;
begin
  sIP := DataSet.FieldByName('��ʼIP').AsString;
  if sIP<>'' then
    DataSet.FieldByName('��ʼIP').AsString := FormatIP(sIP);

  sIP := DataSet.FieldByName('����IP').AsString;
  if sIP<>'' then
    DataSet.FieldByName('����IP').AsString := FormatIP(sIP);
end;

procedure TIpSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('�����').Value := True;
end;

procedure TIpSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TIpSet.FormCreate(Sender: TObject);
begin
  ClientDataSet1.XMLData := dm.OpenData('select * from �ͻ���IP�� order by ��ʼIP');
end;

procedure TIpSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ClientDataSet1.Close;
  Action := cafree;
end;

procedure TIpSet.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if DataSetNoSave(ClientDataSet1) then
    case MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡���', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1 + MB_TOPMOST) of
      IDYES:
        begin
          btn_Save.Click;
        end;
      IDNO:
        begin
          CanClose := True;
        end;
    end;

end;

procedure TIpSet.DataSource1StateChange(Sender: TObject);
begin
  btn_Save.Enabled := (ClientDataSet1.ChangeCount>0) or (ClientDataSet1.State in [dsInsert,dsEdit]);
end;

end.
