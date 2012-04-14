unit uInitKsCjb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls, DB, DBClient, ComCtrls;

type
  TInitKsCjb = class(TForm)
    pnl_Title: TPanel;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Exit: TBitBtn;
    chk_Delete: TCheckBox;
    cds_1: TClientDataSet;
    cds_2: TClientDataSet;
    pnl2: TPanel;
    btn_Start: TBitBtn;
    pb1: TProgressBar;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TInitKsCjb.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TInitKsCjb.btn_StartClick(Sender: TObject);
var
  iCount :Integer;
  zkzh,kskc,str:string;
  bl:Boolean;
begin
  if chk_Delete.Checked then
    str := '并且在初始化之前清空成绩表'
  else
    str := '';
  if MessageBox(Handle, PChar('真的要初始化考生成绩录入表'+str+'吗？　'), '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if chk_Delete.Checked then
  begin
    iCount := vobj_Admin.GetRecordCount('考生成绩表');
    if iCount>0 then
    begin
       if MessageBox(Handle,
         PChar('当前成绩表中已有'+IntToStr(iCount)+'条成绩记录，真的要删除它们吗？　'),
         '系统提示', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) =
         IDNO then
       begin
         Exit;
       end;
      dm.ExecSql('delete from 考生成绩表');
    end;
  end;

  Screen.Cursor := crHourGlass;
  try
    cds_1.XMLData := DM.OpenData('select 准考证号,考试课程 from view_考生签到表');
    cds_2.XMLData := dm.OpenData('select * from 考生成绩表');
    pb1.Max := cds_1.RecordCount;
    iCount := 0;
    while not cds_1.Eof do
    begin
      pb1.Position := cds_1.RecNo;
      Application.ProcessMessages;
      zkzh := cds_1.FieldByName('准考证号').AsString;
      kskc := cds_1.FieldByName('考试课程').AsString;
      if not cds_2.Locate('准考证号;考试课程',varArrayOf([zkzh,kskc]),[]) then
      begin
        cds_2.Append;
        cds_2.FieldByName('准考证号').AsString := zkzh;
        cds_2.FieldByName('考试课程').AsString := kskc;
        cds_2.FieldByName('是否提交').AsBoolean := False;
        cds_2.FieldByName('状态').AsString := '正常';
        cds_2.Post;
        Inc(iCount);
      end;
      cds_1.Next;
    end;

    bl := True;
    if DataSetNoSave(cds_2) then
      bl := dm.UpdateData('Id','select top 1 * from 考生成绩表',cds_2.Delta);

    if bl then
      MessageBox(Handle, PChar('操作完成！共有【'+IntToStr(cds_2.RecordCount)+'】条记录被初始化！其中新增记录'+IntToStr(iCount)+'条！　'), '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TInitKsCjb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

end.
