unit uNetBmTimeSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, DBClient, DBCtrlsEh, Mask, DBCtrls,
  RzEdit, frxpngimage, pngimage, StrUtils;

type
  TNetBmTimeSet = class(TForm)
    grp1: TGroupBox;
    cds1: TClientDataSet;
    ds1: TDataSource;
    pnl1: TPanel;
    btn_Set: TBitBtn;
    btn_Exit: TBitBtn;
    Label1: TLabel;
    dbedt1: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    dbchk1: TDBCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Label6: TLabel;
    lbl1: TLabel;
    dbedtWebSrvUrl: TDBEdit;
    lbl2: TLabel;
    dbedtUploadProcessFile: TDBEdit;
    lbl3: TLabel;
    dbedtUploadVirtualDir: TDBEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dbchk2: TDBCheckBox;
    dbchk3: TDBCheckBox;
    lbl7: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cds1BeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cds1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NetBmTimeSet: TNetBmTimeSet;

implementation
uses uDM;
{$R *.dfm}

procedure TNetBmTimeSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TNetBmTimeSet.btn_SetClick(Sender: TObject);
begin
  if cds1.State in [dsInsert,dsEdit] then
    cds1.Post;
  if cds1.ChangeCount>0 then
    if DM.UpdateData('ID','select * from 网上报名时间设置表',cds1.Delta,False) then
    begin
      cds1.MergeChangeLog;
      MessageBox(Handle, '操作完成！网上报名参数设置成功！　　', '系统提示', MB_OK
        + MB_ICONINFORMATION + MB_TOPMOST);
      //vobj_Admin.GetCurSfSetInfo(gb_Cur_Xn,gb_Cur_Sfmc,gb_Cur_StartTime,gb_Cur_EndTime);
    end;
end;

procedure TNetBmTimeSet.cds1BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('操作员').AsString := gb_Czy_ID;
end;

procedure TNetBmTimeSet.cds1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('招名项目').AsString := FormatDateTime('yyyy年教学工作量网上查询',Now);
  DataSet.FieldByName('操作员').AsString := gb_Czy_ID;
end;

procedure TNetBmTimeSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TNetBmTimeSet.FormCreate(Sender: TObject);
begin
  cds1.XMLData := dm.OpenData('select * from 网上报名时间设置表');
end;

end.
