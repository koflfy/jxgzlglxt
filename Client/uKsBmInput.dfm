object KsBmInput: TKsBmInput
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #32771#29983#25253#21517
  ClientHeight = 487
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = #26041#27491#23002#20307#31616#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    683
    487)
  PixelsPerInch = 96
  TextHeight = 16
  object grp_2: TGroupBox
    Left = 8
    Top = 7
    Width = 667
    Height = 438
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #31532#20108#27493#65306#22635#25253#19987#19994#65306
    TabOrder = 1
    Visible = False
    object lbl38: TLabel
      Left = 68
      Top = 82
      Width = 70
      Height = 16
      Caption = #32771#29983#22995#21517#65306
      FocusControl = DBEditEh1
    end
    object lbl19: TLabel
      Left = 65
      Top = 150
      Width = 70
      Height = 16
      Caption = #25253#32771#31867#21035#65306
      FocusControl = cbb_ZyLb
    end
    object lbl20: TLabel
      Left = 51
      Top = 192
      Width = 84
      Height = 16
      Caption = #19987#19994#24535#24895#19968#65306
      FocusControl = cbb_Zy1
    end
    object lbl21: TLabel
      Left = 51
      Top = 233
      Width = 84
      Height = 16
      Caption = #19987#19994#24535#24895#20108#65306
      FocusControl = cbb_Zy3
    end
    object lbl22: TLabel
      Left = 51
      Top = 275
      Width = 84
      Height = 16
      Caption = #19987#19994#24535#24895#19977#65306
      FocusControl = cbb_Zy2
    end
    object lbl24: TLabel
      Left = 65
      Top = 315
      Width = 70
      Height = 16
      Caption = #26159#21542#35843#21058#65306
      Visible = False
    end
    object lbl23: TLabel
      Left = 145
      Top = 351
      Width = 465
      Height = 16
      Caption = '(*'#26159#21542#21516#24847#22312#25253#32771#22823#31867#20013#36827#34892#19987#19994#35843#21058#65292#24517#39035#22635#20889#65292#21542#21017#35270#20026#25918#24323#35843#21058#19987#19994')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lbl34: TLabel
      Left = 458
      Top = 152
      Width = 73
      Height = 16
      Caption = '(*'#24517#22635#20869#23481')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl35: TLabel
      Left = 458
      Top = 193
      Width = 73
      Height = 16
      Caption = '(*'#24517#22635#20869#23481')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl36: TLabel
      Left = 458
      Top = 234
      Width = 73
      Height = 16
      Caption = '(*'#24517#22635#20869#23481')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl37: TLabel
      Left = 460
      Top = 275
      Width = 73
      Height = 16
      Caption = '(*'#24517#22635#20869#23481')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl39: TLabel
      Left = 63
      Top = 42
      Width = 70
      Height = 16
      Caption = #25253#21517#24207#21495#65306
      FocusControl = dbedt_BmNo
    end
    object bvl1: TBevel
      Left = 13
      Top = 125
      Width = 648
      Height = 13
      Shape = bsTopLine
    end
    object DBEditEh1: TDBEditEh
      Left = 142
      Top = 78
      Width = 286
      Height = 24
      Color = clBtnFace
      DataField = #22995#21517
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 1
      Visible = True
    end
    object cbb_ZyLb: TDBComboBoxEh
      Left = 144
      Top = 149
      Width = 284
      Height = 24
      DataField = #25253#32771#31867#21035
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnExit = cbb_xbExit
    end
    object cbb_Zy1: TDBComboBoxEh
      Left = 144
      Top = 191
      Width = 284
      Height = 24
      DataField = #19987#19994#24535#24895#19968
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 3
      Visible = True
      OnEnter = cbb_Zy1Enter
      OnExit = cbb_xbExit
    end
    object cbb_Zy3: TDBComboBoxEh
      Left = 144
      Top = 274
      Width = 284
      Height = 24
      DataField = #19987#19994#24535#24895#19977
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 5
      Visible = True
      OnEnter = cbb_Zy1Enter
      OnExit = cbb_xbExit
    end
    object cbb_Zy2: TDBComboBoxEh
      Left = 144
      Top = 233
      Width = 284
      Height = 24
      DataField = #19987#19994#24535#24895#20108
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 4
      Visible = True
      OnEnter = cbb_Zy1Enter
      OnExit = cbb_xbExit
    end
    object dbchk1: TDBCheckBox
      Left = 144
      Top = 314
      Width = 105
      Height = 17
      Caption = #26159#21542#21516#24847#35843#21058
      DataField = #26159#21542#21516#24847#35843#21058
      DataSource = DataSource1
      TabOrder = 6
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object dbedt_BmNo: TDBEditEh
      Left = 142
      Top = 38
      Width = 286
      Height = 24
      Color = clBtnFace
      DataField = #25253#21517#24207#21495
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 0
      Visible = True
    end
  end
  object grp_1: TGroupBox
    Left = 8
    Top = 7
    Width = 667
    Height = 438
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #31532#19968#27493#65306#36755#20837#32771#29983#20449#24687
    TabOrder = 0
    object lbl2: TLabel
      Left = 38
      Top = 95
      Width = 56
      Height = 16
      Caption = #32771#29983#21495#65306
      FocusControl = edt_Ksh
    end
    object lbl3: TLabel
      Left = 293
      Top = 91
      Width = 70
      Height = 16
      Caption = #32771#29983#22995#21517#65306
      FocusControl = dbedt3
    end
    object lbl4: TLabel
      Left = 320
      Top = 127
      Width = 42
      Height = 16
      Caption = #24615#21035#65306
      FocusControl = cbb_xb
    end
    object lbl5: TLabel
      Left = 48
      Top = 164
      Width = 42
      Height = 16
      Caption = #27665#26063#65306
      FocusControl = cbb_Mz
    end
    object lbl7: TLabel
      Left = 24
      Top = 130
      Width = 70
      Height = 16
      Caption = #36523#20221#35777#21495#65306
      FocusControl = edt_Sfzh
    end
    object lbl8: TLabel
      Left = 292
      Top = 163
      Width = 70
      Height = 16
      Caption = #25919#27835#38754#35980#65306
      FocusControl = cbb_Zzmm
    end
    object lbl9: TLabel
      Left = 24
      Top = 199
      Width = 70
      Height = 16
      Caption = #29616#35835#23398#26657#65306
      FocusControl = cbb_School
    end
    object lbl10: TLabel
      Left = 292
      Top = 199
      Width = 70
      Height = 16
      Caption = #25152#23398#19987#19994#65306
      FocusControl = dbedt10
    end
    object lbl11: TLabel
      Left = 24
      Top = 233
      Width = 70
      Height = 16
      Caption = #22870#21169#24773#20917#65306
      FocusControl = dbedt11
    end
    object lbl12: TLabel
      Left = 24
      Top = 337
      Width = 70
      Height = 16
      Caption = #26257#26399#22320#22336#65306
      FocusControl = dbedt12
    end
    object lbl13: TLabel
      Left = 292
      Top = 372
      Width = 70
      Height = 16
      Caption = #37038#25919#32534#32534#65306
      FocusControl = dbedt13
    end
    object lbl14: TLabel
      Left = 24
      Top = 371
      Width = 70
      Height = 16
      Caption = #26257#26399#30005#35805#65306
      FocusControl = dbedt14
    end
    object lbl15: TLabel
      Left = 24
      Top = 268
      Width = 70
      Height = 16
      Caption = #32508#21512#27979#35780#65306
      FocusControl = dbedt15
    end
    object lbl16: TLabel
      Left = 24
      Top = 302
      Width = 70
      Height = 16
      Caption = #39640#26657#33521#35821#65306
      FocusControl = cbb_English
    end
    object lbl17: TLabel
      Left = 306
      Top = 302
      Width = 56
      Height = 16
      Caption = #35745#31639#26426#65306
      FocusControl = cbb_Jsj
    end
    object lbl18: TLabel
      Left = 320
      Top = 268
      Width = 42
      Height = 16
      Caption = #29305#38271#65306
      FocusControl = dbedt18
    end
    object lbl1: TLabel
      Left = 24
      Top = 31
      Width = 70
      Height = 16
      Caption = #25253#21517#24207#21495#65306
      FocusControl = edt_BmNo
    end
    object lbl40: TLabel
      Left = 286
      Top = 30
      Width = 101
      Height = 16
      Caption = '(*'#31995#32479#33258#21160#29983#25104')'
      Font.Charset = GB2312_CHARSET
      Font.Color = clMaroon
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl42: TLabel
      Left = 530
      Top = 17
      Width = 103
      Height = 14
      Caption = #29031#29255#22823#23567#65306'120X150'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
    end
    object dbtxt_Photo: TDBText
      Left = 94
      Top = 404
      Width = 68
      Height = 16
      AutoSize = True
      DataField = #29031#29255#25991#20214#21517
      DataSource = ds_Photo
    end
    object lbl6: TLabel
      Left = 24
      Top = 404
      Width = 70
      Height = 16
      Caption = #32771#29983#29031#29255#65306
      FocusControl = dbedt14
    end
    object lbl25: TLabel
      Left = 38
      Top = 63
      Width = 56
      Height = 16
      Caption = #30331#24405#21517#65306
      FocusControl = edt_UserName
    end
    object lbl26: TLabel
      Left = 293
      Top = 59
      Width = 70
      Height = 16
      Caption = #30331#24405#23494#30721#65306
      FocusControl = edt_UserPwd
    end
    object edt_Ksh: TDBEditEh
      Left = 94
      Top = 93
      Width = 184
      Height = 24
      DataField = #32771#29983#21495
      DataSource = DataSource1
      EditButtons = <>
      MaxLength = 19
      TabOrder = 5
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object dbedt3: TDBEditEh
      Left = 360
      Top = 89
      Width = 153
      Height = 24
      DataField = #22995#21517
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 4
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object cbb_xb: TDBComboBoxEh
      Left = 361
      Top = 125
      Width = 152
      Height = 24
      DataField = #24615#21035
      DataSource = DataSource1
      EditButtons = <>
      Items.Strings = (
        #30007
        #22899)
      TabOrder = 6
      Visible = True
      OnExit = cbb_xbExit
    end
    object cbb_Mz: TDBComboBoxEh
      Left = 94
      Top = 162
      Width = 184
      Height = 24
      DataField = #27665#26063
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 9
      Visible = True
      OnExit = cbb_xbExit
    end
    object edt_Sfzh: TDBEditEh
      Left = 94
      Top = 128
      Width = 184
      Height = 24
      DataField = #36523#20221#35777#21495
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 7
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object cbb_Zzmm: TDBComboBoxEh
      Left = 361
      Top = 161
      Width = 152
      Height = 24
      DataField = #25919#27835#38754#35980
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 8
      Visible = True
      OnExit = cbb_xbExit
    end
    object cbb_School: TDBComboBoxEh
      Left = 94
      Top = 197
      Width = 184
      Height = 24
      DataField = #29616#23601#35835#23398#26657
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 11
      Visible = True
      OnEnter = cbb_SchoolEnter
      OnExit = cbb_xbExit
    end
    object dbedt10: TDBEditEh
      Left = 361
      Top = 197
      Width = 152
      Height = 24
      DataField = #25152#23398#19987#19994
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 12
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object dbedt11: TDBEditEh
      Left = 94
      Top = 231
      Width = 419
      Height = 24
      DataField = #21463#22870#21169#24773#20917
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 14
      Visible = True
    end
    object dbedt12: TDBEditEh
      Left = 94
      Top = 335
      Width = 419
      Height = 24
      DataField = #26257#26399#36890#35759#22320#22336
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 19
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object dbedt13: TDBEditEh
      Left = 361
      Top = 369
      Width = 152
      Height = 24
      DataField = #37038#25919#32534#30721
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 21
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object dbedt14: TDBEditEh
      Left = 93
      Top = 369
      Width = 185
      Height = 24
      DataField = #26257#26399#32852#31995#30005#35805
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 20
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object dbedt15: TDBEditEh
      Left = 93
      Top = 266
      Width = 185
      Height = 24
      DataField = #19987#19994#32508#21512#27979#35780#24773#20917
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 15
      Visible = True
    end
    object cbb_English: TDBComboBoxEh
      Left = 93
      Top = 300
      Width = 185
      Height = 24
      DataField = #20840#30465#39640#26657#33521#35821#31561#32423#32771#35797#24773#20917
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 17
      Visible = True
    end
    object cbb_Jsj: TDBComboBoxEh
      Left = 361
      Top = 300
      Width = 152
      Height = 24
      DataField = #20840#30465#39640#26657#35745#31639#26426#31561#32423#32771#35797#24773#20917
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 18
      Visible = True
    end
    object dbedt18: TDBEditEh
      Left = 360
      Top = 266
      Width = 153
      Height = 24
      DataField = #29305#38271
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 16
      Visible = True
    end
    object pnl_photo: TPanel
      Left = 526
      Top = 35
      Width = 125
      Height = 155
      BevelOuter = bvLowered
      Caption = #29031#29255
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object img_Photo: TImage
        Left = 3
        Top = 3
        Width = 120
        Height = 150
        ParentShowHint = False
        PopupMenu = pm1
        ShowHint = True
        Stretch = True
      end
    end
    object edt_BmNo: TDBEditEh
      Left = 94
      Top = 29
      Width = 184
      Height = 24
      Hint = #31995#32479#33258#21160#29983#25104
      Color = clBtnFace
      EditButtons = <>
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      Visible = True
    end
    object btn_UploadPhoto: TBitBtn
      Left = 526
      Top = 196
      Width = 125
      Height = 25
      Caption = #19978#20256#29031#29255#25991#20214'...'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnClick = btn_UploadPhotoClick
    end
    object btn1: TButton
      Left = 526
      Top = 227
      Width = 125
      Height = 25
      Caption = 'btn_UploadTest'
      TabOrder = 13
      Visible = False
      OnClick = btn1Click
    end
    object edt_UserName: TDBEditEh
      Left = 94
      Top = 61
      Width = 184
      Height = 24
      DataField = #30331#24405#21517
      DataSource = DataSource1
      EditButtons = <>
      MaxLength = 19
      TabOrder = 3
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
    object edt_UserPwd: TDBEditEh
      Left = 360
      Top = 57
      Width = 153
      Height = 24
      DataField = #23494#30721
      DataSource = DataSource1
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnChange = edt_KshChange
      OnExit = edt_KshExit
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 446
    Width = 683
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      683
      41)
    object btn_Save: TBitBtn
      Left = 452
      Top = 5
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #23436#25104'[&O]'
      Enabled = False
      TabOrder = 2
      OnClick = btn_SaveClick
    end
    object btn_Close: TBitBtn
      Left = 572
      Top = 5
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #36864#20986'[&X]'
      TabOrder = 3
      OnClick = btn_CloseClick
    end
    object btn_Priv: TBitBtn
      Left = 264
      Top = 5
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '<<'#19978#19968#27493
      Enabled = False
      TabOrder = 0
      OnClick = btn_PrivClick
    end
    object btn_Next: TBitBtn
      Left = 358
      Top = 5
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #19979#19968#27493'>>'
      TabOrder = 1
      OnClick = btn_NextClick
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    OnDataChange = DataSource1DataChange
    Left = 561
    Top = 280
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#32771#29983#25253#21517#34920
    Params = <>
    ProviderName = 'DSP_Query'
    RemoteServer = DM.SoapConnection1
    BeforePost = ClientDataSet1BeforePost
    OnNewRecord = ClientDataSet1NewRecord
    Left = 593
    Top = 280
    object ClientDataSet1Id: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object ClientDataSet1StringField: TStringField
      FieldName = #25253#21517#24207#21495
      Size = 15
    end
    object ClientDataSet1StringField2: TStringField
      FieldName = #23494#30721
      Size = 15
    end
    object ClientDataSet1StringField3: TStringField
      FieldName = #32771#29983#21495
      Size = 18
    end
    object ClientDataSet1StringField4: TStringField
      FieldName = #22995#21517
      Size = 10
    end
    object ClientDataSet1StringField5: TStringField
      FieldName = #24615#21035
      Size = 2
    end
    object ClientDataSet1StringField6: TStringField
      FieldName = #27665#26063
      Size = 5
    end
    object ClientDataSet1StringField7: TStringField
      FieldName = #20986#29983#24180#26376
      Size = 10
    end
    object ClientDataSet1StringField8: TStringField
      FieldName = #36523#20221#35777#21495
      Size = 18
    end
    object ClientDataSet1StringField9: TStringField
      FieldName = #25919#27835#38754#35980
      Size = 10
    end
    object ClientDataSet1StringField10: TStringField
      FieldName = #29616#23601#35835#23398#26657
      Size = 50
    end
    object ClientDataSet1StringField11: TStringField
      FieldName = #25152#23398#19987#19994
    end
    object ClientDataSet1StringField12: TStringField
      FieldName = #21463#22870#21169#24773#20917
      Size = 50
    end
    object ClientDataSet1StringField13: TStringField
      FieldName = #26257#26399#36890#35759#22320#22336
      Size = 50
    end
    object ClientDataSet1StringField14: TStringField
      FieldName = #37038#25919#32534#30721
      Size = 6
    end
    object ClientDataSet1StringField15: TStringField
      FieldName = #26257#26399#32852#31995#30005#35805
    end
    object ClientDataSet1StringField16: TStringField
      FieldName = #19987#19994#32508#21512#27979#35780#24773#20917
      Size = 50
    end
    object ClientDataSet1StringField17: TStringField
      FieldName = #20840#30465#39640#26657#33521#35821#31561#32423#32771#35797#24773#20917
    end
    object ClientDataSet1StringField18: TStringField
      FieldName = #20840#30465#39640#26657#35745#31639#26426#31561#32423#32771#35797#24773#20917
    end
    object ClientDataSet1StringField19: TStringField
      FieldName = #29305#38271
      Size = 50
    end
    object ClientDataSet1StringField20: TStringField
      FieldName = #25253#32771#31867#21035
    end
    object ClientDataSet1StringField21: TStringField
      FieldName = #19987#19994#24535#24895#19968
      Size = 30
    end
    object ClientDataSet1StringField22: TStringField
      FieldName = #19987#19994#24535#24895#20108
      Size = 30
    end
    object ClientDataSet1StringField23: TStringField
      FieldName = #19987#19994#24535#24895#19977
      Size = 30
    end
    object ClientDataSet1BooleanField: TBooleanField
      FieldName = #26159#21542#21516#24847#35843#21058
    end
    object ClientDataSet1StringField24: TStringField
      FieldName = #25805#20316#21592
      Size = 15
    end
    object ClientDataSet1DateTimeField: TDateTimeField
      FieldName = #25253#21517#26102#38388
    end
    object ClientDataSet1Ip: TStringField
      FieldName = 'Ip'
      Size = 15
    end
    object ClientDataSet1BooleanField2: TBooleanField
      FieldName = #26159#21542#25171#21360
    end
    object ClientDataSet1BooleanField3: TBooleanField
      FieldName = #26159#21542#32564#36153
    end
  end
  object pm1: TPopupMenu
    Left = 545
    Top = 136
    object N4: TMenuItem
      Caption = #28165#38500#29031#29255
      OnClick = N4Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object C1: TMenuItem
      Action = DM.EditCopy1
    end
    object T1: TMenuItem
      Action = DM.EditCut1
    end
    object P1: TMenuItem
      Action = DM.EditPaste1
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #29031#29255#21478#23384#20026'(&S)...'
      OnClick = N1Click
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 
      'All (*.png;*.gif;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf)|*.png;*.g' +
      'if;*.jpg;*.jpeg;*.bmp;*.ico;*.emf;*.wmf|PNG graphics from DevExp' +
      'ress (*.png)|*.png|GIF Image (*.gif)|*.gif|JPEG Image File (*.jp' +
      'g)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp)|*.bmp|I' +
      'cons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*' +
      '.wmf)|*.wmf'
    Title = #29031#29255#21478#23384#20026'......'
    Left = 576
    Top = 136
  end
  object cds_Photo: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#32771#29983#25253#21517#34920
    Params = <>
    ProviderName = 'DSP_Query'
    RemoteServer = DM.SoapConnection1
    AfterOpen = cds_PhotoAfterOpen
    Left = 609
    Top = 72
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '*.jpg'
    Filter = 
      #25152#26377#22270#20687#26684#24335'|*.jpg;*.jpeg;*.bmp;*.gif;*.png|JPEG '#25991#20214'(*.jpg)|*.jpg;*.jpe' +
      'g|'#20301#22270#25991#20214'(*.bmp)|*.bmp|GIF'#25991#20214'(*.gif)|*.gif|PNG'#25991#20214'(*.png)|*.png'
    Left = 608
    Top = 136
  end
  object ds_Photo: TDataSource
    DataSet = cds_Photo
    Left = 577
    Top = 72
  end
end
