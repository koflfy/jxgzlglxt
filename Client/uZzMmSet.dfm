object ZzMmSet: TZzMmSet
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #25919#27835#38754#35980#20195#30721#35774#32622
  ClientHeight = 383
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object DBGrid1: TDBGridEh
    Left = 0
    Top = 50
    Width = 552
    Height = 292
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = DataSource1
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh]
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    ImeMode = imDisable
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OddRowColor = 13823456
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
    PopupMenu = DM.PopupMenu1
    RowDetailPanel.Color = clBtnFace
    SortLocal = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    Columns = <
      item
        EditButtons = <>
        FieldName = 'Id'
        Footers = <>
        Title.TitleButton = True
        Visible = False
      end
      item
        EditButtons = <>
        FieldName = #21517#31216
        Footers = <>
        Title.TitleButton = True
        Width = 380
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = #26174#31034#39034#24207
        Footers = <>
        Title.TitleButton = True
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pnl_Title: TPanel
    Left = 0
    Top = 0
    Width = 552
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object img_Title: TImage
      Left = 0
      Top = 0
      Width = 300
      Height = 50
      Align = alLeft
      AutoSize = True
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000012C00
        0000320806000000E6D6E62A000000097048597300000B1300000B1301009A9C
        1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB5193000016FC4944415478DAED9D09D6E4B60D84015E29B9
        4672C7F8A2CAB444005F81EC71EC3CC751423D7BFEEE16C5054BA1B889FE97BF
        FFE37273FBFCF7B9EE3F7EFFF2F963D7FCCDFD49E0F3865FD7F35B3EF77C8EE7
        2C9E89DFE4FEE7C375271C56699FE79EBF5AE6FCCDAB7E9F0F03E9E3EF988DC8
        FCA20CAFFCC62CFF7327F3F5A78EF1F96E63941B65A05E51F6189F7B57D5BB3D
        B3CB638CA897CF72AE791FED9C9F07E4EEB34ED19E4FD9D4D50879C76FA3FD45
        FEC3551F525EFC3EFCFEEE901F655EF9326FAFF2A5FD33BDB32E97A61F51F6D3
        461F96DF359DCAF763A54F5DA20DB6D1076466AE3A8FB2FAF3B39C6E838FCC59
        F72BF560D437FD25747FDD0608FB8E67CB0E4CEA5F75173F8A34563232A60B1F
        8BBA5F863ADA6B2FFFEB0FC08A5626185C0A0EB74260B4D96628C2AF000EABDF
        982FC1C0CA112D412640C835BD85821514088EEE65AC2BE84D4798EA7D8CB0F2
        183090312C7F631BC2B9EE341315595ED4BF3B12CB0B6319E2E89E86357A1B12
        207C01DD708831331C081023403A1CD967BBACEE15F0CCFC4639E020D8DFF7C7
        0A86F25765E1A1DBB84F5013A04340F172F81B2417FD10F4A81383BCEAB9FA6D
        3CEDB2D2D9908084007BA745F09AFA28FB5C6D266C33836ED4CDD6320200D30E
        695F465B6B9FBB3F856C02309B5FC29590B63D9FFFBCEFFA0158BF5C57082550
        FE0A742E055D8CC63F8475E567080346CBE8311EF14E87790AAE48EEA9F83B39
        0165FE4C30CD289B8A52E38AFA2518D8250E446348A0212BA1C376676C5174CC
        44E970F1FBA706C39A03B13D93B964591565CBA11EB0D0685FF518AD2EDF1892
        B68D6CEF02E351E6552CC2007204AD1E245A1D6643973287E9E7F6BCE1796F7A
        B19E8FADCF957C8632A0064C0F7BBB52D029736BF2125B2493BF9A0C1EC3DDB2
        A10662BD2D498C902E03286D1F3E41FD144EC5F7F2DB8759956D1A82FE5B2F5F
        BA84411FC7B5D04C613DC9BC1809205049CBDF343AA812568048B627AC6A9AC3
        28C360F7C2A6E2C4A0ADF2500605301905408FB1A14BF551FC98DD38446B8BFB
        0BDBE8ED8363445406C07D7E18A8EBC836EEBB8B021EC25CD4D907DB184C6DEC
        00E7AA7C4D812AF25D185A82AC02F63600246015000DD4DFA62E859DF1F9CEEC
        248FD29F00C6F0D59E4C41FD963BE460909FA6F54C5F817BB5CD947163A00562
        2148743DD347E04BC8235291713D79A2D7518E077046FEB07F33F8F6CBAEA74B
        58B05EC2201825ABF9C1ACBC28B0B90ABB04DD68332365530E81F0FE2446B702
        414638F36614A6DF8375D9D58C7D022DA22359803216D26E650FD1BE3141E501
        9790536313DD1986763308A0D905FC02E07B5080E3FE0C3444EED1A5FC095BCA
        6777A03181CA1CED9C009B693B6855FBC3E1C6265DC8A182DB7882880424A6AF
        E051F28BBAC1CEC6AE3EB095095ED93368E098638D59FF6E779BEE9D954CEF60
        184EE20D3893A935FFA20F59D9A261BC2B0189ECA905E3F2318CB7BDF0BABB84
        CFA7A96053B61382E0009E4D16E6DE061BA72EAE06500E654BBEF377DB28D7A1
        940E7A3AC612065E4A91486A304A28B122F005C328166017A87F44EA7886CE61
        0518D6C66B083C052805E6E994D3F9AA2B8488EC55668002BB0A31C614FF8F39
        5032C6A6ED5D0E005E19FFB2D916005B06AE1624B26E97CF4900131DAD635DBD
        1B58B289FCACE9687CD173322C5BEB26CC28EBBF1B139BB63C9ACC2117696F80
        1B4129F36A4025652328422FE15A1CF49FE69E20D799B419CA447EC9B028939C
        36E33395F66DD7EC1246E3A221970A270C064254EA4A053F3F0CBBF2A60E0E86
        2AAD229A184A095322D016B0081E8C701DB8AA8E696069E0058A8CD6C22C39BE
        005012C041BDD230B3BBB1FFDDC0E0387B55B398938D6D804E40166094CFCA38
        4E397EB191621086E73B98FB18D25E610609F22A935021D9D402621CC3CAF208
        4C0C6A9B417F61A55640CBF4A600B832C2D59616761A75400090F64DDBE45041
        B707633B1370585FAD57F71309CE8B2FEA7DFAE3C580CFB291C7DBAE1F80F5CB
        95284C25580145B496E0606D9A940644E1959373CAB62295B034EB20A503F5E1
        1CF7407AAB2F014A229D77674139A6CE67B34E31263336CF5B8048283D0007A0
        38102DE9CC8F738D106702C448436D03C50B3BD1DFC6AC8BB663883C7A1DB834
        415958032C47F7CE5C1862078D5D77F319D46FA0993A675A5BF228D0512795F4
        6DBC8EACE91E56F7CB2400993516B502BEB16E69470A22EBCC5C63EE1DD068EF
        65FE696B398B6C90AFB5724CF3085FB8DCA48B1933F59FFFA3BFE4B86FFDB717
        5E39E84EAA190D8BF11FA196341A7C4F815B39A776012F897AA5B81D73B28DA2
        C99E30A00E0613E31DE1242C4B06C167E4116089B419D9D4611370329206486D
        9C3299477308E778550CEE8F9CE028D636EB303AAB22E30859A8EC1690DD3119
        82471FD4DF002DBB659D2D0BAB9BF9ECBBA300812588805DC88406BBDA3A2920
        0108E0BDEFCA79E5E560B0B33D669D19F2B91E742600065A387B09AD8B485D36
        BF90004B3FE8F62F79C2FFB2B2F5DDEB218052B66232393CFBC26B598755EDA0
        B0630A184000852EC2F4124A19A1E139434444F46A0AA9F553652875DF85822F
        8B059947826A630AB65B5FC4E8B6464FED6622AA339F701E00EADD45C6424C61
        7F0360D323F6D07117195C0F79A693F7B6746645599B74F7022CF7CF13587EC2
        FAC018B6E3660D481F006F8015A01D72A1AC7A59D1F5F51A24376B651AF49DE5
        A90D28FBF6A5BE3DCFF53BD853E809861CC196E37604A95CCE238B4A577FB8DC
        C546A21EE1A570474B92116DB9AA8BC8E7DE76DD5DC25440FEFAFC33BCBE934A
        5231481E6283312843F3F016BB1A586D9C5880ACDD1363DB184E772618478F66
        C53EE02C9820181803F95C3A753E01A51B7AA4C794B9655A054B89B4C2926E0D
        64FEABAC0A14ABCB167AE940538045E71716E36D6C6C07C609C4C596A46BEE18
        B0DFAD83E232918D8E088ACAE0A85B7D368255D42DE598E5B5EE5DD8405FA396
        F5EEC04B193596DED99E3DBF937119BA95FE2C485CEC558013ABB6472290CF65
        8A1C5B26C8222F33AD63F12B8B89B368C71BAF1AC362236810C1B0A2A12D6A94
        001AFBC2670B3A1AEC03CB0AAA2BA1E50A604D904B870A0373555A0D4ECFBCBE
        740FC318C4F02402077845DD03C474462EBB07302AD649A87F004BACC189D5E7
        51D7A10C41DBA2CC46E4105DBECD8A7232AA8136F9F4C60423596715DD2B38B6
        ADE0977569403A923D453DFA730A6629F70E6A08883AD84F70D340421D6FD99E
        319F1EF0663ED061FF5ECC650DB23A7B493BD6FC74A2272AA14139C7A52CEA1C
        3243198D6505536390679AF2EB6AC31BAF670C2BBCD81E07B95C1BCA19AD7C70
        233433759A45404305493A5B0CEA126395B18F5A6E3F572B03141DB32E91DE50
        0F01108311AE009340D400AB000A40200CA339B6382C0C78B4B1AC58F7833551
        666422CDE117E0E86DD72EDA6EDC87E389AC8BEEEFFB360930C169F47CB130D5
        66C0F806448E6D58D1765BE56891CF76C1A6ADF5933576082E6087B1D6AACF4C
        065315C06941385C65DB2B081B15E6097B37CD8FB2A3ADA71EE83B0280C8A75C
        B79E074188DBE5E3EAC76FBBEE31AC6B019E12402AEB2AE54C912820F555B711
        CD9A8087D7BD04366B86D50DC568181539776C6BA08E326D6F34B232B0547494
        2969BBD18F1F8E158BFB006241F74D1D5A1C4FA2F0F5CC1662E1646774CB547D
        9B0090ED2FB9A25B17C1F6ED2FCA16E6DF650373312513B08BFF8732BB0D786A
        20D8A4D9302F323E1DEB69C123C040F61462ACE6F3F752BD110846EF3612701C
        8085DF6CD125DA278CE76A7A66DEACC73D5895AC69ED8D6C58D2BC97BB2BE0AC
        29834BD346B93963E851F6AB19D62F5781140060CE1EF16D0D1DCD6BBD5600D6
        4C800DA1C99A04E056F0506ADCBA85564AFD18F405852E83E169CC9A46001286
        C948184E1EA0B163184FF32EE4E36B3EBD7DCD28751FA1153061F03CC7D1C080
        FCF1E8E9D84F3D0706AFCB690B70D501BDC6BD50F772569545CA68C3A4F6C0CC
        AE65742BDB1B19167023C0624FA5014C04EC3620FB18067A026076122CBD8214
        025FD8B0C5FE4A09BCEB5B302A007BAEC0171B621AFC5681EF6EC44CDF7653C4
        B3002AF11D69D3BA18BB13012115FF2B7B091F3DAF7DE3104E18EBB407134625
        0A0CA5169D4D455FBAA29C822F25D2510280ACEDBDD2A8BDB29AA9C804125BC6
        610C06B9467A3ADD0A3C59475912D18061E79C5137B09681B68F74701340EDA0
        276351569F4D1CAD757F3A90B2CD8D09D566EBB6B420D30633AB6797D7DAC467
        590F8745B4634D9BF7FB6B5E3AF013680014BB15FB5D763E0D2A82699F152DDB
        D29EC2BAFC45FD448264B681A066C57A30669B5DB3AC9FF652C256C9D2F2B3C5
        3F26750D799841F64C0B9F7DE3559B9FB3BD012657130E68644CC1764597CC4A
        F0E958D8DB85741CF88E745DA1054488529D5588E2CBA8598F6EC41C9CBF07F5
        473957A7FC956FB1CA5A8DBE770E29178EBDAEADC254BE385103D6DEC50B601E
        C1A69EF9F1651C663B6BC77B0DB867FB82BD6D99D1EDC8A5D385C97590A44E5C
        5F63F380C0FA86850C38BD4DDF964E64DE3368C97BA76C8E93F96233B9D15CF2
        AAEEFED3DB78964F784B9B800419F54033AD70FA8DD7DED3C5577604A0FC2BCB
        300DCAE9A30950935078960C02F1FA2EE1666B4E8ED711B418456CAEB2658428
        C1AAF03AC0209D3024804E008271DC06755980B214B4BC982EDA46235C22EACA
        36082C59FFEE805E6D9781EF4D9EF2FCA445BDDBB3AC239ACEF9539664863D7C
        BDCBD60144BB5F322686594BF75A295E4034444F1F8059DED14540F906746453
        1B402F7D5DC2C80A18C058F89C0419CB755E643D1510DA9B36663BBE2D4F01D1
        59032541817A0692309FB019066F0125BECC31BD94752F021065A4FD5BB0B451
        F642676F20F8C6CBFFF2B7CF2C211A32D128D78CC4CCC75CF85860C42E616357
        9D52DFF942C05F98931A8D41213014796FD01A613B430A45651EDCF01CF70824
        8B032A7844DE63BEBF2B66F64CF22A301690431BD9BDEA2C86DDBE6FF76EA09A
        95FCBE5873C312517EBCA94106B59379691D99E7C80589607B096C1B8717B05C
        D344A09160B1612ABBEE369F35DB754F59CE669F68D3953253DAE23E50661793
        A0120181366801FABA8448EAD2F253202C7F5A40F4AAB61901AB130EBE2BEBCF
        469EDF79CD85A3BA862A4595CA31E902CA38D145811260005E1098B01383E141
        618EF21548F4735FC6404362F4A3E3C7A2C63111218DDF1424B83E4A9812F296
        57C144D9ECD2624333BBA1E294D3B8E53D5B9BC5A9DACD6A8E3B4A06C5324601
        0FDBE390C7C28266FDE5DE17F6248EED00D0FEFEAE95DD8553B24CD15307306B
        A02832EDBADE2C6BA0CD80E569DBA943652E4B37D768EFDFBA846A0B26B61DE9
        005CEDC5950E7D157011EC568697FE6A25C7C0B32175FEB361E7F75F73E1687C
        5365B8084015CFCDCF0BD5F4BE35A1229E89613C9FD359D9BFBF6FB82AF8F929
        B728ECE8B844F259A98110A88E5BF52E075470941703CEDF8A4D907554BE8BA3
        4B142F6014E3DE8052BDE665D3BD8A7AEC989099CE7611601270AE56AEE6D165
        336697D0226F9151A41BDAD5F2B54D2A1BCFBAEA331B50F43E11A15B72147054
        9F0224BE0F580276A293B27309329435C127D3ACEB09B37EE2239825A4CDB33D
        70CEDA7DE24598BCD247DDC2D5C22FB8C21E2F9C79DD550B47650D870256393B
        16A3EDD265248AED898D2904E27B8194E1F7FBDB97BD544AE75BDE41CFA1FC15
        780204D521FA4AED32B83E9D5F0E9EED34DB330E719672026E8D595ECFBC00C0
        2CA36D8C66E4E42111E594FAB609C778C6FA8A960E6C908BA37E1D34EE7A3556
        07DDE57BEFC5A1638CAABA5BF9DC04BBFE1A6882F9B2FCA4015EE876D00EDB4B
        14590743DD338099AEE70ADD9341D33E382E4A1B59023EE46DBB74B485723725
        0209AA705E32450B30C2A4903C9B9EFC6A96F52C6B10E78FB64C008826DEBFD7
        AC9021BD19155FCF97C2D470233AD460EAAFBF0FA88F1385CCFB40A930BA19E9
        F80684FBBFF9D236ED1A71868A7B2057669311CDFDAB63F728DDEBCFFD8231DB
        B6BC333DC0C7CA9997ED3FAE2FE15326538024FB058D8C2500A1F21DD8BAE3AD
        3E02AC3B169580B46186D4A57312E201ACFEFAE13AF063A703EDAEA55E97D7D9
        94EC6556D61CEC34FEE2FDE7695F0005023D01954194362F2C55D95C07333304
        45B7768602D28ADF21FF870AA4CD56A00F9F7AEE531E6FBC6459433125004718
        B2D5BDB14B2F8285B2F279462FA27C45B604802CC7CA80F87A9A1EB13E7F39EB
        C688BA3873945D27D5F0FE935544D2C84BEF2958EDF6FB295B637ABDAF0E3F24
        9D3A04D94B3AC88ED9F5ED300D48D7B56CBDECEEA00EB05487AFAE9CCDEE3C80
        36DB87AE279C53F607C69212C8B16F8D5ADE3726C14DDFC22000B2D963694D26
        5B5BF9D98C32836AFAC36A5FA267FA0E03224F63CA204E10521BCB3FB85F40B9
        3B7A0F4B31D2B7DF7BCD57242B325B3FB2CBE8405662AAFD3A5FA9AC3C9F8A08
        25765604C3C8EF8DA2F745830128B13914632D351B17E55DC6C5991AB9E3BEBE
        002FCACC7A7590B002861172D9741393BD44FA59873E13A86F4CD84CB52FC0F3
        8CE5AC6F217DD649B9FCCEFAB66515CBEA71ED52C5EAFB6ADFF8027E7D905AEB
        4DC04AFB08006C206A9095C886FA718C0746DDAE56A7690C03E0E04DEE4F7BB1
        F66ADAB3CCA8828D49304739154C0824F35E5FBFC8C00B7B0A455577D1967223
        88472AD93B08DF05D59040FAD6CBCF41AA86BCB5BBB7824ED58B6FED3C07A976
        D0DAFC1EF570D6E51CA47A0E52FD6DD739481506720E52D515E8CFFD7390AA04
        3CD84CD86606DD3691B03028EE63A47D196DAD7DEEFE14B23907A94E519E8354
        C1CE9A33B6287A0E52EDE005B98E4D999CB5EBE0CE729ADC16E6D2667A3BF89C
        8354E10BE7205532867390AAC5FD856DF4F6C13186EBACDCCC93E359E7205505
        E885D9491EA53F018CCD920D3305F57390EABBAE7390EA3948F53B5BCA6777A0
        B12E4779DA760E52A5DE52E7C19AC249BC016732B5E65FF4212B5B3C07A99E83
        5485059C835415D83270B520710E52852EF83A1DEB652328422FE15AE720D57F
        ED3A07A99E8354CB21C8766220FE1CA46A313101D35C18D53948F53F739D8354
        E17C36EB740E520D273D07A9268B69406659B7C6DC3BA0D1DECBFCD3D6CE41AA
        BFED3A07A9F6289F914D1D360127236980D43948F51CA45A765EB6DF825CF30B
        09B0F4836EFF9227FC2F2B5BDFBD1E0228652BEC1CA46A14500733CB28720E52
        F573906ACF0FEFA2D7498F5A8B770E52557F3807A9DA3948B5D8079CE51CA42A
        6D3907A9AEC303E720D53FE73A07A99E8354D3516B3377E5B72C0075FD7C0E52
        85EEB776ACF9E9444F544283B2BC4ADC10F059466359C1D418E499A6FCBADAF0
        C6EB1CA4BA616509440DB00AA00004C2309A638BC3C280471BCB3A07A99E8354
        8DF907A8C1770400914FB96E3D0F8210B7CBC7CF41AA2960116A44B326E0E175
        2F81CD9A617543311A4645CE1DDB1AA8E33948551D6FFBEEAE65037331A57390
        EA06B0160645C6730E52FDA3AF73906A6760093C7B86F134EF1CA4BA0766762D
        A35B790E528DDF2AF0DD8D98E9CF41AABFE53A07A92E919E4EB7024FD6519644
        6C4E8D69EDCBBA81B59C835429775B98EA6E1D9C000D80E21CA49A0E546DA12F
        F3377C7FDB750E52BDEF3DD337E7205582989F835403F0CF41AAFF35D73948F5
        0BDB20B064FDBB037AB55D06BE3779CAF39316F56ECF394895FA3A07A926A848
        702F021065A4FD5BB0B451F642676F20F8C6EB1CA4DA9C6D7540058FC8FB1CA4
        EAD2DEA54BECBD4EFDB795E548B0D830955D779BCF9AEDBAA72C67B34FB4E94A
        99296D711F28CF41AAFFD9EB1CA46A9AAFCECED9B2C8D190F73948D5A5FC7390
        AAADCFC26ECE41AAFFFE750E523513C35E667CCE41AAF3FB394855820C654DF0
        C934E720D53FE23A07A926087783B37390EA37D0B8EBD5581D74770E526D011F
        F2B65D3ADA42B99B12810455382F99A205189D8354AD40E51CA44AE7CEEEC0C6
        B17B94EEF5E77EC17390EA0358E720D57390EAAF5DE720D576FFC92A2269E4A5
        F714AC76FBFD94AD31BDDE57871F924E1DE21CA45A76790E5245FB8D40790E52
        156515FD0C433A07A9121846C865D34D4CF612E9671DFA4CE039485583C73948
        55F3531FFBFF3B48F59F5724C798B046759D0000000049454E44AE426082}
      ExplicitLeft = 2
      ExplicitTop = -6
    end
    object img_Hint: TImage
      Left = 10
      Top = 2
      Width = 48
      Height = 48
      AutoSize = True
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000003000
        00003008060000005702F987000000097048597300000B1300000B1301009A9C
        1800000A4D6943435050686F746F73686F70204943432070726F66696C650000
        78DA9D53775893F7163EDFF7650F5642D8F0B1976C81002223AC08C81059A210
        92006184101240C585880A561415119C4855C482D50A489D88E2A028B867418A
        885A8B555C38EE1FDCA7B57D7AEFEDEDFBD7FBBCE79CE7FCCE79CF0F80111226
        91E6A26A003952853C3AD81F8F4F48C4C9BD80021548E0042010E6CBC26705C5
        0000F00379787E74B03FFC01AF6F00020070D52E2412C7E1FF83BA5026570020
        9100E02212E70B01905200C82E54C81400C81800B053B3640A009400006C797C
        422200AA0D00ECF4493E0500D8A993DC1700D8A21CA908008D01009928472402
        40BB00605581522C02C0C200A0AC40222E04C0AE018059B632470280BD050076
        8E58900F4060008099422CCC0020380200431E13CD03204C03A030D2BFE0A95F
        7085B8480100C0CB95CD974BD23314B895D01A77F2F0E0E221E2C26CB1426117
        29106609E4229C979B231348E7034CCE0C00001AF9D1C1FE383F90E7E6E4E1E6
        66E76CEFF4C5A2FE6BF06F223E21F1DFFEBC8C020400104ECFEFDA5FE5E5D603
        70C701B075BF6BA95B00DA560068DFF95D33DB09A05A0AD07AF98B7938FC401E
        9EA150C83C1D1C0A0B0BED2562A1BD30E38B3EFF33E16FE08B7EF6FC401EFEDB
        7AF000719A4099ADC0A383FD71616E76AE528EE7CB0442316EF7E723FEC7857F
        FD8E29D1E234B15C2C158AF15889B850224DC779B952914421C995E212E97F32
        F11F96FD0993770D00AC864FC04EB607B5CB6CC07EEE01028B0E58D27600407E
        F32D8C1A0B91001067343279F7000093BFF98F402B0100CD97A4E30000BCE818
        5CA894174CC608000044A0812AB041070CC114ACC00E9CC11DBCC01702610644
        400C24C03C104206E4801C0AA11896411954C03AD804B5B0031AA0119AE110B4
        C131380DE7E0125C81EB70170660189EC218BC86090441C8081361213A881162
        8ED822CE0817998E04226148349280A420E988145122C5C872A402A9426A915D
        4823F22D7214398D5C40FA90DBC820328AFC8ABC47319481B25103D4027540B9
        A81F1A8AC6A073D174340F5D8096A26BD11AB41E3D80B6A2A7D14BE87574007D
        8A8E6380D1310E668CD9615C8C87456089581A26C71663E55835568F35631D58
        3776151BC09E61EF0824028B8013EC085E8410C26C82909047584C5843A825EC
        23B412BA085709838431C2272293A84FB4257A12F9C478623AB1905846AC26EE
        211E219E255E270E135F9348240EC992E44E0A21259032490B496B48DB482DA4
        53A43ED210699C4C26EB906DC9DEE408B280AC209791B7900F904F92FBC9C3E4
        B7143AC588E24C09A22452A494124A35653FE504A59F324299A0AA51CDA99ED4
        08AA883A9F5A496DA076502F5387A91334759A25CD9B1643CBA42DA3D5D09A69
        6769F7682FE974BA09DD831E4597D097D26BE807E9E7E983F4770C0D860D83C7
        486228196B197B19A718B7192F994CA605D39799C85430D7321B9967980F986F
        55582AF62A7C1591CA12953A9556957E95E7AA545573553FD579AA0B54AB550F
        AB5E567DA64655B350E3A909D416ABD5A91D55BBA936AECE5277528F50CF515F
        A3BE5FFD82FA630DB2868546A08648A35463B7C6198D2116C63265F15842D672
        5603EB2C6B984D625BB2F9EC4C7605FB1B762F7B4C534373AA66AC6691669DE6
        71CD010EC6B1E0F039D99C4ACE21CE0DCE7B2D032D3F2DB1D66AAD66AD7EAD37
        DA7ADABEDA62ED72ED16EDEBDAEF75709D409D2C9DF53A6D3AF77509BA36BA51
        BA85BADB75CFEA3ED363EB79E909F5CAF50EE9DDD147F56DF4A3F517EAEFD6EF
        D11F373034083690196C313863F0CC9063E86B9869B8D1F084E1A811CB68BA91
        C468A3D149A327B826EE8767E33578173E66AC6F1C62AC34DE65DC6B3C616269
        32DBA4C4A4C5E4BE29CD946B9A66BAD1B4D374CCCCC82CDCACD8ACC9EC8E39D5
        9C6B9E61BED9BCDBFC8D85A5459CC54A8B368BC796DA967CCB05964D96F7AC98
        563E567956F556D7AC49D65CEB2CEB6DD6576C501B579B0C9B3A9BCBB6A8AD9B
        ADC4769B6DDF14E2148F29D229F5536EDA31ECFCEC0AEC9AEC06ED39F661F625
        F66DF6CF1DCC1C121DD63B743B7C727475CC766C70BCEBA4E134C3A9C4A9C3E9
        57671B67A1739DF33517A64B90CB1297769717536DA78AA76E9F7ACB95E51AEE
        BAD2B5D3F5A39BBB9BDCADD96DD4DDCC3DC57DABFB4D2E9B1BC95DC33DEF41F4
        F0F758E271CCE39DA79BA7C2F390E72F5E765E595EFBBD1E4FB39C269ED6306D
        C8DBC45BE0BDCB7B603A3E3D65FACEE9033EC63E029F7A9F87BEA6BE22DF3DBE
        237ED67E997E07FC9EFB3BFACBFD8FF8BFE179F216F14E056001C101E501BD81
        1A81B3036B031F049904A50735058D05BB062F0C3E15420C090D591F72936FC0
        17F21BF96333DC672C9AD115CA089D155A1BFA30CC264C1ED6118E86CF08DF10
        7E6FA6F94CE9CCB60888E0476C88B81F69199917F97D14292A32AA2EEA51B453
        747174F72CD6ACE459FB67BD8EF18FA98CB93BDB6AB6727667AC6A6C526C63EC
        9BB880B8AAB8817887F845F1971274132409ED89E4C4D8C43D89E37302E76C9A
        339CE49A54967463AEE5DCA2B917E6E9CECB9E773C593559907C3885981297B2
        3FE5832042502F184FE5A76E4D1D13F2849B854F45BEA28DA251B1B7B84A3C92
        E69D5695F638DD3B7D43FA68864F4675C633094F522B79911992B923F34D5644
        D6DEACCFD971D92D39949C949CA3520D6996B42BD730B728B74F662B2B930DE4
        79E66DCA1B9387CAF7E423F973F3DB156C854CD1A3B452AE500E164C2FA82B78
        5B185B78B848BD485AD433DF66FEEAF9230B82167CBD90B050B8B0B3D8B87859
        F1E022BF45BB16238B5317772E315D52BA647869F0D27DCB68CBB296FD50E258
        5255F26A79DCF28E5283D2A5A5432B82573495A994C9CB6EAEF45AB963156195
        6455EF6A97D55B567F2A17955FAC70ACA8AEF8B046B8E6E2574E5FD57CF5796D
        DADADE4AB7CAEDEB48EBA4EB6EACF759BFAF4ABD6A41D5D086F00DAD1BF18DE5
        1B5F6D4ADE74A17A6AF58ECDB4CDCACD03356135ED5BCCB6ACDBF2A136A3F67A
        9D7F5DCB56FDADABB7BED926DAD6BFDD777BF30E831D153BDEEF94ECBCB52B78
        576BBD457DF56ED2EE82DD8F1A621BBABFE67EDDB847774FC59E8F7BA57B07F6
        45EFEB6A746F6CDCAFBFBFB2096D52368D1E483A70E59B806FDA9BED9A77B570
        5A2A0EC241E5C127DFA67C7BE350E8A1CEC3DCC3CDDF997FB7F508EB48792BD2
        3ABF75AC2DA36DA03DA1BDEFE88CA39D1D5E1D47BEB7FF7EEF31E36375C7358F
        579EA09D283DF1F9E48293E3A764A79E9D4E3F3DD499DC79F74CFC996B5D515D
        BD6743CF9E3F1774EE4CB75FF7C9F3DEE78F5DF0BC70F422F762DB25B74BAD3D
        AE3D477E70FDE148AF5B6FEB65F7CBED573CAE74F44DEB3BD1EFD37FFA6AC0D5
        73D7F8D72E5D9F79BDEFC6EC1BB76E26DD1CB825BAF5F876F6ED17770AEE4CDC
        5D7A8F78AFFCBEDAFDEA07FA0FEA7FB4FEB165C06DE0F860C060CFC3590FEF0E
        09879EFE94FFD387E1D247CC47D52346238D8F9D1F1F1B0D1ABDF264CE93E1A7
        B2A713CFCA7E56FF79EB73ABE7DFFDE2FB4BCF58FCD8F00BF98BCFBFAE79A9F3
        72EFABA9AF3AC723C71FBCCE793DF1A6FCADCEDB7DEFB8EFBADFC7BD1F9928FC
        40FE50F3D1FA63C7A7D04FF73EE77CFEFC2FF784F3FB25D29F33000000046741
        4D410000B18E7CFB519300000F604944415478DAED590B9015E595FEFA3EE7CE
        4CCF0CF39E611801C120A0AB2246D018CCFA40710902123764256625041335AB
        968F450A93A8494AD415A12A2CE8C40722910181680CC9BA6A54886090970465
        98619827CCEB3E66E6DEDBB7BBF73B7FF71D14EE6C912AAB566BD355FFEDDB8F
        BFFB7CE77CE7F5B766DB36BECC9BF677007F07F0FF1DC0C9278A57D4CD85EDB9
        85D02668203802B42D670F384381567F2D67AFAE5BEE3D166C238E5DB37EA55B
        76E1E726A847EBC2A85F5E7CB3F1EB85BF1E1440D18ABAFB0AF5C0E2A2B240B0
        40F779BDBC5A1CF0A02B49A1340D3E4A5BC4E3A8210F047C1C45412FFA5216FC
        5EC0CF7B0A79BDB3BD0D8B47AC862F30F47303904A3663E82367F7C3F2FC34F9
        9F37FD22238092E5873F99747EFE9921BF47F3788009057EECEEA1B414CC43ED
        5AA2095BE3331C63C8B15883A760CA314F983C176D3E8CB517AE2180AACF1140
        13CE7FFE9FECE30D47EB12AB6E1A9D19C08AC3912B2F2AD03B0C1BA2FDDB47E4
        E0A5E638BA9326311004EF110D7719960265933685410F8EC72DB248538086F8
        81A6C3F5A8BDF86902A8FE9B84FCCDFA5D6A3F67F6F91900346254CD1CF41F6D
        882657CFCB17F7CD0860EA5787E82373BDB8B820801D6103971505B0ACAE17B7
        8EC8C6073D29D4F799985D99A526AE6EE4F9E1B978AF3B819DB4D4FCEA6C04C9
        AD87DFDE8F35139F2280E1A72D7C5F9F816F7D672D8E1D0FE3873F988C9BE64E
        3809400346D7CC435F637D34F9F4770703504700857A2739EFA1867F34321BB5
        2D718493B40839EE150B90F3E1640A9A38011F51E0F7A08716B35CC7CEE77163
        FD61ACBE60E9DF6481E75EDC8317D67C08933C1C5A59849A55D7C12BEF700347
        2A7914A39F59400075D1E433370F0EE01A02B028BC9784B8F98C1CAC6D8CC3E7
        759CD6A3CEDBEABF4C145A0D70D10D54F2D49EA387F1C8F8874EDB077AC2097C
        7FE1EF619A26E209134B1FFD3ECE1EDDC5879922BA7A70CA68C3D75FBA0B7507
        3F2680EF0D0260F9A1C8B5938BF58E788A3EE0211D782ECB8B0839FFFC8482D3
        12469CBABEFEAFC8F3DF4F0015A73567E5EAFD78FB9D2625E8F8734663D1BDE7
        C14C75F330410CFD0461C234A298F0ECDDE8686C8A266AFE353380E2158722D3
        2715E96D74CA00B57BEB99D9D8DC924094717E564596D27C36BD3BC963C7A96D
        C5F9848420CD79A484DAE6FA9DB8AAF2E7F0F94B330ABCE5D52338D218C58F16
        8E477B7B3F963CB493DAB761908A8F3E3A1BC5F9AD4C2B0958668440C26A8E95
        B2F18DB57753395DD1C4B30B449BD6A900967F12997E49B1DEDE67C147C12615
        06D04C7FE84D99B8BE228495BB9314D099999E28E1D67293B9EC3CA44176E73B
        5876C953F0068A4E117EEB7FB560C5CA83C8CBF363FECDA351DFD087BDFBBBE8
        C4295C7EF938DC30230F9611A6E0516ABD8B2062F4B7205F12C4F4F5B7636F9D
        114D3CF783CC004A0860D625257A8CDA90A41460A60A78F89F60AE2DC9C28A5D
        092727C09558D3D2B979C00F485654F46CC14F273E4700A7D2AE666D2B7EB7B5
        1EA5C559183224A01C3541DE9BB6070F2FB9081EA38500287CB29B0022A411E9
        ECCFE34C1DB7BFF55D6CDA198A265F58989942A5CB3F8EDCF0B552FD70CC6466
        F5E0B691216C6E4BA0CFB49405C489B3E9D0866DABFF9217B2F8C3F7AB074942
        B39371F41EACC1A5251BE109E8A700F0E59462C7DE3E3CF7EC7684B234152062
        310337CC3E0B1347C5602564446025A3D47E92DAF7C11B1A02CD9B87FBB64FC5
        0B3BAAA389176FCB0CA07CD9C1C83F4F29D73F8AA6A87526B23373B04501B011
        E08B8214BAD8E7412F39233EE2F558C8650DD1472737DD67048C7E541E7A1CD7
        0F7B9700B2337939B440168E2702786AF90738D6D68BE29200962C2C82D5D54D
        C1FB552D659B86E2A4E60FC29B53C839B958BAF7522C7D6F4C2CF1D21D791901
        5412C0B72F2FD777450C64D159C5412BA5D6A1C04F9F97AFEE79BB33A992DB60
        5B381C46C7B67B51A1EFE54B83274BAFEA0DDB10E152300A827862E5614C9B92
        8DB3D00B240D0A9E726A12D7C104AC27378F40B2B1AE6E0C7EF8E6C4D8FD63EF
        CC7FF041ED541FA878F26064DE3F96EB87FA4D721F58C03CF0324B09F9FFD8F8
        3C17806467FFA0003A3B3BD1FFD67C943292C0EF3B45FB030092490A6BC25B19
        82D91E831D8E3B82A7CB7B890EA4B1E60F400B65F1D8873F3795E08A3F5C1E5B
        34EE9ECC00CA9F3C10997FE550FD4FDD4945974B8BFD68EDB7C0B4805943B354
        7D246134458B78DC6C26B922E156D5B2C53A8E61C2F61B51526228014ED954C5
        E70C3B2D70BA5CFF746FA29EEF821047E1CBEA5BBC18B7757A6CD1F8FB330328
        7BE24064E1D4A1FA1B1D04C00814E2D5614C64FD290DB3860550B3C7F10DC54D
        BE40DE71EB797E182E004962ABDE3A829547AE4168884F45A9537D204DA5932C
        9369D30652BE9A93E849A2E04FDF8BADB97171C19C399A7912005B2B7BFC4078
        C135553A958E29857EECA42F8805120430B3CAAFC2690E2DA08A51F54882A49C
        71CB9149C4E8A505B66EAC450FF752D7084851F0C7BD26CECCF1629484B1D3DC
        561D88228BC2F7C44DD52F9D55558E3D5D5ACCA8FDF74C4E2C003E0ADF72CD30
        7D772489102F2D1C293E90209DA01C5A68E52700A192243A1A97CA913EC1C9CC
        22683C1E475FA40709EE852229CB012A6F9B54ECC3E402FF6903F8CE9BC79923
        2CFA36CBF5848609153A5EFAED1FA2C6BA3BF33302287D7C7F78FED461FA1F8F
        25904DFEDD3326079B9A12D4B08D9A0B4F4D4A1B1A9C27CC3CC339AE6D70F6B3
        863BFB971B1CCBDC300258B83B8A69E501A5887ECB3197882001226A580AA029
        E199D7C3CCFE29960ECB3EEC461E7DA0B1CB8091B0F1F5F220366E5C1F355EBC
        3D338092C75C00ED0952C58B6C66E10A9A3CC93C506C045519A18283E654A217
        9486143D67B800363638349AE90258DFE0BC40002D200079673E05EA666922E5
        B7C991CB071EA7960D9A2AC5F7E8B46B736F0ABDE4659C8D94CEF7357633E4B2
        D4985215C2C60DFF0B80520298776595FE269D389B9AB8F72BB9A86D8A236EDB
        2ADA081F4B987A63A6A6FA61193A5518369C82426ABA5CBF86EE38FF13BC6969
        606F846EC36947BF591644D0EB58405E2FF7CB33638C480246829324C82853BB
        44BA273F8C40E73B1ABB122C2B6C4C2A0DE0D5CDB5D13533EE1892D9891FDB17
        9EF38D61FA27ECDAB3086072511007A80D117E064B09D5D47C2A303891D471E7
        F49A85F267FE585A7AC14284D5F03BD2F26AD653357B936AEE67E28EF4D56E34
        B5F83C89AEB347014FEFE9A50FA4680902E418CBE272FDFA755163ED8F335BA0
        7CE9DEF0B42943F5BF74A610A2A4392C1B2A431EF45355375687B09A6194A794
        E6D29B57FBECB1BA0EA77B13807E52E4DB67FBF04A6B3FBE4925ACFBAB0153B9
        B58358CDB74E082F9BC183EBAA353CF1971E140885E80329D2EC2B0C00DB7E5F
        1B4DFDE6DF0629E61EDD1DB9FAB22A7D4F574AE58107C6EA58D7D8873E3AD4DC
        E1D97866AFC1176A4AC074B3E775C364BA2295E82474500028BC50E25B0450DB
        D28B9995D98A9AFDB6E5588973C4D2BD7CBE65C970225D38214E6CE13F3EEC41
        3E8F8F30FB5B44393CE4C5AEFFDE107D60EC9D05191359F12F7745A65C3A4C3F
        1036C9551B4BC6E6E1C5237D7C013077444809279649B989472667F99C86C649
        644EB8158B098504683605A0FF615D530C73AA72F1FC7E43017499A3149072F9
        37778C17C7FB827466B0A3EBC7E33BBB91EF912894248552A808FA70F0DD5706
        0750F48B0F22932755EBD2A40778458495BEC04F87BC71780EAE6714F82D9BFC
        EB2AB3F05A6B1CD7B24B7B9DD4984A6ABCCEF35379FED5967E4C637DB399FBE9
        DC6F6A892BC7D8D8DC8719553958B5278913F61A7001B5CD1BE363040A288B96
        F8E2F8D5EE1EE6001BC97E69292D14929FEFBF511B7D60DC5D990114FE7C67E4
        FC8BAAF5232CA70314FE67E7E6A1A6AE17619AF39651BAE2740E352E79417339
        1EE24F3CE55A4083A28450CE71629B9461D4A2CCCF37C4F02F2372399FD9DA74
        52B9D04894D42B798093A5AD94F9B184930796BEDF850246B5A39DE20326239A
        07C73ED8145D7CCEDD8300786447E49C0BCFD08FB0C10830915D5511C427B114
        7A924E8BE9A3DF94D1A9BB556366AB9C50C47EA0530900C56359F892B86EB961
        B2888D4447D25459590096B23CEF885B0A9C085D44ADB6B1CC304D4B45AC022A
        A82992523ED0CF32A684F31B59C29B7C660E65E8DCBD396A6EB83BB313173EFC
        7EE4AC0BAAF526766452F14BD95099ED43170510E17DA453298BBB6E69C13C4E
        4756C4E3E334713A0CCA5AE9B184E114979673FD18AF3FF00F057898942871EF
        F7C04964C5011FDAA924F12B49644504D042062425B9913E0E00E6016662E951
        C2FB3645ED0DF7640630E4A1ED9191E70ED72F29F3634A5916DE399EC065DCCB
        CB9ED817C35DEC09FE7C2C8EF7A9913BCECE53B3977D14C66D74F6EDBC775B7B
        123F1EA72B87644AE1FDF978871DDD36CE99CC1CF02E33BC4750796DB51429BE
        219691B86F5178D5CBD8D256934214DE4CDA8A4AC27F8B1691B5AAC33B0607A0
        15FC6C5BB87A7CB5DE1A3755A1F6D8C42158B62FA24C9E5ED42ACF7134AAA902
        8D94A246DBFB4C7751CB561A6EE3B1AA4E2954294B9156DEFFC8570BB1E8BD2E
        94657BD4FDB289D0A5A4641B2D2EC2CB327E098F5BC22C1D4478439EEF4113CB
        689BA1C9CB97C43F7E2D8A57EECB77A3F80000D907F21F7CB763D839C3739BC9
        4989E353ABB2B08F49C431B9B33257CE58DCAE00388E5CA200582A070B08A158
        2B05B2DC485391E553C7575407B19539A5920A688D9A4E67263EC17ABC356CAA
        5E42FCA08C946DEE66A895C04050E539AC8DE874B22EE4E30313F55B62D8B8A8
        848F4EB871436DD2BC16E72F7A635BE9F85155ED715B13DA7879598AB9760672
        CD2D1BCAE5B8D7505345E00A026AEB3707BE6F381A355414128AC8FD6D1177D9
        428E19865AA3C981EF2372BD853EE074683C26A0265A4028237C2A23801602B2
        680DBF19B7938DAF3761CB92499CDE21203457FBB2FE31367BE6E225A18BA65D
        915F59E6CBF2FB95D6D52A825BFFF8DC8F1CCEC70D3747786D3757C8228087FF
        A10A3649684EB6765A2FC9B27189E9A44292DA940A37917286D4FB12EF0DE91F
        88D590550E0A6F1B4E64B0C460461CED0D3B5389035BFF885D2FFF848FFC8823
        AAC2398774ECE7725C15BCFAB6EB7D63BE3602413DE034D916D27BDBFD9464BB
        EAB6DD6BB6DBAC7FF61EE79C8613FFD3F3063E5BC1BD17E94F54D689CF57F8D4
        A72D19096693E6BDF5D8FFDA465EDCCAB1872392B6400EC7708E891CA35C8B78
        4E8E52FF875BBAD0655381431C3B381A387AD3024AD897854C694DCA39B2E014
        945FA44D4217EB12B4711CE1E8E4480EACD1C27164D1BC2CA749F3F545D17E7A
        532BAF1C7D702C2151C8FAB49002C28B13D4F922024853C944A6D56977FBA209
        9E09C80961BFF45FEABFEC00FE072F201E987C1444A50000000049454E44AE42
        6082}
    end
    object lbl_Title: TLabel
      Left = 80
      Top = 13
      Width = 120
      Height = 23
      Caption = #25919#27835#38754#35980#35774#32622
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 342
    Width = 552
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      552
      41)
    object btn_Del: TBitBtn
      Left = 102
      Top = 9
      Width = 75
      Height = 25
      Caption = #21024#38500'[&D]'
      TabOrder = 2
      OnClick = btn_DelClick
    end
    object btn_Save: TBitBtn
      Left = 193
      Top = 9
      Width = 75
      Height = 25
      Caption = #20445#23384'[&S]'
      TabOrder = 3
      OnClick = btn_SaveClick
    end
    object btn_Exit: TBitBtn
      Left = 470
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #36864#20986'[&X]'
      TabOrder = 0
      OnClick = btn_ExitClick
    end
    object btn_Add: TBitBtn
      Left = 11
      Top = 9
      Width = 75
      Height = 25
      Caption = #22686#21152'[&A]'
      TabOrder = 1
      OnClick = btn_AddClick
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 214
    Top = 169
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#25919#27835#38754#35980#20195#30721#34920
    Params = <>
    OnNewRecord = ClientDataSet1NewRecord
    Left = 246
    Top = 169
  end
end
