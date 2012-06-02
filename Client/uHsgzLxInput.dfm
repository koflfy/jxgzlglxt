object HsgzLxInput: THsgzLxInput
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #35268#21017#31867#22411#24405#20837
  ClientHeight = 171
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel
    Left = 26
    Top = 24
    Width = 60
    Height = 14
    Caption = #26174#31034#39034#24207#65306
  end
  object Label1: TLabel
    Left = 26
    Top = 67
    Width = 60
    Height = 14
    Caption = #35268#21017#31867#22411#65306
  end
  object edt_Index: TDBNumberEditEh
    Left = 92
    Top = 24
    Width = 183
    Height = 22
    DataField = #26174#31034#39034#24207
    EditButtons = <>
    TabOrder = 0
    Visible = True
    OnChange = edt_IndexChange
  end
  object edt_HsgzLx: TDBEditEh
    Left = 92
    Top = 64
    Width = 183
    Height = 22
    DataField = #35268#21017#31867#22411
    EditButtons = <>
    TabOrder = 1
    Visible = True
    OnChange = edt_IndexChange
  end
  object btn_OK: TButton
    Left = 104
    Top = 120
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object btn_Cancel: TButton
    Left = 196
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 3
  end
end
