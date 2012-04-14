unit uZkzInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, Mask, DB, DBClient;

type
  TZkzInput = class(TForm)
    grp1: TGroupBox;
    lbl4: TLabel;
    edt_XxDM: TDBEditEh;
    lbl1: TLabel;
    edt_lbDm: TDBEditEh;
    lbl2: TLabel;
    lbl3: TLabel;
    edt_kcBH: TDBEditEh;
    edt_ZwBH: TDBEditEh;
    lbl5: TLabel;
    edt_ZkZH: TDBEditEh;
    lbl6: TLabel;
    lbl7: TLabel;
    edt_BMXH: TDBEditEh;
    lbl8: TLabel;
    edt_bkLb: TDBComboBoxEh;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    chk_Edit: TCheckBox;
    btn_Search: TBitBtn;
    cds_Ksxx: TClientDataSet;
    ds_Ksxx: TDataSource;
    btn_Zkzxx: TBitBtn;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    DBEditEh3: TDBEditEh;
    lbl12: TLabel;
    DBEditEh4: TDBEditEh;
    lbl13: TLabel;
    DBEditEh5: TDBEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure btn_ZkzxxClick(Sender: TObject);
    procedure chk_EditClick(Sender: TObject);
    procedure edt_BMXHChange(Sender: TObject);
    procedure edt_ZkZHChange(Sender: TObject);
    procedure edt_ZwBHChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    bZkzIsOK,bKsIsOK:Boolean;
  public
    { Public declarations }
    procedure SetInfo(const sXxdm,sLbDM,sLbMc,sKcBH:string);
  end;

var
  ZkzInput: TZkzInput;

implementation
uses uDM,uZkzEdit;
{$R *.dfm}

procedure TZkzInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZkzInput.btn_SaveClick(Sender: TObject);
var
  sqlstr:string;
  sKcBH,sZwBH,sZkZH,sBmNo,sXxDM,sLbBH,sLbMc:string;
begin
  sBmNo := edt_BMXH.Text;
  sZkZH := edt_ZkZH.Text;

  sZwBH := edt_ZwBH.Text;
  sKcBH := edt_kcBH.Text;
  sLbBH := edt_lbDm.Text;
  sLbMc := edt_bkLb.Text;
  sXxDM := edt_XxDM.Text;

  sqlstr := 'insert into 准考证表 (准考证号,报名序号,学校代码,类别代码,类别,考场编号,座位编号) '+
            'values('+quotedstr(sZkZH)+','+quotedstr(sBmNo)+','+quotedstr(sXxDM)+','+
            quotedstr(sLbBH)+','+quotedstr(sLbMc)+','+quotedstr(sKcBH)+','+quotedstr(sZwBH)+')';
  if dm.ExecSql(sqlstr) then
  begin
    MessageBox(Handle, '操作完成！准考证信息手工添加成功！　', '系统提示',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    if LowerCase(Self.Owner.ClassName)='tzkzedit' then
      TZkzEdit(Self.Owner).OpenTable;
    //TZkzEdit(Self.Parent).cds_Zkz.Last;
    //Close;
  end;
end;

procedure TZkzInput.btn_SearchClick(Sender: TObject);
var
  sqlstr,sBmNo:string;
begin
  bKsIsOK := False;
  sBmNo := edt_BMXH.Text;
  sqlstr := 'select 姓名,性别,报考类别,身份证号,现就读学校 from 已审核考生报名表 where 报名序号='+quotedstr(sBmNo)+' and 报考类别='+quotedstr(edt_bkLb.Text);
  cds_Ksxx.XMLData := dm.OpenData(sqlstr);
  if  cds_Ksxx.RecordCount=0 then
  begin
    MessageBox(Handle, PChar('报名序号为【'+sBmNo+'】的【'+edt_bkLb.Text+'】考生不存在或未审核！　' + #13#10 +
      '请检查后重试！'), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_BMXH.SetFocus;
  end
  else if vobj_Admin.RecordIsExists('where 报名序号='+quotedstr(sBmNo),'准考证表') then
  begin
    MessageBox(Handle, PChar('报名序号为【'+sBmNo+'】的准考证记录已存在！不能重复编制准考证号！　' + #13#10 +
      '请检查后重试！'), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_BMXH.SetFocus;
  end else
    bKsIsOK := True;
  btn_Save.Enabled := bZkzIsOK and bKsIsOK;
end;

procedure TZkzInput.btn_ZkzxxClick(Sender: TObject);
var
  sZkZH:string;
begin
  sZkZH := edt_ZkZH.Text;
  if vobj_Admin.RecordIsExists('where 准考证号='+quotedstr(sZkZH),'准考证表') then
  begin
    bZkzIsOK := False;
    MessageBox(Handle, PChar('准考证号为【'+sZkZH+'】的记录已存在！不能使用此准考证号！　' + #13#10 +
      '请检查后重试！'), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_ZkZH.SetFocus;
  end else
  begin
    bZkzIsOK := True;
    MessageBox(Handle, PChar('该准考证号可以使用！　'), '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
  btn_Save.Enabled := bZkzIsOK and bKsIsOK;
end;

procedure TZkzInput.chk_EditClick(Sender: TObject);
begin
  edt_XxDM.Enabled := chk_Edit.Checked;
  edt_lbDm.Enabled := chk_Edit.Checked;
  edt_bkLb.Enabled := chk_Edit.Checked;
  //edt_kcBH.Enabled := chk_Edit.Checked;
end;

procedure TZkzInput.edt_BMXHChange(Sender: TObject);
begin
  bKsIsOK := False;
  btn_Search.Enabled := edt_BMXH.Text<>'';
end;

procedure TZkzInput.edt_ZkZHChange(Sender: TObject);
begin
  bZkzIsOK := False;
end;

procedure TZkzInput.edt_ZwBHChange(Sender: TObject);
begin
  edt_ZkZH.Text := edt_XxDM.Text+edt_LbDM.Text+edt_kcBH.Text+edt_ZwBH.Text;
  btn_Zkzxx.Enabled := TDBEditEh(Sender).Text<>'';
end;

procedure TZkzInput.FormShow(Sender: TObject);
begin
  if edt_kcBH.Text='' then
    edt_kcBH.SetFocus
  else if edt_ZwBH.Text='' then
    edt_ZwBH.SetFocus
  else
    btn_Exit.SetFocus;
end;

procedure TZkzInput.SetInfo(const sXxdm, sLbDM, sLbMc, sKcBH: string);
begin
  edt_XxDM.Text := sXxdm;
  edt_lbDm.Text := sLbDM;
  edt_bkLb.Text := sLbMc;
  edt_kcBH.Text := sKcBH;
  btn_Save.Enabled := False;
end;

end.
