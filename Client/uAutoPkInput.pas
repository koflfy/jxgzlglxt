unit uAutoPkInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DBClient,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrlsEh, ComCtrls, Spin, Buttons,CnProgressFrm;

type
  TAutoPkInput = class(TForm)
    grp1: TGroupBox;
    lbl5: TLabel;
    se_KcBHLen: TSpinEdit;
    lbl6: TLabel;
    se_LbBHLen: TSpinEdit;
    lbl7: TLabel;
    se_XxDMLen: TSpinEdit;
    lbl2: TLabel;
    se_ZwBHLen: TSpinEdit;
    se_KcCount: TSpinEdit;
    lbl3: TLabel;
    edt_XxDM: TDBNumberEditEh;
    lbl4: TLabel;
    bvl1: TBevel;
    lbl_Sample: TLabel;
    chk1: TCheckBox;
    lbl1: TLabel;
    btn_Start: TBitBtn;
    btn_Close: TBitBtn;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl_Sample2: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure edt_XxDMChange(Sender: TObject);
    procedure se_KcBHLenChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TAutoPkInput.btn_StartClick(Sender: TObject);
var
  cds_bkLb,cds_Temp,cds_Temp2:TClientDataSet;
  iCount,iLbBH,iKcBH,iZwBH:Integer;
  sqlstr,sqlstr2,sOK,sFmt:string;
  sXxDM,sBmNo,sLbBH,sLbMc,sKcBH,sZwBH,sZkZH:string; //学校代码，报名序号，类别编号，类别名称，考场编号，座位编号,准考证号
  bl:Boolean;
