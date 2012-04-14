unit uClientTestMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvokeRegistry, Grids, DBGrids, DB, DBClient, SOAPConn, Rio,
  SOAPHTTPClient, StdCtrls, Buttons, Menus,  ExtCtrls, ComCtrls, GridsEh, DBGridEh, DBGridEhGrouping;

type
  TClinetTestMain = class(TForm)
    HTTPRIO1: THTTPRIO;
    SoapConnection1: TSoapConnection;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    PopupMenu1: TPopupMenu;
    mi_save1: TMenuItem;
    mi_open1: TMenuItem;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    DBGrid1: TDBGridEh;
    pnl1: TPanel;
    btn_Open: TButton;
    edt_Sql: TEdit;
    pnl2: TPanel;
    btn_Execute: TButton;
    mmo1: TMemo;
    edt_Url: TEdit;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_OpenClick(Sender: TObject);
    procedure edt_UrlChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExecuteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClinetTestMain: TClinetTestMain;

implementation
uses uAdminIntf,PwdFunUnit;
{$R *.dfm}

procedure TClinetTestMain.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TClinetTestMain.btn_ExecuteClick(Sender: TObject);
var
  vobj:IAdmin;
  sError:string;
begin
  vobj := httprio1 as IAdmin;
  try
    if vobj.ExecSql(mmo1.Text,sError) then
      ShowMessage('Execute SQL Command complated! OK! ')
    else
      ShowMessage('Error!'+sError);
  finally
    vobj := nil;
  end;
end;

procedure TClinetTestMain.btn_OpenClick(Sender: TObject);
var
  vobj:IAdmin;
  sError,sData:string;
  iCompressType:Integer;
begin
  iCompressType := 0;
  vobj := httprio1 as IAdmin;
  try
    //sData := vobj.GetKsCj('文管类一');
    if vobj.Query_Data(edt_Sql.Text,iCompressType,sData)=S_OK then
    begin
      ShowMessage('Execute SQL Command complated! OK! ');
      ClientDataSet1.XMLData := sData;
    end else
      ShowMessage('Error!');
  finally
    vobj := nil;
  end;
end;

procedure TClinetTestMain.edt_UrlChange(Sender: TObject);
begin
  HTTPRIO1.url := edt_Url.Text;
  SoapConnection1.URL := edt_Url.Text;
end;

procedure TClinetTestMain.FormCreate(Sender: TObject);
begin
  SoapConnection1.Close;
  edt_Url.OnChange(Self);
  pgc1.ActivePageIndex := 0;
end;

end.
