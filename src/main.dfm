object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Deploy NIC Padlock'
  ClientHeight = 519
  ClientWidth = 840
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 300
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 230
    Top = 0
    Width = 6
    Height = 501
    OnMoved = Splitter1Moved
  end
  object panelStringTree: TPanel
    Left = 0
    Top = 0
    Width = 230
    Height = 501
    Align = alLeft
    TabOrder = 0
    object tlb1: TToolBar
      Left = 1
      Top = 1
      Width = 228
      Height = 26
      ButtonHeight = 27
      ButtonWidth = 25
      Caption = 'tlb1'
      DrawingStyle = dsGradient
      Images = Images
      TabOrder = 0
      object btnChangePassword: TToolButton
        Left = 0
        Top = 0
        Hint = 'Change Password'
        Action = actnChangePassword
      end
      object btnAddNewGroup: TToolButton
        Left = 25
        Top = 0
        Action = actAddNewGroup
      end
      object ToolButton2: TToolButton
        Left = 50
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object btnAddOneComputer: TToolButton
        Left = 58
        Top = 0
        Action = actAddOneComputer
      end
      object btnAddMultipleComputers: TToolButton
        Left = 83
        Top = 0
        Action = actAddMultipleComputers
      end
      object ToolButton1: TToolButton
        Left = 108
        Top = 0
        Width = 8
        Caption = 'ToolButton1'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object btnRemoveComputer: TToolButton
        Left = 116
        Top = 0
        Action = actnRemoveComputer
      end
      object btnRemoveGroup: TToolButton
        Left = 141
        Top = 0
        Hint = 'Remove group'
        Action = actnRemoveGroup
      end
      object ToolButton3: TToolButton
        Left = 166
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 23
        Style = tbsSeparator
      end
      object btnRenameComputer: TToolButton
        Left = 174
        Top = 0
        Action = actnRenameComputer
      end
      object btnLocateHost: TToolButton
        Left = 199
        Top = 0
        Hint = 'Locate a host'#39's record'
        Action = actnLocateHostRecord
      end
    end
    object vst1: TVirtualStringTree
      Left = 1
      Top = 27
      Width = 228
      Height = 473
      Align = alClient
      Constraints.MinWidth = 100
      DragOperations = [doMove]
      DrawSelectionMode = smBlendedRectangle
      Header.AutoSizeIndex = 0
      Header.DefaultHeight = 17
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Height = 17
      Header.Options = [hoDblClickResize, hoDrag, hoShowSortGlyphs]
      Images = Images
      IncrementalSearch = isAll
      PopupMenu = vstPopupMenu
      TabOrder = 1
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toUseExplorerTheme]
      TreeOptions.SelectionOptions = [toExtendedFocus, toMultiSelect, toSiblingSelectConstraint]
      OnChange = vst1Change
      OnClick = vst1Click
      OnCompareNodes = vst1CompareNodes
      OnContextPopup = vst1ContextPopup
      OnDragAllowed = vst1DragAllowed
      OnDragOver = vst1DragOver
      OnDragDrop = vst1DragDrop
      OnFocusChanged = vst1FocusChanged
      OnFreeNode = vst1FreeNode
      OnGetText = vst1GetText
      OnGetImageIndex = vst1GetImageIndex
      OnGetNodeDataSize = vst1GetNodeDataSize
      OnIncrementalSearch = vst1IncrementalSearch
      OnMouseDown = vst1MouseDown
      Columns = <
        item
          Position = 0
          Width = 214
        end>
    end
  end
  object PageControl1: TPageControl
    Left = 236
    Top = 0
    Width = 604
    Height = 501
    ActivePage = Tab01_NetworkInfo
    Align = alClient
    Constraints.MinHeight = 300
    Constraints.MinWidth = 570
    Style = tsFlatButtons
    TabOrder = 1
    object Tab01_NetworkInfo: TTabSheet
      Caption = 'Tab01_NetworkInfo'
      TabVisible = False
      object panelNetworkInfo: TPanel
        Left = 0
        Top = 0
        Width = 596
        Height = 491
        Align = alClient
        TabOrder = 0
        DesignSize = (
          596
          491)
        object Label12: TLabel
          Left = 252
          Top = 20
          Width = 4
          Height = 16
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox2: TGroupBox
          Left = 2
          Top = 67
          Width = 234
          Height = 77
          Caption = 'Network Summary'
          TabOrder = 1
          object lblNumGroups: TLabel
            Left = 23
            Top = 24
            Width = 65
            Height = 13
            Caption = 'lblNumGroups'
          end
          object lblNumHosts: TLabel
            Left = 23
            Top = 43
            Width = 58
            Height = 13
            Caption = 'lblNumHosts'
          end
        end
        object panelNetworkScanHostsInfo: TPanel
          Left = 242
          Top = 72
          Width = 263
          Height = 72
          Color = clInfoBk
          ParentBackground = False
          TabOrder = 2
          object lblNetworkScanHostsInfo: TLabel
            Left = 8
            Top = 10
            Width = 250
            Height = 48
            Margins.Left = 10
            Margins.Top = 10
            Margins.Right = 10
            Margins.Bottom = 10
            Alignment = taCenter
            Caption = 
              'Add multiple computers by scanning your'#13#10'network and selecting t' +
              'he hosts to add'#13#10'-- or -- import them from a text or CSV file.'
            Color = clInfoBk
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
        end
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 594
          Height = 60
          Align = alTop
          Color = clBtnHighlight
          ParentBackground = False
          TabOrder = 0
          object Image3: TImage
            Left = 14
            Top = 13
            Width = 32
            Height = 32
            Picture.Data = {
              055449636F6E0000010001002020000001002000A81000001600000028000000
              2000000040000000010020000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000040000000D
              00000014000000140000000D0000000400000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000060000001100000016000000160000001600000016
              0000001600000016000000160000001600000016000000160000001E00000030
              0000003F0000003F000000300000001E00000016000000160000001600000016
              0000001600000016000000160000001600000016000000160000001100000006
              0000000000000000000000110000003200000043000000430000004300000043
              000000430000004300000043000000430000004300000043000000472B7EBCC3
              318BCEFF318BCEFF2B7EBCC30000004700000043000000430000004300000043
              0000004300000043000000430000004300000043000000430000003200000011
              000000000000000000000011525051FF525051FF525051FF525051FF525051FF
              525051FF525051FF525051FF525051FF525051FF534F4FFF554A44FF3895DDFF
              65E4FCFF65E4FCFF3895DDFF554A44FF534F4FFF525051FF525051FF525051FF
              525051FF525051FF525051FF525051FF525051FF525051FF525051FF00000011
              0000000000000000000000067E7B78FF7E7B78FF7E7B78FF7E7B78FF7E7B78FF
              7E7B78FF7E7B78FF7E7B78FF7E7B78FF7E7B78FF7F7A77FF82756DFF4098DFFF
              91F7FFFF91F7FFFF4098DFFF82756DFF7F7A77FF7E7B78FF7E7B78FF7E7B78FF
              7E7B78FF7E7B78FF7E7B78FF7E7B78FF7E7B78FF7E7B78FF7E7B78FF00000006
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000034595D8AC
              4B9DE2FF4C9DE3FF4697D9AC0000000300000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000100000005000000090000000B00000009000000050000000100000016
              827367FF54453CFF000000160000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000001
              0000001426201A5541382E8A443B309841382E8A26201A55000000140000003B
              827367FF54453CFF0000003A0000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000007
              59504584A99D8DDCC8BEACF1CDC4B2F3C8BFADF1AA9E8DDC5950458400000068
              827367FF54453CFF000000640000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000010000000600000009000000090000000E
              756959AFBBAA92FCCDBFA8FFD3C6B1FFCDBFA8FFBBAB92FC75695AAE00000051
              7F6D63FF524139FF0000004C0000000100000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000006322B2364372F2779372F277B372F277D
              6D5F50BF9F8E77F2AF9D84FFB09E84FFAF9D84FF9F8E78F26D5F50BE372F277C
              362E267C352D267C2F2821690000001100000009000000050000000100000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000A887864CEA59985E1ABA08FE2ABA091E2
              B4A998ECC1B5A3FAC7B9A6FFC7B9A5FFC7B9A6FFC1B5A3FAB4A998ECAA9F90E2
              A89D8DE49F9381EB7E6E5CE93F372C9C41382E8A26201A550000001400000001
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000BA9967FF0D2B286FFDDAB65FFE1AD5EFF
              E4B15FFFE8B55FFFECB95FFFEDBB5FFFECBA5FFFE8B55FFFE5B15FFFE1AD5EFF
              DDAB63FFD3AE7CFFA99680FEC3BBA9F4C8BFADF1AA9E8DDC5950458400000007
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000BAC9A84F0D2A970FFE09A39FFE79C2EFF
              EDA22DFFF2A92DFFF7AF2EFFFAB22EFFF8B02EFFF3AA2DFFEDA32DFFE79C2DFF
              E09934FFD4A360FFAC9B86FFC9BDA9FFCDBFA8FFBBAB92FC75695AAE0000000D
              0000000900000009000000060000000100000000000000000000000000000000
              0000000000000000000000000000000BB09E8AF0CFA66DFFDF9A3DFFE69E36FF
              ECA436FFF0A934FFF4AD32FFF6AF32FFF4AE32FFF0A932FFEBA231FFE69C31FF
              E09837FFD2A160FFAE9D88FFA8977EFFAF9D84FF9F8E78F26D5F50BE372F277C
              372F277B372F2779322B23640000000600000000000000000000000000000000
              0000000000000000000000000000000BB3A390F0CCA16AFFDC963AFFE49C37FF
              E9A43CFFEEA93EFFF1AD3DFFF2AE3BFFF1AB39FFEDA636FFE9A034FFE49A31FF
              DD9535FFCF9D5DFFB3A390FFBEB19DFFC7B9A6FFC1B5A3FAB4A998ECABA091E2
              ABA08FE2A59986E1877663CE0000000A00000000000000000000000000000000
              0000000000000000000000000000000BB7A896F0C89D66FFD99238FFE19734FF
              E59F3CFFEAA745FFEDAD4AFFEEAF4CFFEDAE4BFFECAB4BFFE9A84BFFE5A34BFF
              DE9E4BFFCE9F65FFB9A890FFE2B25AFFECBA5FFFE8B55FFFE5B15FFFE1AD5EFF
              DDAB63FFD3AE7CFFA8947EF00000000B00000000000000000000000000000000
              0000000000000000000000000000000BBBAD9BF0C49862FFD58D37FFDD9132FF
              E19939FFE5A041FFE8A648FFE9AB51FFEAAE59FFEAB161FFE9B369FFE8B371FF
              E2B072FFCEA575FFBCAC92FFEFAA2CFFF8B02EFFF3AA2DFFEDA32DFFE79C2DFF
              E09934FFD4A360FFAA9984F00000000B00000000000000000000000000000000
              0000000000000000000000000000000BBFB2A1F0C0935EFFD18835FFD88B30FF
              DC9236FFE0993EFFE29F45FFE4A44DFFE5A755FFE5AA5DFFE5AC64FFE4AE6CFF
              DEAA6FFFCAA071FFC0AF98FFEBA72FFFF4AE32FFF0A932FFEBA231FFE69C31FF
              E09837FFD2A160FFAE9D89F00000000B00000000000000000000000000000000
              0000000000000000000000000000000BC3B7A6F0BA8D5CFFC88339FFCF8533FF
              D28B37FFD5903EFFD89645FFD99A4CFFDA9E54FFDAA15BFFDBA362FFDAA568FF
              D5A36CFFC49A6EFFC3B39EFFE7A638FFF1AB39FFEDA636FFE9A034FFE49A31FF
              DD9535FFCF9D5DFFB2A28FF00000000B00000000000000000000000000000000
              0000000000000000000000000000000AC2B7A8EDB3936DFFB88C5BFFBB8D59FF
              BD8E5AFFBE915CFFBF9460FFC09664FFC19867FFC1996AFFC19B6EFFC19C71FF
              BF9B73FFB99976FFC5B49FFFE4A849FFEDAE4BFFECAB4BFFE9A84BFFE5A34BFF
              DE9E4BFFCE9F65FFB6A794F00000000B00000000000000000000000000000000
              00000000000000000000000000000004AB9C8CD2DCD4C4F4E2DACBF7E2DACCF7
              E2DACCF7E2DACBF7E2DACBF7E1D9CAF7E0D8C9FFE1D7C7FFE1D7C6FFE1D7C6FF
              E1D7C6FFDCD1BEFFB59D80FFE5A84FFFEAAE59FFEAB161FFE9B369FFE8B371FF
              E2B072FFCEA575FFB9AC99F00000000B00000000000000000000000000000000
              00000000000000000000000000000000544A402AA18D7976AB968180AC978280
              AC978280AC978280AC978280A4907C85B4A491F8B59570FFBD8F5BFFC19059FF
              C3945CFFC29359FFCA9144FFE4A44DFFE5A755FFE5AA5DFFE5AC64FFE4AE6CFF
              DEAA6FFFCAA071FFBDB09FF00000000B00000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000BC3B7A6F0BA8D5CFFC88339FFCF8533FF
              D28B37FFD5903EFFD89645FFD99A4CFFDA9E54FFDAA15BFFDBA362FFDAA568FF
              D5A36CFFC49A6EFFC1B4A5F00000000B00000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000AC2B7A8EDB3936DFFB88C5BFFBB8D59FF
              BD8E5AFFBE915CFFBF9460FFC09664FFC19867FFC1996AFFC19B6EFFC19C71FF
              BF9B73FFB99976FFC2B5A6ED0000000A00000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000004AB9C8CD2DCD4C4F4E2DACBF7E2DACCF7
              E2DACCF7E2DACBF7E2DACBF7E2DACBF7E2DACBF7E2DACBF7E2DACBF7E2DACBF7
              E2DACBF7DCD4C4F4AB9C8CD20000000400000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000544A402AA18D7976AB968180AC978280
              AC978280AC978280AC978280AC978280AB978280AC978280AB968280AC968280
              AB968280A08D7976544A3F2A0000000000000000000000000000000000000000
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
              00000000FFF81FFF80000001800000018000000180000001FFF81FFFFE003FFF
              FC003FFFFC003FFFC0001FFFC00003FFC00001FFC00001FFC000001FC000001F
              C000001FC000001FC000001FC000001FC000001FC000001FC000001FE000001F
              FFC0001FFFC0001FFFC0001FFFE0003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF}
          end
          object Label14: TLabel
            Left = 53
            Top = 16
            Width = 321
            Height = 23
            Caption = 'Network Summary and Host Discovery'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
        object pgcHostDiscovery: TPageControl
          Left = 2
          Top = 150
          Width = 591
          Height = 106
          ActivePage = tsImportHosts
          Anchors = [akLeft, akTop, akRight]
          Images = Images
          TabOrder = 3
          OnDrawTab = pgcHostDiscoveryDrawTab
          object tsImportHosts: TTabSheet
            Caption = 'Import hosts from a file'
            ImageIndex = 30
            object btnImportHosts: TButton
              Left = 3
              Top = 7
              Width = 159
              Height = 25
              Hint = 'Import hosts from a text file'
              Caption = 'Import hosts from a file ...'
              ImageIndex = 30
              Images = Images
              TabOrder = 0
              OnClick = btnImportHostsClick
            end
            object mmoImportInfo: TMemo
              Left = 168
              Top = 7
              Width = 369
              Height = 61
              BorderStyle = bsNone
              Color = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Lucida Console'
              Font.Style = []
              Lines.Strings = (
                ' Import file can be comma delimited (Hostname,IP):'
                ''
                ' PcNameA,192.168.1.105'
                ' AcmeCorp03Pc'
                ' ADifferentPc,192.168.1.210')
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
            end
          end
          object tsNbtScanHosts: TTabSheet
            Caption = 'Network scan'
            ImageIndex = 32
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label10: TLabel
              Left = 233
              Top = 17
              Width = 12
              Height = 13
              Caption = 'To'
            end
            object Label9: TLabel
              Left = 12
              Top = 17
              Width = 62
              Height = 13
              Caption = 'Range From:'
            end
            object Animate1: TAnimate
              Left = 411
              Top = 14
              Width = 16
              Height = 16
              CommonAVI = aviFindComputer
              StopFrame = 8
              Visible = False
            end
            object btnCancelScan: TButton
              Left = 431
              Top = 37
              Width = 106
              Height = 25
              Caption = 'Cancel Scan'
              Enabled = False
              ImageIndex = 23
              Images = Images
              TabOrder = 4
              OnClick = btnCancelScanClick
            end
            object btnScanSubnet: TButton
              Left = 431
              Top = 9
              Width = 106
              Height = 25
              Caption = 'Scan for Hosts'
              ImageIndex = 32
              Images = Images
              TabOrder = 0
              OnClick = btnScanSubnetClick
            end
            object edtIpEnd: TIPMask
              Left = 253
              Top = 13
              Width = 150
              Height = 21
              Ctl3D = True
              Text = '0.0.0.1'
              Value = 1
              BorderStyle = bsSingle
              Color = clWindow
              Enabled = True
              OnEnter = edtIpEndEnter
              TabOrder = 2
              TabStop = True
            end
            object edtIpStart: TIPMask
              Left = 80
              Top = 13
              Width = 150
              Height = 21
              Ctl3D = True
              Text = '0.0.0.1'
              Value = 1
              BorderStyle = bsSingle
              Color = clWindow
              Enabled = True
              TabOrder = 1
              TabStop = True
            end
          end
        end
        object grpNetworkInfoHosts: TGroupBox
          Left = 1
          Top = 258
          Width = 594
          Height = 232
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'Confirm Hosts to Add'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 4
          object Label11: TLabel
            Left = 9
            Top = 24
            Width = 95
            Height = 13
            Caption = 'Select/Enter Group:'
          end
          object lvMultipleComputers: TListView
            Left = 2
            Top = 50
            Width = 590
            Height = 165
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            Checkboxes = True
            Columns = <
              item
                Width = 25
              end
              item
                Caption = 'IP'
                Width = 125
              end
              item
                AutoSize = True
                Caption = 'Computer Name'
              end>
            GridLines = True
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            PopupMenu = PopUpMultipleComputerScan
            TabOrder = 3
            ViewStyle = vsReport
            OnColumnClick = lvMultipleComputersColumnClick
            OnCompare = lvMultipleComputersCompare
          end
          object StatusBar1: TStatusBar
            Left = 2
            Top = 215
            Width = 590
            Height = 15
            Panels = <
              item
                Width = 200
              end>
          end
          object btnAddChecked: TButton
            Left = 250
            Top = 16
            Width = 167
            Height = 24
            Caption = 'Add checked items to group'
            ImageIndex = 0
            Images = Images
            TabOrder = 0
            OnClick = btnAddCheckedClick
          end
          object cbGroups: TComboBox
            Left = 110
            Top = 19
            Width = 134
            Height = 21
            TabOrder = 2
          end
          object btnResetScan: TButton
            Left = 434
            Top = 16
            Width = 106
            Height = 24
            Caption = 'Clear Results'
            TabOrder = 1
            OnClick = btnResetScanClick
          end
        end
      end
    end
    object Tab02_GeneralInfo: TTabSheet
      Caption = 'Tab02_GeneralInfo'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object panelGeneralInfo: TPanel
        Left = 0
        Top = 0
        Width = 596
        Height = 491
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 594
          Height = 60
          Align = alTop
          Color = clBtnHighlight
          ParentBackground = False
          TabOrder = 0
          object Image2: TImage
            Left = 14
            Top = 13
            Width = 32
            Height = 32
            Picture.Data = {
              055449636F6E0000010001002020000001002000A81000001600000028000000
              2000000040000000010020000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000001B000000330000003300000033
              000000330000001A000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000083725E9F99856EFF98846DFF98846DFF
              99846EFF81705D9A000000330000003300000033000000330000003300000033
              0000002300000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000230000003300000033A5927CFFB8A284FFCBBDA5FFCBBDA5FF
              B9A488FFA5927CFF98836CFF98846DFF97836CFF96816AFF958069FF96816AFF
              8B7964C000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000907E69C09B8770FF99846DFF97826CFF96806BFF947F69FF947F69FF
              96806BFF97826CFF99846EFF9A866FFFB09F89FFD1C7B2FFD0C4B0FFD5CAB7FF
              99846CFF00000005000000100000001600000016000000160000001600000016
              0000001600000016000000160000001600000016000000160000001600000016
              000000169E8A73FFCDB89BFFF3F9F1FFF0F7F1FFEEF6F1FFEEF5F1FFEEF5F1FF
              EEF6F1FFF0F7F1FFF3F9F2FFCAB69AFF99846DFFD0C5B0FFCEC2ADFFD7CDBAFF
              98836DFF00000010000000310000004200000043000000430000004300000043
              0000004300000043000000430000004300000043000000430000004300000043
              000000439E8A76FFD1C3ADFFE49021FFEB9820FFF4A422FFFDB023FFFFB323FF
              F6A822FFED9C21FFE58E1AFFCFBFAAFF9B8671FFD4C6B3FFD1C3AFFFDBD1C1FF
              9A856EFF000000164598D0F34498D2FF4094D0FF3E92CEFF3E92CEFF3E92CEFF
              3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF
              3E92CEFFA08C78FFD6CFBEFFE3942FFFE8A137FFEFA52FFFF6AD2CFFF7AE2CFF
              F1A72BFFE99C29FFE28E1FFFD5CAB8FFA28875FFE3CABAFFE0C7B6FFE5D7C9FF
              9C876FFF000000164498D2FF3F93CFFFA8FBFFFF9AF4FFFF95F3FFFF95F3FFFF
              95F3FFFF95F3FFFF95F3FFFF95F3FFFF95F3FFFF95F3FFFF95F3FFFF95F3FFFF
              95F3FFFFA28E79FFDEDACBFFDF8E2BFFE6A140FFEEAE4EFFF1B14DFFF1B655FF
              EFB65CFFECB361FFECB672FFDCD4C3FFAC8B7AFF008E42FF008B3EFFF2DDD3FF
              9E8772FF000000164397D1FF5DB3DFFF82D3F2FF9AEFFFFF8AEAFFFF8BEAFFFF
              8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF8BEAFFFF
              8BEAFFFFA38F7AFFE5E5D8FFD88424FFE09739FFE6A445FFEAAB4FFFECB059FF
              EBB262FFE9B36AFFE8AE6BFFE2DCCDFFAD8C7BFF00C957FF00C553FFF5E1D9FF
              A08973FF000000164195D0FF7CD3F2FF5FB2E0FFA5EFFFFF86E6FDFF87E5FDFF
              87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF87E5FDFF
              87E5FDFFA5917CFFECEFE3FFD07516FFD98629FFDE9235FFE39A3EFFE5A048FF
              E5A352FFE4A55CFFE3A461FFE7E6D6FFA78D7AFFC9A592FFC6A18EFFF1E5DCFF
              A18B74FF000000164094D0FF96ECFEFF4096D1FFA6F0FFFF8FE6FEFF83E3FDFF
              84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF84E3FDFF
              84E3FDFFA9947FFFF3F7EAFFF0F6ECFFEFF6EEFFEFF6EEFFEEF5EDFFEEF4ECFF
              EEF4EBFFEEF3E9FFEEF3E7FFEFF0E3FFA58E79FFF5E2D4FFF1DED0FFEFE8DFFF
              A18B76FF000000163F93CFFFA6F6FFFF469DD5FF8EDCF7FF9CE9FFFF7FE1FCFF
              81E1FCFF81E1FCFF81E1FCFF81E1FCFF81E1FCFF81E1FCFF81E1FCFF81E1FCFF
              81E1FCFF9FAFA9FFAB9681FFAA9580FFA99580FFA99580FFA99480FFA99480FF
              A7927DFFA58F79FFA48E78FFA48F79FFB19C86FFB9A189FFB69E85FFF2ECE3FF
              A38D76FF000000163E92CFFFA6F5FFFF5AB5E2FF69BBE6FFAFEFFFFF7DE0FCFF
              7CDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF
              7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF7DDFFCFF
              A58F78FFF7F2EBFFEEDCCCFFEEDCCDFFEEDDCDFFEDDCCCFFECDACAFFF4F0E8FF
              A58F78FF000000163E92CFFFA9F3FFFF76D7F6FF429BD5FFB1EEFFFF8BE2FBFF
              78DDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF
              7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF7ADDFBFF
              A6907AFFF8F4EDFFDACBB7FFDACBB8FFDACBB8FFDACBB7FFDACAB7FFF8F3ECFF
              A5907AFF000000163D92CEFFAAF2FFFF82E6FFFF3C8FCEFF97DFF8FFA1E7FEFF
              72DAFAFF75DBFAFF76DBFAFF76DBFAFF76DBFAFF76DBFAFF77DBFAFF77DBFAFF
              77DBFAFF77DBFAFF77DBFAFF77DBFAFF77DBFAFF77DBFAFF77DBFAFF77DBFAFF
              A9947EFFFEFBF5FFFBF6F2FFFBF6F2FFFBF6F2FFFBF6F2FFFBF6F2FFFEFBF5FF
              A9947EFF000000163D92CEFFAEF0FFFF7EE4FFFF53ADDEFF73C4EBFFBCEFFEFF
              6CD8FAFF6ED8FAFF6FD8FAFF6FD8FAFF6FD9FAFF70D9FAFF73D9FAFF74D9FAFF
              74D9FAFF74D9FAFF74D9FAFF74D9FAFF74D9FAFF74D9FAFF74D9FAFF74D9FAFF
              9BACA7FFAA957FFFA9937DFFA8937DFFA8937DFFA8937DFFA9937DFFAA957FFF
              AC9882B1000000163D92CFFFB1F1FFFF7AE1FDFF68C7EFFF47A4DAFFC6F4FFFF
              C3F2FFFFC4F2FFFFC4F2FFFFC4F2FFFFC5F2FFFFC7F2FFFF70D8FBFF71D7FAFF
              71D6F9FF71D6F9FF71D6F9FF71D6F9FF71D6F9FF71D6F9FF71D6F9FF71D6F9FF
              71D6F9FF71D6F9FF71D6F9FF6FD6F9FF6CD5F9FFBDF1FFFF66ADDBFF00000026
              00000008000000163D92CFFFB5F1FFFF77DDFCFF7CE0FEFF52ACDEFF378BCAFF
              368BCBFF368BCBFF368BCBFF368BCBFF368BCBFF388BCBFF4FA9DDFF70D8FCFF
              6FD6FAFF6DD4F9FF6DD4F9FF6CD4F9FF6CD4F9FF6CD4F9FF6CD4F9FF6CD4F9FF
              6CD4F9FF6CD4F9FF6CD4F9FF6CD3F9FF68D2F9FFA1E7FDFF93CAE9FF2C6B957C
              00000010000000163D92CFFFB8F1FFFF74DBFAFF77DCFBFF7ADFFCFF7AE0FDFF
              7AE1FDFF7BE1FDFF7BE1FDFF7BE1FDFF7BE1FDFF7CE2FEFF54ACDEFF4FA8DDFF
              6AD5FBFF65D2F9FF63D0F8FF62D0F8FF62D0F8FF62D0F8FF62D0F8FF62D0F8FF
              62D0F8FF62D0F8FF62D0F8FF62D0F8FF60D0F8FF7FDBFBFFC8EDFBFF3787C0CA
              00000013000000163C92CFFFBDF2FFFF71DAFAFF74DAFAFF75DBFAFF76DBFBFF
              76DBFBFF76DBFBFF76DBFBFF76DBFBFF76DCFBFF77DCFCFF79DFFDFF52ACDEFF
              4AA6DDFFDAF9FFFFD6F7FFFFD5F7FFFFD5F7FFFFD5F7FFFFD5F7FFFFD5F7FFFF
              D5F7FFFFD5F7FFFFD5F7FFFFD5F7FFFFD5F7FFFFD4F7FFFFD9FCFFFF3D94D0FF
              0000000D000000163C92CFFFC0F3FFFF6ED8FAFF72D8FAFF73D8FAFF73D8FAFF
              73D8FAFF73D8FAFF73D8FAFF73D8FAFF73D8FAFF73D8FAFF74DAFBFF76DDFDFF
              51ABDDFF388DCBFF378DCBFF378DCBFF378DCBFF378DCBFF378DCBFF378DCBFF
              378DCBFF368DCCFF368DCDFF3890CEFF3A92CEFF3B92CFFF3D94D0FF4194CCB4
              00000004000000163C92CFFFC4F3FFFF6CD6F9FF70D7F9FF71D7F9FF71D7F9FF
              71D7F9FF71D7F9FF71D7F9FF71D7F9FF71D7F9FF71D7F9FF71D7F9FF72D9FAFF
              74DBFBFF66C8F1FF66C9F2FF66C9F2FF66C9F2FF66C9F2FF66C9F2FF66C9F2FF
              66C9F2FF63C9F2FF9EDBF5FF3E94D0FF295C80384090C6344294CC3B00000001
              00000000000000163B92CFFFC9F5FFFF69D4F9FF6ED5F9FF6FD5F9FF6FD5F9FF
              6FD5F9FF6FD5F9FF6FD5F9FF6ED5F9FF6ED5F9FF6DD5F9FF6DD5F9FF6ED5F9FF
              6ED5F9FF6FD7FAFF6FD7FBFF6FD7FBFF6FD7FBFF6FD7FBFF6FD7FBFF6FD7FBFF
              6ED7FBFF6AD6FBFFC9F7FFFF3D93CFFF00000016000000000000000000000000
              00000000000000163B92CFFFCFF5FFFF67D3F8FF6CD4F8FF6DD4F8FF6DD4F8FF
              6DD4F8FF6DD4F8FF6BD4F8FF68D3F8FF66D2F8FF66D2F8FF66D2F8FF66D2F8FF
              66D2F8FF66D3F8FF66D3F8FF66D3F8FF66D3F8FF66D3F8FF66D3F8FF66D3F8FF
              65D2F8FF62D2F9FFD5F8FFFF3B92CFFF00000015000000000000000000000000
              00000000000000163B92CFFFD3F6FFFF63D1F8FF68D2F8FF69D3F8FF69D3F8FF
              69D3F8FF69D2F8FF66D1F8FFA8E7FDFFDAF7FFFFDAF8FFFFDAF8FFFFDAF8FFFF
              DAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFFDAF8FFFF
              DAF8FFFFD9F9FFFFDEFDFFFF3D94D0FF0000000D000000000000000000000000
              00000000000000153B92CFFFD7F8FFFF5DCFF9FF60CFF8FF61CFF8FF61CFF8FF
              61CFF8FF61CFF8FF5ECFF8FFBCEEFFFF348CCCFF3991CEFF3A92CFFF3A92CFFF
              3A92CFFF3A92CFFF3A92CFFF3A92CFFF3A92CFFF3A92CFFF3A92CFFF3A92CFFF
              3A92CFFF3A92CFFF3D94D0FF4194CDB400000004000000000000000000000000
              000000000000000D3D94D0FFDBFCFFFFD7F8FFFFD8F7FFFFD8F7FFFFD8F7FFFF
              D8F7FFFFD8F7FFFFD8F8FFFFDBFCFFFF3C93D0FF0000000D0000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000044194CDB43D94D0FF3B92CFFF3A92CFFF3A92CFFF3A92CFFF
              3A92CFFF3A92CFFF3B92CFFF3D94D0FF4194CDB3000000040000000000000000
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
              00000000FFFFE07FFFFFE000FFFF0000FFFF0000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000010000000F
              0000000F0000000F0000000F0007FFFF0007FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF}
          end
          object lblGroupHosts: TLabel
            Left = 54
            Top = 17
            Width = 111
            Height = 23
            Caption = '-groupname-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
        end
        object pgcMultipleHosts: TPageControl
          Left = 1
          Top = 61
          Width = 594
          Height = 429
          ActivePage = tsMassSettings
          Align = alClient
          TabOrder = 1
          object tsMassSettings: TTabSheet
            Caption = 'Multiple Host Configuration'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            DesignSize = (
              586
              401)
            object btnApplyConfigToGroup: TButton
              Left = 418
              Top = 111
              Width = 162
              Height = 55
              Anchors = [akTop, akRight]
              Caption = 'Apply settings'
              CommandLinkHint = 'to checked hosts below'
              ImageIndex = 26
              Images = Images
              Style = bsCommandLink
              TabOrder = 0
              WordWrap = True
              OnClick = btnApplyConfigToGroupClick
            end
            object grpConfigurationOptions: TGroupBox
              Left = 0
              Top = 172
              Width = 586
              Height = 229
              Align = alBottom
              Anchors = [akLeft, akTop, akRight, akBottom]
              Caption = 'Multiple Host Configuration Options'
              TabOrder = 1
              object pgcMultipleConfigOptions: TPageControl
                Left = 2
                Top = 15
                Width = 582
                Height = 212
                ActivePage = tsPage1
                Align = alClient
                Images = Images
                TabOrder = 0
                object tsPage1: TTabSheet
                  Caption = 'NIC Options'
                  ImageIndex = 35
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object grpModifyNicOptions: TGroupBox
                    Left = 6
                    Top = 3
                    Width = 534
                    Height = 146
                    Align = alCustom
                    BiDiMode = bdLeftToRight
                    Caption = '     Modify NIC options for checked hosts'
                    ParentBiDiMode = False
                    TabOrder = 0
                    object cbGroupHostsDisableAll: TCheckBox
                      Left = 14
                      Top = 49
                      Width = 252
                      Height = 17
                      Caption = 'Disable All Network Adapters for checked hosts'
                      TabOrder = 1
                      OnClick = cbGroupHostsDisableAllClick
                    end
                    object cbGroupHostsEnableAll: TCheckBox
                      Left = 14
                      Top = 32
                      Width = 252
                      Height = 17
                      Caption = 'Enable All Network Adapters for checked hosts'
                      TabOrder = 0
                      OnClick = cbGroupHostsEnableAllClick
                    end
                    object cbGroupHostsReEnableAfter: TCheckBox
                      Left = 272
                      Top = 42
                      Width = 154
                      Height = 17
                      Caption = 'Re-Enable Adapter(s) after '
                      TabOrder = 2
                      OnClick = cbGroupHostsReEnableAfterClick
                    end
                    object rbGroupHostsHours: TRadioButton
                      Left = 431
                      Top = 83
                      Width = 58
                      Height = 16
                      Caption = 'Hours'
                      Checked = True
                      Enabled = False
                      TabOrder = 5
                      TabStop = True
                      OnClick = rbHoursClick
                    end
                    object rbGroupHostsMinutes: TRadioButton
                      Left = 431
                      Top = 64
                      Width = 66
                      Height = 17
                      Caption = 'Minutes'
                      Enabled = False
                      TabOrder = 4
                      OnClick = rbMinutesClick
                    end
                    object seGroupHostsHoursMinutes: TSpinEdit
                      Left = 431
                      Top = 40
                      Width = 65
                      Height = 22
                      Enabled = False
                      MaxValue = 9999
                      MinValue = 1
                      TabOrder = 3
                      Value = 1
                    end
                    object chkAutoUpdateIp: TCheckBox
                      Left = 14
                      Top = 87
                      Width = 141
                      Height = 17
                      Hint = 
                        'This will update the current IP address of the host from DNS bef' +
                        'ore accessing the remote host.'
                      Caption = 'Auto-update IP Address'
                      Checked = True
                      State = cbChecked
                      TabOrder = 6
                    end
                    object grpLine: TGroupBox
                      Left = 14
                      Top = 76
                      Width = 230
                      Height = 6
                      TabOrder = 7
                    end
                  end
                  object chkModifyNicOptions: TCheckBox
                    Left = 11
                    Top = 1
                    Width = 15
                    Height = 17
                    TabOrder = 1
                    OnClick = chkModifyNicOptionsClick
                  end
                end
                object tsCredentials: TTabSheet
                  Caption = 'Set Credentials'
                  ImageIndex = 29
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object grpModifyCredentials: TGroupBox
                    Left = 6
                    Top = 3
                    Width = 219
                    Height = 146
                    Caption = '     Modify Credentials for checked hosts'
                    TabOrder = 0
                    object cbGroupHostsUseAltCreds: TCheckBox
                      Left = 19
                      Top = 27
                      Width = 161
                      Height = 17
                      Caption = 'Connect as a different user'
                      TabOrder = 0
                      OnClick = cbGroupHostsUseAltCredsClick
                    end
                    object lblGroupHostsCredPass: TLabeledEdit
                      Left = 19
                      Top = 105
                      Width = 169
                      Height = 21
                      EditLabel.Width = 50
                      EditLabel.Height = 13
                      EditLabel.Caption = 'Password:'
                      Enabled = False
                      PasswordChar = '*'
                      TabOrder = 2
                    end
                    object lblGroupHostsCredUser: TLabeledEdit
                      Left = 19
                      Top = 65
                      Width = 169
                      Height = 21
                      EditLabel.Width = 157
                      EditLabel.Height = 13
                      EditLabel.Caption = 'Username (or domain\username)'
                      Enabled = False
                      TabOrder = 1
                    end
                    object chkShowPass: TCheckBox
                      Left = 80
                      Top = 86
                      Width = 97
                      Height = 17
                      Caption = 'Show characters'
                      Enabled = False
                      TabOrder = 3
                      OnClick = chkShowPassClick
                    end
                  end
                  object chkModifyCredentials: TCheckBox
                    Left = 11
                    Top = 1
                    Width = 14
                    Height = 17
                    TabOrder = 1
                    OnClick = chkModifyCredentialsClick
                  end
                end
                object tsMessage: TTabSheet
                  Caption = 'Show User Message'
                  ImageIndex = 28
                  ExplicitLeft = 0
                  ExplicitTop = 0
                  ExplicitWidth = 0
                  ExplicitHeight = 0
                  object grpModifyUserMessage: TGroupBox
                    Left = 6
                    Top = 3
                    Width = 565
                    Height = 178
                    Align = alCustom
                    Caption = '     Modify user message'
                    TabOrder = 0
                    DesignSize = (
                      565
                      178)
                    object memoUserMessage: TMemo
                      Left = 211
                      Top = 15
                      Width = 346
                      Height = 155
                      Anchors = [akLeft, akTop, akRight, akBottom]
                      Enabled = False
                      Lines.Strings = (
                        'Your network card(s) have been disabled by technology '
                        'support because of suspected malicious activity, likely '
                        'performed by a virus on your system.'
                        ''
                        'Please contact your technology support team immediately '
                        'for more information and remediation.'
                        ''
                        'phone:  1-800-XXX-XXX'
                        '  email:  YOUR_SUPPORT_TEAM@your_company.com')
                      ScrollBars = ssVertical
                      TabOrder = 1
                      OnKeyDown = memoUserMessageKeyDown
                    end
                    object cbGroupHostsDisplayMsg: TCheckBox
                      Left = 29
                      Top = 15
                      Width = 162
                      Height = 32
                      Caption = 'Display a message to user on NIC disable'
                      TabOrder = 0
                      WordWrap = True
                      OnClick = cbGroupHostsDisplayMsgClick
                    end
                  end
                  object chkModifyUserMessage: TCheckBox
                    Left = 11
                    Top = 1
                    Width = 13
                    Height = 17
                    TabOrder = 1
                    OnClick = chkModifyUserMessageClick
                  end
                end
              end
            end
          end
          object tsMassActions: TTabSheet
            Caption = 'Multiple Host Actions'
            ImageIndex = 1
            DesignSize = (
              586
              401)
            object btnDeployToCheckedHosts: TButton
              Left = 417
              Top = 64
              Width = 144
              Height = 55
              Anchors = [akTop, akRight]
              Caption = 'Deploy'
              CommandLinkHint = 'to checked hosts'
              ImageIndex = 25
              Images = Images
              Style = bsCommandLink
              TabOrder = 0
              WordWrap = True
              OnClick = btnDeployToCheckedHostsClick
            end
            object btnGetSysInfoList: TButton
              Left = 417
              Top = 6
              Width = 144
              Height = 55
              Anchors = [akTop, akRight]
              Caption = 'Retrieve info'
              CommandLinkHint = 'from checked hosts'
              ImageIndex = 2
              Images = Images
              Style = bsCommandLink
              TabOrder = 1
              WordWrap = True
              OnClick = btnGetSysInfoListClick
            end
          end
        end
        object lvGroupHosts: TListView
          Left = 7
          Top = 88
          Width = 409
          Height = 163
          Align = alCustom
          Anchors = [akLeft, akTop, akRight]
          Checkboxes = True
          Columns = <
            item
              Width = 25
            end
            item
              Caption = 'Host'
              Width = 248
            end>
          ReadOnly = True
          RowSelect = True
          PopupMenu = PopUpGroupHosts
          TabOrder = 2
          ViewStyle = vsReport
          OnColumnClick = lvGroupHostsColumnClick
          OnCompare = lvGroupHostsCompare
        end
        object panelNoHostsInGroup: TPanel
          Left = 55
          Top = 124
          Width = 274
          Height = 109
          Color = clInfoBk
          ParentBackground = False
          TabOrder = 3
          Visible = False
          OnClick = panelNoHostsInGroupClick
          object lblNoHostsInGroup: TLabel
            Left = 8
            Top = -15
            Width = 258
            Height = 112
            Alignment = taCenter
            Caption = 
              #13#10'There are currently no hosts in this group. '#13#10#13#10'To add them, c' +
              'lick the '#39'Tools'#39' menu and add '#13#10'a single machine or add multiple' +
              ' computers.'#13#10#13#10'     [click to dismiss]'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = lblNoHostsInGroupClick
          end
        end
      end
    end
    object Tab03_HostDetail: TTabSheet
      Caption = 'Tab03_HostDetail'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object panelHostDetail: TPanel
        Left = 0
        Top = 0
        Width = 596
        Height = 491
        Align = alClient
        DoubleBuffered = True
        ParentBackground = False
        ParentDoubleBuffered = False
        TabOrder = 0
        object Panel1: TPanel
          Left = 1
          Top = 1
          Width = 594
          Height = 60
          Align = alTop
          Color = clBtnHighlight
          ParentBackground = False
          PopupMenu = pmHostActions
          TabOrder = 0
          object lblHost: TLabel
            Left = 51
            Top = 17
            Width = 37
            Height = 23
            Caption = 'Host'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Image1: TImage
            Left = 13
            Top = 13
            Width = 32
            Height = 32
            Picture.Data = {
              055449636F6E0000010001002020000001002000A81000001600000028000000
              2000000040000000010020000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000040000000D00000014000000160000001600000016000000140000000D
              0000000400000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000200000009
              0000001B000000310000003F0000004300000043000000430000003F00000031
              0000001B00000009000000020000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000900000023
              1A16134882705DC4958069FF947E68FF937E68FF947E68FF957F69FF81705DC4
              1A16134800000022000000090000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000001264574873
              9D8A72FFC5B7A5FFE7E2D6FFF4F0E4FFF3F0E4FFF4F0E4FFE7E2D6FFC6B8A7FF
              9D8A72FF60544676000000230000001600000016000000160000001600000016
              000000160000001600000016000000160000001600000016000000150000000D
              000000040000000000000000000000000000000000000000000000169F8A74FF
              D8CFBDFFDED5C1FFD3C6AEFFCEC1A7FFCEC0A7FFCEC1A7FFD3C6AEFFDED5C1FF
              DBD1C1FF9F8B75FF000000480000004300000043000000430000004300000043
              0000004300000043000000430000004300000043000000430000003F0000002B
              0000000D000000000000000000000000000000000000000000000012A28E78FF
              C9BAA2FFC0AF94FFBEAC91FFBDAB90FFBDAB90FFBDAB90FFBEAC91FFC0AF94FF
              C9BAA1FFA28D77FF958069FF958069FF958069FF958069FF958069FF958069FF
              958069FF958069FF958069FF958069FF958069FF958069FF96826AFF897762C4
              00000015000000040000000D0000001500000016000000160000001EA7937EFF
              B29E81FFB09B7EFFDACFB6FFE4DCCBFFE4DBCAFFE4DCCBFFDACFB6FFB09B7EFF
              B19C80FFA7937DFFD1C6B2FFD0C5B0FFD0C5B0FFD0C5B0FFCFC4AFFFCFC4AFFF
              CFC4AFFFCFC4AFFFCFC4AFFFCFC4AFFFCFC4AFFFCFC4AFFFD4C9B4FF98836BFF
              000000160000000D0000002B0000003F0000004300000043000000444C433A6B
              A89580F8A99277FFCFC2AAFFBCA988FFBCA988FFBCA988FFCFC2AAFFA99277FF
              AE9A84FFC6B8A4FFD2C6B2FFD0C4B1FFD0C4B1FFD0C4B0FFCFC2AFFFCDC0ACFF
              CCBFABFFCCBFABFFCCBFABFFCCBFABFFCCBFABFFCDC0ACFFD3C8B6FF96816BFF
              0000001600000015897762C497836CFF95816BFF95816AFF94806AFF948069FF
              937F69FF927E67FF998671FF917C66FF917D66FF917C66FF998671FF927E67FF
              927E68FF917D66FF917C65FF907B65FF907B65FF907B64FFA79680FFCEC2ADFF
              CBBFAAFFCBBFAAFFCBBFA9FFCBBFAAFFCBBFAAFFCBBFAAFFD5CBB8FF97826AFF
              000000160000001697836EFFD1BA9DFFC7AF8FFFC6AD8EFFC5AD8EFFC5AD8EFF
              C4AD8EFFC4AC8DFFC4AC8DFFC4AC8DFFC4AC8DFFC4AC8DFFC4AC8DFFC4AC8DFF
              C4AC8DFFC4AC8DFFC4AC8DFFC5AD8DFFC6AE8EFFCDB496FF917C66FFCFC3AEFF
              CABEA9FFCABEA8FFCABDA8FFCABEA8FFCABEA8FFCCBFAAFFD8CEBDFF98836BFF
              000000160000001698846DFFD2BDA1FFD9D1BDFFECECE7FFEBECE9FFEAECE9FF
              EAEBE9FFE9EAE9FFE9EAE9FFE8EAE9FFE8E9E9FFE8EAE9FFE9EAE9FFE9EAE9FF
              E9EBE9FFEAECE9FFEBECE9FFECECE7FFD9D2BDFFCDB89BFF927D66FFCEC2ADFF
              FFFDF1FFC7BBA5FFFFFBF0FFC8BBA5FFFFFDF2FFCBBFA9FFDAD0C0FF98846CFF
              000000160000001699846EFFD6C2A8FFD2CBB8FFE18E24FFE3911EFFE99822FF
              ED9D22FFF3A422FFF7AA22FFFCB023FFFFB323FFFDB123FFF8AB22FFF4A522FF
              EEA022FFEA9922FFE69320FFE18919FFD2CCB9FFD1BDA2FF927D65FFFFFFF6FF
              C8B9A5FFFFF9EEFFC7B9A3FFFFF9EEFFC9BBA6FFCCBFAAFFDCD3C4FF99856DFF
              0000001600000016998570FFDAC8B2FFCCC4B3FFE39531FFE79E3AFFE89D2FFF
              ECA12EFFF1A82FFFF5AD2FFFFAB330FFFEB830FFFBB530FFF6AF2FFFF2A92FFF
              EEA42FFFE99E2FFFE5982CFFE18F23FFCCC5B5FFD7C3AAFF927D67FFCEC1ACFF
              FFFAEEFFC7B9A4FFFFF9EDFFC8BAA5FFFFFBF0FFCDBFABFFDED6C7FF9A866DFF
              00000016000000169C8770FFDFCFB9FFC7BEACFFE29532FFE5A041FFEAA644FF
              ECA537FFF0A630FFF3AC31FFF7B031FFFAB233FFF7B133FFF4AD32FFF1A832FF
              ECA332FFE89E32FFE4982FFFE18F25FFC7BFAEFFDAC9B2FF958068FFFFFFF5FF
              CABCA7FFFFF9EDFFC9BBA6FFFFF9EEFFCBBDA8FFCEC0ACFFE1D8CAFF9A856EFF
              00000016000000169C8872FFE4D5C1FFC1B7A4FFE19130FFE39E3DFFE8A645FF
              EEAC4DFFEFAC45FFF1A933FFF3AA2FFFF4AC30FFF3AC30FFF1A931FFEEA531FF
              EBA131FFE79C30FFE2962EFFE08D24FFC1B7A6FFDFD0BAFF97816BFFD2C5B0FF
              FFFCF1FFCCBEA9FFFFFBEFFFCCBEA9FFFFFCF0FFCFC2ADFFE3DCCEFF9B866FFF
              00000016000000169D8973FFE8DCC9FFBCB19DFFDF8E2EFFE1993CFFE6A142FF
              EAA849FFEDAF4FFFF0B455FFF1B553FFF1AF44FFF0AB3BFFECA22CFFEBA02DFF
              E79B2CFFE3972BFFDF9129FFDF8921FFBCB09CFFE4D6C1FF98836DFFD5C7B4FF
              D1C2AFFFD0C2AEFFD0C1AEFFD0C2AFFFD0C1AEFFD1C2AFFFE7DED2FF9C8770FF
              00000016000000169F8B75FFEDE2D0FFB7A995FFDC8C2CFFDF973AFFE39D40FF
              E7A345FFEAA94BFFECAD51FFEEB257FFEFB55DFFEFB862FFF0B968FFEFBA6EFF
              EBB66AFFEBB66EFFEBB978FFEAB573FFB6A792FFE9DCC9FF9B856FFFD7CAB6FF
              D5C6B3FFD4C5B1FFD4C5B1FFD4C6B0FFD4C6AFFFD2C5AFFFE8E0D5FF9D8871FF
              0000001600000016A08B75FFF2E9D8FFB1A38EFFDA8629FFDC9238FFE0993FFF
              E39F43FFE6A448FFE8A84DFFEAAC52FFEBAF57FFEBB15DFFEBB262FFEBB466FF
              EAB46CFFE9B571FFE8B373FFE9AF6FFFB0A088FFEEE1D0FF9D8670FFDDCCB9FF
              E3CABAFFE3CAB8FFDFCBB4FFE2D0AFFFE0CFAEFFD8C9AFFFEBE5D8FF9E8872FF
              0000001600000016A18C77FFF8EEDFFFAC9C86FFD68227FFD88E35FFDC943DFF
              E09A41FFE29F46FFE4A34BFFE6A650FFE7A955FFE8AC5AFFE8AD5FFFE7AE63FF
              E7AF68FFE6B06DFFE6AF71FFE6AD6EFFAB9880FFF2E8D7FF9F8873FFE6CCBEFF
              008A3EFF008B3DFFEFD1B6FF0018E7FF0017E6FFDFCEAEFFEEE6DAFF9F8973FF
              0000001600000016A38E77FFFBF4E7FFA7967EFFD37D26FFD68732FFD98F39FF
              DD943EFFDF9945FFE29D48FFE3A14DFFE4A453FFE5A658FFE5A85DFFE5A962FF
              E4AC66FFE4AB6BFFE4AD70FFE5AC6EFFA69278FFF7EEDFFFA18A73FFE6CDBFFF
              00C552FF00C551FFECD0B6FF7966FFFF7665FFFFDECDAEFFF0E8DEFF9F8973FF
              0000001600000016A48E79FFFFFAEEFFA28D73FFD37920FFD47F29FFD78630FF
              DC8D35FFDD913BFFE19741FFE29A46FFE39D4CFFE4A151FFE4A356FFE4A55BFF
              E4A661FFE4A766FFE4A96CFFE6A96DFFA18A6FFFFCF5E6FFA18B76FFE0CEBEFF
              E6CDC0FFE6CCBFFFE1CEBAFFE0D1B4FFDFD0B3FFD9CAB2FFF0EBE0FFA08A74FF
              0000001600000015A6907AFFFFFFF5FF998061FF9B8669FF9B876CFF9A866CFF
              9A866BFF9A856BFF9A856AFF99846AFF998469FF998469FF998368FF998368FF
              998367FF998367FF9A8366FF9A8264FF997F5FFFFFF8ECFFA38D77FFC4AB8BFF
              C4AA8BFFC3A98AFFC2AA8AFFC2AA88FFC1A886FFD8CAB6FFF2ECE4FFA08B74FF
              000000160000000DA8937DFFFFFFF7FFFFFFF4FFFFFFF6FFFFFFF6FFFFFFF6FF
              FFFFF6FFFFFFF6FFFFFFF6FFFFFFF6FFFFFFF6FFFFFFF6FFFFFFF6FFFFFFF6FF
              FFFFF6FFFFFFF6FFFFFFF6FFFFFFF5FFFFFFF4FFFFFEF3FFA28D77FFC1A887FF
              BFA786FFBFA686FFBFA686FFBFA685FFBEA583FFD8CAB6FFF4EFE8FFA18C75FF
              0000001600000004A5917DB3A7927CFFCFC2ADFFCDC1ABFFCDC0ABFFCDC0ABFF
              CDC0ABFFCDC0ABFFCDC0ABFFCDC0ABFFCDC0ABFFCDC0ABFFCDC0ABFFCDC0AAFF
              CCC0AAFFCCC0AAFFCDC0AAFFCDC0ABFFCDC1ACFFA48E78FFC6B9ABFFFFFDFDFF
              FDFBFAFFFCFAFAFFFCFAFAFFFCFAFAFFFDFAFAFFD7C8B5FFF6F0EAFFA28D76FF
              000000160000000000000004A99581B0AD9983FFAC9782FFAC9782FFAC9782FF
              AC9782FFAC9782FFAC9782FFAC9782FFAC9782FFAC9782FFAC9782FFAB9680FF
              A8937DFFA8937EFFAA9480FFAA9681FFAA9681FFBDAB98FFDED1BEFFDBCDBAFF
              D9CCB9FFD9CBB8FFD9CBB8FFD9CBB8FFD9CBB8FFD8C9B6FFF7F4ECFFA38E77FF
              0000001600000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000016A59078FF
              FCF9F4FFDFD1BEFFC3AB8AFFC4AD8DFFC4AD8DFFC4AB8CFFC2AA8AFFC1A889FF
              C1A889FFC1A889FFC1A889FFC0A888FFBFA685FFDACCB9FFF9F5F0FFA48F78FF
              0000001600000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000016A48F79FF
              FCF8F3FFDBCCBAFFBEA584FFBFA786FFBFA786FFBFA786FFBFA686FFBFA686FF
              BFA686FFBFA686FFBFA686FFBFA685FFBEA483FFDBCBB9FFFBF7F2FFA48F79FF
              0000001600000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000016A59079FF
              FBF8F4FFDACAB6FFFBFAF8FFFBFAF8FFFBFAF8FFFBFAF8FFFBFAF8FFFBFAF8FF
              FBFAF8FFFBFAF8FFFBFAF8FFFBFAF8FFFBFAF8FFDACAB6FFFBF8F4FFA59079FF
              0000001600000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000015A6917BFF
              FCFAF7FFDACAB6FFDAC9B5FFDAC9B5FFDAC9B5FFDAC9B5FFDAC9B5FFDAC9B5FF
              DAC9B5FFDAC9B5FFDAC9B5FFDAC9B5FFDAC9B5FFDACAB6FFFCFAF7FFA6917BFF
              0000001500000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000DA9947DFF
              FFFFFDFFFDFAF7FFFCF9F5FFFCF9F5FFFCF9F5FFFCF9F5FFFCF9F5FFFCF9F5FF
              FCF9F5FFFCF9F5FFFCF9F5FFFCF9F5FFFCF9F5FFFDFAF7FFFFFFFDFFA9947DFF
              0000000D00000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000000000000004A6927EB3
              A9937DFFCEC1ABFFCCC0A9FFCCBFA9FFCCBFA9FFCCBFA9FFCCBFA9FFCCBFA9FF
              CCBFA9FFCCBFA9FFCCBFA9FFCCBFA9FFCCC0A9FFCEC1ABFFA9937DFFA6927EB3
              0000000400000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000004
              A99581B0AD9883FFAC9782FFAC9782FFAC9782FFAC9782FFAC9782FFAC9782FF
              AC9782FFAC9782FFAC9782FFAC9782FFAC9782FFAD9883FFA99581B000000004
              00000000FE00FFFFF8003FFFF8003FFFF8000000F8000000F800000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000080000000FFF80000FFF80000FFF80000FFF80000FFF80000FFF80000
              FFFC0001}
          end
          object lblGroup: TLabel
            Left = 500
            Top = 13
            Width = 29
            Height = 13
            Caption = 'Group'
            Visible = False
          end
          object lblRemoteIpAddress: TLabel
            Left = 51
            Top = 40
            Width = 96
            Height = 13
            Caption = 'lblRemoteIpAddress'
          end
        end
        object ToolBar1: TToolBar
          Left = 1
          Top = 61
          Width = 594
          Height = 31
          ButtonHeight = 30
          ButtonWidth = 126
          Caption = 'ToolBar1'
          DrawingStyle = dsGradient
          Images = Images
          List = True
          ShowCaptions = True
          TabOrder = 1
          object btnHostActions: TToolButton
            Left = 0
            Top = 0
            Caption = 'Host Actions'
            DropdownMenu = pmHostActions
            EnableDropdown = True
            ImageIndex = 6
            Indeterminate = True
            Style = tbsDropDown
            OnClick = btnHostActionsClick
          end
          object btnnRefreshHost: TToolButton
            Left = 141
            Top = 0
            Action = actnRefreshHost
            Caption = 'Retrieve host info'
          end
          object btnnDeploySvc: TToolButton
            Left = 267
            Top = 0
            Action = actnDeploySvc
            Caption = 'Deploy NIC Padlock'
          end
        end
        object pgc1: TPageControl
          Left = 1
          Top = 92
          Width = 594
          Height = 398
          ActivePage = ts1
          Align = alClient
          TabOrder = 2
          object ts1: TTabSheet
            Caption = 'Details'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object btnnDeploySvc1: TJvTransparentButton
              Left = 3
              Top = 143
              Width = 169
              Height = 28
              Action = actnDeploySvc
              Caption = 'Deploy NIC Padlock'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 25
            end
            object btnnDeploySvc2: TJvTransparentButton
              Left = 3
              Top = 114
              Width = 189
              Height = 28
              Action = actnUserMessage
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 28
            end
            object btnnDeploySvc3: TJvTransparentButton
              Left = 3
              Top = 58
              Width = 94
              Height = 28
              Action = actnPingTheHost
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 36
            end
            object btnnDeploySvc4: TJvTransparentButton
              Left = 3
              Top = 86
              Width = 157
              Height = 28
              Action = actnRefreshHost
              Caption = 'Retrieve host info'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 2
            end
            object btnnDeploySvc5: TJvTransparentButton
              Left = 3
              Top = 2
              Width = 134
              Height = 28
              Action = actnUseAlternateCreds
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 29
            end
            object btnnDeploySvc6: TJvTransparentButton
              Left = 3
              Top = 30
              Width = 155
              Height = 28
              Action = actnModifyIpAddress
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5577749
              Font.Height = -15
              Font.Name = 'Verdana'
              Font.Style = []
              HotTrack = True
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clHotLight
              HotTrackFont.Height = -15
              HotTrackFont.Name = 'Verdana'
              HotTrackFont.Style = []
              FrameStyle = fsNone
              ParentFont = False
              TextAlign = ttaRight
              Images.ActiveImage = Images
              Images.ActiveIndex = 27
            end
            object cbReEnableAdapters: TCheckBox
              Left = 298
              Top = 9
              Width = 130
              Height = 17
              Hint = 
                'Checking this will re-enable any NIC'#39's disabled by this applicat' +
                'ion after the specified time period.'
              Caption = 'Re-Enable NIC(s) after'
              TabOrder = 3
              OnClick = cbReEnableAdaptersClick
            end
            object chkDisableAllAdapters: TCheckBox
              Left = 194
              Top = 19
              Width = 99
              Height = 20
              Hint = 
                'Checking this will ensure all NIC'#39's are disabled and remain disa' +
                'bled.'
              Caption = 'Disable All NIC'#39's'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = chkDisableAllAdaptersClick
            end
            object chkEnableAllAdapters: TCheckBox
              Left = 194
              Top = 2
              Width = 99
              Height = 17
              Hint = 
                'Checking this will ensure all NIC'#39's are enabled and remain enabl' +
                'ed.'
              Caption = 'Enable All NIC'#39's'
              TabOrder = 0
              OnClick = chkEnableAllAdaptersClick
            end
            object lvRemoteNics: TListView
              Left = 194
              Top = 45
              Width = 389
              Height = 122
              Align = alCustom
              Anchors = [akLeft, akTop, akRight, akBottom]
              Columns = <
                item
                  Caption = 'Enable'
                end
                item
                  Caption = 'Disable'
                end
                item
                  Caption = 'IP Address'
                  Width = 120
                end
                item
                  Caption = 'MAC'
                  Width = 120
                end
                item
                  Caption = 'Mfg'
                  Width = 100
                end
                item
                  Caption = 'Caption'
                  Width = 150
                end
                item
                  Caption = 'GUID'
                  Width = 200
                end>
              DoubleBuffered = True
              OwnerDraw = True
              ReadOnly = True
              RowSelect = True
              ParentDoubleBuffered = False
              ShowWorkAreas = True
              TabOrder = 6
              ViewStyle = vsReport
              OnColumnClick = lvRemoteNicsColumnClick
              OnCompare = lvRemoteNicsCompare
              OnDrawItem = lvRemoteNicsDrawItem
              OnMouseUp = ListView1MouseUp
            end
            object pnlSysInfo: TPanel
              Left = 0
              Top = 173
              Width = 586
              Height = 197
              Align = alBottom
              Color = 5525059
              DoubleBuffered = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentBackground = False
              ParentDoubleBuffered = False
              ParentFont = False
              ParentShowHint = False
              PopupMenu = pmHostActions
              ShowCaption = False
              ShowHint = False
              TabOrder = 7
              DesignSize = (
                586
                197)
              object lblSysInfoHostname: TLabel
                Left = 94
                Top = 17
                Width = 95
                Height = 13
                Caption = 'lblSysInfoHostname'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoModel: TLabel
                Left = 94
                Top = 84
                Width = 75
                Height = 13
                Caption = 'lblSysInfoModel'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoUsername: TLabel
                Left = 93
                Top = 49
                Width = 95
                Height = 13
                Caption = 'lblSysInfoUsername'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoDomain: TLabel
                Left = 94
                Top = 33
                Width = 82
                Height = 13
                Caption = 'lblSysInfoDomain'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoManufacturer: TLabel
                Left = 94
                Top = 67
                Width = 112
                Height = 13
                Caption = 'lblSysInfoManufacturer'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoPrimaryOwnerName: TLabel
                Left = 397
                Top = 17
                Width = 142
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'lblSysInfoPrimaryOwnerName'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoSystemType: TLabel
                Left = 397
                Top = 33
                Width = 106
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'lblSysInfoSystemType'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoTotalPhysMem: TLabel
                Left = 397
                Top = 67
                Width = 116
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'lblSysInfoTotalPhysMem'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label1: TLabel
                Left = 62
                Top = 17
                Width = 26
                Height = 13
                Caption = 'Host:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 48
                Top = 33
                Width = 39
                Height = 13
                Caption = 'Domain:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label3: TLabel
                Left = 35
                Top = 50
                Width = 52
                Height = 13
                Caption = 'Username:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label4: TLabel
                Left = 18
                Top = 67
                Width = 69
                Height = 13
                Caption = 'Manufacturer:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label5: TLabel
                Left = 55
                Top = 84
                Width = 32
                Height = 13
                Caption = 'Model:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label6: TLabel
                Left = 316
                Top = 17
                Width = 75
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'Primary Owner:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label7: TLabel
                Left = 363
                Top = 33
                Width = 28
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'Type:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label8: TLabel
                Left = 291
                Top = 67
                Width = 100
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'Physical Mem (RAM):'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblLastRefreshed: TLabel
                Left = 14
                Top = 3
                Width = 84
                Height = 13
                Caption = 'Last Retrieved:  -'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clYellow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label13: TLabel
                Left = 306
                Top = 50
                Width = 85
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'Windows Version:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoWindowsVersion: TLabel
                Left = 397
                Top = 50
                Width = 125
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'lblSysInfoWindowsVersion'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object Label15: TLabel
                Left = 29
                Top = 175
                Width = 76
                Height = 13
                Caption = 'User Message?:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblUserMessageVisible: TLabel
                Left = 111
                Top = 175
                Width = 125
                Height = 13
                Caption = 'lblUserMessageVisible'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clYellow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label16: TLabel
                Left = 297
                Top = 175
                Width = 83
                Height = 13
                Caption = 'User Credentials:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblUserCredentialsType: TLabel
                Left = 386
                Top = 175
                Width = 131
                Height = 13
                Caption = 'lblUserCredentialsType'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clYellow
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label18: TLabel
                Left = 361
                Top = 84
                Width = 30
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'Serial:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object lblSysInfoSerial: TLabel
                Left = 398
                Top = 84
                Width = 75
                Height = 13
                Anchors = [akTop, akRight]
                Caption = 'lblSysInfoModel'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
              end
              object mmoDeploymentResult: TMemo
                Left = 29
                Top = 104
                Width = 526
                Height = 65
                Anchors = [akLeft, akTop, akRight]
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clDefault
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                PopupMenu = pmClearHostHistory
                ReadOnly = True
                ScrollBars = ssVertical
                TabOrder = 0
                OnClick = mmoDeploymentResultClick
                OnKeyDown = mmoDeploymentResultKeyDown
              end
            end
            object rbHours: TRadioButton
              Left = 518
              Top = 19
              Width = 58
              Height = 17
              Caption = 'Hours'
              Enabled = False
              TabOrder = 5
              OnClick = rbHoursClick
            end
            object rbMinutes: TRadioButton
              Left = 518
              Top = 2
              Width = 66
              Height = 17
              Caption = 'Minutes'
              Enabled = False
              TabOrder = 1
              OnClick = rbMinutesClick
            end
            object seHoursMinutes: TSpinEdit
              Left = 433
              Top = 7
              Width = 65
              Height = 22
              MaxValue = 9999
              MinValue = 1
              TabOrder = 2
              Value = 1
              OnChange = seHoursMinutesChange
            end
          end
          object tsAutoStart: TTabSheet
            Caption = 'Automatic Start Applications'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvAutoStartApplications: TListView
              Left = 0
              Top = 0
              Width = 586
              Height = 370
              Align = alClient
              BorderStyle = bsNone
              Columns = <
                item
                  Caption = 'Caption'
                  Width = 100
                end
                item
                  Caption = 'Command'
                  Width = 250
                end
                item
                  Caption = 'User'
                  Width = 100
                end
                item
                  Caption = 'Location'
                  Width = 250
                end>
              ReadOnly = True
              RowSelect = True
              TabOrder = 0
              ViewStyle = vsReport
              OnColumnClick = lvAutoStartApplicationsColumnClick
              OnCompare = lvAutoStartApplicationsCompare
            end
          end
        end
      end
    end
  end
  object sbGeneralInfo: TStatusBar
    Left = 0
    Top = 501
    Width = 840
    Height = 18
    Panels = <
      item
        Width = 200
      end>
  end
  object Images: TImageList
    Left = 144
    Top = 88
    Bitmap = {
      494C010126002900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      00000000000000000000000000000072B5000271B30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000071BE00A2ECFF00A5EBFF00006DB000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000088543D00BFDEE70000AEED0000B6F600A7EBFF00006CB0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080564200F8CFC100C36341000C76990004BEFB0003BAF500A7EEFF00006D
      B400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000053A58000008A4A0000894900008A4A0053A580000000
      0000000000000000000000000000000000000000000000000000000000007F54
      4100F4D3C600CE785900DA7B59003F4B4D0002C9FF0006C4FC0001C4FD00A4F5
      FF000070C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000053A58000009B5C0000CE900000D1940000CE9000009B5C0053A5
      80000000000000000000000000000000000000000000000000007F544000F5D4
      C700CE7D6000CE816500D88668009157420003BDF2001693BC001D6B8D001469
      8D009DF9FF000C4D000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008A4A0000C7890000C88A0000C6890000C88A0000C78900008A
      4A000000000000000000000000000000000000000000855A4600FEDCD200F5D4
      C900E4B5A300D4896D00DD907300C97E6400253D3C00168C4D0002B950005ED1
      760099E69200A0F1A30011560000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000089480025CF990000C07F0000BE7E0000C07F0025CF99000089
      4800000000000000000000000000000000008A5F4C00875C490081564300A068
      4F00F7DACE00E0967400E0987200483A3C00243B3C0010BF14000AB31200A3E6
      A500067000000F50000014590200175C05000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008A490066DAB4001EC68E0016C388001EC68E0066DAB400008A
      4900000000000000000000000000000000000000000000000000000000008855
      3D00F8DDC8007658480026296C001116DD0023179C001EB42B0015BC2F00A8EA
      B500007000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000068BA9400109F630074DAB7007ADEBD0074DAB700109F630068BA
      940000000000000000000000000000000000000000000000000000000000955C
      36009AA4FF00111DF2001D27F0002229F2002623DF002C8430001FC54600ADF0
      C200017000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000068BA9400008A480000894600008A480068BA94000000
      0000000000000000000000000000000000000000000000000000000000000F1B
      A500ABB2FF002433EF002C3AEE002E3BF0002E36FC002F434D0029D15B00B2F3
      CB00016F00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000151E
      9F00B3BDFF002E43F6003247F5003348F7003346FF002F2C99002DBF6200B5F8
      D700016E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001921
      A000BECAFF00BBC7FF00BBC7FF00BCC8FF00BCC7FF00BBBEFF00BBFFDC00C0FF
      EC00037100000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006369
      BF001921A000161E9D00161D9D00161D9D00161DA0001815AC00007600000372
      000055A04F000000000000000000000000000000000000000000000000000000
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
      0000A3A1A0008783820086818000868180008681800087838200A3A1A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B
      7C00B98B7C00B98B7C00B98B7C00B98B7C000000000000000000000000000000
      0000000000000000000000000000669D70003B8648003C8648003B8648003C86
      48003D8749003C8648003D874900478D53000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008884
      8300A49D9E00B9B0B500C2B8BE00C3B8BE00C2B8BE00B9B0B500A49D9E008884
      8300000000000000000000000000000000000000000000000000000000000000
      0000B98B7C00ECDEC200ECDEC100ECDEC100ECDEC100ECDDC100ECDDC000ECDD
      C000ECDDC000ECDDC000ECDDC000B98B7C00B4B4B300AFAFAD00AEAEAB00ADAD
      AB00ADADAB00B0AFAD00BBB3B7002C7F3A0045A15F00419E5B00409E5B00449F
      5E0047A1600045A05E0047A262003A8647000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008F8A8A00B6AD
      B2007F957E0014601400004C0000004D0000004C0000146014007F957E00B6AD
      B2008F8A8A000000000000000000000000000000000000000000000000005147
      3A00B98B7C00FEFEFE00000000000000000000000000F7F7F700F2F3F200EEEE
      EE00FAFAFA00ECECEC00FEFDFD00B98B7C00B0B0AD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0024793200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003A9C5500FFFFFF00FFFFFF00358242000000000082808100000000000000
      000000000000366F3200356E2F00356E2F00356E2F00356E2F004D7D4C000000
      0000356F31004B7B4A000000000000000000000000008F8A8A00B8AEB200597F
      5600004E00000063000005630400056604000563040000630000004E0000597F
      5600B8AEB2008F8A8A000000000000000000000000000000000000000000A592
      7C00B98B7C00FEFCFB00FEFBF80000000000F3F3F00000000000BBBAB7000000
      0000E4E3DF0000000000FAF6F100B98B7C00AEAEAB00FFFFFF00FDFDFC00FCFC
      FB00FCFCFB00FFFEFE00FFFFFF002478320047A86300FFFFFF00FFFFFF00329C
      5000FFFFFF00FFFFFF004BAB6600388344000000000085808500347037003870
      3B00376F34007FC4EF007CC0E9007CC0E9007CC0E9007DC2E90047858900356D
      32007EC2EA006FAE970038703A0000000000AAA8A700A7A0A20082947E00004C
      000000680000124B1000183F16000F540E00183F1600124B100000690000004C
      000082947E00A7A0A200AAA8A700000000006C5E4F009B87700099846D009782
      6C00B98B7C00FBF8F600FBF3EC0000000000F2ECE500F7EFE800F7EEE700F7EF
      E700F7EFE700F6EEE700F4ECE500B98B7C00ADADAB00FFFFFF00F8F8F800F8F8
      F800F8F8F800FBFAFB00FFFFFF002779340055B3700043A96000FFFFFF00FFFF
      FF00FFFFFF0043A9600058B573003A84460000000000827B800055AA750055A5
      730055A5720053A26B0052A1690052A1690052A36A004C674F0051A36D00509F
      6C004D9D66004E9D68005CAB7B0037703B0095919000BBB1B7001C5A1B000062
      0000104E0D000F4F0D0004690300026F0100046A0400104D0D00104E0B000062
      00001C5A1A00BBB1B7009591900000000000B98B7C00CDB89B00F3F9F100F0F7
      F100B98B7C00FAF5F200F9ECE20000000000F2E5DC00F2E6DC00EFE3DA00EFE3
      DA00EFE3DA00EFE3DA00EFE3D900B98B7C00ADADAB00FFFFFF00F6F5F500F6F5
      F500F6F5F500F9F7F800FFFFFF002477320055B77200FFFFFF00FFFFFF0048AD
      6500FFFFFF00FFFFFF0058B975003783440000000000A4A2A100A39BA000499A
      67004C9A69004F9D6C004A9566004F9E6C004FA06D0050705A005D846A005750
      53005851540062585C005DA97B00366F390096919000C4BABF00004100000167
      000012430E0005670000114108000679190011450B00056C000013490300016B
      000000430000C4BABE0096919000000000009E8A7600D1C3AD00E4902100EB98
      2000B98B7C00F9F4EF00000000000000000000000000EEE0D400EADDD100EADD
      D000EADDD000EADDD000EADDD000B98B7C00ADADAB00FFFFFF00F3F2F200F3F2
      F200F3F2F200F6F4F400FFFBFF001D742C00FFFFFF00FFFFFF005BBA760061BD
      7B005ABA7600FFFFFF00FFFFFF0034814100000000009E9B99009F999B00417B
      56004174510044916100486452004B8461004B856200554A4E00689178004F4D
      4C00514F4E006D66690060A77E00356F380099949300CEC4CA00003D00000065
      000009510000018B2300059E490004AF58000462000002730000001EE500001E
      E10000430000CEC4C8009994930000000000A08C7800D6CFBE00E3942F00E8A1
      3700B98B7C00ECDCBF00ECDCBF00ECDCBF00ECDCBF00ECDCBF00ECDCBF00EBDC
      BF00EBDCBF00EBDCBF00EBDCBF00B98B7C00ADADAB00FFFFFF00F0F0EF00F0F0
      EF00F0F0EF00F2F1F100FAF6F80072A67B0049A8620068C885006FCA8A0073CC
      8D0071CC8C006DCA890071CF8E003984450000000000878484007D9B88007EBC
      AA00C0EBFF0080BFAC0053434A00496D5700496E57004D404600759D85006B65
      67006D6769008C82870064A58000346F370099959400DCD2D600003800000087
      21000BB15F0003B75D000A9A50000B8D44000A480100036E0000001EE500001E
      E00000400000DCD3D4009995940000000000A28E7900DEDACB00DF8E2B00E6A1
      4000B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B7C00B98B
      7C00B98B7C00B98B7C00B98B7C00B98B7C00ADADAB00FFFFFF00EEECEB00EEED
      EC00EEEDEC00EEEDEC00F2EFEF00FCF4F80074A67C00257733002A7A3700307F
      3D0035824300378345003985470069A3730000000000807B7E0088B99E0071A8
      88006EA6840071A9880074AD8D0074AD8E0074AD8E0074AD8E0072AB8B0071AB
      8B0071AC8B0071AB8A008BBAA200346F37009D999800E1DBDD0027501F0000B3
      580004AF5A0008984A000A883D000E793300006B000006570000055A00000063
      000027561E00E1DBDD009D99980000000000A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EBB36B00EDAF6C00EDDDCF00B98B
      7C0000000000000000000000000000000000ADADAB00FFFFFF00EAE9E900EBEA
      EA00EBEAEA00EAE9E900F5F4F400FFFFFF00FFFFFF00D8EADC00FFFFFF00C2B7
      C0000000000000000000000000000000000000000000847F84002E6E3300326E
      3600326E3600326E3600326E3600326E3600326E3600326E3600326E3600326E
      3600326E3600326E3600336E370000000000C6C5C300CBC6C700ADB4A6000044
      07000096410009823B000E6D2F0013642500024F000000580000006B0000003B
      0000ADB7A900CBC6C700C6C5C30000000000A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EBB36B00EDAF6C00EDDDCF00B98B
      7C0000000000000000000000000000000000ADADAB00FFFFFF00E7E7E600E8E8
      E700E8E8E700E6E7E500FFFFFF00CCCCCB00A9A8A600A9A8A600FFFFFF00B3B5
      BA0000000000C784430000000000000000000000000082808100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A09C9B00F2EAEF008395
      7E0001350000065F19000C6B1B00116C1100006B0000005E0000013800008398
      8100F2EBEF00A09C9B000000000000000000A5917C00ECEFE300D0751600D986
      2900DE923500E39A3E00E5A04800E5A35200E4A55C00E4A56100E9E6D700B98B
      7C0000000000000000000000000000000000AEAEAB00FFFFFF00E4E3E200E5E4
      E300E5E4E300E4E3E200FFFFFF00A6A6A400FBFBFA00FFFFFF00E9EBEE00BBBF
      C400BB813C00F4C07300BE854500000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAA5A400F9F3
      F700BBC4B80033542E00012B0000052D0100032C000034553100BBC4B900F9F3
      F800AAA5A400000000000000000000000000A9947F00F3F7EA00F0F6EC00EFF6
      EE00EFF6EE00EEF5ED00EEF4EC00EEF4EB00EEF3E900EEF3E700EFF0E300B98B
      7C0000000000000000000000000000000000AEAEAC00FFFFFF00E0DFDE00E1DF
      DE00E1DFDE00E0DFDE00FFFFFF00A5A5A200FFFFFF00E7E8E900CFD1D300BA7E
      3500BA844200B9854500BB864600BC8747000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5A0
      9F00D9D6D800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D9D6D800A5A0
      9F000000000000000000000000000000000077695B00AB968100AA958000A995
      8000A9958000A9948000A9948000A7927D00A58F7900A48E7800A48F7900B19C
      860000000000000000000000000000000000AFAFAD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9E9E900CCCDCD00000000000000
      000000000000BB87470000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CCCAC900A9A5A400A7A3A100A7A3A100A7A3A100A9A5A400CCCAC9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B7B7B500B0B0AD00AEAEAC00AEAE
      AB00AEAEAB00ADAEAB00AEAEAB00AFAFAD00B7B8B70000000000BB7F3600BB85
      4200BB874700D4B48C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EDEDED00D4D4D400D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300DCDCDC00FBFBFB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1E6DC004BB68B0000AC
      6D0000AC6D004BB68B00D1E6DC00000000000000000097969600565454005654
      5400565454005654540056545400565454005654540056545400565454005654
      5400565454005F5D5C00F4F4F40000000000A3A3A3008E8E8E008C8C8C008C8C
      8C008B8B8B008B8B8B008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008D8D8D009A9A9A00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000767573007F7D7C000000
      00007F7D7C007675730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000013A46B0000CA8C003FD4
      A3003FD4A30000CA8C0013A46B0000000000000000008D8D8D00595757005856
      5600585656005856560058565600585656005856560058565600585656005856
      5600585656005B595900F4F4F400000000008E8E8E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008D8D8D00000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E7D7B0073716F008987
      850073716F007F7D7B000000000000000000000000000000000000000000CCAB
      8200E1D2C0000000000000000000000000008BC7AB0000C0820000C07F007FDD
      B9007FDDB90000C07F0000C082008BC7AB00000000008E8E8E00605E5E005D5B
      5B005D5B5B005D5B5B005D5B5B005D5B5B005D5B5B005D5B5B005D5B5B005D5B
      5B005D5B5A0062606000F4F4F400000000008C8C8C00FFFFFF005F5F5F009F9F
      9F009C9C9C00FFFFFF005E5E5E00A0A0A0009F9F9F009E9E9E009E9E9E009E9E
      9E009C9C9C00FFFFFF008C8C8C00000000000000000000000000000000000000
      00000000000000000000000000007F7C7A0084818000928E8C00BFBCBA00C4C0
      BE00BFBCBA008C89870085828000807D7B00000000000000000000000000E3CF
      B600F3EBDE00CFB89F0000000000000000007FC3A30014C68A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0015C68A007FC3A300000000009191910069666600615F
      5F0062606000626060006260600062606000626060006260600062606000615F
      5F006260600069676700F7F7F700000000008C8C8C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008B8B8B00000000000000000000000000000000000000
      0000000000000000000000000000939290007C7A7800C8C5C200ABA8A6008988
      8600ABA8A600C8C5C3007C7A78007F7D7B00000000000000000000000000DEC5
      AA00FFFEF100EEE0C500DABFA100DABEA0007BA271003AC8980000B875007FD9
      B5007FD9B50000B875003EC999008DC9AC0000000000DBDBDB007F7D7C00726F
      6F006E6B6B00666463006664630066646400666464006563630069676600706E
      6D00706E6D00A1A0A000FEFEFE00000000008C8C8C00FFFFFF0060606000A1A1
      A1009F9F9F009C9C9C00FFFFFF005F5F5F00A0A0A0009D9D9D00FFFFFF005F5F
      5F009E9E9E00FFFFFF008C8C8C00000000000000000000000000000000000000
      00000000000000000000000000000000000093929000D5D2D1008F8C8B000000
      00008F8C8B00D5D2D10087858300000000000000000000000000CFB19100E7D4
      B700FFFCEB00FFFBEA00FFFDF000FFFDF100F2F8EA0035AA760042CB9B0042C7
      940042C7940043CC9D0044B1820000000000000000000000000000000000BCBB
      BB009493920078767500716F6E006B6968006A6867007A7877007E7C7B009D9C
      9C00E7E7E7000000000000000000000000008C8C8C00FFFFFF00FFFFFF00FFFF
      FF00FEFEFE00FCFCFC00FBFBFB00FCFCFC00FCFCFC00FCFCFD00FCFCFC00FDFE
      FE00FCFCFC00FFFFFF008C8C8C00000000000000000000000000767573007F7D
      7C0000000000807F7D007B7A78009C9A980085828000D8D5D400B8B6B4009592
      8F00B8B6B400D8D5D400858280008A87850000000000D1B49300F4EAD500FFFA
      E600FFF8E300FFF8E300FFF8E300FFF8E300FFF9E500D8EBD20055B382004AAF
      7E004AB07F0047A06C00D7EBE200000000000000000000000000000000000000
      000000000000A4A3A300807E7D006F6D6C0073706F0082818000F9F9F9000000
      0000000000000000000000000000000000008C8C8C00FFFFFF00636363006464
      6500A3A3A300A0A1A100A0A0A0009F9F9F00FAF9F70060606000A2A2A200A1A1
      A1009F9F9F00FFFFFF008C8C8C000000000000000000000000007E7D7B007371
      6F008987850073716F00838280009C9998009A989600A8A6A600E0DEDD00E6E4
      E300E0DEDD00A6A4A200ACAAA900918F8D00EFE7DF00E7CFAE00FFF5DF00FFF4
      DD00FFF4DD00FFF4DD00FFF4DD00FFF4DD00FFF4DD00FFF4DD00FFF7E100FFF9
      E400FFFAE600EBD0AF00EFE7DF00000000000000000000000000000000000000
      0000FDFDFD00B8B8B8008684830072706F00807D7C008A898800F1F1F1000000
      0000000000000000000000000000000000008C8D8D00FFFFFF00FBFAF900FCFB
      FA00FBFAF900F9F8F700FCFBFA00FCFBF900F9F7F600F8F7F600FBFAF900F0EF
      EF00FAF9F800FFFFFF008C8C8C00000000007F7C7A0084818000928E8C00BFBC
      BA00C4C0BE00BFBCBA008E8B89008986850087858400A8A7A5008D8B89009794
      92008C8B8900A19F9E000000000000000000DEC4A900FDF3DE00FFF0D600FFF0
      D600FFF0D600FFF0D600FFF0D600FFF0D600FFF0D600FFF0D600FFF0D600FFF0
      D600FFF0D600FDF3DE00DEC4A900000000000000000000000000000000000000
      0000F3F3F3008E8D8C008986850078767500787675008F8D8B00BCBCBB00FEFE
      FE00000000000000000000000000000000008D8D8D00FFFFFF0047474700FFFF
      FE0047484800FDFCFA004A4A4A004B4B4B008B8B8B00F9F8F7008A8B8B004748
      480042434300FFFFFF008D8D8D000000000092908F007C7A7800C8C5C200ABA8
      A60089888600ABA8A600C8C5C3007C7A78007D7B7900A4A19F00969391000000
      0000969391009A9795000000000000000000DFC3A600FFF4DD00FFECCE00FFEC
      CF00FFECCF00FFECCF00FFECCF00FFECCF00FFECCF00FFECCF00FFECCF00FFEC
      CF00FFECCE00FFF4DD00DFC3A600000000000000000000000000000000000000
      0000C2C2C1008F8D8C007C7A79007D7B7A007D7B79008C8A880087868600F7F7
      F700000000000000000000000000000000008E8E8E00FFFFFF004E4E4E005151
      51004F505000FEFCFC0050505000FFFFFF004D4D4D00FBF9F9004A4A4A00F8F6
      F600F0EEEE00FFFEFE008C8C8C00000000000000000093919000D5D2D1008F8C
      8B00000000008F8C8B00D5D2D100878584000000000000000000000000000000
      000000000000000000000000000000000000E1C4A700FFF3DC00FFE8C800FFE8
      C800FFE8C800FFE8C800FFE8C800FFE8C800FFE8C800FFE8C800FFE8C800FFE8
      C800FFE8C800FFF3DC00E1C4A700000000000000000000000000000000000000
      000097969600918E8C00817F7E0082807F0082807F00848281008C8A8800F4F4
      F400000000000000000000000000000000008D8D8D00FFFFFF004B4B4B00FDFB
      FB004D4D4D00FAF8F800525252005454540066666700FAF7F7004A4B4B00F1EE
      EF00E8E6E600FDFCFC008C8C8C00000000009592900085828000D8D5D400B8B6
      B40095928F00B8B6B400D8D5D400858280008986840000000000000000000000
      000000000000000000000000000000000000E5D1BC00F6E1C600FFE4C000FFE4
      C100FFE4C100FFE4C100FFE4C100FFE4C100FFE4C100FFE4C100FFE4C100FFE4
      C100FFE4C000F6E1C600E5D1BC00000000000000000000000000000000000000
      000098989700918F8D0087858300878583008785830086848200918E8D00F4F4
      F400000000000000000000000000000000008D8D8D00FFFFFF0086868600F5F3
      F20088898900F4F1F00050505000FEFBFA004E4E4E00F5F2F1004A4B4B00F1EE
      ED00E9E6E500FFFFFE008C8C8C0000000000918E8C0099969400A7A4A300E0DE
      DD00E6E4E300E0DEDD00A6A4A200ACAAA900918F8D0000000000000000000000
      00000000000000000000000000000000000000000000E0BB9700FFEBCF00FFE0
      B900FFE1BA00FFE1BA00FFE1BA00FFE1BA00FFE1BA00FFE1BA00FFE1BA00FFE0
      B900FFEBCF00E0BB960000000000000000000000000000000000000000000000
      00009F9E9E0094918F008A8987008B8987008B8987008B898700928F8D00F8F8
      F800000000000000000000000000000000008D8D8D00FFFFFF00828281004848
      480083848300ECE9E8004B4B4B004D4D4D0086868500EBE8E700858584004848
      490043434400FFFFFF008D8D8D00000000000000000000000000A1A09E008C8B
      8900979492008C8B8900A19F9E00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F2E5D900E3BF9900FFEC
      D300FFE1BB00FFDCB100FFDCB100FFDCB100FFDCB100FFDCB100FFE1BB00FFEC
      D300E3BF9900F2E5D90000000000000000000000000000000000000000000000
      0000DFDFDF00928F8D00918F8D00908E8C00908E8C00949290009D9C9B00FEFE
      FE00000000000000000000000000000000008E8F8F00FFFFFF00FBF8F800FDFB
      FB00FBF9F900FAF8F800FDFBFB00FEFCFC00FCF9F900FAF7F700FBF9F900FEFB
      FB00FCFAFA00FFFFFF008F8F8F000000000000000000000000009A9795009693
      910000000000969391009A979500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F6EEE600E4C4
      A500E6C5A200E7C7A400E7C7A400E7C7A400E7C7A400E7C7A400E6C5A200E4C4
      A500F6EEE6000000000000000000000000000000000000000000000000000000
      000000000000CECDCD009C9A99009492900094918F009E9D9C00F7F7F7000000
      000000000000000000000000000000000000989898008F8F8F008D8D8D008E8E
      8E008D8E8E008D8D8D008E8E8E008E8E8E008D8E8E008D8D8D008D8E8E008E8E
      8E008E8E8E008F8F8F0098989800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00D0D0D0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002F76B6002E73B4002F73B3003073
      B4003077B6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002A8DD7003891CF00CCCC
      CC00F2F2F2000000000000000000000000000000000000000000000000000000
      000000000000369D6D00008C4B00008B4A00008B4A00008C4B00369D6D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000058B0E60058B0E60058B0E60058B0E600000000000000
      0000000000000000000000000000000000002F75B5004FC8FC004DC3F8004DC4
      F8003887C5003378B60000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBDBDB00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00779EAF003A9BDC003A99
      DC00B3BAB900CCCCCC00DBDBDB000000000000000000000000000000000044A1
      77000090500001A1690001AB760001AC790001AC790001AB760001A169000090
      500055A782000000000000000000000000000000000029282800292828002928
      2800292828002928280058B0E6003EA0D8003EA0D80058B0E600292828002928
      2800292828002928280029282800000000004382BC003B92CE004DC1F6004CBF
      F4004DC3F8003176B50000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BD954700B67E0E00B47B0900B47A
      0700B47A0700B47A0700B47A0700B57A0600BA7A0100BB7B02004AA4D50092F4
      FF00469DD4008F865500BD95470000000000000000000000000055A781000091
      520002AC770000C38C0000D79B0000DA9C0000DA9C0000D79C0001C38C0001AB
      76000092530055A7820000000000000000000000000000000000000000000000
      0000000000000000000058B0E60058B0E60058B0E60058B0E600000000000000
      000000000000000000000000000000000000000000004885BD003E92CC0053C6
      F80053C5F8002F72B0003377B500357BB9000000000000000000000000000000
      000000000000000000000000000000000000B67E0E00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7CCEE006BCD
      F00083EBFF003B9EE50081886B00DDDDDD000000000000000000009051000FB4
      830000D2980000D5980000D1920000CF900000D0910000D3960000D69B0000D1
      980001AB76000090500000000000000000000000000000000000000000000000
      0000000000000000000000000000403A36002924210000000000000000000000
      00000000000000000000000000000000000000000000000000004986BE004294
      CD005ECCFC005CCBFA005ECDFD003174B300357AB70000000000000000000000
      000000000000000000000000000000000000B47B0900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002082CD003E9ED9004FAF
      E0007DE9FD007FEFFF0052B4EA006CA6D30000000000369D6C0016AB780010C9
      960000D3970000CD8C00FFFFFF00FFFFFF00FFFFFF0000CC8C0000D1950000D5
      9B0001C18C0001A16900369E6D00000000000000000000000000000000000000
      00000000000000000000000000003F3D3C002B2A2A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004A87
      BD004597CF0067D2FC0065CFFA0067D2FC0057B2E2003578B400377AB6003D7E
      B70080A3C100000000000000000000000000B47A0700FFFFFF00FBFCFD00FAFA
      FA00FAFAFA00FAFAFA00FAFAFA00FDFCFB00FFFFFE002984CE008AEBFC006CE1
      F9005CC0E9003D8DD3003F93D9004395D70000000000008A480039C49D0000D1
      980000CB8C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000CA8C0000CF
      960000D29B0001AB7600008C4B0000000000AEAEAB00AEAEAB00AEAEAB00AEAE
      AB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAE
      AB00AEAEAB00AEAEAB00AEAEAB00AEAEAB000000000000000000000000000000
      00004C88BE004999CF0072D5FD005FC6F80048B2F4004EB7F7004FB9F90044AB
      F0003D8CCB004886BA000000000000000000B47A0700FFFFFF00F2F3F300F2F2
      F100F2F2F100F2F2F100F2F2F100F4F3F100FFF9F30065A5D90088D3F1007CE0
      F80057CCF0004296DA00A487410000000000000000000089460052D2B00000CC
      9200FFFFFF00FFFFFF00FFFFFF0000C48400FFFFFF00FFFFFF00FFFFFF0000C8
      8D0000D09A0000AD7900008B4A0000000000AEAEAB00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AEAEAB000000000000000000000000000000
      0000000000003376B4006DD1FE0058BDF60075D5FB0079D8FC007AD9FC0077D8
      FE005DC5FC003F8FCC0082A5C30000000000B47B0800FFFFFF00EAEAEB00EBEA
      E900EBEAE900EBEAE900EBEAE900EDEBE900F5EFEA008CB8DD0056B5E500D9F9
      FE004DD3F40049B5E8005A93BD00EDEDED00000000000088450068DDBE0000C9
      9100FFFFFF00FFFFFF0000C68C0000C8910000C58B00FFFFFF00FFFFFF00FFFF
      FF0000CC960000AD7800008B4A0000000000AEAEAB00FBFBFB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F8F7F700AEAEAB000000000000000000000000000000
      0000000000003578B50062CAFE0081DCFE007FDBFD0080DCFF0081DEFF0082DF
      FF0085E1FF005ABFF6003C80B90000000000B47B0800FFFFFF00E1E0E100E2E1
      E000E2E1E000E2E1E000E2E1E000E3E2E000EAE5E100ACC6DD003A9FDD008FE7
      F80091E7F80095E9FB004998DA009FBAD100000000000088460076E0C60000CB
      980000C5900000C6910000C8950000C9970000C8940000C38C00FFFFFF00FFFF
      FF0000C7920000AB7500008C4B0000000000AEAEAB00F5F4F400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F3F3F200AEAEAB000000000000000000000000000000
      0000000000003B7FBA006FD5FF007CDAFD007CDAFD0070CAF1004C97CB004C98
      CC0073CEF40071D9FF003C7EB80000000000B47B0800FFFFFF00D5D6D600D6D6
      D500D7D7D500D7D7D500D7D7D500D7D7D500DBD8D600C2CCD500388FD9003C8F
      D8003D90D8004093DD00489BE4004E9EE2000000000041A6750059C9A40049DE
      BC0000C7940000C8970000C9980000C9990000C9980000C7940000C38E00FFFF
      FF0000BD8A0000A0670040A8780000000000AEAEAB00F7F7F700000000000000
      000000000000F3F2F200000000000000000000000000F2F2F100000000000000
      000000000000F1F1F000F7F7F600AEAEAB000000000000000000000000000000
      0000000000003A80BC0074DBFF0077D8FC0078DAFE004A96CB00000000000000
      00004D99CE0077E0FF003D7FBA0000000000B57C0A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C67C00000000000000000000000000000A945800ADF8
      E90018D0A70000C4950000C6970000C6980000C7980000C7980000C6970000C5
      960012B58500008F50000000000000000000AEAEAB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AEAEAB000000000000000000000000000000
      000000000000387BB8006FD3F80073D9FC0073DAFD004A97CC00000000000000
      00004D9BCF0073D7FB003F82BB0000000000B57E0F00F7E0BF00E0A64900E0A7
      4C00E0A84D00E0A84D00E0A84D00E0A84D00E0A84D00E1A84D00E2A84D00E2A8
      4C00E2A64900FAE1BE00BA7E090000000000000000000000000055B18500199C
      6300BCFFF7005EE4C90000C59A0000C3960000C4970000C59A0022CAA2002FC1
      9600029355006ABC96000000000000000000AEAEAB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AEAEAB000000000000000000000000000000
      0000000000009BBDDB004B99CE0071DBFF006FD8FD0066C8F0004B99CD004D9A
      CF0069CEF5004F9ED1009DC0DC0000000000B6801300F2D8AE00D4922200D494
      2600D4942700D4942700D4942700D4942700D4942700D4942700D4942700D494
      2600D4922200F2D8AE00B7801200000000000000000000000000000000006ABA
      94000E96590074D5B600A0F4E10094EFDC007CE6CC005ED6B5002EB587000391
      520055B28700000000000000000000000000AEAEAB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AEAEAB000000000000000000000000000000
      000000000000000000004F8BC0004A99CE0067CEF6006EDBFF006FDDFF0069D3
      F9004E9ED100518EC2000000000000000000B8821700EED09B00ECCE9800ECCE
      9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE9A00ECCE
      9A00ECCE9800EED09B00B8821700000000000000000000000000000000000000
      00000000000044A877000087440000874300008744000089460044A979000000
      000000000000000000000000000000000000AEAEAB00AEAEAB00AEAEAB00AEAE
      AB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAEAB00AEAE
      AB00AEAEAB00AEAEAB00AEAEAB00AEAEAB000000000000000000000000000000
      00000000000000000000000000009CBFDC003E80BA003F80BA003F81BA003F82
      BB009DC0DD00000000000000000000000000CCA45600B8821700B7811600B781
      1600B7811600B7811600B7811600B7811600B7811600B7811600B7811600B781
      1600B7811600B8821700CCA45600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFAFA00B9B9B900AEAEAE00B7B7
      B700B9B9B900B8B8B800B8B8B800B7B7B700B7B7B700B6B6B600B6B6B600B6B6
      B600B7B7B700AEAEAE00AFAFAF00B9B9B900FDFDFD00F5F5F500F4F4F400F4F4
      F400F4F4F400F4F4F400F1F1F100DBDBDB00DBDBDB00F1F1F100F4F4F400F4F4
      F400F4F4F400F4F4F400F5F5F500FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE00E6E6E600D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300E6E6
      E600FEFEFE00000000000000000000000000BCBCBC00C2C2C200DDDDDD00BBBB
      BB00F0F0F000D2D2D200CECECE00D9D9D900D1D1D100CACACA00C2C2C200BABA
      BA00B7B7B700CCCCCC00CFCFCF00A9A9A900F7F7F7007B7A7A00777777007777
      770077777700777777007775730049A5DA0049A5DA0077757300777777007777
      770077777700777777007B7A7A00F7F7F7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE00E3E3
      E300555FA8003343C3003241C2003140C1002F3FC1002D3DC0002D3DC000545D
      A800E3E3E300FEFEFE000000000000000000A9A9A900E8E8E800CACACA00BCBC
      BC00FFFFFF00B8B8B800B8B8B800ECECEC00E4E4E400DCDCDC00D5D5D500CDCD
      CD00B8B8B800BFBFBF00D4D4D400A9A9A900FDFDFD00BEBCBB00BEBCBB00BEBC
      BB00BEBCBB00BEBCBB00A9A6A50065B6E80065B6E800A9A6A500BEBCBB00BEBC
      BB00BEBCBB00BEBCBB00BEBCBB00FDFDFD00000000003D38330038332F00322E
      2A002B282500262320001F1C1A0000000000323030000C0B0A00060605000404
      03000000000000000000000000000000000000000000FEFEFE00E3E3E300575F
      A8004C5CD9006678FE006679FE006679FE006679FE006679FE006679FE004051
      D500555EA700E3E3E300FEFEFE0000000000A9A9A900EDEDED00C7C7C700BCBC
      BC00FFFFFF00B8B8B800B8B8B800FEFEFE00F7F7F700EFEFEF00E7E7E700E0E0
      E000B8B8B800C1C1C100D8D8D800A9A9A900000000000000000000000000F9F9
      F900C9C9C800BBB9B800E3E3E300908C8800837E7C0000000000000000000000
      0000000000000000000000000000000000000000000045403A0084796F00C1B7
      AC007D7369007E746A0035312C00000000004B48460094887C00B9ADA1007D73
      69007E746A00000000000000000000000000FEFEFE00E3E3E3005861A8005261
      DA005F73FD005D71FB005E71FB005E72FB005E72FB005E71FB005D71FB006073
      FD003E4FD500555EA700E3E3E300FEFEFE00A9A9A900F0F0F000C9C9C900BCBC
      BC00FFFFFF00B8B8B800B8B8B800FFFFFF00FFFFFF00FFFFFF00FAFAFA00F2F2
      F200B9B9B900C3C3C300DDDDDD00A9A9A90000000000FDFDFD00FBFBFB00BDBB
      B900C1B4A100CEC3B000A79E91007C7773006E69660000000000000000000000
      000000000000000000000000000000000000000000004C46400084796F00CCC2
      B900776E64007A706600322F2C00000000002D29250094887C00C1B7AC00776E
      64007A706600060605000000000000000000E6E6E6005962A8005766DB005A6E
      FB005368F90099A5FC00556AF900596DF900596DF900556AF90099A5FC005368
      F9005B6FFB003D4ED400555EA800E6E6E600A9A9A900F4F4F400CBCBCB00B9B9
      B900F6F6F600FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFC
      FC00B9B9B900C5C5C500E1E1E100A9A9A90000000000BDBBB9009C958D009E96
      8C00B6A79300BBAB9400A99C8C009B958D00928B8200B9B7B500E3E3E3000000
      00000000000000000000000000000000000000000000544D470081766D00CCC2
      B900786F650070675E0057534F000000000048454300857A7000C1B7AC00786F
      65007A7066000C0B0A0000000000000000008488AB005C6ADB00556AF8005066
      F700B5BEFB00FFFFFF00BDC5FC004D63F7004D63F700C0C8FC00FFFFFF00B5BE
      FB005166F700566BF9003A4CD2008589AB00A9A9A900F7F7F700D0D0D000C2C2
      C200B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900BABABA00BABA
      BA00C0C0C000C8C8C800E5E5E500A9A9A90000000000ABA6A000D8A86500E6A7
      4600EFB14600F2B54600EBAC4600E1A34800BFA07800C9BEAB00A79E9100F8F8
      F800FBFBFB0000000000000000000000000000000000807975009C908400CCC2
      B900BFB3A900A5978A007F7B78000000000073716E008F837800C1B7AC00BFB3
      A900A6998D004947460000000000000000008084A9006171E6005066F5004B62
      F500C6CEFB00FFFFFF00FFFFFF00AEB8FA00AEB8FA00FFFFFF00FFFFFF00C3CB
      FB004C62F5005066F6004356DD008185A900A9A9A900FBFBFB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E9E9E900A9A9A90000000000ACA8A300D59D5300E7A0
      3700F0AB3800F3AD3600ECA43300E1983300C09F7500B7A79100A99C8C009D96
      8E009C958C00FBFBFB000000000000000000000000005E585100413C37005750
      49003C373200322E2A0038353300000000005E5D5B001816140024211F001816
      14000F0E0D001111110000000000000000007F84A8006574E6004B62F3004B61
      F300465DF300C6CDFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6CDFB00465D
      F3004B61F3004C62F4004557DD008185A900A9A9A900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EDEDED00A9A9A90000000000AEABA600CE954D00E198
      3600E9A64600EBAD5000EAAD5800E3A95E00C4A67F00EDB14400EBAC4600E1A3
      4800BFA17A00F9F9F9000000000000000000000000009C908400B0A295007E74
      6A007A706600776E64006B625A002D292500575049007E746A007A706600766C
      630070675E000000000000000000000000007F84A8006777E700465EF000475E
      F000465DF0003A53EF00E6E9FD00FFFFFF00FFFFFF00E6E9FD003A53EF00465D
      F000475EF000475EF1004558DC008185A900A9A9A900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F1F1F100A9A9A90000000000B0ADA900C48A4A00D58B
      3400DB974100DFA05000DFA65F00DCA86B00C4A78500EDA93400ECA43300E198
      3300C1A17800F9F9F900000000000000000000000000B7AB9F00B9ADA1008176
      6D0081766D00A9907A00B9A69300B7A48F00AF9680009E8C7C00826C5A007062
      560094887C002222210000000000000000007F84A8006A7BE700425AEE00425A
      EE003A54EE00ABB6F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00ABB6F7003A54
      EE00425AEE00425BEF004559DC008185A900AAAAAA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F5F5F500A9A9A90000000000B5B1AE00CBB49700CFB4
      9300D0B79500D0B79700D1B89900D0B99C00C3AE9400E8AB4F00EAAD5800E3A9
      5E00C3A78400F9F9F900000000000000000000000000000000009A8D81009C90
      8400857A7000544D47004F4943007E746A006E655C00816B5700A5907C009383
      7300544D47000000000000000000000000007F83A8006D7EE8003D56EC003953
      EC00ABB5F600FFFFFF00FFFFFF00BEC6F900BEC6F900FFFFFF00FFFFFF00ABB5
      F6003953EC003E57EC004659DC008085A900AAAAAA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F9F9F900A9A9A90000000000F8F7F700E9E4DF00EAE4
      DF00EAE4DF00B4ACA300BD8D5800C98D4700CE924800DFA05000DFA65F00DCA8
      6B00C4A98B00F9F9F90000000000000000000000000000000000736A6100A396
      890094887C009C9084003D383300000000004B453F007D73690084796F003D38
      330084807D00000000000000000000000000898DAF007E8CE4003650EA00334E
      EA00C3CAF800FFFFFF00C0C8F800324DE900324DE900C0C8F800FFFFFF00C3CA
      F800334EEA003852EB004959D5008A8EAF00AAAAAA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FCFCFC00A9A9A9000000000000000000000000000000
      000000000000B5B1AE00CBB49700CFB49300D0B79500D1B99900D1BB9C00D1BB
      9F00C4B4A200FBFBFB0000000000000000000000000000000000000000000000
      000099908600C1B7AC00645C5400000000007A706600A6998D00A69A90000000
      000000000000000000000000000000000000FEFEFE006F76B400828FE600304B
      E8002E49E70093A1F3002E49E700344EE800344EE8002E49E70093A1F3002E49
      E700324DE9004F60D700676FB200FEFEFE00AAAAAA00FFFFFF009E9E9E009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B00FFFFFF00A9A9A9000000000000000000000000000000
      000000000000F8F7F700E9E4DF00EAE4DF00EAE4DF00E9E4DF00E9E4DF00E9E4
      DF00EAE7E5000000000000000000000000000000000000000000000000000000
      0000A69A9000B9ADA1009C90840000000000AD9F92009C9084007A736C000000
      00000000000000000000000000000000000000000000FEFEFE007077B4008B97
      E8002C47E6002E49E6002F4AE600304BE600304BE6002F4AE6002E49E6002D49
      E7005666D9006870B200FEFEFE0000000000AAAAAA00FFFFFF00EFEFEF00EDED
      ED00ECECEC00EAEAEA00E9E9E900E8E8E800E6E6E600E5E5E500E3E3E300E2E2
      E200E0E0E000DFDFDF00FFFFFF00A9A9A9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE007279
      B5008E99E9002542E4002542E4002643E4002643E5002744E5002744E5005B6B
      DB006A71B200FEFEFE000000000000000000C6C6C600A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00C9C9C9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE007279B5006B77D600626FD5005E6BD3005A67D2005563D1005361CF006B73
      B300FEFEFE000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000225B
      C0000441BB001E58BF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008BAAE0002765C9002076
      E6000578EA000163DD00064EBC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E4E4
      E400CCCCCC00CCCCCC00CCCCCC00CCCCCC00E5E5E50000000000E2E2E200CCCC
      CC00CCCCCC00CCCCCC00E1E1E10000000000000000000000000075B0E5003D8F
      DB00328AD900328AD900328AD900328AD900328AD900074BBB00629CF400177E
      FF000075F8000075EE000367E1001D57BF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000B1A7
      9A0099856E0098846D0098846D009A846E00B8A89E00CCCCCC0056B28D00009E
      5E00009D5D00009E5E0053B28C00DDDDDD00000000004698DC00DEF0FA00A6DD
      F4009DDBF40095DAF3008DD8F30085D7F3007ED4F2000442BB00ADCDFE00FFFF
      FF00FFFFFF00FFFFFF00177EEF000441BB000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000000000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000DCDCDC00CCCCCC00CCCCCC00A592
      7C00B8A28400CBBDA500CBBDA500BBA48800B2907E004292650000A7690000BA
      860077DFC40000BA860000A66A004DAB8300000000003A96DB00EFFAFE00A0E9
      F90090E5F80080E1F70071DEF60062DAF50053D7F4000C56C0008CB4F6004C91
      FF001176FF002085FF003F89EB00235BC100000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000AB9D8E009B87700099846D009782
      6C0096806B00947F6900947F690098806B00A7826F00009E5A0000C08B0000BB
      8200FFFFFF0000BB820000C08C00009E5E00000000003A9BDB00F2FAFD00B2ED
      FA00A3E9F90094E6F80084E2F70075DEF60064DBF5003B9ADE003774D2008CB4
      F700B7D6FE0071A7F5002C6BCB0000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000009E8A7300CDB89B00F3F9F100F0F7
      F100EEF6F100EEF5F100EEF5F100F1F6F200FFF8F5000099570073E5CC00FFFF
      FF00FFFFFF00FFFFFF0077E5CC00009C5C000000000039A2DA00F6FCFE00C8F2
      FC00B8EFFB00ABECFA009BE8F9008AE3F7007BE0F6006BDCF6003E9BDE00155C
      C5000442BB001958C0001F75CA0000000000000000008080800040404000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000009E8A7600D1C3AD00E4902100EB98
      2000F4A42200FDB02300FFB32300F9A82200FF9D2100009B5E0000CC980000C8
      8F00FFFFFF0000C88F0000CC9700009E5D000000000039A6DA00FEFFFF00F8FD
      FF00F6FDFF00F5FCFF00F3FCFE00D8F6FC0093E6F80084E3F70075DFF60067DB
      F5005BD8F400D7F4FC003AA5DB0000000000000000008080800040404000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A08C7800D6CFBE00E3942F00E8A1
      3700EFA52F00F6AD2C00F7AE2C00F4A72B00F69C27005A97450000AD710000D3
      9D0075EDD40000D39D0000AE6F00489469000000000037ABDA00E8F6FB0093D4
      EF0087CEEE0072C0E900C9E9F600F2FCFE00F3FCFE00F2FCFE00F0FCFE00EFFB
      FE00EEFBFE00FEFFFF003BACDB0000000000000000008080800040404000FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A28E7900DEDACB00DF8E2B00E6A1
      4000EEAE4E00F1B14D00F1B65500F0B65C00F1B36100FFB7740058B48B00009A
      5800009958000099580062BA900000000000000000003FADDB00F1FAFD0093DE
      F50092DCF40080D5F20069CAED006BCBEA0084D3EF007FD2EF0079D0EF0075CF
      EE0071CFEE00E9F7FB003CB0DB0000000000000000008080800040404000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EBB36B00EDAF6C00EDDDCF00B98B
      7C0000000000000000000000000000000000000000003FB2DC00F7FCFE008DE4
      F80090DEF5009EE0F500ABE1F600EFFBFE00F4FDFE00F3FCFE00F1FCFE00EFFB
      FE00EEFBFE00FAFDFF0057BBE00000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EBB36B00EDAF6C00EDDDCF00B98B
      7C0000000000000000000000000000000000000000003AB4DB00FDFEFE00FEFF
      FF00FEFEFF00FDFEFF00FEFFFF00EAF7FB006DC8E4006EC8E3006EC8E3006EC8
      E3007CCEE60083D0E8000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A5917C00ECEFE300D0751600D986
      2900DE923500E39A3E00E5A04800E5A35200E4A55C00E4A56100E9E6D700A98D
      7B00000000000000000000000000000000000000000058C1E00060C2E10062C3
      E20062C3E20062C3E20061C3E20055BEDF000000000000000000000000000000
      000000000000000000000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000008080800040404000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000A9947F00F3F7EA00F0F6EC00EFF6
      EE00EFF6EE00EEF5ED00EEF4EC00EEF4EB00EEF3E900EEF3E700EFF0E300A58E
      7900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      400000000000FFFFFF0000000000000000000000000080808000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      400000000000FFFFFF000000000000000000C6B8AA00AB968100AA958000A995
      8000A9958000A9948000A9948000A7927D00A58F7900A48E7800A48F7900B19C
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF00C6C6
      C60084848400C6C6C600FFFFFF00C6C6C6000000000000000000000000009B9B
      9B007D7D7D0078787800737373006F6F6F0088888800000000000A812800037A
      1D0000000000000000000000000000000000000000000000000000000000E4E4
      E400CCCCCC00CCCCCC00CCCCCC00CCCCCC00E5E5E50000000000E2E2E200CCCC
      CC00CCCCCC00CCCCCC00E1E1E10000000000000000000000000000000000E4E4
      E400CCCCCC00CCCCCC00CCCCCC00CCCCCC00E5E5E50000000000E2E2E200CCCC
      CC00CCCCCC00CCCCCC00E1E1E100000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840084848400FFFF
      FF0084848400FFFFFF0084848400848484000000000000000000000000009191
      9100D5D3D300E2E0DF00DFDCDB00E1DFDF0075757500000000000A86320042A0
      5E001B883500000000000000000000000000000000000000000000000000B1A7
      9A0099856E0098846D0098846D009A846E00B8A89E00CCCCCC0056B28D00009E
      5E00009D5D00009E5E0053B28C00DDDDDD00000000000000000000000000B1A7
      9A0099856E0098846D0098846D0099856D00B6AB9A00CCCCCC007381CF00374D
      CC00384DCB00384DCC007280CD00DDDDDD008400000084000000840000008400
      00000000000000000000848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF00840000008400000084000000840000000000000000000000000000000000
      0000A8A8A800C3C1C000219650001A904800148E42000F8A3A00399E5D007FC0
      950045A261000A7A25005266560078787800DCDCDC00CCCCCC00CCCCCC00A592
      7C00B8A28400CBBDA500CBBDA500BBA48800B2907E004292650000A7690000BA
      860077DFC40000BA860000A66A004DAB8300DCDCDC00CCCCCC00CCCCCC00A592
      7C00B8A28400CBBDA500CBBDA500BAA58700AD9776006165A100344FDB00375D
      F900375DFA00385DF9003751D8006F7BC5000000000000000000000000008400
      0000FF00000084000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000CDCDCD00B3B3B300AFAFAF00ABAB
      AB009E9E9E009D9D9D00289A5A008FCAA8008CC8A40089C5A00087C49D0069B5
      840081C1960047A465001385300050675500AB9D8E009B87700099846D009782
      6C0096806B00947F6900947F690098806B00A7826F00009E5A0000C08B0000BB
      8200FFFFFF0000BB820000C08C00009E5E00AB9D8E009B87700099846D009782
      6C0096806B00947F6900947F690097826900A28964002541D5003E63FD003B60
      FA003A5DF8003C60FA004165FB00334ACC000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000ADADAD00E4E2E200D7D5D500D5D3
      D200D1CECD00CAC3C200309E620093CDAC006EB98D006AB7880065B5840060B2
      7F0066B4810082C197003B9F5B00017E25009E8A7300CDB89B00F3F9F100F0F7
      F100EEF6F100EEF5F100EEF5F100F1F6F200FFF8F5000099570073E5CC00FFFF
      FF00FFFFFF00FFFFFF0077E5CC00009C5C009E8A7300CDB89B00F3F9F100F0F7
      F100EEF6F100EEF5F100EEF5F100F1F7F000FEFFEB00203CD200A6B8FF00FFFF
      FF00FFFFFF00FFFFFF00A9BAFF003148CB000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000B3B3B300E0DDDD00A6714C00A671
      4C00A6714C00A6714C0036A26A0095CEAF0093CDAC0090CBA9008FCBA70073BB
      8F0089C7A00045A4670009873500666D68009E8A7600D1C3AD00E4902100EB98
      2000F4A42200FDB02300FFB32300F9A82200FF9D2100009B5E0000CC980000C8
      8F00FFFFFF0000C88F0000CC9700009E5D009E8A7600D1C3AD00E4902100EB98
      2000F4A42200FDB02300FFB32300F8A92000FBA417001C3DDB005776FF005775
      FF005473FD005775FE005B78FF002F47CF000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      000084000000000000000000000000000000B9B9B900DEDBDB00B47F5900CE97
      6F00D8AD9000D9AE90003CA46E0037A26C0033A066002F9C600054AE7B0090CB
      A9004EAA7300178E4500CBCDC80072727200A08C7800D6CFBE00E3942F00E8A1
      3700EFA52F00F6AD2C00F7AE2C00F4A72B00F69C27005A97450000AD710000D3
      9D0075EDD40000D39D0000AE6F0048946900A08C7800D6CFBE00E3942F00E8A1
      3700EFA52F00F6AD2C00F7AE2C00F3A82A00F2A121007A6686003856E6006C86
      FF007389FF006D86FF003D58E2006568A3000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF0084000000000000000000000000000000BFBFBF00DFDCDC00B37E5800CB94
      6D00CD966E00CF987000D19A7100D29B7300D49D7400A6714C0037A0660059B2
      80002797560035933700D6D1D00077777700A28E7900DEDACB00DF8E2B00E6A1
      4000EEAE4E00F1B14D00F1B65500F0B65C00F1B36100FFB7740058B48B00009A
      5800009958000099580062BA900099756600A28E7900DEDACB00DF8E2B00E6A1
      4000EEAE4E00F1B14D00F1B65500F0B65C00F0B55E00F9BE6A007783CB00253D
      D4002E3ED4002B3CD4008389D100AA916B000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      000084000000000000000000000000000000C4C4C400E1DEDC00B27C5700C790
      6A00C9926C00CB946D00CD966F00CF987000D19A7200A6714C003CA46E00309E
      64009BC5A1004FA85500D7D3D1007D7D7D00A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EBB36B00EDAF6C00EDDDCF00B98B
      7C00FFFFFF00FFFFFF00CDB89B00A58A7500A38F7A00E5E5D800D8842400E097
      3900E6A44500EAAB4F00ECB05900EBB26200EAB36A00EBB16900E9E2C900B493
      730000D04C0000CD4A00F9E7D500A38C72000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF0084000000000000000000000000000000CACACA00E1DFDE00B07B5600C38D
      6700C58F6900C8916A00CA936C00CC956E00CE976F00A6714C00DBD6D6009090
      9000C0BAB800BFB8B700D7D3D30083838300A5917C00ECEFE300D0751600D986
      2900DE923500E39A3E00E5A04800E5A35200E4A55C00E4A56100E9E6D700A98D
      7B00EBB36B00EDAF6C00F2E5DC00A18B7500A5917C00ECEFE300D0751600D986
      2900DE923500E39A3E00E5A04800E5A35200E4A55C00E3A56100E8E6D600A88E
      7900C9A69000C6A28C00F1E6DB00A18B74000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000000000000000000000000000CECECE00E2DFDF00AF7A5500B07A
      5500B07B5600B17C5700B27D5700B37E5800B47F5900A6714C00DCD8D7009797
      97008C8C8C0089898900D9D5D4008A8A8A00A9947F00F3F7EA00F0F6EC00EFF6
      EE00EFF6EE00EEF5ED00EEF4EC00EEF4EB00EEF3E900EEF3E700EFF0E300A58E
      7900EBB36B00EDAF6C00EFE8DF00A18B7600A9947F00F3F7EA00F0F6EC00EFF6
      EE00EFF6EE00EEF5ED00EEF4EC00EEF4EB00EEF3E900EEF3E700EFF0E300A58E
      7900F5E2D400F1DED000EFE8DF00A18B76000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D3D3D300F1EFEF00E2DFDF00E2DF
      DF00E1DFDE00E1DEDD00E0DDDC00DFDCDB00DEDBDB00DEDBD900EDECEB009D9D
      9D00C4BEBD00C2BCBA00DAD6D50090909000C6B8AA00AB968100AA958000A995
      8000A9958000A9948000A9948000A7927D00A58F7900A48E7800A48F7900B19C
      8600EBB36B00EDAF6C00F2ECE300A38D7600C6B8AA00AB968100AA958000A995
      8000A9958000A9948000A9948000A7927D00A58F7900A48E7800A48F7900B19C
      8600B9A18900B69E8500F2ECE300A38D76000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D6D600D3D3D300D0D0D000CCCC
      CC00C8C8C800C2C2C200BEBEBE00B9B9B900B4B4B400AFAFAF00A9A9A900A4A4
      A4009392920091909000DBD7D600979797000000000000000000000000000000
      0000A28E7900DFDCCD00D8842400E0973900E6A44500EAAB4F00ECB05900EBB2
      6200EBB36B00EDAF6C00EDDDCF00B98B7C000000000000000000000000000000
      0000000000000000000000000000A58F7800F7F2EB00EEDCCC00EEDCCD00EEDD
      CD00EDDCCC00ECDACA00F4F0E800A58F78000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D0D0D000DFDFDF00EAEAEA00CFCAC900CBC5C400CAC3
      C200C8C2C000C7C0C000DCD9D8009D9D9D000000000000000000000000000000
      0000A38F7A00E7E9DC00D0751600D9862900DE923500E39A3E00E5A04800E5A3
      5200E4A55C00E4A56100E9E6D700A98D7B000000000000000000000000000000
      0000000000000000000000000000A6907A00F8F4ED00DACBB700DACBB800DACB
      B800DACBB700DACAB700F8F3EC00A5907A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DCDCDC00DCDCDC00E6E3E300E1DEDC00DFDC
      DC00DFDCDB00DEDBDB00EEECEC00A4A4A4000000000000000000000000000000
      0000A9947F00F3F7EA00F0F6EC00EFF6EE00EFF6EE00EEF5ED00EEF4EC00EEF4
      EB00EEF3E900EEF3E700EFF0E300A58E79000000000000000000000000000000
      0000000000000000000000000000A9947E00FEFBF500FBF6F200FBF6F200FBF6
      F200FBF6F200FBF6F200FEFBF500A9947E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DFDFDF00C9C9C900C3C3C300BFBF
      BF00BABABA00B5B5B500AFAFAF00C7C7C7000000000000000000000000000000
      0000AF9D8900AB968100AA958000A9958000A9958000A9948000A9948000A792
      7D00A58F7900A48E7800A48F7900B19C86000000000000000000000000000000
      0000000000000000000000000000C6B8A900AA957F00A9937D00A8937D00A893
      7D00A8937D00A9937D00AA957F00C6B8A9000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000075B0E5003D8F
      DB00328AD900328AD900328AD900328AD900328AD900328AD900328AD900328A
      D9003289D900378DDA0084B8E80000000000000000000000000075B0E5003D8F
      DB00328AD900328AD900328AD900328AD900328AD900328AD900328AD900328A
      D9003289D900378DDA0084B8E800000000000000000000000000000000000000
      000000000000E4E4E41BCCCCCC33CCCCCC33CCCCCC33CCCCCC33E5E5E51A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000001B000000330000003300000033000000330000001A0000
      000000000000000000000000000000000000000000004698DC00DEF0FA00A6DD
      F4009DDBF40095DAF3008DD8F30085D7F3007ED4F20078D3F20071D2F1006BD0
      F10068CFF100C1EAF8003E93DB0000000000000000004698DC00DEF0FA00A6DD
      F4009DDBF40095DAF3008DD8F30085D7F3007ED4F20078D3F20071D2F1006BD0
      F10068CFF100C1EAF8003E93DB00000000000000000000000000000000000000
      000000000000B1A79A9F99856EFF98846DFF98846DFF9A846EFFB8A89E990000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004343439F808080FF7F7F7FFF7F7F7FFF7F7F7FFF404040990000
      000000000000000000000000000000000000000000003A96DB00EFFAFE00A0E9
      F90090E5F80080E1F70071DEF60062DAF50053D7F40046D3F30038D0F2002DCD
      F10025CBF000CAF2FB003A96DB0000000000000000003A96DB00EFFAFE00A0E9
      F90090E5F80080E1F70071DEF60062DAF50053D7F40046D3F30038D0F2002DCD
      F10025CBF000CAF2FB003A96DB00000000000000000000000000DCDCDC23CCCC
      CC33CCCCCC33A5927CFFB8A284FFCBBDA5FFCBBDA5FFBBA488FFB2907EFFCCCC
      CC33CCCCCC33DCDCDC2300000000000000000000000000000000000000230000
      0033000000338D8D8DFF9B9B9BFFB7B7B7FFB7B7B7FF9E9E9EFF8E8E8EFF0000
      003300000033000000230000000000000000000000003A9BDB00F2FAFD00B2ED
      FA00A3E9F90094E6F80084E2F70075DEF60064DBF50056D7F40048D4F3003AD1
      F2002FCEF100CCF2FB003A9ADB0000000000000000003A9BDB00F2FAFD00B2ED
      FA00A3E9F90094E6F80084E2F70075DEF60064DBF50056D7F40048D4F3003AD1
      F2002FCEF100CCF2FB003A9ADB00000000000000000000000000AB9D8EC09B87
      70FF99846DFF97826CFF96806BFF947F69FF947F69FF98806BFF9B8770FF9984
      6DFF97826CFFAB9D8EC0000000000000000000000000000000005B5B5BC08282
      82FF7F7F7FFF7D7D7DFF7C7C7CFF7A7A7AFF7A7A7AFF7C7C7CFF828282FF7F7F
      7FFF7D7D7DFF5B5B5BC000000000000000000000000039A2DA00F6FCFE00C8F2
      FC00B8EFFB00ABECFA009BE8F9008AE3F7007BE0F6006BDCF6005CD9F5004ED6
      F40043D3F300D0F3FC003AA1DB00000000000000000039A2DA00F6FCFE00C8F2
      FC00B8EFFB00ABECFA009BE8F9008AE3F7007BE0F6006BDCF6005CD9F5004ED6
      F40043D3F300D0F3FC003AA1DB000000000000000000000000009E8A73FFCDB8
      9BFFF3F9F1FFF0F7F1FFEEF6F1FFEEF5F1FFEEF5F1FFF1F6F2FFFFF8F5FFFFF8
      F5FFCDB89BFF9E8A73FF00000000000000000000000000000000858585FFB1B1
      B1FFF5F5F5FFF4F4F4FFF3F3F3FFF3F3F3FFF3F3F3FFF4F4F4FFF7F7F7FFF7F7
      F7FFB1B1B1FF858585FF00000000000000000000000039A6DA00FEFFFF00F8FD
      FF00F6FDFF00F5FCFF00F3FCFE00D8F6FC0093E6F80084E3F70075DFF60067DB
      F5005BD8F400D7F4FC003AA5DB00000000000000000039A6DA00FEFFFF00F8FD
      FF00F6FDFF00F5FCFF00F3FCFE00D8F6FC0093E6F80084E3F70075DFF60067DB
      F5005BD8F400D7F4FC003AA5DB000000000000000000000000009E8A76FFD1C3
      ADFFE49021FFEB9820FFF4A422FFFDB023FFFFB323FFF9A822FFFF9D21FFFF9D
      21FFD1C3ADFF9E8A76FF00000000000000000000000000000000868686FFBDBD
      BDFF777777FF7D7D7DFF858585FF8E8E8EFF909090FF888888FF828282FF8282
      82FFBDBDBDFF868686FF00000000000000000000000037ABDA00E8F6FB0093D4
      EF0087CEEE0072C0E900C9E9F600F2FCFE00F3FCFE00F2FCFE00F0FCFE00EFFB
      FE00EEFBFE00FEFFFF003BACDB00000000000000000037ABDA00E8F6FB0093D4
      EF0087CEEE0072C0E900C9E9F600F2FCFE00F3FCFE00F2FCFE00F0FCFE00EFFB
      FE00EEFBFE00FEFFFF003BACDB00000000000000000000000000A08C78FFD6CF
      BEFFE3942FFFE8A137FFEFA52FFFF6AD2CFFF7AE2CFFF4A72BFFF69C27FFF69C
      27FFD6CFBEFFA08C78FF00000000000000000000000000000000888888FFCACA
      CAFF7E7E7EFF898989FF898989FF8E8E8EFF8F8F8FFF8A8A8AFF828282FF8282
      82FFCACACAFF888888FF0000000000000000000000003FADDB00F1FAFD0093DE
      F50092DCF40080D5F20069CAED006BCBEA0084D3EF007FD2EF0079D0EF0075CF
      EE0071CFEE00E9F7FB003CB0DB0000000000000000003FADDB00F1FAFD0093DE
      F50092DCF40080D5F20069CAED006BCBEA0084D3EF007FD2EF0079D0EF0075CF
      EE0071CFEE00E9F7FB003CB0DB00000000000000000000000000A28E79FFDEDA
      CBFFDF8E2BFFE6A140FFEEAE4EFFF1B14DFFF1B655FFF0B65CFFF1B361FFFFB7
      74FFDEDACBFFA28E79FF00000000000000000000000000000000898989FFD5D5
      D5FF797979FF8B8B8BFF989898FF9A9A9AFF9F9F9FFFA1A1A1FFA1A1A1FFAAAA
      AAFFD5D5D5FF898989FF0000000000000000000000003FB2DC00F7FCFE008DE4
      F80090DEF5009EE0F500ABE1F600EFFBFE00F4FDFE00F3FCFE00F1FCFE00EFFB
      FE00EEFBFE00FAFDFF0057BBE00000000000000000003FB2DC00F7FCFE008DE4
      F80090DEF5009EE0F500ABE1F600EFFBFE00F4FDFE00F3FCFE00F1FCFE00EFFB
      FE00EEFBFE00FAFDFF0057BBE000000000000000000000000000A38F7AFFE5E5
      D8FFD88424FFE09739FFE6A445FFEAAB4FFFECB059FFEBB262FFEBB36BFFEDAF
      6CFFEDDDCFFFB98B7CFF000000000000000000000000000000008A8A8AFFE1E1
      E1FF707070FF828282FF8E8E8EFF969696FF9C9C9CFFA0A0A0FFA3A3A3FFA1A1
      A1FFDADADAFF8B8B8BFF0000000000000000000000003AB4DB00FDFEFE00FEFF
      FF00FEFEFF00FDFEFF00FEFFFF00EAF7FB006DC8E4006EC8E3006EC8E3006EC8
      E3007CCEE60083D0E8000000000000000000000000003AB4DB00FDFEFE00FEFF
      FF00FEFEFF00FDFEFF00FEFFFF00EAF7FB006DC8E4006EC8E3006EC8E3006EC8
      E3007CCEE60083D0E80000000000000000000000000000000000A38F7AFFE5E5
      D8FFD88424FFE09739FFE6A445FFEAAB4FFFECB059FFEBB262FFEBB36BFFEDAF
      6CFFEDDDCFFFB98B7CFF000000000000000000000000000000008A8A8AFFE1E1
      E1FF707070FF828282FF8E8E8EFF969696FF9C9C9CFFA0A0A0FFA3A3A3FFA1A1
      A1FFDADADAFF8B8B8BFF00000000000000000000000058C1E00060C2E10062C3
      E20062C3E20062C3E20061C3E20055BEDF000000000000000000000000000000
      0000000000000000000000000000000000000000000058C1E00060C2E10062C3
      E20062C3E20062C3E20061C3E20055BEDF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5917CFFECEF
      E3FFD07516FFD98629FFDE9235FFE39A3EFFE5A048FFE5A352FFE4A55CFFE4A5
      61FFE9E6D7FFA98D7BFF000000000000000000000000000000008C8C8CFFEBEB
      EBFF626262FF737373FF7E7E7EFF868686FF8D8D8DFF919191FF969696FF9797
      97FFE1E1E1FF8A8A8AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A9947FFFF3F7
      EAFFF0F6ECFFEFF6EEFFEFF6EEFFEEF5EDFFEEF4ECFFEEF4EBFFEEF3E9FFEEF3
      E7FFEFF0E3FFA58E79FF00000000000000000000000000000000909090FFF2F2
      F2FFF2F2F2FFF2F2F2FFF2F2F2FFF1F1F1FFF0F0F0FFF0F0F0FFEFEFEFFFEEEE
      EEFFEBEBEBFF8A8A8AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6B8AAB0AB96
      81FFAA9580FFA99580FFA99580FFA99480FFA99480FFA7927DFFA58F79FFA48E
      78FFA48F79FFB19C86FF00000000000000000000000000000000666666B09292
      92FF919191FF909090FF909090FF909090FF909090FF8E8E8EFF8A8A8AFF8989
      89FF8A8A8AFF979797FF00000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000000000000000000083AF93002371
      4000186A36002371400083AF930000000000816F60FF874A20FF874A20FF874A
      20FF817467FF0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000826E5DFFA26333FF9F673BFF6C6C
      6BFF706D6CFF6F6D6BFF6F6C6BFF6E6C6AFF6E6C6AFF6D6B6AFF6D6B6AFF6D6B
      6AFF6C6B6BFF9B663CFFA26739FF946041FF000000000000000000000000E4E4
      E41BCCCCCC33CCCCCC33CCCCCC33CCCCCC33E5E5E51A00000000C8C8C837A3A3
      A35CA3A3A35CA3A3A35CC7C7C738000000000000000000000000000000000000
      0000000000000000000000000000000000000000000087B19600278B520063B9
      8C0094D2B10063B98C00278B520080AD9000874A20FFBEA592FFB89C86FFB89C
      86FF874A20FF9C5D2EFF00000000000000000000000000000000000000009477
      5EFF8A8379FF94775EFF00000000000000009E5F31FFB27A53FFBF957BFF7270
      6FFFA4A4A4FF868686FF828282FF8D8D8DFF858585FF7E7E7EFF767676FF6E6E
      6EFF6E6C6BFFB38468FFBA8769FFA46534FF000000000000000000000000B1A7
      9A9F99856EFF98846DFF98846DFF9A846EFFB8A89E99A3A3A35C3966A9E2374D
      CCFF384DCBFF384DCCFF3A67A7E4C0C0C03F000000000000000075B0E5003D8F
      DB00328AD900328AD900328AD900328AD900328AD9001B6C3D0061B98A005FB9
      8600FFFFFF005FB8860066BB8E001F6E3C00874A20FFCCBBADFFA7917DFFB595
      7AFFAE8B72FF874A20FFBA8355FF000000000000000000000000B6936FFF858A
      88FF9EA1A0FF858A88FF0000000000000000A46534FFCCA084FFB58262FF7371
      6FFFB7B7B7FF6C6C6CFF6C6C6CFFA0A0A0FF989898FF909090FF898989FF8181
      81FF6F6D6BFFAD7757FFBD8C6EFFA46534FFDCDCDC23CCCCCC33CCCCCC33A592
      7CFFB8A284FFCBBDA5FFCBBDA5FFBBA488FFB2907EFF6165A1FF344FDBFF375D
      F9FF375DFAFF385DF9FF3751D8FF4065A4EE000000004698DC00DEF0FA00A6DD
      F4009DDBF40095DAF3008DD8F30085D7F3007ED4F200307A4B009BD4B500FFFF
      FF00FFFFFF00FFFFFF0094D2B100186A3600874A20FFCCBBADFFA48D78FFA28A
      74FFB4957AFFB3937CFF874A20FF0000000000000000B89674FF858A88FFD2D3
      D4FFC2C3C4FF858A88FF0000000000000000A46534FFD0A58AFFB5805EFF7371
      70FFC9C9C9FF6C6C6CFF6C6C6CFFB2B2B2FFABABABFFA3A3A3FF9B9B9BFF9494
      94FF6F6D6CFFAF7959FFC19073FFA46534FFAB9D8EC09B8770FF99846DFF9782
      6CFF96806BFF947F69FF947F69FF98806BFFA7826FFF2541D5FF3E63FDFF3B60
      FAFF3A5DF8FF3C60FAFF4165FBFF334ACCFF000000003A96DB00EFFAFE00A0E9
      F90090E5F80080E1F70071DEF60062DAF50053D7F400438861008FD3B00091D6
      B000FFFFFF0064BB8B0066BB8E001F6E3C005C544BFF874A20FFD4C8BDFFA48D
      78FFA48D78FFBEA592FF874A20FF00000000BDA387FF858A88FFE2E3E4FFC2C4
      C6FF858A88FFA9937AFF0000000000000000A36433FFD1A88CFFB78260FF7370
      6FFFBEBEBEFF6C6C6CFF6C6C6CFFC5C5C5FFBDBDBDFFB6B6B6FFAEAEAEFFA6A6
      A6FF706E6DFFB27B5AFFC49578FFA46534FF9E8A73FFCDB89BFFF3F9F1FFF0F7
      F1FFEEF6F1FFEEF5F1FFEEF5F1FFF1F6F2FFFFF8F5FF203CD2FFA6B8FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFA9BAFFFF3148CBFF000000003A9BDB00F2FAFD00B2ED
      FA00A3E9F90094E6F80084E2F70075DEF60064DBF50053B2AD0060AA800094D4
      B300B9E6D00069BA8E002C8E560080AD900000000000B9B4B0FF874A20FFCCBB
      ADFFCCBBADFFB3937CFF874A20FFAE9C89FF858A88FFD3D3D4FFBDBEBFFF858A
      88FFBFA58AFFD4AD88FF0000000000000000A36433FFD4AC91FFB98462FF706E
      6DFFAAAAAAFFB1B1B1FFB6B6B6FFBBBBBBFFC0C0C0FFC2C2C2FFBBBBBBFFB0B0
      B0FF6E6D6DFFB47D5CFFC7997CFFA46534FF9E8A76FFD1C3ADFFE49021FFEB98
      20FFF4A422FFFDB023FFFFB323FFF9A822FFFF9D21FF1C3DDBFF5776FFFF5775
      FFFF5473FDFF5775FEFF5B78FFFF2F47CFFF0000000039A2DA00F6FCFE00C8F2
      FC00B8EFFB00ABECFA009BE8F9008AE3F7007BE0F6006BDCF6005AB6B3005796
      74004E8D650046896000348C9200000000000000000000000000A16232FF874A
      20FF874A20FF874A20FF85837DFFAAADADFFC8C9CAFFBDBEBFFF858A88FFBFA5
      8AFF00000000000000000000000000000000A36433FFD7AF95FFC38A62FF8D78
      6AFF706E6DFF706E6DFF706E6DFF706E6DFF706E6DFF706E6DFF706F6DFF716F
      6DFF907767FFBC825CFFCA9D80FFA46534FFA08C78FFD6CFBEFFE3942FFFE8A1
      37FFEFA52FFFF6AD2CFFF7AE2CFFF4A72BFFF69C27FF7A6686FF3856E6FF6C86
      FFFF7389FFFF6D86FFFF3D58E2FF6568A3FF0000000039A6DA00FEFFFF00F8FD
      FF00F6FDFF00F5FCFF00F3FCFE00D8F6FC0093E6F80084E3F70075DFF60067DB
      F5005BD8F400D7F4FC003AA5DB00000000000000000000000000000000000000
      00000000000000000000B5B7B8FF858A88FFB7B8B9FF858A88FFBDA58AFFCCB3
      92FF00000000000000000000000000000000A36534FFD9B398FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFCDA184FFA46534FFA28E79FFDEDACBFFDF8E2BFFE6A1
      40FFEEAE4EFFF1B14DFFF1B655FFF0B65CFFF1B361FFF9BE6AFF7783CBFF253D
      D4FF2E3ED4FF2B3CD4FF8389D1FFC0C0C03F0000000037ABDA00E8F6FB0093D4
      EF0087CEEE0072C0E900C9E9F600F2FCFE00F3FCFE00F2FCFE00F0FCFE00EFFB
      FE00EEFBFE00FEFFFF003BACDB000000000000000000B4B6B5FF858A88FF858A
      88FF858A88FF858A88FFD0D1D2FFA3A4A4FF858A88FFAC9D8BFF000000000000
      000000000000000000000000000000000000A36534FFDBB79DFFFFFFFFFFDEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFFCFCFCFFD0A589FFA46534FFA38F7AFFE5E5D8FFD88424FFE097
      39FFE6A445FFEAAB4FFFECB059FFEBB262FFEBB36BFFEDAF6CFFEDDDCFFFB98B
      7CFF00000000000000000000000000000000000000003FADDB00F1FAFD0093DE
      F50092DCF40080D5F20069CAED006BCBEA0084D3EF007FD2EF0079D0EF0075CF
      EE0071CFEE00E9F7FB003CB0DB00000000006E7370FF858A88FFF3F2F2FFEFF0
      F0FFEDEEEEFFEAECECFFB6B9BAFF858A88FFBDA58BFF858A88FF89BAB5FF0000
      000000000000000000000000000000000000A36534FFDEBAA0FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFD3A98EFFA46534FFA38F7AFFE5E5D8FFD88424FFE097
      39FFE6A445FFEAAB4FFFECB059FFEBB262FFEBB36BFFEDAF6CFFEDDDCFFFB98B
      7CFF00000000000000000000000000000000000000003FB2DC00F7FCFE008DE4
      F80090DEF5009EE0F500ABE1F600EFFBFE00F4FDFE00F3FCFE00F1FCFE00EFFB
      FE00EEFBFE00FAFDFF0057BBE00000000000858A88FFF5F6F6FFA9ACABFF858A
      88FFF7F7F7FFE2E3E5FFAAADADFFEAE0D6FF00000000ADC1B9FF858A88FF99CE
      D1FF00000000000000000000000000000000A46535FFE0BDA3FFFCFCFCFFDEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFFFFFFFFFD5AD91FFA46534FFA5917CFFECEFE3FFD07516FFD986
      29FFDE9235FFE39A3EFFE5A048FFE5A352FFE4A55CFFE4A561FFE9E6D7FFA98D
      7BFF00000000000000000000000000000000000000003AB4DB00FDFEFE00FEFF
      FF00FEFEFF00FDFEFF00FEFFFF00EAF7FB006DC8E4006EC8E3006EC8E3006EC8
      E3007CCEE60083D0E80000000000000000006E7370FF858A88FF000000009A70
      4DFF858A88FFFAFAFAFF858A88FF00000000000000000000000074ABA6FF858A
      88FF878C8AFFAAABACFF0000000000000000A36434FFE2C0A7FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFD8B196FFA46534FFA9947FFFF3F7EAFFF0F6ECFFEFF6
      EEFFEFF6EEFFEEF5EDFFEEF4ECFFEEF4EBFFEEF3E9FFEEF3E7FFEFF0E3FFA58E
      79FF000000000000000000000000000000000000000058C1E00060C2E10062C3
      E20062C3E20062C3E20061C3E20055BEDF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000858A88FFEEF0F0FF858A88FF00000000000000000000000000000000858A
      88FFF0F0F0FF858A88FF559EA6FF00000000A36434FFE3C3ABFF98A3EDFF97A2
      EDFF97A2EDFF97A2EDFF97A2EDFF97A2EDFF97A2EDFF97A2EDFF97A2EDFF97A2
      EDFF97A2EDFF97A2EDFFDAB499FFA46534FFC6B8AAB0AB9681FFAA9580FFA995
      80FFA99580FFA99480FFA99480FFA7927DFFA58F79FFA48E78FFA48F79FFB19C
      86FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000858A
      88FFE9EBECFF858A88FF909391FF000000000000000000000000000000003A4F
      51FF858A88FFECEEEEFF858A88FF00000000A36535FFE6C6AEFF031FD4FF001C
      D3FF001CD3FF001CD3FF001CD3FF001CD3FF001CD3FF001CD3FF001CD3FF001C
      D3FF001CD3FF001CD3FFDDB89EFFA46534FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B8BA
      B9FF858A88FFB8BAB9FF00000000000000000000000000000000000000000000
      0000A3A6A6FF858A88FFBDBFBEFF00000000A36535FFE7C8B1FF7988E8FF7786
      E8FF7584E7FF7382E7FF7181E6FF6F7FE6FF6D7DE6FF6B7BE5FF6879E5FF6677
      E5FF6475E4FF6374E4FFDEBAA0FFA46534FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A704EFFA46534FFA46534FFA364
      33FFA46433FFA46433FFA36533FFA36533FFA36534FFA36534FFA46535FFA365
      35FFA36535FFA36535FFA36534FF987150FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFDFF8C8E8DFF8C8E8DFF828484FF0000000000000000000000000000
      00000000000000000000549B5D003E8D48003A8B44004B945200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000536AC6003D58BF003852BE004A66C100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008ABB8F005C9C6200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C8E8DFFB7B8B8FFA3A4A3FF828484FF0000000000000000000000000000
      0000569F620040984F007CC18E0095D0A50095CFA50077BD8800358C41003F8C
      4700000000000000000000000000000000000000000000000000000000000000
      00005364CA003B51CC007479E8008E91EE008E91EE007077E400324CC0003E5A
      BD00000000000000000000000000000000000000000000000000000000000000
      00009ACA9F0065AF6D0060A967003C8A430036823D00317A36003C7E41006395
      6600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AEB1B0FF808381FF808381FF808381FF808381FF8C8E
      8DFFB7B8B8FFA3A4A3FFA3A4A3FF828484FF000000000000000000000000539F
      630063B37700A7DBB40086CC970065BB7C0063B97B0085CB9700A4D9B30057A9
      6A0034853B000000000000000000000000000000000000000000000000004F5F
      CD005B64E000A0A5F5007D85EF005A62E900585CE7007C83EE009D9FF400505C
      D7003350B900000000000000000000000000000000000000000000000000A9D7
      AE0072BC7B0095D19E0093CF9B008ECD950089CA900084C78A0079BD800064AC
      6B004A91500067966A000000000000000000B3B6B5FF868B89FF858A88FF858A
      88FF858A88FF7B807EFF808381FFDCC8B3FFCFAC8BFFD1A880FFD0B399FF8083
      81FFA3A4A3FFA3A4A3FF808482FF00000000000000000000000066AB740069B8
      7C00A7DBB1005FBB76005BB9720058B76F0058B46E0057B46E005AB67300A4D9
      B20059A96B00408D4700000000000000000000000000000000006370D300606A
      E300A0ABF500535EEC004F5BEA004C58E9004D58E6004B55E6004F55E6009DA1
      F400535FD6003E5BBE000000000000000000000000000000000000000000A8DA
      AE0078C382009DD7A6009AD4A30096D29E0091CF99008CCC940087CA8F0079C1
      81007DC384005CA3620068986B0000000000878C8AFFFFFFFFFFFFFFFFFFFFFF
      FFFFCDCFCFFF808381FFD1B89FFFD6B391FFDFC5AFFFE3CAB2FFD6BAA0FFD3B4
      97FF808381FF828584FF0000000000000000000000000000000052AA6700A9DD
      B30063C078005EBD70005FBB7600FFFFFF00FFFFFF0058B76F0057B46D005BB6
      7300A5DAB300378E4200000000000000000000000000000000004A55DB00A1AA
      F6005563F0005165EE004C58E9004C58E9004C58E9004C58E9004B57E6005159
      E6009EA2F500334FC30000000000000000000000000000000000000000000000
      0000A3D8AA007AC7840076C1800053AA5D004DA25600489A500062AB6A0082C2
      8A0086C98E0081C588004F96550000000000878C8AFFF9FAFAFFEFF0F0FFEFF0
      F0FF808381FFC3B5A7FFD0AB89FFE5CAB3FFEBD7C3FFEAD4C1FFEEDDCFFFDABD
      A3FFCEB094FF808381FF00000000000000000000000076B6870089CC970088D3
      95006AC5790062C06F0054AA6400FFFFFF00FFFFFF0058B76F0058B76F005AB8
      710084CC96007ABD8C004C95540000000000000000007277DC00808BEE007D90
      F7005C72F3004C58E9004C58E9004C58E9004C58E9004C58E9004C58E9004E5A
      E9007A82F000747AE2004A63C200000000000000000000000000000000000000
      0000000000009DD7A3007AC683000000000000000000000000009AC89F005AA1
      610085C58D0087C98E006EB27500689B6B00868B89FFFDFEFEFFEFF0F0FFEFF0
      F0FF808381FFD6BFA9FFE0C1A5FFEEDED0FFF2E5DAFFEDDCCDFFECD9C8FFE8D0
      BCFFD1A780FF808381FF00000000000000000000000069B07D00A8DDB2007CCF
      890074CC8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0058B7
      6F0066BD7C009BD4AA003A8B420000000000000000006367DB00A0AAF7006F85
      F8006781F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004C58
      E9005B65EA00959BF1003855BD00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A3CE
      A700539F5A0046934E003F8A4600468A4C00878C8AFFFFFFFFFFEFF0F0FFEFF0
      F0FF808381FFD0B8A2FFDFC0A5FFF1E4D9FFF3EAE0FFF2E7DDFFE9D4C1FFDFBE
      A0FFD0A681FF808381FF0000000000000000000000006DB38100B5E2BD008AD5
      960079C98500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0058B7
      6F0068C07D009CD4A9003E8E47000000000000000000686DDC00AEB8F9007E92
      FA006F84F000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004C58
      E9005D69EE00959CF1003C54BF00000000005CA863004B9A520046934E00478F
      4E0096BD9A000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000878C8AFFFFFFFFFFEFF0F0FFC6C7
      C7FF808381FFBBAEA3FFCFA985FFF2E6DCFFF7EEE8FFF5ECE4FFECDACAFFD8B2
      8EFFCBAF97FF808381FF00000000000000000000000080BE9300ABDDB500A5DF
      AE0080CB8B007BC985006DBC7800FFFFFF00FFFFFF005AAB69005FBB76005BB9
      72008AD198007FC49100569D600000000000000000007B7EE200A4AEF5009CAA
      FA00768BF000535EEC00535EEC00535EEC00535EEC00535EEC00535EEC006276
      F200808DF400777EE900546AC8000000000083C28A007FC288008CCC940082C3
      8900529759008FB9930000000000000000000000000049804C00729B75000000
      000000000000000000000000000000000000868B89FFFFFFFFFFEFF0F0FFEFF0
      F0FFD5D7D6FF808381FFC8B7A8FFD2AC8AFFE7D3BFFFEAD7C5FFD9BA9CFFCBAD
      90FF808381FFE2E3E2FF0000000000000000000000000000000084C79600D2EE
      D70094D99F0089D393007EC88800FFFFFF00FFFFFF0078CD84006AC27B006EC7
      7D00ABDFB400449D5600000000000000000000000000000000007C82EA00CDD4
      FC008A9CFA007D92F7007489EE006B83F6006B83F6006B83F6006B83F6006278
      F300A3AEF8003D4ED00000000000000000000000000074BE7D0097D2A00093CF
      9B0085C78C005DA6640038853F00337D39002D753200488F4E00448A49007DA4
      800000000000000000000000000000000000878C8AFFFFFFFFFFEFF0F0FFC6C7
      C7FFC6C7C7FFA6A9A8FF808381FFC8BAAEFFD2BCA6FFD4BAA2FFCDB9A8FF8083
      81FFCBCCCCFF00000000000000000000000000000000000000007DBE9200A9DA
      B600D8F1DC0091D89C0087CD920083CC8D008AD4950089D4940082D28D00AEE0
      B6006AB87C0059A16600000000000000000000000000000000007877E300A2A6
      F300D4DBFD008699FA007E90F000798DF1007E93F8007D91F900758BF800A7B5
      F800626DE3005767CC000000000000000000000000008DCB950084C98D009AD4
      A3008ECE970091CF99008CCC940087CA8F0082C58A007DC3840078C07E00468C
      4B0086AB8800000000000000000000000000868B89FFFFFFFFFFEFF0F0FFEFF0
      F0FFEFF0F0FFEFF0F0FFD5D6D6FF808381FF808381FF808381FF808381FF8084
      82FF0000000000000000000000000000000000000000000000000000000075BA
      8B00AEDCBA00DCF2E000B5E4BC009ADBA40095D99F00A4DFAE00BFE8C40078C1
      890056A164000000000000000000000000000000000000000000000000006F6E
      E100A9ACF200D8DCFD00ADB9FA0090A2FA008A9CFA009BA8FB00B9C7FC006F7A
      E9005261CE0000000000000000000000000000000000000000008FCD960078C2
      820088CA910093D09B0094D19D008FCF98008BCB930086C98E007FC386004D94
      53008EB29100000000000000000000000000878C8AFFFFFFFFFFEFF0F0FFC6C7
      C7FFC6C7C7FFC6C7C7FFC6C7C7FFC6C7C7FFC6C7C7FFEFF0F0FFFFFFFFFF858A
      88FF000000000000000000000000000000000000000000000000000000000000
      00007EBE910093CEA300C2E6CB00CFEBD400C9E9CE00AEDDB7006CB87E0067AC
      7600000000000000000000000000000000000000000000000000000000000000
      00007777E2008D92ED00BDC2F800CCD3F900C3CBF900A9B3F400656FE200626C
      D500000000000000000000000000000000000000000000000000000000000000
      000088C88F0063B26B004FA559004A9D520044954C005FA767005AA161008BB5
      8F0000000000000000000000000000000000868B89FFFFFFFFFFEFF0F0FFEFF0
      F0FFEFF0F0FFEFF0F0FFEFF0F0FFEFF0F0FFEFF0F0FFEFF0F0FFFFFFFFFF858A
      88FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000081BF940070B585006DB3810078B88900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007C7EE100696ADD00676ADB007378DE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000066AA6D008ABB8F000000
      000000000000000000000000000000000000878C8AFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF858A
      88FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AAADACFF858A88FF858A88FF858A
      88FF858A88FF858A88FF858A88FF858A88FF858A88FF858A88FF858A88FFB0B3
      B2FF00000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000A00000000100010000000000000500000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFE7F00000000
      FFFFFC3F00000000FFFFF81F00000000FFFFF00F00000000FC1FE00700000000
      F80FC00300000000F80F800100000000F80F000000000000F80FE00700000000
      F80FE00700000000FC1FE00700000000FFFFE00700000000FFFFE00700000000
      FFFFE00700000000FFFFFFFF00000000FFFFFFFFFFFFFFFFF01FF000FE00FFFF
      E00FE0000000FFFFC007E0000000B81380030000000080010001000000008000
      0001000000008000000100000000800000010000000080000001000000008000
      0001000F000F80010001000F000BBFFF8003000F0001BFFFC007000F0000BFFF
      E00F000F003BFFFFF01FFFFF0043FFFFFFFF8001FFFFFFFFFF8180010001FF93
      FF8180010001FF83E70080010001FE00E30080010001FE00E00080010001FF11
      C001E0070001C8008001F81F0001C0000001F01F000100030001F00F00010013
      0001F00F000188FF0001F00F0001007F0001F00F0001007F8003F00F0001C1FF
      8003F00F0001C9FFC007F81F0001FFFFFFFFFF9FFFFFFFFF07FFFF87F81FFC3F
      03FF0001E007800103FF0001C003FC3F80FF0000C003FE7FC07F00008001FE7F
      E007000080010000F003000180013FFEF801000080010444F801000080011F74
      F801000080010000F8310001C00375DEF8310001C0034446F8010001E0077FFE
      FC030001F81F0000FE070001FFFFFFFF00000000FFFFE00700000000FFFFC003
      00000000810380010000E07F810300000000807F810300000000801F81030000
      0000800781030000000080038103000000008003800300000000800380030000
      00008003C007000000008003C10700000000F803F11F00000000F807F11F8001
      0000FFFFFFFFC0030000FFFFFFFFE007FFE3FFFFFFFFFFFFFF81FFFFFFFFE041
      C00080038003E0008000BFFBBFFB00008000800B800B00008001800B800B0000
      8001800B800B00008001800B800B00008001800B800B00018001800B800B000F
      8001800B800B000F8003800B800B000F80FF800B800B000FFFFF800B800B000F
      FFFF80038003FFFFFFFFFFFFFFFFFFFF0000E04FE041E0410000E047E000E000
      0000F00000000000E007000000000000E007000000000000E007000000000000
      E007000000000000E007000000000000E007000000000000E007000000000000
      E007000000000000FFFF000000000000F81F0000F000FE00F81FFC00F000FE00
      F81FFE00F000FE00FFFFFF00F000FE00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      C001C001F81FF81F80018001F81FF81F80018001C003C00380018001C003C003
      80018001C003C00380018001C003C00380018001C003C00380018001C003C003
      80018001C003C00380038003C003C00380FF80FFC003C003FFFFFFFFC003C003
      FFFFFFFFC003C003FFFFFFFFFFFFFFFFFFFFFFC107FF0000E041FF8003E30000
      E000C00001C30000000080000183000000008000010300000000800080030000
      00008001C00F000000008001FC0F000000008001803F0000000F8001001F0000
      000F8001008F0000000F800321C30000000F80FFF1E10000000FFFFFE1E10000
      FFFFFFFFE3F10000FFFFFFFFFFFF0000FFFFFFFFFFFFFFF0FC3FFC3FF9FFFFF0
      F00FF00FF00FFC00E007E007E0030001C003C003E0010003C003C003F0010003
      80018001F9C0000380018001FFE000038001800107FF000380018001039F0003
      C003C003800F0007C003C0038007000FE007E007C007000FF00FF00FF00F000F
      FC3FFC3FFF9F000FFFFFFFFFFFFF000F00000000000000000000000000000000
      000000000000}
  end
  object vstPopupMenu: TPopupMenu
    Images = Images
    Left = 144
    Top = 160
    object Addsinglecomputer1: TMenuItem
      Action = actAddOneComputer
    end
    object Addmultiplecomputers1: TMenuItem
      Action = actAddMultipleComputers
    end
    object Removecomputer1: TMenuItem
      Action = actnRemoveComputer
    end
    object AddNewGroup1: TMenuItem
      Action = actAddNewGroup
    end
    object RemoveGroup1: TMenuItem
      Action = actnRemoveGroup
    end
    object Renamecomputer1: TMenuItem
      Action = actnRenameComputer
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            ContextItems.CaptionOptions = coAll
            ContextItems = <>
            Items.CaptionOptions = coAll
            Items = <
              item
                Action = actnSaveHost
                Caption = 'S&ave changes'
                ImageIndex = 7
              end
              item
                Action = actnModifyIpAddress
                Caption = '&Modify IP Address'
                ImageIndex = 27
              end
              item
                Action = actnUserMessage
                ImageIndex = 28
              end
              item
                Action = actnUseAlternateCreds
                Caption = 'S&et Credentials'
                ImageIndex = 29
              end
              item
                Action = actnPingTheHost
                Caption = '&Ping Host'
                ImageIndex = 36
              end
              item
                Action = actnAutoUpdateIp
                Caption = 'A&uto-Update host'#39's IP address'
              end>
            Action = actHostActionsDropDown
            Default = True
            NewCol = True
            NewRow = True
            UsageCount = -1
          end
          item
            Action = actnRefreshHost
            Caption = '&Retrieve host details'
            ImageIndex = 2
          end
          item
            Action = actnDeploySvc
            Caption = '&Deploy NicLocker'
            ImageIndex = 25
          end>
      end
      item
        Items = <
          item
            Action = FileExit1
            ImageIndex = 12
          end
          item
            Action = actnChangePassword
            Caption = '&Change Password'
          end>
      end
      item
        Items = <
          item
            ChangesAllowed = [caMove, caDelete]
            Action = actnChangePassword
            Caption = '&Change Password'
            ImageIndex = 24
          end
          item
            Action = actAddNewGroup
            Caption = '&Add a new group'
            ImageIndex = 5
            CommandProperties.ButtonType = btSplit
          end
          item
            Action = actAddOneComputer
            Caption = 'A&dd a computer'
            ImageIndex = 19
          end
          item
            Action = actAddMultipleComputers
            Caption = 'Add &multiple computers'
            ImageIndex = 14
          end
          item
            Action = actnRemoveComputer
            Caption = '&Remove computer'
            ImageIndex = 4
          end
          item
            Action = actnRemoveGroup
            Caption = 'R&emove group'
            ImageIndex = 16
          end>
      end>
    LinkedActionLists = <
      item
        Caption = '(No Name)'
      end>
    Images = Images
    Left = 48
    Top = 88
    StyleName = 'XP Style'
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 12
    end
    object actnRefreshHost: TAction
      Category = 'File'
      Caption = 'Retrieve host details'
      ImageIndex = 2
      OnExecute = actnRefreshHostExecute
    end
    object actnSaveHost: TAction
      Category = 'File'
      Caption = 'Save changes'
      ImageIndex = 7
      OnExecute = actnSaveHostExecute
    end
    object Action1: TAction
      Caption = 'Action1'
    end
    object actnFileMenu: TAction
      Category = 'File'
      Caption = '&File'
    end
    object actnChangePassword: TAction
      Caption = 'Change Password'
      Hint = 'Change the password used when starting this application'
      ImageIndex = 24
      OnExecute = actnChangePasswordExecute
    end
    object actnDeploySvc: TAction
      Caption = 'Deploy NicLocker'
      Hint = 'Deploy NicLocker application to the current host'
      ImageIndex = 25
      OnExecute = actnDeploySvcExecute
    end
    object actnUseAlternateCreds: TAction
      Caption = 'Set Credentials'
      Hint = 'Set credentials to use for this host'
      ImageIndex = 29
      OnExecute = actnUseAlternateCredsExecute
    end
    object actnModifyIpAddress: TAction
      Caption = 'Modify IP Address'
      Hint = 'Modify the IP address for this host'
      ImageIndex = 27
      OnExecute = actnModifyIpAddressExecute
    end
    object actnUserMessage: TAction
      Caption = 'Show user a message'
      Hint = 'Show the user a message'
      ImageIndex = 28
      OnExecute = actnUserMessageExecute
    end
    object actAddNewGroup: TAction
      Caption = 'Add a new group'
      Hint = 'Add a new group'
      ImageIndex = 5
      OnExecute = actAddNewGroupExecute
    end
    object actAddOneComputer: TAction
      Caption = 'Add a computer'
      Hint = 'Add a computer'
      ImageIndex = 19
      OnExecute = actAddOneComputerExecute
    end
    object actAddMultipleComputers: TAction
      Caption = 'Add multiple computers'
      Hint = 'Add multiple computers'
      ImageIndex = 14
      OnExecute = actAddMultipleComputersExecute
    end
    object actnRemoveComputer: TAction
      Caption = 'Remove computer'
      Hint = 'Remove computer'
      ImageIndex = 4
      OnExecute = actnRemoveComputerExecute
    end
    object actnRemoveGroup: TAction
      Caption = 'Remove group'
      ImageIndex = 16
      OnExecute = actnRemoveGroupExecute
    end
    object actnPingTheHost: TAction
      Caption = 'Ping Host'
      ImageIndex = 36
      OnExecute = actnPingTheHostExecute
    end
    object actnAutoUpdateIp: TAction
      AutoCheck = True
      Caption = 'Auto-Update host'#39's IP address'
      Checked = True
      OnExecute = actnAutoUpdateIpExecute
    end
    object actnRenameComputer: TAction
      Caption = 'Rename computer'
      Hint = 'Rename computer'
      ImageIndex = 33
      OnExecute = actnRenameComputerExecute
    end
    object actnLocateHostRecord: TAction
      Caption = 'Locate a host'#39's record'
      ImageIndex = 22
      OnExecute = actnLocateHostRecordExecute
    end
    object actnClearHostHistory: TAction
      Caption = 'Clear this host'#39's action log'
      OnExecute = actnClearHostHistoryExecute
    end
    object actHostActionsDropDown: TAction
      Caption = 'Action2'
    end
  end
  object PopUpMultipleComputerScan: TPopupMenu
    Images = Images
    Left = 48
    Top = 296
    object puCheckAll: TMenuItem
      Caption = 'Check All'
      ImageIndex = 26
      OnClick = puCheckAllClick
    end
    object puCheckNone: TMenuItem
      Caption = 'Check None'
      ImageIndex = 23
      OnClick = puCheckNoneClick
    end
  end
  object PopUpGroupHosts: TPopupMenu
    Images = Images
    Left = 48
    Top = 216
    object CheckAll_GroupHosts: TMenuItem
      Caption = 'Check All'
      ImageIndex = 26
      OnClick = CheckAll_GroupHostsClick
    end
    object CheckNone_GroupHosts: TMenuItem
      Caption = 'Check None'
      ImageIndex = 23
      OnClick = CheckNone_GroupHostsClick
    end
  end
  object MainMenu1: TMainMenu
    Images = Images
    Left = 48
    Top = 152
    object File1: TMenuItem
      Caption = '&File'
      OnClick = File1Click
      object SaveHostChanges1: TMenuItem
        Action = actnSaveHost
      end
      object Exit1: TMenuItem
        Action = FileExit1
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      RadioItem = True
      object ChangePassword1: TMenuItem
        Action = actnChangePassword
      end
      object Addnewgroup2: TMenuItem
        Action = actAddNewGroup
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Addacomputer1: TMenuItem
        Action = actAddOneComputer
      end
      object AddMultipleComputers2: TMenuItem
        Action = actAddMultipleComputers
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Removecomputer2: TMenuItem
        Action = actnRemoveComputer
      end
      object Removegroup2: TMenuItem
        Action = actnRemoveGroup
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Renamecomputer2: TMenuItem
        Action = actnRenameComputer
      end
      object Locateahostsrecord1: TMenuItem
        Action = actnLocateHostRecord
      end
    end
    object HostSpecificActions1: TMenuItem
      Caption = 'Host Actions'
      object Retrievehostdetails1: TMenuItem
        Action = actnRefreshHost
      end
      object DeployNicLocker1: TMenuItem
        Action = actnDeploySvc
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ModifyIPAddress1: TMenuItem
        Action = actnModifyIpAddress
      end
      object ShowUserMessage1: TMenuItem
        Action = actnUserMessage
      end
      object SetCredentials1: TMenuItem
        Action = actnUseAlternateCreds
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object PingHost2: TMenuItem
        Action = actnPingTheHost
      end
      object AutoUpdatehostsIPaddress1: TMenuItem
        Action = actnAutoUpdateIp
        AutoCheck = True
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object OnlineHelp1: TMenuItem
        Caption = 'Online Help'
        OnClick = OnlineHelp1Click
      end
      object CheckforUpdates1: TMenuItem
        Caption = 'Check for Updates'
        OnClick = CheckforUpdates1Click
      end
      object Registration1: TMenuItem
        Caption = 'Registration'
        OnClick = Registration1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = 'About...'
        OnClick = About1Click
      end
    end
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmr1Timer
    Left = 760
    Top = 8
  end
  object pmHostActions: TPopupMenu
    Images = Images
    Left = 144
    Top = 216
    object Savechanges1: TMenuItem
      Action = actnSaveHost
    end
    object ModifyIPAddress2: TMenuItem
      Action = actnModifyIpAddress
    end
    object ShowUserMessage2: TMenuItem
      Action = actnUserMessage
    end
    object SetCredentials2: TMenuItem
      Action = actnUseAlternateCreds
    end
    object PingHost1: TMenuItem
      Action = actnPingTheHost
    end
    object AutoUpdatehostsIPaddress2: TMenuItem
      Action = actnAutoUpdateIp
      AutoCheck = True
    end
  end
  object pmClearHostHistory: TPopupMenu
    Left = 48
    Top = 360
    object Clearthisdeploymentlog1: TMenuItem
      Action = actnClearHostHistory
    end
  end
end
