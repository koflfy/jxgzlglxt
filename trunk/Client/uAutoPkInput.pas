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
  sXxDM,sBmNo,sLbBH,sLbMc,sKcBH,sZwBH,sZkZH:string; //ѧУ���룬������ţ�����ţ�������ƣ�������ţ���λ���,׼��֤��
  bl:Boolean;
begin
  if MessageBox(Handle, '���棺' + #13#10#13#10 +
    '�����Զ��ſ�������ɾ��֮ǰ���е��ſ���¼���������ۡ���' + #13#10 +
    '��Щ��¼���Զ������Ļ����ֹ�¼��Ķ����ᱻɾ����' + #13#10#13#10 +
    '��Ҫ�����Զ��ſ�������', 'ϵͳ��ʾ', MB_YESNO + MB_ICONSTOP +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  iCount := vobj_Admin.GetRecordCount('׼��֤��');
  if iCount>0 then
  begin
    if MessageBox(Handle, PChar('���ؾ��棡' + #13#10#13#10 +
      '�������ݿ����Ѵ��ڡ�'+IntToStr(iCount)+'�����ſ���¼�����Ҫ�����ſ�����' + #13#10#13#10 +
      '��ɾ��������'), 'ϵͳ��ʾ', MB_YESNO + MB_ICONSTOP + MB_DEFBUTTON2 +
      MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

    if not InputQuery('ɾ����¼ȷ��','�����롾OK�������ַ�ȷ��ɾ����',sOK) then Exit;
    if UpperCase(sOk)<>'OK' then Exit;

    dm.ExecSql('delete from ׼��֤��');
    if chk1.Checked then
      dm.ExecSql('delete from �������ű�');
  end;

  sXxDM := edt_XxDM.Value;
  iCount := se_KcCount.Value;

  cds_bkLb := TClientDataSet.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  cds_Temp2 := TClientDataSet.Create(nil);

  cds_bkLb.XMLData := dm.OpenData('select ���,��� from רҵ���� order by ��ʾ˳��');

  sqlstr2 := 'SELECT * FROM ׼��֤��';// where ���='+quotedstr(sLbMc);
  cds_Temp2.XMLData := DM.OpenData(sqlstr2);

  ShowProgress('���ڽ����Զ��ſ�׼��...');
  btn_Start.Enabled := False;
  try
    iKcBH := 1; //������

    while not cds_bkLb.Eof do
    begin
      sLbBH := cds_bkLb.FieldByName('���').AsString;
      sLbMc := cds_bkLb.FieldByName('���').AsString;
      sqlstr := 'SELECT �������,�������,����� FROM ����˿��������� '+
                ' where �������='+quotedstr(sLbMc)+
                ' ORDER BY NEWID()';
      cds_Temp.XMLData := dm.OpenData(sqlstr);

      iZwBH := 1; //��λ��
      //iLbBH := cds_Temp.FieldByName('�����').AsInteger;
      sLbBH := cds_Temp.FieldByName('�����').AsString;
      sLbMC := cds_Temp.FieldByName('�������').AsString;

      UpdateProgressMax(cds_Temp.RecordCount);
      while not cds_Temp.Eof do
      begin
        UpdateProgress(cds_Temp.RecNo);
        UpdateProgressTitle(Format('���ڽ��С�'+sLbMc+'���Զ��ſ�...[%d/%d]',[cds_Temp.RecNo,cds_Temp.RecordCount]));

        sBmNo := cds_Temp.FieldByName('�������').AsString;

        sFmt := '%.'+se_kcBHLen.Text+'d';
        sKcBH := Format(sFmt,[iKcBH]);

        //if (sLbMC = cds_Temp.FieldByName('�������').AsString) and (iZwBH<=iCount) then
        if (iZwBH<=iCount) then
        begin
          sFmt := '%.'+se_ZwBHLen.Text+'d';
          sZwBH := Format(sFmt,[iZwBH]);

          sZkZH := sXxDM+sLbBH+sKcBH+sZwBH;

          cds_Temp2.Append;
          cds_Temp2.FieldByName('׼��֤��').Value := sZkZH;
          cds_Temp2.FieldByName('�������').Value := sBmNo;
          cds_Temp2.FieldByName('ѧУ����').Value := sXxDM;
          cds_Temp2.FieldByName('������').Value := sLbBH;
          cds_Temp2.FieldByName('���').Value := sLbMc;
          cds_Temp2.FieldByName('�������').Value := sKcBH;
          cds_Temp2.FieldByName('��λ���').Value := sZwBH;
          cds_Temp2.Post;
          iZwBH := iZwBH+1;
          cds_Temp.Next;
        end else
        begin
          sLbBH := cds_Temp.FieldByName('�����').AsString;
          sLbMC := cds_Temp.FieldByName('�������').AsString;
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
      bl := dm.UpdateData('Id','select top 1 * from ׼��֤��',cds_Temp2.Delta,False);
      if not bl then  Exit;
    end;
    
    sqlstr := 'SELECT ���,�������,MIN(׼��֤��) AS ��ʼ׼��֤��,MAX(׼��֤��) AS ����׼��֤��,'+
              'COUNT(*) AS �������� FROM ׼��֤�� GROUP BY ���, �������';
    cds_Temp.XMLData := DM.OpenData(sqlstr);

    sqlstr2 := 'select * from �������ű�';
    cds_Temp2.XMLData := dm.OpenData(sqlstr2);

    while not cds_Temp.Eof do
    begin
      if cds_Temp2.Locate('�������',cds_Temp.FieldByName('�������').AsString,[]) then
        cds_Temp2.Edit
      else
        cds_Temp2.Append;

      cds_Temp2.FieldByName('���').Value := cds_Temp.FieldByName('���').Value;
      cds_Temp2.FieldByName('�������').Value := cds_Temp.FieldByName('�������').Value;
      cds_Temp2.FieldByName('��ʼ׼��֤��').Value := cds_Temp.FieldByName('��ʼ׼��֤��').Value;
      cds_Temp2.FieldByName('����׼��֤��').Value := cds_Temp.FieldByName('����׼��֤��').Value;
      cds_Temp2.FieldByName('��������').Value := cds_Temp.FieldByName('��������').Value;
      //cds_Temp2.FieldByName('����').Value := '';
      cds_Temp2.Post;

      cds_Temp.Next
    end;

    if DataSetNoSave(cds_Temp2) then
      bl := dm.UpdateData('Id','select top 1 * from �������ű�',cds_Temp2.Delta,False);

  finally
    cds_Temp.Free;
    cds_Temp2.Free;
    cds_bkLb.Free;
    HideProgress;
    btn_Start.Enabled := True;
    if bl then
    begin
      iCount := vobj_Admin.GetRecordCount('׼��֤��');
      MessageBox(Handle, PChar('������ɣ�׼��֤��¼('+IntToStr(iCount)+'��)��������Ϣ�����Զ����ɣ���'
        + #13#10#13#10 + '���������ֹ����Ż����������Ӧ�Ľ�����Ϣ��'),
        'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
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
