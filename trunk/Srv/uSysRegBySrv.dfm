object SysRegBySrv: TSysRegBySrv
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36719#20214#27880#20876
  ClientHeight = 236
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object RzPageControl1: TRzPageControl
    Left = 16
    Top = 16
    Width = 337
    Height = 169
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #36719#20214#27880#20876
      object Label1: TLabel
        Left = 83
        Top = 109
        Width = 60
        Height = 14
        Caption = #27880#20876#29366#24577#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl_RegMsg: TLabel
        Left = 150
        Top = 109
        Width = 72
        Height = 14
        Caption = #26412#31995#32479#26410#27880#20876
      end
      object Label11: TLabel
        Left = 15
        Top = 64
        Width = 72
        Height = 14
        Caption = #36719#20214#27880#20876#30721#65306
        FocusControl = edt_Code
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 15
        Top = 20
        Width = 72
        Height = 14
        Caption = #31995#32479#29992#25143#21517#65306
        FocusControl = edt_User
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edt_Code: TDBEditEh
        Left = 93
        Top = 61
        Width = 220
        Height = 22
        DataField = #27880#20876#30721
        DataSource = DataSource1
        EditButtons = <>
        TabOrder = 0
        Visible = True
      end
      object edt_User: TDBEditEh
        Left = 92
        Top = 17
        Width = 220
        Height = 22
        DataField = #29992#25143#21517#31216
        DataSource = DataSource1
        EditButtons = <>
        TabOrder = 1
        Visible = True
      end
    end
  end
  object btn_Reg: TBitBtn
    Left = 167
    Top = 200
    Width = 75
    Height = 25
    Caption = #27880#20876'[&R]'
    TabOrder = 1
    OnClick = btn_RegClick
  end
  object btn_Exit: TBitBtn
    Left = 263
    Top = 200
    Width = 75
    Height = 25
    Caption = #36864#20986'[&X]'
    TabOrder = 2
    OnClick = btn_ExitClick
  end
  object DataSource1: TDataSource
    DataSet = qry_Temp
    Left = 224
  end
  object qry_Temp: TADOQuery
    CursorType = ctStatic
    CommandTimeout = 3
    Parameters = <>
    SQL.Strings = (
      'select * from '#26426#20027#20449#24687#34920)
    Left = 192
  end
end
