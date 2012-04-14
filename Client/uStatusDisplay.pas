//--------------------------------------------------------------------------
//原创 自绘ListBox的两种效果收藏
//
//　　本文利用Listbox自绘实现了两种特殊效果（见图），左边的风格是自己突然灵感触发想到的，右边的风格来自＂C++ Builder 研究＂的一个帖子，老妖用BCB实现了，这里则用Delphi实现它。
//
//演示图片：
//自绘ListBox的效果
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
  DESIGN BY :  彭国辉
  DATE:        2004-11-29
  SITE:        http://kacarton.yeah.net/
  BLOG:        http://blog.csdn.net/nhconch
  EMAIL:       kacarton#sohu.com

  文章为作者原创，转载前请先与本人联系，转载请注明文章出处、保留作者信息，谢谢支持！
=========================================================================}

procedure TStatusDisplay.A1Click(Sender: TObject);
begin
  Main.tmr_Count.Enabled := TMenuItem(Sender).Checked;
end;

procedure TStatusDisplay.DisplayStatus;
var
  sData :string;
  bl,IsStart :Boolean;   //是否启用网上缴费
  sfmc,sTime,eTime,sState,
  jffs,jfCount,jfje :String;
  sqlstr:string;
begin
  sqlstr := 'select * from 网上报名时间设置表';
  sData := DM.OpenData(sqlstr);
  bl := sData<>'';
  if bl then
  begin
    ClientDataSet1.XMLData := sData;
    bl := ClientDataSet1.RecordCount>0;
  end;
  if not bl then
  begin
    sfmc := '网上报考信息设置不正确！';
    sTime := '开始时间：未设置   ';
    eTime := '结束时间：未设置   ';
    IsStart := False;
  end else
  begin
    sfmc    := Format('报考名称：%s',[ClientDataSet1.FieldByName('报名项目').AsString]);
    IsStart := ClientDataSet1.FieldByName('网络报名').AsBoolean and
               ((ClientDataSet1.FieldByName('开始时间').AsDateTime<=Now) and
               (ClientDataSet1.FieldByName('结束时间').AsDateTime>=Now));

    sTime   := FormatDateTime('开始时间：yyyy-mm-dd',ClientDataSet1.FieldByName('开始时间').AsDateTime);
    eTime   := FormatDateTime('结束时间：yyyy-mm-dd',ClientDataSet1.FieldByName('结束时间').AsDateTime);

{
    if not IsStart then
    begin
      if ClientDataSet1.FieldByName('是否启用').AsBoolean then
      begin
        sfmc := sfmc+'[未启用]';
      end else
        sfmc := sfmc+'[未开始]';
    end;
}

    {
    if IsStart then
      sState := '服务状态：网银收费已开启'
    else
      sState := '服务状态：网银收费已关闭'
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
    jffs    := Format('报名总人数：%d 人',[ClientDataSet1.FieldByName('总人数').AsInteger]);
    jfCount := Format('已缴费人数：%d 人',[ClientDataSet1.FieldByName('已缴费人数').AsInteger]);
    jfje    := Format('未缴费人数：%d 人',[ClientDataSet1.FieldByName('未缴费人数').AsInteger]);

    imgIndexList.Add('2');

    lsbRight.Items.Add(jffs+#13+jfCount+#13+jfje);
    ClientDataSet1.Next;
  end;
  ClientDataSet1.Close;
{

  lsbRight.Items.Add('本机发票信息：允许打印'+#13+'当前可用编号：'+dm.GetPrintBH+#13+'开票员打印为：'+dm.GetKpyName+#13+'');
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

    //文字颜色
    lsbRight.Canvas.Font.Color := clBlack;
    //设置背景颜色并填充背景
    //if imgIndexList[Index]<>'3' then
       lsbRight.Canvas.Brush.Color := clWhite;
    //else
    //   lsbRight.Canvas.Brush.Color := clSilver;

    lsbRight.Canvas.FillRect (Rect);
    //设置圆角矩形颜色并画出圆角矩形
    lsbRight.Canvas.Brush.Color := TColor($00FFF7F7);
    lsbRight.Canvas.Pen.Color := TColor($00131315);
    lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 2, Rect.Bottom - 2, 8, 8);
    //以不同的宽度和高度再画一次，实现立体效果
    lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 3, Rect.Bottom - 3, 5, 5);
    //如果是当前选中项
    if(odSelected in State) then
    begin
        //以不同的背景色画出选中项的圆角矩形
        lsbRight.Canvas.Brush.Color := TColor($00FFB2B5);
        lsbRight.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
                Rect.Right - 3, Rect.Bottom - 3, 5, 5);
        //选中项的文字颜色
        lsbRight.Canvas.Font.Color := clBlue;
        //如果当前项拥有焦点，画焦点虚框，当系统再绘制时变成XOR运算从而达到擦除焦点虚框的目的
        if(odFocused in State) then DrawFocusRect(lsbRight.Canvas.Handle, Rect);
    end;

    //画出图标
    //ImageList1.Draw(lsbRight.Canvas, Rect.Left + 7,
    //        Rect.top + (lsbRight.ItemHeight - ImageList1.Height) div 2, Index, true);

    ImageList1.Draw(lsbRight.Canvas, Rect.Left + 7,
         Rect.top + (lsbRight.ItemHeight - ImageList1.Height) div 2, StrToIntDef(imgIndexList[Index],4), true);

    //分别绘出三行文字
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

    //文字颜色
    lst_PrintBH.Canvas.Font.Color := clBlack;
    //设置背景颜色并填充背景
    //if imgIndexList[Index]<>'3' then
       lst_PrintBH.Canvas.Brush.Color := clWhite;
    //else
    //   lst_PrintBH.Canvas.Brush.Color := clSilver;

    lst_PrintBH.Canvas.FillRect (Rect);
    //设置圆角矩形颜色并画出圆角矩形
    lst_PrintBH.Canvas.Brush.Color := TColor($00FFF7F7);
    lst_PrintBH.Canvas.Pen.Color := TColor($00131315);
    lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 2, Rect.Bottom - 2, 8, 8);
    //以不同的宽度和高度再画一次，实现立体效果
    lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
            Rect.Right - 3, Rect.Bottom - 3, 5, 5);
    //如果是当前选中项
    if(odSelected in State) then
    begin
        //以不同的背景色画出选中项的圆角矩形
        lst_PrintBH.Canvas.Brush.Color := TColor($00FFB2B5);
        lst_PrintBH.Canvas.RoundRect(Rect.Left + 3, Rect.Top + 3,
                Rect.Right - 3, Rect.Bottom - 3, 5, 5);
        //选中项的文字颜色
        lst_PrintBH.Canvas.Font.Color := clBlue;
        //如果当前项拥有焦点，画焦点虚框，当系统再绘制时变成XOR运算从而达到擦除焦点虚框的目的
        if(odFocused in State) then DrawFocusRect(lst_PrintBH.Canvas.Handle, Rect);
    end;

    //画出图标
    //ImageList1.Draw(lst_PrintBH.Canvas, Rect.Left + 7,
    //        Rect.top + (lst_PrintBH.ItemHeight - ImageList1.Height) div 2, Index, true);

    ImageList1.Draw(lst_PrintBH.Canvas, Rect.Left + 7,
         Rect.top + (lst_PrintBH.ItemHeight - ImageList1.Height) div 2, 3, true);

    //分别绘出三行文字
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


