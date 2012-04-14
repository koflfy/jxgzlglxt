object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #26435#38480#32452#35774#32622
  ClientHeight = 394
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object spl1: TSplitter
    Left = 177
    Top = 0
    Height = 352
    ExplicitLeft = 199
    ExplicitHeight = 353
  end
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 177
    Height = 352
    ActivePage = TabSheet1
    Align = alLeft
    TabIndex = 0
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 16
    ExplicitHeight = 313
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #26435#38480#32452#65306
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnl2: TPanel
        Left = 0
        Top = 288
        Width = 173
        Height = 40
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btn3: TBitBtn
          Left = 8
          Top = 9
          Width = 75
          Height = 25
          Caption = #20445#23384'[&S]'
          TabOrder = 0
        end
        object btn4: TBitBtn
          Left = 88
          Top = 9
          Width = 75
          Height = 25
          Caption = #20851#38381'[&C]'
          TabOrder = 1
        end
      end
    end
  end
  object RzPageControl2: TRzPageControl
    Left = 180
    Top = 0
    Width = 359
    Height = 352
    ActivePage = RzTabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 1
    ExplicitLeft = 208
    ExplicitTop = 8
    ExplicitWidth = 177
    ExplicitHeight = 313
    FixedDimension = 20
    object RzTabSheet1: TRzTabSheet
      Caption = #26435#38480#32452#65306
      ExplicitWidth = 173
      ExplicitHeight = 289
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 352
    Width = 539
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 493
    object btn_Save: TBitBtn
      Left = 332
      Top = 6
      Width = 75
      Height = 25
      Caption = #20445#23384'[&S]'
      TabOrder = 0
    end
    object btn_Close: TBitBtn
      Left = 444
      Top = 6
      Width = 75
      Height = 25
      Caption = #20851#38381'[&C]'
      TabOrder = 1
      OnClick = btn_CloseClick
    end
  end
end
