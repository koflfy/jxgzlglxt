//--------------------------------------------------------------------------
//ԭ�� �Ի�ListBox������Ч���ղ�
//
//������������Listbox�Ի�ʵ������������Ч������ͼ������ߵķ�����Լ�ͻȻ��д����뵽�ģ��ұߵķ�����ԣ�C++ Builder �о�����һ�����ӣ�������BCBʵ���ˣ���������Delphiʵ������
//
//��ʾͼƬ��
//�Ի�ListBox��Ч��
//
//--------------------------------------------------------------------------

unit uStatusDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ExtCtrls, DB, DBClient, Menus;

type
  TStatusDisplay = class(TForm)
    lsbRight: TListBox;
    ImageList1: TImageList;
    ClientDataSet1: TClientDataSet;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    A1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure lsbRightDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lsbRightClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure lst_PrintBHDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lst_PrintBHDblClick(Sender: TObject);
  private
    imgIndexList,jfhList:TStrings;
    OnlyDispalyOpenJf:Boolean;
  public
    { Public declarations }
    procedure SetDisplayStatus(const bOnlyDisplayOpenJf:Boolean=True);
    procedure DisplayStatus;
  end;

implementation
uses uMain,uDM;
{$R *.dfm}

{========================================================================
  DESIGN BY :  �����
  DATE:        2004-11-29
  SITE:        http://kacarton.yeah.net/
  BLOG:        http://blog.csdn.net/nhconch
  EMAIL:       kacarton#sohu.com

  ����Ϊ����ԭ����ת��ǰ�����뱾����ϵ��ת����ע�����³���������������Ϣ��лл֧�֣�
=========================================================================}

procedure TStatusDisplay.A1Click(Sender: TObject);
begin
  Main.tmr_Count.Enabled := TMenuItem(Sender).Checked;
end;

procedure TStatusDisplay.DisplayStatus;
var
  sData :string;
  bl,IsStart :Boolean;   //�Ƿ��������Ͻɷ�
  sfmc,sTime,eTime,sState,
  jffs,jfCount,jfje :String;
  sqlstr:string;
begin
  sqlstr := 'select * from ���ϱ���ʱ�����ñ�';
  sData := DM.OpenData(sqlstr);
  bl := sData<>'';
  if bl then
  begin
    ClientDataSet1.XMLData := sData;
    bl := ClientDataSet1.RecordCount>0;
  end;
  if not bl then
  begin
    sfmc := '���ϱ�����Ϣ���ò���ȷ��';
    sTime := '��ʼʱ�䣺δ����   ';
    eTime := '����ʱ�䣺δ����   ';
    IsStart := False;
  end else
  begin
    sfmc    := Format('�������ƣ�%s',[ClientDataSet1.FieldByName('������Ŀ').AsString]);
    IsStart := ClientDataSet1.FieldByName('���籨��').AsBoolean and
               ((ClientDataSet1.FieldByName('��ʼʱ��').AsDateTime<=Now) and
               (ClientDataSet1.FieldByName('����ʱ��').AsDateTime>=Now));

    sTime   := FormatDateTime('��ʼʱ�䣺yyyy-mm-dd',ClientDataSet1.FieldByName('��ʼʱ��').AsDateTime);
    eTime   := FormatDateTime('����ʱ�䣺yyyy-mm-dd',ClientDataSet1.FieldByName('����ʱ��').AsDateTime);

