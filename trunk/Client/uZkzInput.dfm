object ZkzInput: TZkzInput
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25163#24037#32534#21046#20934#32771#35777
  ClientHeight = 352
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object grp1: TGroupBox
    Left = 9
    Top = 8
    Width = 481
    Height = 297
    Caption = #20934#32771#35777#20449#24687#24405#20837#65306
    TabOrder = 0
    object lbl4: TLabel
      Left = 21
      Top = 33
      Width = 60
      Height = 14
      Caption = #23398#26657#20195#30721#65306
      Enabled = False
    end
    object lbl1: TLabel
      Left = 274
      Top = 66
      Width = 60
      Height = 14
      Caption = #31867#21035#20195#30721#65306
      Enabled = False
    end
    object lbl2: TLabel
      Left = 21
      Top = 66
      Width = 60
      Height = 14
      Caption = #25253#32771#31867#21035#65306
      Enabled = False
    end
    object lbl3: TLabel
      Left = 21
      Top = 100
      Width = 60
      Height = 14
      Caption = #32771#22330#32534#21495#65306
    end
    object lbl5: TLabel
      Left = 274
      Top = 100
      Width = 60
      Height = 14
      Caption = #24231#20301#32534#21495#65306
    end
    object lbl6: TLabel
      Left = 21
      Top = 133
      Width = 60
      Height = 14
      Caption = #20934#32771#35777#21495#65306
    end
    object lbl7: TLabel
      Left = 274
      Top = 32
      Width = 53
      Height = 14
      Caption = '(*'#22266#23450#20540')'
      Enabled = False
    end
    object lbl8: TLabel
      Left = 21
      Top = 166
      Width = 60
      Height = 14
      Caption = #25253#21517#24207#21495#65306
    end
    object lbl9: TLabel
      Left = 21
      Top = 199
      Width = 60
      Height = 14
      Caption = #32771#29983#22995#21517#65306
      Enabled = False
    end
    object lbl10: TLabel
      Left = 298
      Top = 199
      Width = 36
      Height = 14
      Caption = #24615#21035#65306
      Enabled = False
    end
    object lbl11: TLabel
      Left = 21
      Top = 233
      Width = 60
      Height = 14
      Caption = #36523#20221#35777#21495#65306
      Enabled = False
    end
    object lbl12: TLabel
      Left = 21
      Top = 266
      Width = 60
      Height = 14
      Caption = #29616#35835#23398#26657#65306
      Enabled = False
    end
    object lbl13: TLabel
      Left = 274
      Top = 233
      Width = 60
      Height = 14
      Caption = #32771#29983#31867#21035#65306
      Enabled = False
    end
    object edt_XxDM: TDBEditEh
      Left = 81
      Top = 29
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      Enabled = False
      TabOrder = 0
      Visible = True
      OnChange = edt_ZwBHChange
    end
    object edt_lbDm: TDBEditEh
      Left = 334
      Top = 62
      Width = 127
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      Enabled = False
      TabOrder = 1
      Visible = True
      OnChange = edt_ZwBHChange
    end
    object edt_kcBH: TDBEditEh
      Left = 81
      Top = 96
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      MaxLength = 2
      TabOrder = 2
      Visible = True
      OnChange = edt_ZwBHChange
    end
    object edt_ZwBH: TDBEditEh
      Left = 334
      Top = 96
      Width = 127
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      MaxLength = 2
      TabOrder = 3
      Visible = True
      OnChange = edt_ZwBHChange
    end
    object edt_ZkZH: TDBEditEh
      Left = 81
      Top = 129
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      TabOrder = 4
      Visible = True
      OnChange = edt_ZkZHChange
    end
    object edt_BMXH: TDBEditEh
      Left = 81
      Top = 162
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      EditButtons = <>
      TabOrder = 5
      Visible = True
      OnChange = edt_BMXHChange
    end
    object edt_bkLb: TDBComboBoxEh
      Left = 81
      Top = 62
      Width = 178
      Height = 22
      Enabled = False
      EditButtons = <>
      TabOrder = 6
      Visible = True
    end
    object chk_Edit: TCheckBox
      Left = 335
      Top = 32
      Width = 97
      Height = 17
      Caption = #20801#35768#20462#25913
      Enabled = False
      TabOrder = 7
      OnClick = chk_EditClick
    end
    object btn_Search: TBitBtn
      Left = 274
      Top = 162
      Width = 186
      Height = 25
      Caption = #26597#35810#32771#29983#25253#32771#20449#24687
      TabOrder = 8
      OnClick = btn_SearchClick
    end
    object btn_Zkzxx: TBitBtn
      Left = 274
      Top = 129
      Width = 186
      Height = 25
      Caption = #26816#27979#20934#32771#35777#26159#21542#21487#29992
      TabOrder = 9
      OnClick = btn_ZkzxxClick
    end
    object DBEditEh1: TDBEditEh
      Left = 81
      Top = 195
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      DataField = #22995#21517
      DataSource = ds_Ksxx
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 10
      Visible = True
    end
    object DBEditEh2: TDBEditEh
      Left = 335
      Top = 195
      Width = 125
      Height = 22
      Alignment = taLeftJustify
      DataField = #24615#21035
      DataSource = ds_Ksxx
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 11
      Visible = True
    end
    object DBEditEh3: TDBEditEh
      Left = 81
      Top = 229
      Width = 178
      Height = 22
      Alignment = taLeftJustify
      DataField = #36523#20221#35777#21495
      DataSource = ds_Ksxx
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 12
      Visible = True
    end
    object DBEditEh4: TDBEditEh
      Left = 81
      Top = 262
      Width = 379
      Height = 22
      Alignment = taLeftJustify
      DataField = #29616#23601#35835#23398#26657
      DataSource = ds_Ksxx
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 13
      Visible = True
    end
    object DBEditEh5: TDBEditEh
      Left = 335
      Top = 229
      Width = 125
      Height = 22
      Alignment = taLeftJustify
      DataField = #25253#32771#31867#21035
      DataSource = ds_Ksxx
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 14
      Visible = True
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 307
    Width = 498
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 279
    ExplicitWidth = 458
    object btn_Save: TBitBtn
      Left = 289
      Top = 7
      Width = 75
      Height = 25
      Caption = #20445#23384
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = btn_SaveClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 393
      Top = 7
      Width = 75
      Height = 25
      Caption = #20851#38381
      ModalResult = 2
      TabOrder = 1
      OnClick = btn_ExitClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object cds_Ksxx: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 32
  end
  object ds_Ksxx: TDataSource
    DataSet = cds_Ksxx
    Left = 400
    Top = 32
  end
end
