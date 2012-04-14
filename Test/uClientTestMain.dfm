object ClinetTestMain: TClinetTestMain
  Left = 0
  Top = 0
  Caption = #23458#25143#31471#27979#35797
  ClientHeight = 472
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 699
    Height = 472
    ActivePage = ts1
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = #25191#34892#26597#35810#65306
      object DBGrid1: TDBGridEh
        Left = 0
        Top = 0
        Width = 691
        Height = 403
        Align = alClient
        DataGrouping.GroupLevels = <>
        DataSource = DataSource1
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghColumnResize, dghColumnMove]
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        SortLocal = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object pnl1: TPanel
        Left = 0
        Top = 403
        Width = 691
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          691
          41)
        object btn_Open: TButton
          Left = 607
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = '&Open'
          TabOrder = 0
          OnClick = btn_OpenClick
        end
        object edt_Sql: TEdit
          Left = 8
          Top = 10
          Width = 585
          Height = 21
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 1
          Text = 'select * from '#32467#31639#23545#24080#34920
        end
      end
    end
    object ts2: TTabSheet
      Caption = #25191#34892#26356#26032#65306
      ImageIndex = 1
      object pnl2: TPanel
        Left = 0
        Top = 403
        Width = 691
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          691
          41)
        object btn_Execute: TButton
          Left = 601
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = '&Execute'
          TabOrder = 0
          OnClick = btn_ExecuteClick
        end
      end
      object mmo1: TMemo
        Left = 0
        Top = 0
        Width = 691
        Height = 403
        Align = alClient
        Lines.Strings = (
          'mmo1')
        TabOrder = 1
      end
    end
  end
  object edt_Url: TEdit
    Left = 152
    Top = 0
    Width = 539
    Height = 21
    TabOrder = 1
    Text = 'http://210.35.24.18/ZsbBm/Srv/zsbbmwebsrv.dll/soap/iAdmin/'
    OnChange = edt_UrlChange
  end
  object HTTPRIO1: THTTPRIO
    URL = 'http://localhost/NetPay/NetPayWebSrv.dll/soap/INetPay'
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soUTF8InHeader, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 160
    Top = 48
  end
  object SoapConnection1: TSoapConnection
    Agent = 'Borland SOAP 1.2'
    URL = 'http://localhost:1024/NetPayWadSrv.NetPay/soap/INetPay'
    SOAPServerIID = 'IAppServerSOAP - {C99F4735-D6D2-495C-8CA2-E53E5A439E61}'
    UseSOAPAdapter = True
    Left = 120
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 272
    Top = 48
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#25805#20316#26085#24535#34920
    Params = <>
    Left = 240
    Top = 48
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 48
    object mi_save1: TMenuItem
      Caption = 'save'
    end
    object mi_open1: TMenuItem
      Caption = 'open'
    end
  end
end
