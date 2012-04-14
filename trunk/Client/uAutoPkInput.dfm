object AutoPkInput: TAutoPkInput
  Left = 0
  Top = 0
  ActiveControl = btn_Close
  BorderIcons = [biSystemMenu]
  Caption = #33258#21160#25490#32771'--'#9312#38543#26426#29983#25104#20934#32771#35777#21495#65307#9313#33258#21160#29983#25104#22330#20449#24687#12290
  ClientHeight = 376
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #26041#27491#23002#20307#31616#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 19
  object grp1: TGroupBox
    Left = 14
    Top = 8
    Width = 536
    Height = 297
    Caption = #20934#32771#35777#21495#30721#35268#21017#35774#32622#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbl5: TLabel
      Left = 50
      Top = 103
      Width = 189
      Height = 19
      Caption = 'C'#65306#32771#22330#32534#30721#38271#24230#12288#12288#12288' '#20301
    end
    object lbl6: TLabel
      Left = 50
      Top = 69
      Width = 189
      Height = 19
      Caption = 'B'#65306#25253#32771#31867#21035#38271#24230#12288#12288' '#12288#20301
    end
    object lbl7: TLabel
      Left = 50
      Top = 35
      Width = 205
      Height = 19
      Caption = 'A'#65306#23398#26657#20195#30721#38271#24230#12288#12288#12288' '#20301#65292
    end
    object lbl2: TLabel
      Left = 50
      Top = 138
      Width = 206
      Height = 19
      Caption = 'D'#65306#24231#20301#32534#30721#38271#24230#12288#12288#12288' '#20301#65292
    end
    object lbl3: TLabel
      Left = 259
      Top = 138
      Width = 216
      Height = 19
      Caption = #27599#20010#32771#22330#23433#25490#20154#25968#65306#12288#12288#12288'  '#20154
    end
    object lbl4: TLabel
      Left = 259
      Top = 35
      Width = 196
      Height = 19
      Caption = #23398#26657#20195#30721#20026#22266#23450#20540#65306#12288#12288#12288' '
    end
    object bvl1: TBevel
      Left = 24
      Top = 223
      Width = 481
      Height = 10
      Shape = bsTopLine
    end
    object lbl_Sample: TLabel
      Left = 150
      Top = 185
      Width = 101
      Height = 23
      Caption = 'AAAABCCDD'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 50
      Top = 246
      Width = 336
      Height = 19
      Caption = #27880#24847#65306#33258#21160#25490#32771#26102#20250#21024#38500#24050#23384#22312#30340#20934#32771#35777#21495#20449#24687
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 50
      Top = 185
      Width = 100
      Height = 23
      Caption = #26679#24335#25928#26524#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 288
      Top = 185
      Width = 40
      Height = 23
      Caption = #22914#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl_Sample2: TLabel
      Left = 326
      Top = 185
      Width = 90
      Height = 23
      Caption = '260510918'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object se_KcBHLen: TSpinEdit
      Left = 175
      Top = 101
      Width = 47
      Height = 29
      MaxValue = 4
      MinValue = 1
      TabOrder = 3
      Value = 2
      OnChange = se_KcBHLenChange
    end
    object se_LbBHLen: TSpinEdit
      Left = 175
      Top = 66
      Width = 47
      Height = 29
      Enabled = False
      MaxValue = 1
      MinValue = 1
      TabOrder = 2
      Value = 1
      OnChange = se_KcBHLenChange
    end
    object se_XxDMLen: TSpinEdit
      Left = 175
      Top = 30
      Width = 47
      Height = 29
      Enabled = False
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 4
      OnChange = se_KcBHLenChange
    end
    object se_ZwBHLen: TSpinEdit
      Left = 175
      Top = 136
      Width = 47
      Height = 29
      MaxValue = 4
      MinValue = 2
      TabOrder = 4
      Value = 2
      OnChange = se_KcBHLenChange
    end
    object se_KcCount: TSpinEdit
      Left = 396
      Top = 136
      Width = 60
      Height = 29
      MaxValue = 0
      MinValue = 0
      TabOrder = 5
      Value = 30
    end
    object edt_XxDM: TDBNumberEditEh
      Left = 395
      Top = 30
      Width = 60
      Height = 27
      Alignment = taCenter
      EditButtons = <>
      TabOrder = 1
      Value = 2605.000000000000000000
      Visible = True
      OnChange = edt_XxDMChange
    end
  end
  object chk1: TCheckBox
    Left = 18
    Top = 328
    Width = 180
    Height = 17
    Caption = #21516#27493#21024#38500#32771#22330#32534#25490#20449#24687
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object btn_Start: TBitBtn
    Left = 273
    Top = 324
    Width = 138
    Height = 28
    Caption = '>>>'#24320#22987#33258#21160#25490#32771'>>>'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btn_StartClick
  end
  object btn_Close: TBitBtn
    Left = 451
    Top = 324
    Width = 96
    Height = 28
    Caption = #36864#20986'[&X]'
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btn_CloseClick
  end
end
