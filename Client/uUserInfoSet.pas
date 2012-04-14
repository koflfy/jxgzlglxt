unit uUserInfoSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, Mask, DBCtrls, 
  ExtCtrls, pngimage, frxpngimage;

type
  TUserInfoSet = class(TForm)
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    ClientDataSet1WideStringField: TWideStringField;
    ClientDataSet1WideStringField2: TWideStringField;
    ClientDataSet1WideStringField3: TWideStringField;
    ClientDataSet1WideStringField4: TWideStringField;
    ClientDataSet1WideStringField5: TWideStringField;
    ClientDataSet1WideStringField6: TWideStringField;
    ClientDataSet1WideStringField7: TWideStringField;
    ClientDataSet1WideStringField8: TWideStringField;
    ClientDataSet1WideStringField9: TWideStringField;
    ClientDataSet1WideStringField10: TWideStringField;
    ClientDataSet1WideStringField11: TWideStringField;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
    dbedt3: TDBEdit;
    dbedt4: TDBEdit;
    dbedt5: TDBEdit;
    dbedt6: TDBEdit;
    dbedt7: TDBEdit;
    dbedt8: TDBEdit;
    dbedt9: TDBEdit;
    dbedt10: TDBEdit;
    dbedt11: TDBEdit;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  UserInfoSet: TUserInfoSet;

implementation
uses uDM;
{$R *.dfm}

procedure TUserInfoSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TUserInfoSet.btn_SaveClick(Sender: TObject);
begin
  if dm.UpdateData('用户名称','select * from 机主信息表',ClientDataSet1.Delta) then
  begin
    MessageBox(Handle, '信息已保存！　　', '系统提示', MB_OK+MB_ICONINFORMATION);
    ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TUserInfoSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;

  if ClientDataSet1.ChangeCount>0 then
     if MessageBox(Handle, '数据已修改但未保存，要保存吗？　　', '系统提示',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;
  Action := caFree;
end;

procedure TUserInfoSet.FormCreate(Sender: TObject);
var
  sData:string;
begin
  sData := dm.OpenData('select * from 机主信息表');
  ClientDataSet1.XMLData := sData;
end;

end.
