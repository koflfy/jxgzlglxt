unit uHsgzLxDmSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, DBGridEh, StdCtrls, Buttons, ExtCtrls,uHsgzLxInput,
  DBGrids, GridsEh, pngimage, DBGridEhGrouping, frxpngimage;

type
  THsgzLxDmSet = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Del: TBitBtn;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    btn_Add: TBitBtn;
    img_Hint: TImage;
    btn_Edit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PageControl1Change(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_EditClick(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    aForm: THsgzLxInput;
    sFilterStr:String;
    sOldHsgzLx:string;//规则类型
    sqlStr:String;
    procedure OpenTable;
  public
    { Public declarations }
  end;

var
  HsgzLxDmSet: THsgzLxDmSet;

implementation
uses uDM;
{$R *.dfm}

procedure THsgzLxDmSet.btn_AddClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    ClientDataSet1.Append;
    sOldHsgzLx := '';
    if aForm.ShowModal=mrOk then
      btn_Save.Click
    else
      ClientDataSet1.Cancel;
  end;
end;

procedure THsgzLxDmSet.btn_DelClick(Sender: TObject);
begin
  sOldHsgzLx := '';
  if ClientDataSet1.ReadOnly then Exit;
  
  if MessageBox(Handle, '真的要删除该记录吗？　　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  vobj_Admin.DropView(ClientDataSet1.FieldByName('规则类型').AsString);
  ClientDataSet1.Delete;
  sOldHsgzLx := ClientDataSet1.FieldByName('规则类型').AsString;
  btn_Save.Click;
end;

procedure THsgzLxDmSet.btn_EditClick(Sender: TObject);
begin
  if not ClientDataSet1.ReadOnly then
  begin
    sOldHsgzLx := ClientDataSet1.FieldByName('规则类型').AsString;
    if aForm.ShowModal=mrOk then
      btn_Save.Click
    else
      ClientDataSet1.Cancel;
  end;
end;

procedure THsgzLxDmSet.btn_ExitClick(Sender: TObject);
begin
  close;
end;

procedure THsgzLxDmSet.btn_SaveClick(Sender: TObject);
var
  sError,vn,sNewHsgzLx:string;
begin
  if not DataSetNoSave(ClientDataSet1) then Exit;

  try
    if DM.UpdateData('id',sqlStr,ClientDataSet1.Delta) then
    //if vobj_Admin.WriteHsgzLxData(ClientDataSet1.XMLData,sError) then
    begin
      if (sOldHsgzLx<>'') and (sNewHsgzLx<>sOldHsgzLx) then
        vobj_Admin.DropView(sOldHsgzLx);

      vn := ClientDataSet1.FieldByName('规则类型').AsString;
      sNewHsgzLx := ClientDataSet1.FieldByName('默认检索条件').AsString;
      if (sNewHsgzLx<>sOldHsgzLx) and (sNewHsgzLx<>'') then
        vobj_Admin.CreateView(vn,sNewHsgzLx);
      ClientDataSet1.MergeChangeLog;
    end else
      MessageBox(Handle, PAnsiChar('数据保存失败！原因为：'+sError+'　'), '系统提示', MB_OK + 
        MB_ICONSTOP + MB_TOPMOST);
  finally
    //cds_Temp.Free;
  end;
end;

procedure THsgzLxDmSet.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  DBGrid1.ReadOnly := True;
end;

procedure THsgzLxDmSet.ClientDataSet1AfterPost(DataSet: TDataSet);
begin
  btn_Save.Click;
end;

procedure THsgzLxDmSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('显示顺序').AsInteger := DataSet.RecordCount+1;
end;

procedure THsgzLxDmSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ClientDataSet1.State in [dsInsert,dsEdit] then
    ClientDataSet1.Post;

  if DataSetNoSave(ClientDataSet1) then
     if MessageBox(Handle, '数据已修改但未保存，要保存吗？　　', '系统提示',
       MB_YESNO + MB_ICONWARNING) = IDYES then
     begin
       btn_Save.Click;
     end;

  Action := caFree;
end;

procedure THsgzLxDmSet.FormCreate(Sender: TObject);
begin
  aForm := THsgzLxInput.Create(Self);
  aForm.edt_Index.DataSource := DataSource1;
  aForm.edt_HsgzLx.DataSource := DataSource1;
  OpenTable;
end;

procedure THsgzLxDmSet.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure THsgzLxDmSet.OpenTable;
begin
  sqlStr := 'select * from  核算规则类型表 order by 显示顺序';
  ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  //ClientDataSet1.XMLData := vobj_Admin.ReadHsgzLxData;
end;

procedure THsgzLxDmSet.PageControl1Change(Sender: TObject);
begin
  OpenTable;
end;

end.