begin
  if MessageBox(Handle, '警告：' + #13#10#13#10 +
    '　　自动排考操作将删除之前所有的排考记录！而且无论　　' + #13#10 +
    '这些记录是自动产生的还是手工录入的都将会被删除！' + #13#10#13#10 +
    '还要继续自动排考操作吗？', '系统提示', MB_YESNO + MB_ICONSTOP +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  iCount := vobj_Admin.GetRecordCount('准考证表');
  if iCount>0 then
  begin
    if MessageBox(Handle, PChar('严重警告！' + #13#10#13#10 +
      '　　数据库中已存在【'+IntToStr(iCount)+'】条排考记录！真的要重新排考　　' + #13#10#13#10 +
      '并删除它们吗？'), '系统提示', MB_YESNO + MB_ICONSTOP + MB_DEFBUTTON2 +
      MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

    if not InputQuery('删除记录确认','请输入【OK】两个字符确认删除：',sOK) then Exit;
    if UpperCase(sOk)<>'OK' then Exit;

    dm.ExecSql('delete from 准考证表');
    if chk1.Checked then
      dm.ExecSql('delete from 考场编排表');
  end;

  sXxDM := edt_XxDM.Value;
  iCount := se_KcCount.Value;

  cds_bkLb := TClientDataSet.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  cds_Temp2 := TClientDataSet.Create(nil);

  cds_bkLb.XMLData := dm.OpenData('select 编号,类别 from 专业类别表 order by 显示顺序');

  sqlstr2 := 'SELECT * FROM 准考证表';// where 类别='+quotedstr(sLbMc);
  cds_Temp2.XMLData := DM.OpenData(sqlstr2);

  ShowProgress('正在进行自动排考准备...');
  btn_Start.Enabled := False;
  try
    iKcBH := 1; //考场号

    while not cds_bkLb.Eof do
    begin
      sLbBH := cds_bkLb.FieldByName('编号').AsString;
      sLbMc := cds_bkLb.FieldByName('类别').AsString;
      sqlstr := 'SELECT 报名序号,报考类别,类别编号 FROM 已审核考生报名表 '+
                ' where 报考类别='+quotedstr(sLbMc)+
                ' ORDER BY NEWID()';
      cds_Temp.XMLData := dm.OpenData(sqlstr);

      iZwBH := 1; //座位号
      //iLbBH := cds_Temp.FieldByName('类别编号').AsInteger;
      sLbBH := cds_Temp.FieldByName('类别编号').AsString;
      sLbMC := cds_Temp.FieldByName('报考类别').AsString;

      UpdateProgressMax(cds_Temp.RecordCount);
      while not cds_Temp.Eof do
      begin
        UpdateProgress(cds_Temp.RecNo);
        UpdateProgressTitle(Format('正在进行【'+sLbMc+'】自动排考...[%d/%d]',[cds_Temp.RecNo,cds_Temp.RecordCount]));

        sBmNo := cds_Temp.FieldByName('报名序号').AsString;

        sFmt := '%.'+se_kcBHLen.Text+'d';
        sKcBH := Format(sFmt,[iKcBH]);

        //if (sLbMC = cds_Temp.FieldByName('报考类别').AsString) and (iZwBH<=iCount) then
        if (iZwBH<=iCount) then
        begin
          sFmt := '%.'+se_ZwBHLen.Text+'d';
          sZwBH := Format(sFmt,[iZwBH]);

          sZkZH := sXxDM+sLbBH+sKcBH+sZwBH;

          cds_Temp2.Append;
          cds_Temp2.FieldByName('准考证号').Value := sZkZH;
          cds_Temp2.FieldByName('报名序号').Value := sBmNo;
          cds_Temp2.FieldByName('学校代码').Value := sXxDM;
          cds_Temp2.FieldByName('类别代码').Value := sLbBH;
          cds_Temp2.FieldByName('类别').Value := sLbMc;
          cds_Temp2.FieldByName('考场编号').Value := sKcBH;
          cds_Temp2.FieldByName('座位编号').Value := sZwBH;
          cds_Temp2.Post;
          iZwBH := iZwBH+1;
          cds_Temp.Next;
        end else
        begin
          sLbBH := cds_Temp.FieldByName('类别编号').AsString;
          sLbMC := cds_Temp.FieldByName('报考类别').AsString;
          iKcBH := iKcBH+1;
          iZwBH := 1;
        end;

      end;
      iKcBH := iKcBH+1;
      cds_bkLb.Next;
    end;

    bl := True;
    if DataSetNoSave(cds_Temp2) then
    begin
      bl := dm.UpdateData('Id','select top 1 * from 准考证表',cds_Temp2.Delta,False);
      if not bl then  Exit;
    end;
    
    sqlstr := 'SELECT 类别,考场编号,MIN(准考证号) AS 起始准考证号,MAX(准考证号) AS 结束准考证号,'+
              'COUNT(*) AS 考试人数 FROM 准考证表 GROUP BY 类别, 考场编号';
    cds_Temp.XMLData := DM.OpenData(sqlstr);

    sqlstr2 := 'select * from 考场编排表';
    cds_Temp2.XMLData := dm.OpenData(sqlstr2);

    while not cds_Temp.Eof do
    begin
      if cds_Temp2.Locate('考场编号',cds_Temp.FieldByName('考场编号').AsString,[]) then
        cds_Temp2.Edit
      else
        cds_Temp2.Append;

      cds_Temp2.FieldByName('类别').Value := cds_Temp.FieldByName('类别').Value;
      cds_Temp2.FieldByName('考场编号').Value := cds_Temp.FieldByName('考场编号').Value;
      cds_Temp2.FieldByName('起始准考证号').Value := cds_Temp.FieldByName('起始准考证号').Value;
      cds_Temp2.FieldByName('结束准考证号').Value := cds_Temp.FieldByName('结束准考证号').Value;
      cds_Temp2.FieldByName('考试人数').Value := cds_Temp.FieldByName('考试人数').Value;
      //cds_Temp2.FieldByName('教室').Value := '';
      cds_Temp2.Post;

      cds_Temp.Next
    end;

    if DataSetNoSave(cds_Temp2) then
      bl := dm.UpdateData('Id','select top 1 * from 考场编排表',cds_Temp2.Delta,False);

  finally
    cds_Temp.Free;
    cds_Temp2.Free;
    cds_bkLb.Free;
    HideProgress;
    btn_Start.Enabled := True;
    if bl then
    begin
      iCount := vobj_Admin.GetRecordCount('准考证表');
      MessageBox(Handle, PChar('操作完成！准考证记录('+IntToStr(iCount)+'条)及考场信息均已自动生成！　'
        + #13#10#13#10 + '接下来请手工安排或调整考场对应的教室信息！'),
        '系统提示', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
      Self.Close;
    end;
  end;
end;

procedure TAutoPkInput.edt_XxDMChange(Sender: TObject);
begin
  se_XxDMLen.Value := Length(edt_XxDM.Text);
  btn_Start.Enabled := Length(edt_XxDM.Text)>0;
end;

procedure TAutoPkInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAutoPkInput.se_KcBHLenChange(Sender: TObject);
begin
  lbl_Sample.Caption := StringOfChar('A',se_XxDMLen.Value)+StringOfChar('B',se_LbBHLen.Value)+
                        StringOfChar('C',se_KcBHLen.Value)+StringOfChar('D',se_ZwBHLen.Value);
  lbl_Sample2.Caption := edt_XxDM.Text+Format('%.'+se_LbBHLen.Text+'d',[1])+
                         Format('%.'+se_KcBHLen.Text+'d',[9])+Format('%.'+se_ZwBHLen.Text+'d',[18]);
end;

procedure TAutoPkInput.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

end.