{
    if not IsStart then
    begin
      if ClientDataSet1.FieldByName('�Ƿ�����').AsBoolean then
      begin
        sfmc := sfmc+'[δ����]';
      end else
        sfmc := sfmc+'[δ��ʼ]';
    end;
}

    {
    if IsStart then
      sState := '����״̬�������շ��ѿ���'
    else
      sState := '����״̬�������շ��ѹر�'
    }
  end;

  lsbRight.Items.Clear;
  imgIndexList.Clear;

  lsbRight.Items.Add(sfmc+#13+sTime+#13+eTime+#13+sState);
  if IsStart then
    imgIndexList.Add('0')
  else
    imgIndexList.Add('1');

  try
    sData := vobj_Admin.GetHintMessage;
    if sData='' then Exit;
  except
    Exit;
  end;

  ClientDataSet1.XMLData := sData;
  while not ClientDataSet1.Eof do
  begin
    jffs    := Format('������������%d ��',[ClientDataSet1.FieldByName('������').AsInteger]);
    jfCount := Format('�ѽɷ�������%d ��',[ClientDataSet1.FieldByName('�ѽɷ�����').AsInteger]);
    jfje    := Format('δ�ɷ�������%d ��',[ClientDataSet1.FieldByName('δ�ɷ�����').AsInteger]);

    imgIndexList.Add('2');

    lsbRight.Items.Add(jffs+#13+jfCount+#13+jfje);
    ClientDataSet1.Next;
  end;
  ClientDataSet1.Close;
{

  lsbRight.Items.Add('������Ʊ��Ϣ�������ӡ'+#13+'��ǰ���ñ�ţ�'+dm.GetPrintBH+#13+'��ƱԱ��ӡΪ��'+dm.GetKpyName+#13+'');
  imgIndexList.Add('3');
}
  lsbRight.ItemIndex := 0;
end;

procedure TStatusDisplay.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caMinimize;
end;

procedure TStatusDisplay.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Main.act_Win_HintMessage.Checked;
end;

procedure TStatusDisplay.FormCreate(Sender: TObject);
begin
    OnlyDispalyOpenJf := True;
    imgIndexList := TStringList.Create;
    jfhList := TStringList.Create;
    lsbRight.Style := lbOwnerDrawFixed;
    lsbRight.Ctl3D := false;
    lsbRight.ItemHeight := 55;

    //lst_PrintBH.Style := lbOwnerDrawFixed;
    //lst_PrintBH.Ctl3D := false;
    //lst_PrintBH.ItemHeight := 55;

    DisplayStatus;
end;

procedure TStatusDisplay.FormDestroy(Sender: TObject);
begin
  imgIndexList.Free;
  jfhList.Free;
end;

procedure TStatusDisplay.lsbRightDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
    strTemp: String;
begin
    if (Index=-1) or (Index>=imgIndexList.Count) or (Index>=lsbRight.Count) then
      Exit;

    //������ɫ
    lsbRight.Canvas.Font.Color := clBlack;
    //���ñ�����ɫ����䱳��
    //if imgIndexList[Index]<>'3' then
       lsbRight.Canvas.Brush.Color := clWhite;
    //else
    //   lsbRight.Canvas.Brush.Color := clSilver;

    lsbRight.Canvas.FillRect (Rect);
    //����Բ�Ǿ�����ɫ������Բ�Ǿ���
    lsbRight.Canvas.Brush.Color := TColor($00FFF7F7);
    lsbRight.Canvas.Pen.Color := TColor($00131315);
    lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 2, Rect.Bottom - 2, 8, 8);
    //�Բ�ͬ�Ŀ�Ⱥ͸߶��ٻ�һ�Σ�ʵ������Ч��
    lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 3, Rect.Bottom - 3, 5, 5);
    //����ǵ�ǰѡ����
    if(odSelected in State) then
    begin
        //�Բ�ͬ�ı���ɫ����ѡ�����Բ�Ǿ���
        lsbRight.Canvas.Brush.Color := TColor($00FFB2B5);
        lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
                Rect.Right - 3, Rect.Bottom - 3, 5, 5);
        //ѡ�����������ɫ
        lsbRight.Canvas.Font.Color := clBlue;
        //�����ǰ��ӵ�н��㣬��������򣬵�ϵͳ�ٻ���ʱ���XOR����Ӷ��ﵽ������������Ŀ��
        if(odFocused in State) then DrawFocusRect(lsbRight.Canvas.Handle, Rect);
    end;

    //����ͼ��
    //ImageList1.Draw(lsbRight.Canvas, Rect.Left + 7,
    //        Rect.top + (lsbRight.ItemHeight - ImageList1.Height) div 2, Index, true);

    ImageList1.Draw(lsbRight.Canvas, Rect.Left + 7,
         Rect.top + (lsbRight.ItemHeight - ImageList1.Height) div 2, StrToIntDef(imgIndexList[Index],4), true);

    //�ֱ�����������
    strTemp := lsbRight.Items.Strings[Index];
    lsbRight.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 4
                            , Copy(strTemp, 1, Pos(#13, strTemp)-1));
    strTemp := Copy(strTemp, Pos(#13, strTemp)+1, Length(strTemp));
    lsbRight.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 18,
                            Copy(strTemp, 1, Pos(#13, strTemp)-1));
    lsbRight.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 32,
                            Copy(strTemp, Pos(#13, strTemp)+1, Length(strTemp)));
end;

procedure TStatusDisplay.N1Click(Sender: TObject);
begin
  DisplayStatus;
end;

procedure TStatusDisplay.SetDisplayStatus(
  const bOnlyDisplayOpenJf: Boolean);
begin
  OnlyDispalyOpenJf := bOnlyDisplayOpenJf;
end;

procedure TStatusDisplay.tmr1Timer(Sender: TObject);
begin
  DisplayStatus;
end;

procedure TStatusDisplay.lsbRightClick(Sender: TObject);
begin
    //StaticText1.Caption := ' ' + lsbRight.Items.Strings[lsbRight.ItemIndex];
end;

procedure TStatusDisplay.FormShow(Sender: TObject);
begin
  //Mng_RoomStatusForm.Left := Mng_MainForm.ClientWidth-Mng_RoomStatusForm.Width-6;
  //Mng_RoomStatusForm.Top := 1;
  lsbRight.ItemIndex := 0;
  lsbRight.Repaint();
  //lst_PrintBH.Repaint();
end;

procedure TStatusDisplay.lst_PrintBHDblClick(Sender: TObject);
var
  iCount:Integer;
begin
  iCount := TListbox(Sender).Count-1;
  if TListbox(Sender).ItemIndex = iCount then
    Main.act_Cwsf_PrintSet.Execute;
end;

procedure TStatusDisplay.lst_PrintBHDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
    strTemp: String;
begin
{    if (Index=-1) or (Index>=imgIndexList.Count) or (Index>=lst_PrintBH.Count) then
      Exit;

    //������ɫ
    lst_PrintBH.Canvas.Font.Color := clBlack;
    //���ñ�����ɫ����䱳��
    //if imgIndexList[Index]<>'3' then
       lst_PrintBH.Canvas.Brush.Color := clWhite;
    //else
    //   lst_PrintBH.Canvas.Brush.Color := clSilver;

    lst_PrintBH.Canvas.FillRect (Rect);
    //����Բ�Ǿ�����ɫ������Բ�Ǿ���
    lst_PrintBH.Canvas.Brush.Color := TColor($00FFF7F7);
    lst_PrintBH.Canvas.Pen.Color := TColor($00131315);
    lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 2, Rect.Bottom - 2, 8, 8);
    //�Բ�ͬ�Ŀ�Ⱥ͸߶��ٻ�һ�Σ�ʵ������Ч��
    lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 3, Rect.Bottom - 3, 5, 5);
    //����ǵ�ǰѡ����
    if(odSelected in State) then
    begin
        //�Բ�ͬ�ı���ɫ����ѡ�����Բ�Ǿ���
        lst_PrintBH.Canvas.Brush.Color := TColor($00FFB2B5);
        lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
                Rect.Right - 3, Rect.Bottom - 3, 5, 5);
        //ѡ�����������ɫ
        lst_PrintBH.Canvas.Font.Color := clBlue;
        //�����ǰ��ӵ�н��㣬��������򣬵�ϵͳ�ٻ���ʱ���XOR����Ӷ��ﵽ������������Ŀ��
        if(odFocused in State) then DrawFocusRect(lst_PrintBH.Canvas.Handle, Rect);
    end;

    //����ͼ��
    //ImageList1.Draw(lst_PrintBH.Canvas, Rect.Left + 7,
    //        Rect.top + (lst_PrintBH.ItemHeight - ImageList1.Height) div 2, Index, true);

    ImageList1.Draw(lst_PrintBH.Canvas, Rect.Left + 7,
         Rect.top + (lst_PrintBH.ItemHeight - ImageList1.Height) div 2, 3, true);

    //�ֱ�����������
    strTemp := lst_PrintBH.Items.Strings[Index];
    lst_PrintBH.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 4
                            , Copy(strTemp, 1, Pos(#13, strTemp)-1));
    strTemp := Copy(strTemp, Pos(#13, strTemp)+1, Length(strTemp));
    lst_PrintBH.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 18,
                            Copy(strTemp, 1, Pos(#13, strTemp)-1));
    lst_PrintBH.Canvas.TextOut(Rect.Left + 32 + 10, Rect.Top + 32,
                            Copy(strTemp, Pos(#13, strTemp)+1, Length(strTemp)));
}
end;

end.


