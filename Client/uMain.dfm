object Main: TMain
  Left = 480
  Top = 193
  Caption = #25945#23398#24037#20316#37327#31649#29702#31995#32479
  ClientHeight = 490
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  WindowState = wsMaximized
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 471
    Width = 751
    Height = 19
    SimpleCaption = #25805#20316#21592#65306
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    VisualStyle = vsGradient
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 58
      Height = 19
      Align = alLeft
      AutoSize = True
      Caption = #25805#20316#21592#65306
      ExplicitTop = 6
    end
    object lbl_CzyName: TRzStatusPane
      Left = 58
      Top = 0
      Height = 19
      Align = alLeft
      ExplicitLeft = 753
      ExplicitHeight = 20
    end
    object RzStatusPane3: TRzStatusPane
      Left = 369
      Top = 0
      Width = 82
      Height = 19
      Align = alLeft
      AutoSize = True
      Caption = #24403#21069#26381#21153#22120#65306
      ExplicitLeft = 351
    end
    object RzFieldStatus1: TRzFieldStatus
      Left = 158
      Top = 0
      Width = 68
      Height = 19
      Align = alLeft
      Caption = #24403#21069#26102#38388#65306
    end
    object RzClockStatus1: TRzClockStatus
      Left = 226
      Top = 0
      Width = 143
      Height = 19
      Align = alLeft
    end
    object Status_SrvInfo: TRzStatusPane
      Left = 451
      Top = 0
      Width = 296
      Height = 19
      Align = alLeft
      ExplicitLeft = 409
    end
  end
  object auAutoUpgrader1: TauAutoUpgrader
    AutoCheck = True
    InfoFile.Files.Strings = (
      'http://vir.jxstnu.edu.cn/jcgl/')
    InfoFileURL = 'http://vir.jxstnu.edu.cn/Jcgl/download/AutoUpdte.inf'
    VersionControl = byNumber
    VersionDate = '2012-04-14 00:00:00'
    VersionDateAutoSet = True
    OnDoOwnCloseAppMethod = auAutoUpgrader1DoOwnCloseAppMethod
    Left = 680
    Top = 40
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 712
    Top = 40
  end
  object tmr_Count: TTimer
    Interval = 300000
    OnTimer = tmr_CountTimer
    Left = 648
    Top = 40
  end
  object ActionManger1: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Action = act_sys_Czy
              end
              item
                Action = act_sys_CzyRight
              end
              item
                Action = act_sys_ChgCzyPwd
              end
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end
              item
                Action = act_sys_IpSet
              end
              item
                Action = act_sys_OnlineUpdateSet
              end
              item
                Action = act_sys_LoginLog
              end
              item
                Caption = '-'
              end
              item
                Action = act_sys_Exit
              end>
            Caption = #31995#32479#35774#32622'(&Z)'
          end
          item
            Items = <
              item
                Action = act_Stu_BmBrowse
              end
              item
                Caption = '-'
              end>
            Caption = #23398#21592#20449#24687'(&T)'
          end
          item
            Items = <
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end
              item
                Action = act_cwgl_SfCsSet
              end
              item
                Action = act_cwgl_SfInfoPublish
              end>
            Caption = #36130#21153#31649#29702'(&Y)'
          end
          item
            Caption = #36130#21153#25910#36153'(&W)'
          end
          item
            Items = <
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end>
            Caption = #26597#35810#32479#35745'(&S)'
          end
          item
            Items = <
              item
                Action = act_Win_CloseAll
                ImageIndex = 17
              end
              item
                Action = act_Win_CloseCurWin
              end
              item
                Caption = '-'
              end
              item
                Action = act_Win_Wizard
              end
              item
                Action = act_Win_HintMessage
              end>
            Caption = #31383#21475'(&V)'
          end
          item
            Items = <
              item
                Action = act_Interface_Xjgl
              end
              item
                Caption = '-'
              end
              item
                Caption = '-'
              end>
            Caption = #25509#21475#35774#32622'(&U)'
          end
          item
            Items = <
              item
                Action = act_hlp_Help
              end
              item
                Action = act_hlp_Reg
              end
              item
                Action = act_hlp_Update
              end
              item
                Caption = '-'
              end
              item
                Action = act_hlp_about
              end>
            Caption = #24110#21161'(&X)'
          end>
      end>
    Images = ImageList_mm
    Left = 616
    Top = 40
    StyleName = 'XP Style'
    object act_sys_Czy: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #25805#20316#21592#31649#29702'(&C)'
      ImageIndex = 0
      OnExecute = act_sys_CzyExecute
    end
    object act_sys_CzyRight: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #26435#38480#31649#29702'(&R)'
      ImageIndex = 1
      OnExecute = act_sys_CzyRightExecute
    end
    object act_sys_ChgCzyPwd: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #23494#30721#20462#25913'(&P)'
      ImageIndex = 2
      OnExecute = act_sys_ChgCzyPwdExecute
    end
    object act_sys_IpSet: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #23458#25143#31471'IP'#35774#32622'(&I)'
      ImageIndex = 14
      OnExecute = act_sys_IpSetExecute
    end
    object act_sys_OnlineUpdateSet: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #21319#32423#22320#22336#35774#32622'(&U)'
      ImageIndex = 1
      OnExecute = act_sys_OnlineUpdateSetExecute
    end
    object act_sys_LoginLog: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #30331#24405#26085#24535#26597#35810'(&L)'
      ImageIndex = 0
      OnExecute = act_sys_LoginLogExecute
    end
    object act_sys_SysLog: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #25805#20316#26085#24535#26597#35810'(&S)'
      ImageIndex = 7
      OnExecute = act_sys_SysLogExecute
    end
    object act_sys_LockScreen: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #38145#23631#31163#24320'(&K)'
      ImageIndex = 34
      ShortCut = 49227
      OnExecute = act_sys_LockScreenExecute
    end
    object act_sys_Exit: TAction
      Category = '01.'#31995#32479#35774#32622
      Caption = #36864#20986#31995#32479'(&X)'
      ImageIndex = 3
      OnExecute = act_sys_ExitExecute
    end
    object act_hlp_Help: TAction
      Category = '09.'#24110#21161
      Caption = #24110#21161#20449#24687'(&H)'
      ImageIndex = 21
      OnExecute = act_hlp_HelpExecute
    end
    object act_hlp_Reg: TAction
      Category = '09.'#24110#21161
      Caption = #31995#32479#27880#20876'(&R)'
      ImageIndex = 31
      OnExecute = act_hlp_RegExecute
    end
    object act_hlp_Update: TAction
      Category = '09.'#24110#21161
      Caption = #22312#32447#21319#32423'(&O)'
      ImageIndex = 26
      OnExecute = act_hlp_UpdateExecute
    end
    object act_cwsf_UpdateReport: TAction
      Category = '09.'#24110#21161
      Caption = #26356#26032#25253#34920#27169#26495'(&B)'
      ImageIndex = 26
      OnExecute = act_cwsf_UpdateReportExecute
    end
    object act_hlp_about: TAction
      Category = '09.'#24110#21161
      Caption = #20851#20110#26412#31995#32479'(&A)'
      ImageIndex = 22
      OnExecute = act_hlp_aboutExecute
    end
    object act_Win_CloseAll: TWindowCascade
      Category = '08.'#31383#21475
      Caption = #20851#38381#25152#26377#25171#24320#31383#21475'(&A)'
      Enabled = False
      Hint = 'Cascade'
      ImageIndex = 25
      OnExecute = act_Win_CloseAllExecute
    end
    object act_Win_CloseCurWin: TWindowClose
      Category = '08.'#31383#21475
      Caption = #20851#38381#24403#21069#27963#21160#31383#21475'(&C)'
      Enabled = False
      Hint = 'Close'
    end
    object act_Win_Wizard: TAction
      Category = '08.'#31383#21475
      Caption = #23548#33322#31383#21475'(&W)'
      ImageIndex = 18
      OnExecute = act_Win_WizardExecute
      OnUpdate = act_Win_WizardUpdate
    end
    object act_ReportDesign: TAction
      Category = '06.'#32479#35745#25253#34920
      Caption = #25253#34920#27169#26495#35774#35745'(&D)'
      ImageIndex = 23
      OnExecute = act_ReportDesignExecute
    end
    object act_Data_BkLbSet: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #25253#32771#31867#21035#35774#32622
      ImageIndex = 18
      OnExecute = act_Data_BkLbSetExecute
    end
    object act_Data_BkZySet: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #25253#32771#19987#19994#35774#32622
      ImageIndex = 30
      OnExecute = act_Data_BkZySetExecute
    end
    object act_Stu_BmData_Clear: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #28165#31354#25152#26377#25253#32771#20449#24687
      ImageIndex = 25
      OnExecute = act_Stu_BmData_ClearExecute
    end
    object act_Stu_BmInput: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #32771#29983#25253#32771#20449#24687#36755#20837
      ImageIndex = 5
      OnExecute = act_Stu_BmInputExecute
    end
    object act_Interface_Xjgl: TAction
      Category = '07.'#25509#21475#35774#32622
      Caption = #23398#31821#31649#29702#25509#21475#35774#32622'(&X)'
      ImageIndex = 16
      OnExecute = act_Interface_XjglExecute
    end
    object act_Win_HintMessage: TAction
      Category = '08.'#31383#21475
      Caption = #29366#24577#25552#31034#31383#21475'(&D)'
      ImageIndex = 31
      OnExecute = act_Win_HintMessageExecute
    end
    object act_Cwsf_PrintSet: TAction
      Category = '06.'#32479#35745#25253#34920
      Caption = #21457#31080#25171#21360#35774#32622'(&S)'
      ImageIndex = 1
      OnExecute = act_Cwsf_PrintSetExecute
    end
    object act_cwsf_print: TAction
      Category = '06.'#32479#35745#25253#34920
      Caption = #21457#31080#25171#21360#20013#24515'(&P)'
      ImageIndex = 19
    end
    object act_Stu_BmConfirm: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #32771#29983#25253#32771#20449#24687#23457#26680
      ImageIndex = 28
      OnExecute = act_Stu_BmConfirmExecute
    end
    object act_Stu_BmBrowse: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #32771#29983#25253#32771#20449#24687#26597#35810
      ImageIndex = 7
      OnExecute = act_Stu_BmBrowseExecute
    end
    object act_cwgl_SfCsSet: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #32593#19978#25253#21517#21442#25968#35774#32622
      ImageIndex = 8
      OnExecute = act_cwgl_SfCsSetExecute
    end
    object act_cwgl_SfInfoPublish: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #32593#31449#20844#24067#20449#24687#31649#29702
      ImageIndex = 4
      OnExecute = act_cwgl_SfInfoPublishExecute
    end
    object act_Data_SfDmSet: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #30465#20221#20195#30721#35774#32622
      ImageIndex = 12
      OnExecute = act_Data_SfDmSetExecute
    end
    object act_Data_Mz: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #27665#26063#20195#30721#20195#30721#35774#32622
      ImageIndex = 0
      OnExecute = act_Data_MzExecute
    end
    object act_Data_Zzmm: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #25919#27835#38754#35980#20195#30721#35774#32622
      ImageIndex = 15
      OnExecute = act_Data_ZzmmExecute
    end
    object act_Data_SchoolSet: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #20840#22269#39640#26657#20449#24687#35774#32622
      ImageIndex = 26
      OnExecute = act_Data_SchoolSetExecute
    end
    object act_Data_JsjLbSet: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #35745#31639#26426#31561#32423#32771#35797#32423#21035#35774#32622
      Hint = #20840#30465#39640#26657#35745#31639#26426#31561#32423#32771#35797#32423#21035#35774#32622
      ImageIndex = 9
      OnExecute = act_Data_JsjLbSetExecute
    end
    object act_Data_EnglishLbSet: TAction
      Category = '02.'#25968#25454#23383#20856
      Caption = #33521#35821#31561#32423#32771#35797#32423#21035#35774#32622
      Hint = #20840#30465#39640#26657#33521#35821#31561#32423#32771#35797#32423#21035#35774#32622
      ImageIndex = 10
      OnExecute = act_Data_EnglishLbSetExecute
    end
    object act_PK_KsxzSet: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #32771#29983#39035#30693#20869#23481#35774#32622
      ImageIndex = 4
      OnExecute = act_PK_KsxzSetExecute
    end
    object act_Pk_RoomSet: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #25945#23460#36164#28304#20449#24687#35774#32622
      ImageIndex = 14
      OnExecute = act_Pk_RoomSetExecute
    end
    object act_Pk_KsKcSet: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #32771#35797#31185#30446#21450#26102#38388#35774#32622
      ImageIndex = 8
      OnExecute = act_Pk_KsKcSetExecute
    end
    object act_PK_DeleteAllPKRecord: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #28165#31354#25152#26377#25490#32771#35760#24405
      ImageIndex = 25
      OnExecute = act_PK_DeleteAllPKRecordExecute
    end
    object act_Pk_AutoCreate: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #31995#32479#33258#21160#25490#32771#22788#29702
      ImageIndex = 20
      OnExecute = act_Pk_AutoCreateExecute
    end
    object act_Pk_Input: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #20934#32771#35777#21495#32534#36753#21450#31649#29702
      ImageIndex = 32
      OnExecute = act_Pk_InputExecute
    end
    object act_Pk_KsPcSet: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #32771#22330#25945#23460#36164#28304#23433#25490
      ImageIndex = 10
      OnExecute = act_Pk_KsPcSetExecute
    end
    object act_Pk_Browse: TAction
      Category = '04.'#32771#35797#23433#25490
      Caption = #25490#32771#32467#26524#26597#35810#21450#25171#21360
      ImageIndex = 7
      OnExecute = act_Pk_BrowseExecute
    end
    object act_cwgl_WebSite: TAction
      Category = '03.'#25253#32771#31649#29702
      Caption = #25171#24320#25253#21517#32593#31449#20027#39029
      ImageIndex = 26
      OnExecute = act_cwgl_WebSiteExecute
    end
    object act_Cj_PrintDfb: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #25171#21360#31354#30333#32771#29983#30331#20998#34920
      ImageIndex = 19
      OnExecute = act_Cj_PrintDfbExecute
    end
    object act_Cj_InitKsCjb: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #21021#22987#21270#25104#32489#24405#20837#34920
      ImageIndex = 12
      OnExecute = act_Cj_InitKsCjbExecute
    end
    object act_Cj_CjImport: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #32771#29983#25104#32489#23548#20837
      ImageIndex = 32
      OnExecute = act_Cj_CjImportExecute
    end
    object act_Cj_CjInput: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #32771#29983#25104#32489#24405#20837
      ImageIndex = 5
      OnExecute = act_Cj_CjInputExecute
    end
    object act_Cj_CjBrowse: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #32771#29983#25104#32489#26597#35810'('#21333#31185')'
      ImageIndex = 7
      OnExecute = act_Cj_CjBrowseExecute
    end
    object act_Cj_CjTotal: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #32771#29983#25104#32489#26597#35810'('#27719#24635')'
      ImageIndex = 4
      OnExecute = act_Cj_CjTotalExecute
    end
    object act_Cj_Upload: TAction
      Category = '05.'#25104#32489#31649#29702
      Caption = #32771#29983#25104#32489#26597#35810'('#25253#30424')'
      ImageIndex = 6
      OnExecute = act_Cj_UploadExecute
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    Categories.Strings = (
      #20998#38548#32447
      #20027#33756#21333
      #31995#32479#35774#32622
      #25968#25454#23383#20856
      #25253#32771#31649#29702
      #32771#35797#23433#25490
      #25104#32489#31649#29702
      #32479#35745#25253#34920
      #25509#21475#35774#32622
      #31383#21475
      #24110#21161)
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True)
    ImageOptions.Images = ImageList_mm
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = True
    Left = 584
    Top = 40
    DockControlHeights = (
      0
      0
      27
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'MainMenuBar'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 777
      FloatTop = 8
      FloatClientWidth = 84
      FloatClientHeight = 184
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem3'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem5'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem9'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem4'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem7'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem6'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem8'
        end>
      MultiLine = True
      OneOnRow = True
      RotateWhenVertical = False
      Row = 0
      ShowMark = False
      SizeGrip = False
      UseOwnFont = True
      UseRecentItems = False
      Visible = True
      WholeRow = True
    end
    object dxBarSeparator1: TdxBarSeparator
      Caption = '----'#20998#38548#32447'----'
      Category = 0
      Hint = '----'#20998#38548#32447'----'
      Visible = ivAlways
      ShowCaption = False
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #31995#32479#35774#32622'[&S]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarButton21'
        end
        item
          Visible = True
          ItemName = 'dxBarButton46'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = #25968#25454#23383#20856'[&D]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton28'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = #25253#32771#31649#29702'[&M]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton17'
        end
        item
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton55'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarButton19'
        end
        item
          Visible = True
          ItemName = 'dxBarButton29'
        end>
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = #32771#35797#23433#25490'[&K]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton39'
        end
        item
          Visible = True
          ItemName = 'dxBarButton20'
        end
        item
          Visible = True
          ItemName = 'dxBarButton30'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton40'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton31'
        end
        item
          Visible = True
          ItemName = 'dxBarButton23'
        end
        item
          Visible = True
          ItemName = 'dxBarButton22'
        end
        item
          Visible = True
          ItemName = 'dxBarButton27'
        end>
    end
    object dxBarSubItem9: TdxBarSubItem
      Caption = #25104#32489#31649#29702'[&C]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton53'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton49'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton37'
        end
        item
          Visible = True
          ItemName = 'dxBarButton50'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton52'
        end
        item
          Visible = True
          ItemName = 'dxBarButton54'
        end
        item
          Visible = True
          ItemName = 'dxBarSeparator1'
        end
        item
          Visible = True
          ItemName = 'dxbrbtn1'
        end>
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = #32479#35745#25253#34920'[&B]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton25'
        end
        item
          Visible = True
          ItemName = 'dxBarButton24'
        end
        item
          Visible = True
          ItemName = 'dxBarButton47'
        end>
    end
    object dxBarSubItem6: TdxBarSubItem
      Caption = #31383#21475'[&W]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton32'
        end
        item
          Visible = True
          ItemName = 'dxBarButton33'
        end
        item
          Visible = True
          ItemName = 'dxBarButton34'
        end
        item
          Visible = True
          ItemName = 'dxBarButton35'
        end>
    end
    object dxBarSubItem7: TdxBarSubItem
      Caption = #25509#21475#35774#32622'[&I]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton36'
        end
        item
          Visible = True
          ItemName = 'dxBarButton38'
        end
        item
          Visible = True
          ItemName = 'dxBarButton41'
        end>
    end
    object dxBarSubItem8: TdxBarSubItem
      Caption = #24110#21161'[&H]'
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton42'
        end
        item
          Visible = True
          ItemName = 'dxBarButton43'
        end
        item
          Visible = True
          ItemName = 'dxBarButton44'
        end
        item
          Visible = True
          ItemName = 'dxBarButton48'
        end
        item
          Visible = True
          ItemName = 'dxBarButton45'
        end>
    end
    object dxBarButton26: TdxBarButton
      Caption = #32593#38134#20449#24687#35774#32622'(&N)'
      Category = 2
      Visible = ivAlways
      ImageIndex = 31
    end
    object dxBarButton51: TdxBarButton
      Caption = #32564#36153#26041#24335#35774#32622'(&S)'
      Category = 2
      Visible = ivAlways
      ImageIndex = 18
    end
    object dxBarButton1: TdxBarButton
      Action = act_sys_Czy
      Category = 2
    end
    object dxBarButton2: TdxBarButton
      Action = act_sys_CzyRight
      Category = 2
    end
    object dxBarButton3: TdxBarButton
      Action = act_sys_ChgCzyPwd
      Category = 2
    end
    object dxBarButton4: TdxBarButton
      Action = act_sys_IpSet
      Category = 2
    end
    object dxBarButton5: TdxBarButton
      Action = act_sys_OnlineUpdateSet
      Category = 2
    end
    object dxBarButton6: TdxBarButton
      Action = act_sys_LoginLog
      Category = 2
    end
    object dxBarButton21: TdxBarButton
      Action = act_sys_SysLog
      Category = 2
    end
    object dxBarButton46: TdxBarButton
      Action = act_sys_LockScreen
      Category = 2
    end
    object dxBarButton7: TdxBarButton
      Action = act_sys_Exit
      Category = 2
    end
    object dxBarButton28: TdxBarButton
      Action = act_Data_SfDmSet
      Category = 3
    end
    object dxBarButton10: TdxBarButton
      Action = act_Data_Mz
      Category = 3
    end
    object dxBarButton13: TdxBarButton
      Action = act_Data_Zzmm
      Category = 3
    end
    object dxBarButton14: TdxBarButton
      Action = act_Data_SchoolSet
      Category = 3
    end
    object dxBarButton15: TdxBarButton
      Action = act_Data_EnglishLbSet
      Category = 3
    end
    object dxBarButton16: TdxBarButton
      Action = act_Data_JsjLbSet
      Category = 3
    end
    object dxBarButton17: TdxBarButton
      Action = act_Data_BkLbSet
      Category = 4
    end
    object dxBarButton18: TdxBarButton
      Action = act_Data_BkZySet
      Category = 4
    end
    object dxBarButton55: TdxBarButton
      Action = act_Stu_BmData_Clear
      Category = 4
    end
    object dxBarButton11: TdxBarButton
      Action = act_Stu_BmInput
      Category = 4
    end
    object dxBarButton9: TdxBarButton
      Action = act_Stu_BmConfirm
      Category = 4
    end
    object dxBarButton8: TdxBarButton
      Action = act_Stu_BmBrowse
      Category = 4
    end
    object dxBarButton12: TdxBarButton
      Action = act_cwgl_SfCsSet
      Category = 4
    end
    object dxBarButton19: TdxBarButton
      Action = act_cwgl_SfInfoPublish
      Category = 4
    end
    object dxBarButton29: TdxBarButton
      Action = act_cwgl_WebSite
      Category = 4
    end
    object dxBarButton39: TdxBarButton
      Action = act_PK_KsxzSet
      Category = 5
    end
    object dxBarButton20: TdxBarButton
      Action = act_Pk_RoomSet
      Category = 5
    end
    object dxBarButton30: TdxBarButton
      Action = act_Pk_KsKcSet
      Category = 5
    end
    object dxBarButton40: TdxBarButton
      Action = act_PK_DeleteAllPKRecord
      Category = 5
    end
    object dxBarButton31: TdxBarButton
      Action = act_Pk_AutoCreate
      Category = 5
    end
    object dxBarButton22: TdxBarButton
      Action = act_Pk_KsPcSet
      Category = 5
    end
    object dxBarButton23: TdxBarButton
      Action = act_Pk_Input
      Category = 5
    end
    object dxBarButton27: TdxBarButton
      Action = act_Pk_Browse
      Category = 5
    end
    object dxBarButton53: TdxBarButton
      Action = act_Cj_PrintDfb
      Category = 6
    end
    object dxBarButton49: TdxBarButton
      Action = act_Cj_InitKsCjb
      Category = 6
    end
    object dxBarButton37: TdxBarButton
      Action = act_Cj_CjImport
      Category = 6
    end
    object dxBarButton50: TdxBarButton
      Action = act_Cj_CjInput
      Category = 6
    end
    object dxBarButton52: TdxBarButton
      Action = act_Cj_CjBrowse
      Category = 6
    end
    object dxBarButton54: TdxBarButton
      Action = act_Cj_CjTotal
      Category = 6
    end
    object dxbrbtn1: TdxBarButton
      Action = act_Cj_Upload
      Category = 6
    end
    object dxBarButton25: TdxBarButton
      Action = act_Cwsf_PrintSet
      Category = 7
    end
    object dxBarButton47: TdxBarButton
      Action = act_ReportDesign
      Category = 7
    end
    object dxBarButton24: TdxBarButton
      Action = act_cwsf_print
      Category = 7
    end
    object dxBarButton36: TdxBarButton
      Action = act_Interface_Xjgl
      Category = 8
    end
    object dxBarButton38: TdxBarButton
      Caption = #32771#35797#31995#32479#25509#21475#35774#32622'(&K)'
      Category = 8
      Hint = #32771#35797#36153#20351#29992#24773#20917#26597#35810#25509#21475#35774#32622
      Visible = ivAlways
      ImageIndex = 5
      OnClick = act_Interface_KsxtSetExecute
    end
    object dxBarButton41: TdxBarButton
      Caption = #20854#20182#19994#21153#25509#21475#35774#32622'(&O)'
      Category = 8
      Visible = ivAlways
      ImageIndex = 35
      OnClick = act_Interface_OtherExecute
    end
    object dxBarButton32: TdxBarButton
      Action = act_Win_CloseAll
      Category = 9
    end
    object dxBarButton33: TdxBarButton
      Action = act_Win_CloseCurWin
      Category = 9
    end
    object dxBarButton34: TdxBarButton
      Action = act_Win_Wizard
      Category = 9
    end
    object dxBarButton35: TdxBarButton
      Action = act_Win_HintMessage
      Category = 9
    end
    object dxBarButton42: TdxBarButton
      Action = act_hlp_Help
      Category = 10
    end
    object dxBarButton43: TdxBarButton
      Action = act_hlp_Reg
      Category = 10
    end
    object dxBarButton44: TdxBarButton
      Action = act_hlp_Update
      Category = 10
    end
    object dxBarButton48: TdxBarButton
      Action = act_cwsf_UpdateReport
      Category = 10
    end
    object dxBarButton45: TdxBarButton
      Action = act_hlp_about
      Category = 10
    end
  end
  object ImageList_mm: TImageList
    AllocBy = 1
    Left = 550
    Top = 40
    Bitmap = {
      494C0101240026001C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000A0000000010020000000000000A0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C0000000000000000000000000000000
      0000000000000060000000600000006000000040000000400000004000000000
      0000000000000000000000000000000000000000000066CCFF003399CC003399
      CC003399CC003399CC003399CC003399CC003399CC003399CC003399CC003399
      CC003399CC0066CCFF0000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00808080000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C0000000000000000000000000000060
      00000060000040A0200040A0200040A0200040A0200040802000408020000040
      00000040000000000000000000000000000066CCFF003399CC0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF003399CC0066CCFF00000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF008080800000000000000000000000
      00000000000000000000C0C0C000C0C0C00000000000000000000080000040A0
      2000408020004080200040802000408020004080200040A02000408020004080
      2000408020000040000000000000000000003399CC0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF003399CC00003366003399CC0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF003399CC00000000000000000000000000808080000000
      0000000000000000000080808000000000008080800000000000000000000000
      000080808000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF008080800000000000808080000000
      0000000000000000000000000000808080000000000000000000008000004080
      200080C06000FFFFFF00FFFFFF0080C060004080200040802000408020004080
      2000408020000040000000000000000000003399CC0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000336600003366000033660000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF003399CC00000000000000000000000000808080000000
      0000000000000000000080808000000000008080800000000000000000000000
      000080808000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF008080800000000000000000008080
      800000000000000000008080800000000000000000000080000040A0200080C0
      6000FFFFFF0080C0600080C06000FFFFFF004080000080C06000FFFFFF00FFFF
      FF0080C060004080200000400000000000003399CC0066CCFF0000FFFF0000FF
      FF0000FFFF0000FFFF003399CC00003366003399CC0000FFFF0000FFFF0000FF
      FF0000FFFF0066CCFF003399CC00000000000000000000000000808080000000
      0000000000000000000080808000000000008080800000000000000000000000
      000080808000000000000000000000000000000000008080800000000000C0C0
      C000C0C0C000C0C0C000C0C0C000FFFFFF008080800000000000000000000000
      000000000000000000000000000000000000000000000080000040A02000FFFF
      FF0080C060004080000080C06000FFFFFF0040800000FFFFFF0080C0600080C0
      6000FFFFFF0040802000006000000000000066CCFF003399CC0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF003399CC0066CCFF00000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000808080000000000000000000000000000000
      000000000000000000000000000000000000000000000080000040A02000FFFF
      FF004080000040802000FFFFFF00FFFFFF0040800000FFFFFF00408000004080
      0000FFFFFF00408020000060000000000000000000003399CC0066CCFF0000FF
      FF0000FFFF0000FFFF0066CCFF000033660066CCFF0000FFFF0000FFFF0000FF
      FF0066CCFF003399CC0000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000080000040A02000FFFF
      FF004080000040A0200040A0200040A0200040802000FFFFFF00408000004080
      0000FFFFFF004080200000600000000000000000000066CCFF003399CC0000FF
      FF0000FFFF0000FFFF003399CC00003366003399CC0000FFFF0000FFFF0000FF
      FF003399CC0066CCFF0000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000080000000
      FF0000008000000000000000000000000000000000000080000040A02000FFFF
      FF0080C060004080000040A0200040A0200040802000FFFFFF0080C0600080C0
      6000FFFFFF0040802000006000000000000000000000000000003399CC0066CC
      FF0000FFFF0000FFFF0033669900003366003366990000FFFF0000FFFF0066CC
      FF003399CC000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF000000800000000000000000000000000000A0000040A0200080C0
      6000FFFFFF0080C0600080C06000FFFFFF004080000080C06000FFFFFF00FFFF
      FF0080C06000408020000060000000000000000000000000000066CCFF003399
      CC0000FFFF0000FFFF0000336600003366000033660000FFFF0000FFFF003399
      CC0066CCFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      000080808000000000000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000000000000000000000000000000000A000004080
      200080C06000FFFFFF00FFFFFF0080C0600040A0200040A02000408020004080
      200040A020000060000000000000000000000000000000000000000000003399
      CC0066CCFF0000FFFF0000336600003366000033660000FFFF0066CCFF003399
      CC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000008080800000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      000000000000808080000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF00000080000000000000000000000000000000000000A0000040C0
      200040A0200040A0200040A0200040A0200040A0200040C0200040A0200040A0
      200040A0200000600000000000000000000000000000000000000000000066CC
      FF003399CC0000FFFF003399CC00003366003399CC0000FFFF003399CC0066CC
      FF00000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000FF000000FF000000
      FF000000FF000000FF00000000000000000000000000000000000000000000A0
      000000A0000040C0200040C0200040C0200040C0200040C0200040C020000080
      0000008000000000000000000000000000000000000000000000000000000000
      00003399CC0066CCFF0000FFFF0000FFFF0000FFFF0066CCFF003399CC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000A0000000A00000008000000080000000800000008000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000066CCFF003399CC003399CC003399CC003399CC003399CC0066CCFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066CCFF0066CCFF0066CCFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC996600CC99660000000000000000000000000000000000000000000000
      000000000000C0200000C0200000C0200000C0200000C0200000C02000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC99660000000000000000000000000000000000000000000000
      0000C0600000C0600000C0400000C0400000C0400000C0400000C0600000C040
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC660000CC66000099330000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600FFFF
      FF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500FFFFFF00CC9966000000000000000000000000000000000000000000C0A0
      2000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C060
      0000C0400000000000008000200000000000000000000000000099330000CC66
      0000CC660000CC660000CC660000993300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC99660000000000000000000000000000000000C0A02000C080
      0000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0600000C040000000000000000000000000000099330000CC660000CC66
      0000CC660000CC660000CC660000CC6600009933000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CC99
      6600993300000000000000000000000000000000000000000000CC996600FFFF
      FF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500FFFFFF00CC996600000000000000000000000000F0CAA600C0A02000C080
      0000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0800000C0600000C0200000000000000000000099330000CC660000CC66
      00009933000099330000CC660000CC660000CC66000099330000000000000000
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300009933000099330000000000000000000000000000000000000000
      000099330000CC99660000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600000000000000000000000000F0CAA600C0A02000C080
      0000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0800000C0600000C0400000000000000000000099330000CC6600009933
      0000000000000000000099330000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000009933000000000000000000000000000000000000CC996600FFFF
      FF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500FFFFFF00CC996600000000000000000000000000F0CAA600C0A02000C080
      0000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0800000C0600000C0400000000000000000000099330000993300000000
      000000000000000000000000000099330000CC660000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000993300009933
      0000993300000000000000000000000000000000000000000000000000000000
      0000000000009933000000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600000000000000000000000000F0CAA600C0A02000C080
      0000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0800000C0600000C0400000000000000000000000000000000000000000
      00000000000000000000000000000000000099330000CC660000CC660000CC66
      0000993300000000000000000000000000000000000000000000993300009933
      0000000000009933000000000000000000000000000000000000000000000000
      0000000000009933000000000000000000000000000000000000CC996600FFFF
      FF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500FFFFFF00CC996600000000000000000000000000F0CAA600C0A02000C080
      0000C0800000C0800000C0800000C0800000C0800000C0800000C0800000C080
      0000C0800000C0600000C0400000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000CC660000CC66
      0000CC6600009933000000000000000000000000000000000000993300000000
      0000000000000000000099330000993300000000000000000000000000000000
      000099330000CC99660000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600000000000000000000000000FFFFFF00C0C02000C080
      0000C0800000C0800000C0800000C0800000C0800000C0800000C0800000C080
      0000C0800000C0600000C0400000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000099330000CC66
      0000CC6600009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000099330000993300009933
      0000CC9966000000000000000000000000000000000000000000CC996600FFFF
      FF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500FFFFFF00CC996600CC99
      6600CC996600CC99660000000000000000000000000000000000FFFFFF00C0A0
      2000C0800000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C0800000C060000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000CC6600009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC996600E5E5
      E500CC996600000000000000000000000000000000000000000000000000FFFF
      FF00C0A02000C0800000C0600000FFFFFF00FFFFFF00C0600000C0800000C080
      0000C06000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC996600CC99
      6600000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00C0A02000C0600000C0600000C0600000C0600000C0800000C060
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC9966000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00F0CAA600F0CAA600F0CAA600F0CAA600C06000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009999CC0000008000000080000000800000008000000080009999CC000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      000000000000000000000000000000000000FFCC9900CC996600CC996600CC99
      6600CC996600CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000808080000000000000FFFF0000000000808080000000
      0000808080000000000000000000000000000000000000000000000000000000
      80000000CC000000FF000000FF000000FF000000FF000000FF000000CC000000
      8000000000000000000000000000000000000000000000000000000000000000
      00000099330000000000FF000000FF663300FF000000FF000000FF000000FF00
      000000000000000000000000000000000000FFCC9900FFFFCC00FFFFCC00CCCC
      FF00E5E5E500CC996600CC996600CCCCCC000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C0000000000000FFFF00808080000000000000FFFF00000000008080800000FF
      FF0000000000C0C0C00000000000000000000000000000000000000080000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000080000000000000000000000000000000000000000000009933000099
      3300009933000099330000000000FF663300FF663300FF663300FF000000FF00
      000000330000000000000000000000000000FFCC9900FFFFFF00FFFFFF00CCCC
      FF00FFFFFF00FFFFFF00E5E5E500CC9966000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008080
      80008080800000000000000000000000000000000000000080000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF0000008000000000000000000000000000009933000099330066FF
      330066FF330033CC33000099330000000000FF663300FF663300006600000066
      000000660000006600000000000000000000FFCC9900FFFFCC00FFFFCC00CCCC
      FF00FFFFCC00FFFFCC00FFFFCC00CC996600CCCCCC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000FFFF0080808000000000008080800000FFFF000000
      0000000000008080800000000000000000009999CC000000CC000000FF000000
      FF00FFFFFF00FFFFFF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      FF000000FF000000CC009999CC0000000000000000000099330066FF330066FF
      330066FF330033CC33000099330000000000FF99000000660000009933000099
      330000660000006600000000000000000000FFCC9900FFFFFF00CCCCCC00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00E5E5E500CC996600CCCCCC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FF
      FF0000FFFF00000000000000000000000000000080000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000FF00000080000000000000993300CCFFCC00CCFFCC00CCFF
      CC0033CC33000066000000660000FF9900000066000033CC3300009933000099
      330000660000006600000066000000000000FFCC9900FFFFCC00FFFFCC00CCCC
      FF00FFFFCC00FFFFCC00FFFFCC00FFFFCC00E5E5E500CC996600CC996600CC99
      6600CCCCCC000000000000000000000000000000000000000000000000008080
      8000000000000000000000FFFF0080808000000000008080800000FFFF000000
      000000000000808080000000000000000000000080000000FF000000FF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF0000008000000000000099330000993300FFFFFF0033CC
      330000660000FF990000FFCC3300FFCC330000660000CCFFCC0033CC33000099
      330000660000006600000066000000000000FFCC9900FFFFFF00FFFFFF00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5E5
      E500CC996600CC996600CC996600CCCCCC000000000000000000000000000000
      0000808080008080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008080
      800080808000000000000000000000000000000080000000FF000000FF000000
      FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF000000FF000000FF000000800000000000FF663300FFFFCC00009933000099
      3300FF990000FFCC3300FFCC3300FFCC3300FF99000000660000CCFFCC0033CC
      330000993300006600000066000000000000FFCC9900FFFFCC00FFFFCC00CCCC
      FF00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFF
      CC00FFFFCC00FFFFCC00E5E5E500CC9966000000000000000000000000000000
      00000000000000FFFF00808080000000000000FFFF00000000008080800000FF
      FF0000000000000000000000000000000000000080000000FF000000FF000000
      FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF000000800000000000FF663300FFFFCC00FFFF3300FF99
      000000663300FF663300FF990000FFCC3300FF990000FF663300FF6633000066
      000033CC3300009933000066000000000000FFCC9900FFFFFF00FFFFFF00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC9966000000000000000000000000000000
      00008080800000000000808080000000000000FFFF0000000000808080000000
      000080808000000000000000000000000000000080000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000FF00000080000000000000000000FF663300006633000066
      330033CC330000663300FF663300FFCC3300FFCC3300FF990000FF663300FF66
      330000660000006600000000000000000000FFCC9900FFFFCC00FFFFCC00CCCC
      FF00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFF
      CC00FFFFCC00FFFFCC00FFFFCC00CC9966000000000000000000000000000000
      0000000000000000000000000000808080000000000080808000000000000000
      0000000000000000000000000000000000009999CC000000CC000000FF000000
      FF00FFFFFF00FFFFFF000000FF000000FF000000FF00FFFFFF00FFFFFF000000
      FF000000FF000000CC009999CC00000000000000000000993300FFFFFF00CCFF
      CC0033CC330033CC330000663300FF990000FF990000FFCC3300FF663300FF66
      3300FF663300FF6633000000000000000000FFCC9900FFFFFF00CCCCCC00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC9966000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000080000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000080000000000000000000000000000000000000993300FFFF
      FF00CCFFCC0033CC330033CC33000066330000663300FF990000FF663300FF66
      3300FF663300800000000000000000000000FFCC9900FFFFFF00FFFFFF00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC9966000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000080000000000000000000000000000000000000000000000000000099
      3300FFFFFF00CCFFCC00CCFFCC0033CC33000099330000663300FF663300FF66
      3300FF663300000000000000000000000000FFCC9900FFFFFF00FFFFFF00CCCC
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC9966000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      80000000CC000000FF000000FF000000FF000000FF000000FF000000CC000000
      8000000000000000000000000000000000000000000000000000000000000000
      00000099330000993300FFFFFF0033CC330033CC330000993300FF663300FF66
      330000000000000000000000000000000000FFCC9900FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC99000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009999CC0000008000000080000000800000008000000080009999CC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000993300009933000099330000993300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300006600000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC996600993300009933
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000CC6600009933000066000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099330000FFFFFF0099330000000000000000
      0000000000000000000000000000000000000000000066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC99660099330000000000000000
      0000000000000000000099330000993300000000000000000000000000009933
      0000000000000000000000000000000000000000000000000000000000009933
      00009933000099330000E5E5E500E5E5E500CCCCCC0099330000660000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099330000FFFFFF00FFFFFF0099330000000000000000
      00000000000000000000000000000000000000000000CCCCCC00666666000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000009933000000000000993300009933
      0000000000000000000000000000000000000000000099330000993300009933
      0000E5E5E500E5E5E500E5E5E500E5E5E500CCCCCC00CCCCCC00993300006600
      000000000000000000000000000000000000000000000000000000000000CC99
      6600993300009933000099330000FFFFFF00FFFFFF009933000099330000CC99
      6600000000000000000000000000000000000000000000000000CCCCCC006666
      66000000000000000000FF990000993300009933000099330000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      0000000000000000000000000000000000009933000099330000E5E5E500E5E5
      E500E5E5E500E5E5E50099330000993300009999990099999900CCCCCC009933
      000066000000000000000000000000000000000000000000000099330000CC99
      6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC99
      660099330000000000000000000000000000000000000000000000000000CCCC
      CC0066666600FF990000CC660000CC660000CC660000CC660000993300000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000009933000099330000993300009933
      00000000000000000000000000000000000099330000E5E5E500E5E5E500E5E5
      E500993300009933000099330000993300006600000080808000999999009999
      9900993300006600000000000000000000000000000099330000FFFFFF00FFFF
      FF00FFFFFF009933000099330000993300009933000099330000FFFFFF00FFFF
      FF00FFFFFF009933000000000000000000000000000000000000000000000000
      0000FF990000CC660000FF990000CC660000CC660000CC660000993300000000
      000000000000000000000000000000000000CC99660099330000000000000000
      0000000000000000000000000000993300009933000099330000993300009933
      00000000000000000000000000000000000099330000E5E5E500993300009933
      000099330000CC660000CC660000CC6600009933000066000000666666009999
      990099999900993300006600000000000000CC996600CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00993300009933000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600CC99660000000000000000000000000000000000FF99
      0000CC660000FF990000FF990000FF990000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000099330000CC9966000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000993300009933000099330000CC66
      0000CC6600009933000099330000CC660000CC66000099330000660000006666
      66009999990080808000993300006600000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00993300009933000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009933000000000000000000000000000000000000CC66
      0000FF996600FF996600FF990000FF990000CC660000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC99660099330000000000000000000099330000FF990000CC660000CC66
      0000CC66000000FFFF0033CCFF00993300009933000099330000993300006600
      00006666660099999900993300006600000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00993300009933000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009933000000000000000000000000000000000000CC66
      0000FFFFFF00FFFFFF00FF996600CC660000FF990000CC660000CC6600009933
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000099330000993300000000000000000000000000000000
      00000000000099330000CC996600000000000000000099330000FF990000CC66
      0000CC660000CC660000CC66000000FFFF0000FFFF0033CCFF00336699009933
      00006600000066666600993300000000000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0099330000993300009933000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009933000000000000000000000000000000000000CC66
      0000FF996600FF996600CC660000FFFFFF00FF996600FF990000CC6600009933
      0000993300009933000099330000000000000000000000000000000000009933
      0000993300009933000099330000000000000000000000000000000000000000
      000000000000000000009933000000000000000000000000000099330000FF99
      0000CC660000CC660000CC660000CC660000CC66000033CCFF0000FFFF003366
      99009933000066000000993300000000000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0099330000000000000000000000000000000000000000
      0000CC660000CC660000CC660000CC660000FFFFFF00FF99660099330000CC66
      0000CC660000CC660000CC660000993300000000000000000000000000009933
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000000000000099330000000000000000000000000000000000009933
      0000FF990000CC660000CC66000000FFFF0000FFFF0000FFFF003399CC003366
      99009933000099330000660000006600000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CC99660099330000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0099330000000000000000000000000000000000000000
      000000000000000000000000000000000000CC660000CC660000CC660000FF99
      0000CC660000CC660000CC660000993300000000000000000000000000009933
      0000993300000000000099330000000000000000000000000000000000000000
      0000000000000000000099330000000000000000000000000000000000000000
      000099330000FF990000CC660000CC6600003366990033669900660066009933
      000099330000993300006600000000000000CC996600CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00993300009933000099330000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600CC996600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC660000FF996600FF99
      0000FF990000CC660000CC660000993300000000000000000000000000009933
      0000000000000000000000000000993300009933000000000000000000000000
      00000000000099330000CC996600000000000000000000000000000000000000
      00000000000099330000FF990000CC660000CC660000CC660000993300009933
      0000660000000000000000000000000000000000000099330000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CC99660099330000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009933000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC660000FF996600FF99
      6600FF990000CC660000CC660000FF9900000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      000099330000CC99660000000000000000000000000000000000000000000000
      0000000000000000000099330000FF990000CC66000099330000660000000000
      000000000000000000000000000000000000000000000000000099330000CC99
      6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC99
      6600993300000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC660000FFFFFF00FF99
      6600CC660000CC660000FF990000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000993300006600000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CC99
      660099330000993300009933000099330000993300009933000099330000CC99
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CC660000CC66
      0000CC660000FF9900000000000000000000000000003399CC003399CC003399
      CC0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF000000000000000000000000000000
      000000000000CC99660099330000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000066CCFF0066CCFF003399CC003399
      CC003399CC0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CCFF0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF000000000000000000000000000000
      0000CC996600FFFFFF00FFCC9900FFCC9900CC996600CC996600993300000000
      000000000000000000000000000000000000CC996600CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC996600CC996600CC996600CC9966000000000000000000993300009933
      0000993300009933000099330000993300009933000099330000993300009933
      00009933000000000000000000000000000066CCFF0066CCFF0066CCFF000099
      0000008000000080000066CCFF00336699003366990033669900336699003399
      CC0066CCFF0066CCFF0066CCFF00336699000000000000000000000000000000
      0000CC9966009933000099330000993300009933000099330000993300000000
      000000000000000000000000000000000000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC99660000000000CC996600FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900CC99
      6600CC99660099330000000000000000000066CCFF0066CCFF0066CCFF000099
      000000FF00000080000066CCFF003399CC006699CC006699CC003399CC0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF00000000000000000000000000CC99
      6600FFFFFF00FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900CC9966009933
      000000000000000000000000000000000000CC996600FFFFFF00CC996600CC99
      6600CC996600CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600CC996600CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      660099330000CC996600993300000000000066CCFF0066CCFF0066CCFF000099
      000000FF00000080000066CCFF0066CCFF003399CC003399CC0066CCFF0066CC
      FF00336699003366990066CCFF0066CCFF000000000000000000CC996600FFFF
      FF00CC996600CC996600CC996600CC996600CC996600FFCC9900CC996600CC99
      660099330000000000000000000000000000CC996600FFFFFF00CC996600FFFF
      FF00FFFFFF00CC996600FFFFFF00993300009933000099330000993300009933
      00009933000099330000FFFFFF00CC996600CC996600FFFFFF00FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC
      9900CC99660099330000993300000000000066CCFF0066CCFF0066CCFF000099
      000000FF000000FF00000080000066CCFF0066CCFF0066CCFF0066CCFF0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF0000000000CC996600FFFFFF00FFCC
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCC9900FFCC9900CC99
      660099330000000000000000000000000000CC996600FFFFFF00CC996600FFFF
      FF00FFFFFF00CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600CC996600FFFFFF00FFCC9900FFCC
      9900FFCC9900FFCC990000CC000000990000FFCC99000000FF000000CC00FFCC
      9900CC996600CC996600993300000000000066CCFF0066CCFF0066CCFF000099
      000000FF000033CC330000FF00000080000066CCFF0066CCFF0066CCFF0066CC
      FF0066CCFF0066CCFF0066CCFF0066CCFF0000000000CC996600FFFFFF00FFCC
      9900CC996600CC996600CC996600CC996600CC996600FFCC9900FFCC9900CC99
      6600CC996600993300000000000000000000CC996600FFFFFF00CC996600CC99
      6600CC996600CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CC996600CC996600CC99660099330000FFCC990066CC66000080000000FF
      000000FF00000099000000FF000000FF000000990000FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC990000000000CC996600FFFFFF00FFCC
      9900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFCC9900FFCC9900CC99
      6600CC996600993300000000000000000000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600CC996600FFFFFF00FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC
      9900CC996600CC996600CC99660099330000FFCC99000099000000FF00000099
      000000FF0000008000000099000000FF000000990000FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC990000000000CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      660099330000993300000000000000000000CC996600FFFFFF00CC996600CC99
      6600CC996600CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC99660000000000CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600FFCC
      9900FFCC9900CC996600CC99660099330000FFCC99000099000000FF00000099
      000000FF00000080000066CC66000099000066CC6600FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC99
      6600CC996600993300000000000000000000CC996600FFFFFF00CC996600FFFF
      FF00FFFFFF00CC996600FFFFFF00993300009933000099330000993300009933
      00009933000099330000FFFFFF00CC9966000000000000000000CC996600FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC99
      6600FFCC9900FFCC9900CC99660099330000FFCC99000099000000FF00000099
      000000FF000000800000FFCC9900FFCC9900FFCC9900FFCC9900FFCC990000CC
      FF0000CCFF0000CCFF00FFCC9900FFCC9900CC996600FFCC9900FFCC990099CC
      CC000099CC00FFCC9900FFCC9900FFCC990099CCCC000099CC00FFCC9900FFFF
      FF00CC996600CC9966009933000000000000CC996600FFFFFF00CC996600FFFF
      FF00FFFFFF00CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600000000000000000000000000CC99
      6600FFFFFF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500FFFFFF00CC99
      6600CC996600CC9966009933000000000000FFCC990066CC6600009900000099
      000000FF000000800000FFCC9900FFCC9900FFCC9900FFCC990000CCFF0066FF
      FF0066FFFF0066FFFF0000CCFF00FFCC990000000000CC996600FFCC990099CC
      CC0000FFFF000099CC00CC996600FFCC990099CCCC0000FFFF000099CC00FFCC
      9900FFFFFF00CC9966009933000000000000CC996600FFFFFF00CC996600CC99
      6600CC996600CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC996600000000000000000000000000CC99
      6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CC996600000000000000000000000000FFCC9900FFCC9900FFCC99000099
      000000FF000000800000FFCC9900FFCC9900FFCC9900FFCC990000CCFF0066FF
      FF0066FFFF0066FFFF0000CCFF00FFCC99000000000000000000CC99660099CC
      CC0000FFFF000099CC00CC996600CC99660099CCCC0000FFFF000099CC00CC99
      6600CC996600CC9966000000000000000000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CC9966000000000000000000000000000000
      0000CC996600FFFFFF00E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500FFFF
      FF00CC996600000000000000000000000000FFCC9900FFCC9900FFCC990066CC
      66000099000066CC6600FFCC9900FFCC9900FFCC9900FFCC990000CCFF0066FF
      FF0066FFFF0066FFFF0000CCFF00FFCC990000000000000000000000000099CC
      CC0000FFFF000099CC00000000000000000099CCCC0000FFFF000099CC000000
      000000000000000000000000000000000000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CC996600CC996600CC996600CC996600CC996600CC99
      6600CC996600CC996600CC996600CC9966000000000000000000000000000000
      0000CC996600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC9966000000000000000000FFCC9900FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC990000CC
      FF0000CCFF0000CCFF00FFCC9900FFCC990000000000000000000000000099CC
      CC0000FFFF000099CC00000000000000000099CCCC0000FFFF000099CC000000
      000000000000000000000000000000000000CC996600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CC996600CC996600CCCCCC00CCCCCC00CCCCCC00CCCCCC00CC99
      6600000000000000000000000000000000000000000000000000000000000000
      000000000000CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC996600CC9966000000000000000000FFCC9900FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC9900FFCC
      9900FFCC9900FFCC9900FFCC9900FFCC99000000000000000000000000000000
      000099CCCC000099CC0000000000000000000000000099CCCC000099CC000000
      00000000000000000000000000000000000000000000CC996600CC996600CC99
      6600CC9966000000000000000000CC996600CC996600CC996600CC9966000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF0000000000000000008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066CCFF003399CC003399CC0066CCFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9900000099000000990000009900000099000000990000009900000099000000
      99000000990000000000000000000000000000000000000000003399CC003399
      CC003399CC003399CC003399CC0066CCFF0066CCFF003399CC003399CC003399
      CC003399CC003399CC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000099000000
      CC000000CC000000CC000000CC000000CC00000099000000CC00000099000000
      99000000990000009900000000000000000000000000000000003399CC0099FF
      FF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0066CCFF0066CC
      FF0066CCFF003399CC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000000000000808080000000000000000000000000000000
      0000000000000000000000000000666699000000000000000000000099000000
      FF000000CC000000CC000000CC000000CC000000CC00000099000000CC000000
      9900000099000000990000000000000000000000000000000000000000003399
      CC0099FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0066CC
      FF003399CC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000C0C0C0000000000000000000000000000000
      00000000000000000000666699003399CC000000000000000000000099000000
      CC000000FF000000CC000000CC000000CC000000CC000000CC00000099000000
      CC00000099000000990000000000000000000000000000000000000000000000
      00003399CC0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF003399
      CC00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00000000000000
      0000FFFFFF0080808000C0C0C000FFFFFF008080800000000000FFFFFF008080
      800000000000666699003399CC0066CCFF000000000000000000000099000000
      FF000000CC000000FF000000CC000000CC000000CC000000CC000000CC000000
      99000000CC000000990000000000000000000000000000000000000000000000
      00003399CC0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF003399
      CC00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C00000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000808080000000000000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00666699003399CC0066CCFF00000000000000000000000000000099000000
      FF000000FF000000CC000000FF000000CC000000CC000000CC000000CC000000
      CC00000099000000990000000000000000000000000000000000000000000000
      00003399CC0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF003399
      CC0000000000000000000000000000000000000000000000000000000000C0C0
      C000000000000000000000000000C0C0C00000000000C0C0C000000000000000
      0000000000000000000080000000800000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000FFFFFF006666
      99003399CC0066CCFF0000000000000000000000000000000000000099009999
      FF000000FF000000FF000000CC000000FF000000CC000000CC000000CC000000
      CC000000CC000000990000000000000000000000000000000000000000000000
      00003399CC00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF003399
      CC00000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0
      C000C0C0C0000000000080000000800000000000000000000000C0C0C000C0C0
      C0000000000000000000FFFFFF00000000000000000000000000666699003399
      CC0066CCFF000000000000000000000000000000000000000000000099009999
      FF009999FF000000FF000000FF000000CC000000FF000000CC000000CC000000
      CC000000CC000000990000000000000000000000000000000000000000000000
      000066CCFF0066CCFF00FFFFFF0000FFFF0000FFFF0000FFFF0066CCFF0066CC
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00000000000C0C0C00000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080000000800000000000000080808000C0C0C000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF0000000000666699003399CC0066CC
      FF00000000000000000000000000000000000000000000000000000000000000
      9900000099000000990000009900000099000000990000009900000099000000
      9900000099000000000000000000000000000000000000000000000000000000
      0000000000003399CC0099FFFF00FFFFFF0000FFFF0000FFFF003399CC000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C00000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00080000000800000000000000000000000808080008080
      80000000000000000000FFFFFF00FFFFFF00666699003399CC0066CCFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003399CC003399CC003399CC003399CC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000080000000800000000000000000000000000000000000
      0000000000000000000000000000666699003399CC0066CCFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000800000000000000000000000000000000000
      00000000000000000000666699003399CC0066CCFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000666699003399CC0066CCFF000000000000000000000000000000
      000000000000000000000000000000000000CCCCCC0077777D005A5A66005A5A
      66005A5A66005A5A66005A5A66005A5A66005A5A66005A5A66005A5A66005A5A
      66005A5A66005A5A660077777D00CCCCCC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E5E5E50065657000F9F9E900F3F3
      E300F3F3E300F3F3E300F3F3E300F3F3E300F3F3E300F3F3E300F3F3E300F3F3
      E300F3F3E300F9F9E90065657000E5E5E5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0072727C00F5F5E600DCDC
      CC007171600082827100B5B5A600E9E9DA00E9E9DA00E9E9DA00E9E9DA00E9E9
      DA00E9E9DA00F5F5E60072727C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0079798200F6F6E900ECEC
      E000ECECE000DFDFD10066665500ECECE000ECECE00066665500666655006666
      5500ECECE000F6F6E90079798200FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007D7D8600F8F8ED00EFEF
      E600EFEFE600EFEFE60074746300EFEFE600EFEFE600EFEFE60074746300EFEF
      E600EFEFE600F8F8ED007D7D8600FFFFFF000000000000000000000000009900
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000000000000000000000000000000000000000000000000000000099
      0000009900000099000000990000009900000099000000990000009900000099
      0000009900000000000000000000000000000000000000000000000000000099
      9900009999000099990000999900009999000099990000999900009999000099
      990000999900000000000000000000000000FFFFFF0080808800FAFAF100F3F3
      EB00D6D6CC0082827100BBBBAE00F3F3EB00F3F3EB00F3F3EB0082827100F3F3
      EB00F3F3EB00FAFAF10080808800FFFFFF00000000000000000099000000CC00
      0000CC000000CC000000CC000000CC00000099000000CC000000990000009900
      00009900000099000000000000000000000000000000000000000099000000CC
      000000CC000000CC000000CC000000CC00000099000000CC0000009900000099
      00000099000000990000000000000000000000000000000000000099990000CC
      CC0000CCCC0000CCCC0000CCCC0000CCCC000099990000CCCC00009999000099
      990000999900009999000000000000000000FFFFFF0084848C00FBFBF500F7F7
      F100F7F7F100F7F7F1008E8E7D00F7F7F100F7F7F100F7F7F1008E8E7D00F7F7
      F100F7F7F100FBFBF50084848C00FFFFFF00000000000000000099000000FF00
      0000CC000000CC000000CC000000CC000000CC00000099000000CC0000009900
      00009900000099000000000000000000000000000000000000000099000000FF
      000000CC000000CC000000CC000000CC000000CC00000099000000CC00000099
      00000099000000990000000000000000000000000000000000000099990000FF
      FF0000CCCC0000CCCC0000CCCC0000CCCC0000CCCC000099990000CCCC000099
      990000999900009999000000000000000000FFFFFF0087878F00FDFDF900FAFA
      F700B0B0A30098988700A5A59500FAFAF700FAFAF700B0B0A30098988600FAFA
      F700FAFAF700FDFDF90087878F00FFFFFF00000000000000000099000000CC00
      0000FF000000CC000000CC000000CC000000CC000000CC00000099000000CC00
      00009900000099000000000000000000000000000000000000000099000000CC
      000000FF000000CC000000CC000000CC000000CC000000CC00000099000000CC
      00000099000000990000000000000000000000000000000000000099990000CC
      CC0000FFFF0000CCCC0000CCCC0000CCCC0000CCCC0000CCCC000099990000CC
      CC0000999900009999000000000000000000FFFFFF008A8A9200FEFEFD00FDFD
      FB00FDFDFB00FDFDFB00FDFDFB00FDFDFB00FDFDFB00FDFDFB00FDFDFB00FDFD
      FB00FDFDFB00FEFEFD008A8A9200FFFFFF00000000000000000099000000FF00
      0000CC000000FF000000CC000000CC000000CC000000CC000000CC0000009900
      0000CC00000099000000000000000000000000000000000000000099000000FF
      000000CC000000FF000000CC000000CC000000CC000000CC000000CC00000099
      000000CC000000990000000000000000000000000000000000000099990000FF
      FF0000CCCC0000FFFF0000CCCC0000CCCC0000CCCC0000CCCC0000CCCC000099
      990000CCCC00009999000000000000000000FFFFFF008D8D9500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008D8D9500FFFFFF00000000000000000099000000FF00
      0000FF000000CC000000FF000000CC000000CC000000CC000000CC000000CC00
      00009900000099000000000000000000000000000000000000000099000000FF
      000000FF000000CC000000FF000000CC000000CC000000CC000000CC000000CC
      00000099000000990000000000000000000000000000000000000099990000FF
      FF0000FFFF0000CCCC0000FFFF0000CCCC0000CCCC0000CCCC0000CCCC0000CC
      CC0000999900009999000000000000000000FFFFFF003636AF006363F8004646
      DE005050E7005050E7004646DE005A5AF0005A5AF0005A5AF0005A5AF0005A5A
      F0005A5AF0006363F8003636AF00FFFFFF00000000000000000099000000FF99
      6600FF000000FF000000CC000000FF000000CC000000CC000000CC000000CC00
      0000CC00000099000000000000000000000000000000000000000099000099FF
      990000FF000000FF000000CC000000FF000000CC000000CC000000CC000000CC
      000000CC0000009900000000000000000000000000000000000000999900FFFF
      FF0000FFFF0000FFFF0000CCCC0000FFFF0000CCCC0000CCCC0000CCCC0000CC
      CC0000CCCC00009999000000000000000000FFFFFF003D3DB2006D6DFB00D7D7
      FB00A1A1EC00A8A8F100C4C4E8006464F5006464F5006464F5005C5CEF004E4E
      E4005C5CEF006D6DFB003D3DB200FFFFFF00000000000000000099000000FF99
      6600FF996600FF000000FF000000CC000000FF000000CC000000CC000000CC00
      0000CC00000099000000000000000000000000000000000000000099000099FF
      990099FF990000FF000000FF000000CC000000FF000000CC000000CC000000CC
      000000CC000000990000000000000000000000000000000000000099990099FF
      FF00FFFFFF0000FFFF0000FFFF0000CCCC0000FFFF0000CCCC0000CCCC0000CC
      CC0000CCCC00009999000000000000000000FFFFFF004646B6007777FD002F2F
      C100111188002F2FC1006E6EFB006E6EFB006E6EFB006E6EFB002F2FC1001111
      88002F2FC1007777FD004646B600FFFFFF000000000000000000000000009900
      0000990000009900000099000000990000009900000099000000990000009900
      0000990000000000000000000000000000000000000000000000000000000099
      0000009900000099000000990000009900000099000000990000009900000099
      0000009900000000000000000000000000000000000000000000000000000099
      9900009999000099990000999900009999000099990000999900009999000099
      990000999900000000000000000000000000FFFFFF004D4DB8008383FF003D3D
      D500B1B1B1003D3DD5007E7EFF007E7EFF007E7EFF007E7EFF003D3DD500B1B1
      B1003D3DD5008383FF004D4DB800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF007D7DB8005353BA003333
      9100D6D6D600333391005353BA005353BA005353BA005353BA0033339100D6D6
      D600333391005353BA007D7DB800FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00C8C8
      C800A0A0A000C8C8C800FFFFFF00FFFFFF00FFFFFF00FFFFFF00C8C8C800A0A0
      A000C8C8C800FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F5F5F500E7E7E700E5E5E500E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5E500E5E5
      E500E7E7E700F4F4F400FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CC99990099330000CC9999000000000000CB0B000076A8000071
      E4000071E4000071E4000071E4000071E4000071E4000071E4000071E4000071
      E4000071E4000076A80000CB0B00000000000000000033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A399008E8E7D008E8E7D008E8E
      7D008E8E7D008E8E7D008E8E7D008E8E7D008E8E7D008E8E7D008E8E7D008E8E
      7D008E8E7D00A3A39900FFFFFF00FFFFFF0000000000CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600CC996600CC99
      6600CC999900993300009933000099330000000000000076AC0079B6F500AFD5
      FC00AFD5FC00AFD5FC00AFD5FC00AFD5FC00AFD5FC00AFD5FC00AFD5FC00AFD5
      FC00AFD5FC0079B6F5000076AC00000000003333330066666600666666006666
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A8900F9F9E900F3F3E200F3F3
      E200F3F3E200F3F3E200F3F3E200F3F3E200F3F3E200F3F3E200F3F3E200F3F3
      E200F9F9E9009A9A8900FFFFFF00FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000993300009933000099330000CC999900000000000071E4008FC4FB0071B4
      FA002F92F7002D91F7003595F700248CF700248CF700288EF700248CF700248C
      F7003C98F8008FC4FB000071E400000000000000000099999900CCCCCC009999
      9900666666006666660000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A9A99800F4F4E400FFCC4300FECB
      4200EBD28400D9D9C800D7D7C500D4D4C200D2D2C000D0D0BE00CFCFBD009B9B
      8A008A8A7900A1A19000FFFFFF00FFFFFF0000000000CC996600FFFFFF00E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500CC996600CC996600CC9966009933
      00009933000099330000CC99990000000000000000000071E4006EB3F900248C
      F600CCE4FD00CCE4FD002C90F700FFFFFF00F7FBFF00248CF600FFFFFF00F7FB
      FF001F89F6006EB3F9000071E400000000000000000099999900CCCCCC00CCCC
      CC00999999009999990066666600666666000000000000000000000000000000
      000000000000000000000000000000000000AFAF9D00F5F5E600FFCC4300FFEE
      8700EBD28400F5F5EE00F5F5EE00F5F5EE00D2D2C000F5F5EE00F5F5EE009090
      7F00FFFFFF0091918000CECEC600FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E5E5E500CC996600FFFFCC00FFFFCC00FFFFFF00CCCC
      990099330000CC9999000000000000000000000000000071E4004EA2F8001986
      F600CAE3FD00CAE3FD005FAAF900FFFFFF00CDE5FD003293F700FFFFFF00E3F0
      FE001A87F6004EA2F8000071E40000000000000000000000000099999900CCCC
      CC00CCCCCC009999990099999900999999006666660066666600000000000000
      000000000000000000000000000000000000B2B2A100F6F6E900FFCC4300FECB
      4200EBD28400D9D9C800D7D7C500CCCCBA00C2C2B100ACAC9B009F9F8E009797
      8600E6E6E200FFFFFF0099998800D1D1C90000000000CC996600FFFFFF00E5E5
      E500E5E5E500E5E5E500FFCC9900FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFF
      FF00CC996600000000000000000000000000000000000071E4002E91F7001282
      F6001A87F7005FABF900E5F1FE00FFFFFF0070B4FA0062ACF900FFFFFF00AFD5
      FC001684F6002E91F7000071E40000000000000000000000000099999900E5E5
      E500CCCCCC00CCCCCC0099999900999999009999990099330000663300006633
      000000000000000000000000000000000000B5B5A400F7F7EB00FFCC4300FFEE
      8700EBD28400F7F7F100F7F7F100F8F8F300E2E2D700FCFCFA00FEFEFD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A1A1900000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFCC9900FFFFCC00FFFFFF00FFFFCC00FFFFCC00FFFF
      CC00CC996600000000000000000000000000000000000071E4000E80F600047B
      F500FFFFFF00FFFFFF00FFFFFF00AFD5FC000A7FF500CAE3FD00FFFFFF0062AD
      F900097EF6000E80F6000071E400000000000000000000000000000000009999
      9900E5E5E500CCCCCC00CCCCCC00999999009933000099330000993300009933
      000066330000000000000000000000000000B8B8A700F8F8EE00FFCC4300FECB
      4200EBD28400D9D9C800D7D7C500CECEBC00C9C9B900B6B6A500ADAD9C00A7A7
      9600E9E9E500FFFFFF00AAAA9900D8D8D00000000000CC996600FFFFFF00E5E5
      E500E5E5E500E5E5E500FFCC9900FFFFCC00FFFFFF00FFFFFF00FFFFCC00FFFF
      CC00CC996600000000000000000000000000000000000071E4004CA1F8001785
      F600FFFFFF00CEE5FD0074B6FA001A86F60097C8FB00FFFFFF00E1EFFE001F8A
      F600499FF8004CA1F8000071E400000000000000000000000000000000009999
      9900FFFFFF00E5E5E500CCCCCC00993300009933000099330000993300009933
      000099330000663300000000000000000000BBBBAA00F9F9F100FFCC4300FFEE
      8700EBD28400F9F9F500F9F9F500F9F9F500D2D2C000F9F9F500F9F9F500AFAF
      9E00FFFFFF00B2B2A100DCDCD400FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFCC9900FFFFCC00FFFFCC00FFFFCC00CC99
      6600CC996600000000000000000000000000000000000071E40078B8FA003293
      F7002F92F700479FF8007BBAFA00D3E8FD00FFFFFF00F8FBFF0059A8F90058A7
      F90078B8FA0078B8FA000071E400000000000000000000000000000000000000
      000099999900FFFFFF0099330000CC6633009933000099330000993300009933
      000099330000993300006633000000000000BEBEAD00FBFBF400FFCC4300FECB
      4200EBD28400D9D9C800D7D7C500D4D4C200DBDBCD00D0D0BE00CFCFBD00BDBD
      AC00B8B8A700BDBDAC00FFFFFF00FFFFFF0000000000CC996600FFFFFF00E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500FFCC9900FFCC9900FFCC9900E5E5
      E500CC996600000000000000000000000000000000000071E4009FCCFB004DA1
      F800FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6F2FE0071B4F9006EB2F9009FCC
      FB009FCCFB009FCCFB000071E400000000000000000000000000000000000000
      00009999990099330000CC66330099330000CC66330099330000993300009933
      000099330000993300009933000066330000C1C1AF00FCFCF700FFCC4300FFEE
      8700EBD28400FCFCFA00FCFCFA00FCFCFA00D2D2C000FCFCFA00FCFCFA00CDCD
      BB00FCFCF700C1C1AF00FFFFFF00FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CC996600000000000000000000000000000000000071E400BFDDFC006FB3
      F900FFFFFF00EBF4FE00D1E7FD00A4CFFB0075B6F9009CCBFB00BFDDFC00BFDD
      FC00BFDDFC00BFDDFC000071E400000000000000000000000000000000000000
      0000000000009933000099330000CC66330099330000CC663300993300009933
      000099330000993300009933000099330000C3C3B300FDFDF900FFCC4300FECB
      4200F4CE6200EAD18300E8CF8100E5CC7E00E3CA7C00E1C87A00E0C77900DEC4
      7700FDFDF900C3C3B300FFFFFF00FFFFFF0000000000CC996600FFFFFF00E5E5
      E500E5E5E500E5E5E500E5E5E500E5E5E500FFFFFF00CC996600CC996600CC99
      6600CC996600000000000000000000000000000000000071E400D9EBFE00A3CE
      FC0092C6FB009DCCFC00A7D1FC00BADBFD00D5E9FE00D9EBFE00D9EBFE00D9EB
      FE00D9EBFE00D9EBFE000071E400000000000000000000000000000000000000
      000000000000993300009933000099330000CC66330099330000CC6633009933
      000099330000993300009933000099999900C6C6B500FEFEFC00FFCC4300FFEE
      8700FCC94000FBEA8300F9E88100F6E57E00F4C03800F1E07900EFDE7700EFBB
      3300FEFEFC00C6C6B500FFFFFF00FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC996600E5E5E500CC99
      660000000000000000000000000000000000000000000076AC00C0DDFA00ECF5
      FE00ECF5FE00ECF5FE00ECF5FE00ECF5FE00ECF5FE00ECF5FE00ECF5FE00ECF5
      FE00ECF5FE00C0DDFA000076AC00000000000000000000000000000000000000
      00000000000000000000993300009933000099330000CC66330099330000CC66
      330099330000993300009999990099999900C8C8B700FFFFFE00FFCC4300FECB
      4200FCC94000FBC83F00F9C53D00F6C23A00F4C03800F2BE3600F1BD3500EFBB
      3300FFFFFE00C8C8B700FFFFFF00FFFFFF0000000000CC996600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC996600CC9966000000
      0000000000000000000000000000000000000000000000CB0B000076A8000071
      E4000071E4000071E4000071E4000071E4000071E4000071E4000071E4000071
      E4000071E4000076A80000CB0B00000000000000000000000000000000000000
      0000000000000000000000000000993300009933000099330000CC6633009933
      000099330000CCCCCC00CCCCCC0099999900CACAB900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CACAB900FFFFFF00FFFFFF0000000000CC996600CC996600CC99
      6600CC996600CC996600CC996600CC996600CC996600CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000099330000993300009933
      0000E5E5E500E5E5E500CCCCCC00CCCCCC00D8D8CB00CBCBBA00CBCBBA00CBCB
      BA00CBCBBA00CBCBBA00CBCBBA00CBCBBA00CBCBBA00CBCBBA00CBCBBA00CBCB
      BA00CBCBBA00D8D8CB00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000CC66000099330000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E2EFF100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099330000CC66000099330000CC66000099330000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000066
      990000669900006699000000000000000000000000000000000000000000E2EF
      F100E5E5E500CCCCCC00E5E5E500E2EFF1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080000000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009933000099330000CC66000099330000CC660000993300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006699003399
      CC003399CC0066CCFF00006699000000000000000000E2EFF100E5E5E500B2B2
      B200CC9999009966660099666600B2B2B200CCCCCC00E5E5E500E2EFF1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009999990099330000993300009933000099330000999999000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000006699003399CC000066
      990000CCFF0066CCFF000066990000000000E5E5E500CC99990099666600CC99
      9900CC999900FFFFFF00996666009999990099999900B2B2B200E5E5E5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFFFFF00FFCCCC0066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000006699003399CC000066990000CC
      FF003399CC0066CCFF00006699000000000099666600CC999900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600336699003366990033669900E2EFF1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFFFFF00FFCCCC0066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000669900006699003399CC000066990000CCFF003399
      CC0066CCFF0000669900000000000000000099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660066CCCC0066CCCC000099CC00FFFFFF00FFCC
      CC00000000000000000000000000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFFFFF00FFCCCC0066666600000000000000
      0000000000000000000000000000000000000000000000000000006699000066
      990000669900006699003399CC003399CC000066990000CCFF003399CC0066CC
      FF000066990000000000000000000000000099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660066CCCC0066CCFF003399CC00FFCCCC00CC66
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFFFFF00FFCCCC0066666600000000000000
      000000000000000000000000000000000000000000000066990000CCFF0000CC
      FF0000CCFF0000CCFF00006699000066990000CCFF003399CC0066CCFF000066
      99000000000000000000000000000000000099666600FFCC9900CC999900CC99
      6600FFCCCC00FFFFFF009966660099CCCC0099CCFF00B2B2B200FF660000CC66
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFFFFF00FFCCCC0066666600000000000000
      0000000000000000000000000000000000000066990000CCFF0000CCFF003399
      CC0000CCFF0000CCFF0000CCFF0000CCFF003399CC0066CCFF00006699000000
      00000000000000000000000000000000000099666600FFCC990099666600FFFF
      FF00FFCCCC00FFFFFF009966660099CCCC00C0C0C000CC660000CC660000CC66
      0000CC660000CC660000CC660000000000000000000000000000000000000000
      0000000000008080000080800000808000008080000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600666666006666660066666600000000000000
      0000000000000000000000000000666666000066990000CCFF003399CC0000CC
      FF003399CC0000CCFF0000CCFF0000CCFF0066CCFF0000669900000000000000
      00000000000000000000000000000000000099666600FFCC9900CC9999009966
      6600FFCCCC00FFFFFF009966660000000000CC660000CC660000CC660000CC66
      0000CC660000CC660000CC660000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066666600666666000000
      0000000000006666660099999900999999009999990099999900666666000000
      0000000000000000000066666600666666000066990000CCFF0000CCFF003399
      CC0000CCFF003399CC0000CCFF0000CCFF0066CCFF0000669900000000000000
      00000000000000000000000000000000000099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660000000000CC999900CC660000CC660000CC66
      0000CC660000CC660000CC660000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000000000
      0000000000000000000000000000000000009999990099999900999999006666
      66006666660099999900CCCCCC00CCCCCC00CCCCCC0099999900666666006666
      66006666660066666600CCCCCC00666666000066990000CCFF0000CCFF0000CC
      FF003399CC0000CCFF003399CC0000CCFF0066CCFF0000669900000000000000
      00000000000000000000000000000000000099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600CCCCCC00E2EFF100CC999900FF660000CC66
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      00000000000000000000000000000000000099999900FFFFFF00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00999999009999
      990099999900CCCCCC0066666600000000000066990000CCFF00006699000066
      990000CCFF003399CC0000CCFF003399CC0066CCFF0000669900000000000000
      00000000000000000000000000000000000099666600FFCC9900FFCC9900FFCC
      9900FFCCCC00FFFFFF009966660099CCCC000000000099CCCC00FFCC9900CC66
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000000000000000
      00000000000000000000000000000000000099999900FFFFFF00CCCCCC00CCCC
      CC00FFFFFF00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009999990000000000000000000066990099FFFF003399CC000066
      990000CCFF0000CCFF003399CC0000CCFF0099FFFF0000669900000000000000
      00000000000000000000000000000000000099666600CC999900FFCC9900FFCC
      9900FFCCCC00FFFFFF0099666600CCCCCC00000000003399CC0000000000FFCC
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800000000000000000000000
      00000000000000000000000000000000000099999900FFFFFF00FFFFFF009999
      990099999900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009999
      990099999900000000000000000000000000000000000066990099FFFF0066CC
      FF0066CCFF0066CCFF0066CCFF0099FFFF000066990000000000000000000000
      00000000000000000000000000000000000000000000C0C0C000CC996600CC99
      9900CCCC9900FFFFFF00996666000099CC000099CC000099CC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999000000
      0000000000009999990099999900999999009999990099999900999999000000
      0000000000000000000000000000000000000000000000000000006699000066
      9900006699000066990000669900006699000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CCCC
      CC00CC9999009966660099666600000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000A00000000100010000000000000500000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F81FFFFFFFFFE1C0E00780038003C0F0
      C00300019FF38070800100019C738040800100019C738061000000019C738073
      000000019C73C0FF000080039FF3E187000080039FF3FF030000C0078003CE01
      0000C007EBAF86018001E00FE92F02018001E00FE44FCE01C003F01FF39FCF03
      E007F01FF83FC387F81FFC7FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFC003E007
      F3FFFFFFC003C003E1FFFFFFC0038001C0FFFFFFC0030000807FFFE7C0030000
      803FC1F3C00300008C1FC3FBC00300009E0FC7FBC0030000FF07CBFBC0030000
      FF83DCF3C0030000FFC3FF07C0030000FFE3FFFFC0078001FFF3FFFFC00FC003
      FFFFFFFFC01FE007FFFFFFFFFFFFF00F8000FFFFFC3FFFFFBE3EF01FF00F03FF
      B006E00FE00700FFA002C007C00300FFA00280038001007FA00200018001003F
      A082000100000007A002000100000000B006000100000000B006000100000000
      B006000180010000BE3E000180010000BFF08003C0030000BFF5C007E0070000
      BFF3E00FF00F00008007F01FFC3FFFFFFFFFFE7FFF3FFFFF83FFF83FFE3FBFFF
      3CEFE01FFC3F9FFF7F4F800FE00FCC3F7F8F0007C007E01F7F0F00038003F01F
      3E0F00010001E01F9FFF00000001E01FFFF300000001E00FE0F980010001E001
      E1FDC0010001F000E3FDE0000001FF00E5FDF0010001FF80EE79F8078003FF80
      FF83FC1FC007FF81FFFFFE7FE00FFFC38000F83FFFFFFFFF0000F01F0000C007
      0000F01F000080030000E00F000000010000C007000000010000800700000001
      000080030000000000008003000000000000800300008000000000030000C000
      000000010000E001000080010000E0070000C0030000F0070000E31F0000F003
      0000E31F000FF8030000F39F861FFFFFFFFFFFFFFFFFFCFFFFFFFFFF000FF87F
      FFFFFFFF7FEFF07FFFFFFC3F482FE07FE007C0037FEFC03FC003C003482F803E
      C003E0077FEF001CC003F00F7F6F0008C003F00F4E2F0001C003F00F44048003
      C003F00F60008007C003F00F0000800FE007F81FF800C01FFFFFFC3FFC00E03F
      FFFFFFFFFE04F07FFFFFFFFFFFFFF8FF0000FFFFFFFFFFFF0000FFFFFFFFFFFF
      0000FFFFFFFFFFFF0000FFFFFFFFFFFF0000E007E007E0070000C003C003C003
      0000C003C003C0030000C003C003C0030000C003C003C0030000C003C003C003
      0000C003C003C0030000C003C003C0030000E007E007E0070000FFFFFFFFFFFF
      0000FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFF880013FFF00008000
      80010FFF00008000800183FF00008001800180FF000080038001C03F00008007
      8001C00F000080078001E007000080078001E003000080078001F00100008007
      8001F000000080078001F800000080078001F8000000800F8001FC000000801F
      8001FE000000803FFFFFFF000000FFFFFFFFF81FFFFFFDFFF83FF81FFFE3E0FF
      F83FF81FFFC1801FF83FF81FFF81001FF83FFC3FFF01001FF83FFC3FFC03000F
      F01FFC3FC007000FF01FFC3F800F000FF01FFC3F001F0001F01FFC3E003F0101
      F83F981C003F0101FC3F0000003F000FF83F0001003F008FF83F0003003F00AF
      FC3F0007807F803FFC7F981FC0FFE1FF00000000000000000000000000000000
      000000000000}
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmr1Timer
    Left = 648
    Top = 96
  end
end
