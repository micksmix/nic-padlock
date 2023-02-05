object frmAddIPAddress: TfrmAddIPAddress
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Add IP Address'
  ClientHeight = 144
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddIp: TButton
    Left = 80
    Top = 107
    Width = 102
    Height = 27
    Caption = 'Add this address'
    Default = True
    TabOrder = 0
    OnClick = btnAddIpClick
  end
  object IPMask1: TIPMask
    Left = 28
    Top = 75
    Width = 154
    Height = 21
    Ctl3D = True
    Text = '0.0.0.0'
    Value = 0
    BorderStyle = bsSingle
    Color = clWindow
    Enabled = True
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 198
    Height = 60
    Align = alTop
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 2
    object Image1: TImage
      Left = 14
      Top = 13
      Width = 32
      Height = 32
      Picture.Data = {
        055449636F6E0000010001002020000001002000A81000001600000028000000
        2000000040000000010020000000000000000000000000000000000000000000
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
        000000000000000000000000000000000000000000000000000000034496D9AC
        4B9DE2FF4C9DE3FF4597D9AC0000000300000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000016
        827368FF53463DFF000000160000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000016
        7F7873FF514C4AFF000000160000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000005000000100000001600000016000000160000001600000016
        0000001600000016000000160000001600000016000000160000001600000027
        7A7673FF4D4A4AFF000000270000001600000016000000160000001600000016
        000000160000001600000016000000160000001600000016000000150000000D
        0000000400000010000000310000004200000043000000430000004300000043
        0000004300000043000000430000004300000043000000430000004300000048
        838180FF605F5EFF000000480000004300000043000000430000004300000043
        0000004300000043000000430000004300000043000000430000003F0000002B
        0000000D00000016B0B0AEF3AFAFADFFAEAEABFFADADABFFADADABFFADADABFF
        ADADABFFADADABFFADADABFFADADABFFADADABFFADADABFFAEAEACFFAFAFADFF
        B2B2B0FFB3B3B0FFB0B0AEFFAEAEACFFADADABFFADADABFFADADABFFADADABFF
        ADADABFFADADABFFADADABFFADADABFFADADABFFAEAEABFFAFAFADFFA1A19FC4
        0000001500000016B0B0ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0B0ADFF
        0000001600000016AEAEABFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFFFCFCFCFFFFFFFFFFAEAEABFF
        0000001600000016ADADABFFFFFFFFFFFFFFFFFF232121FF262424FF1F1C1CFF
        FFFFFFFF201D1DFF272525FF252323FFFFFFFFFF201E1EFF272525FF252323FF
        FFFFFFFF181616FFFFFFFFFF1E1C1CFFFFFFFFFF1E1C1CFFFFFFFFFF181616FF
        FFFFFFFF1E1C1CFFFFFFFFFF1D1B1BFFFFFFFFFFF8F7F7FFFFFFFFFFADADABFF
        0000001600000016ADADABFFFFFFFFFFFDFCFCFF363432FFFFFFFFFFFFFFFFFF
        FEFEFEFFFFFFFFFFFFFFFFFF3B3938FFFFFFFFFFFFFFFFFFFFFFFFFF3A3837FF
        FFFFFFFFFDFCFCFFFFFFFFFF353231FFFFFFFFFF353231FFFFFFFFFFFDFCFCFF
        FFFFFFFF353231FFFFFFFFFF343231FFFDFCFCFFF4F3F3FFFFFFFFFFADADABFF
        0000001600000016ADADABFFFFFFFFFFF3F2F2FFFDFCFCFF454342FFFDFCFCFF
        FBFAFAFF908D8CFF4C4A49FF8E8C8BFFFFFEFEFF918E8DFF4C4A49FF8C8A89FF
        F7F7F7FFF2F1F1FFF6F5F6FFFFFFFFFF494746FFFFFFFFFFF6F5F6FFF2F1F1FF
        F6F5F6FFFFFFFFFF494746FFFFFFFFFFF6F5F5FFEEEDEDFFFFFFFFFFADADABFF
        0000001600000016ADADABFFFFFFFFFFEDECECFFF5F4F4FFFCFBFCFF5A5654FF
        FAF9FAFF5E5B59FFFFFFFFFFFBFAFAFFF9F8F9FF5E5B58FFFFFFFFFFF9F8F9FF
        EFEEEFFFECEBEBFFF2F1F1FF595654FFFEFDFEFF595654FFF2F1F1FFEDECECFF
        F2F1F1FF595654FFFEFDFEFF595654FFF2F1F1FFEAE9E9FFFFFFFFFFADADABFF
        0000001600000016AEAEABFFFFFFFFFFE9E9E8FF686462FF6D6967FF9D9B99FF
        F3F3F2FF6E6B69FF6F6C69FF6A6765FFF2F3F2FF6E6B68FF6F6C69FF696663FF
        EBEBEAFFE8E8E7FFECECEBFF696664FFF3F4F3FF696664FFECECEBFFE8E8E7FF
        ECECEBFF696664FFF3F4F3FF696664FFEBECEBFFE5E6E4FFFFFFFFFFAEAEABFF
        0000001600000015AEAEACFFFFFFFFFFE2E1E0FFE7E6E5FFE9E8E7FFE7E6E5FF
        E6E5E4FFE8E7E7FFE9E8E7FFE8E7E6FFE6E5E4FFE9E8E7FFE9E8E7FFE7E6E5FF
        E3E2E1FFE2E0DFFFE3E2E1FFE6E5E4FFE6E5E4FFE6E5E4FFE3E2E1FFE2E0DFFF
        E3E2E1FFE6E5E4FFE6E5E4FFE6E5E4FFE3E2E1FFE0DFDEFFFFFFFFFFAEAEACFF
        000000160000000DAFAFADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFADFF
        0000001000000004AFAFADB4B0B0ADFFAEAEACFFAEAEABFFAEAEABFFAEAEABFF
        AEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFF
        AEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFF
        AEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEABFFAEAEACFFB0B0ADFFB2B2B0F0
        0000000500000000000000000000000000000000000000000000000000000000
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
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF81FFF
        80000001800000018000000180000001FFF81FFFFFFC3FFFFFFC3FFF00000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF}
    end
    object Label1: TLabel
      Left = 52
      Top = 18
      Width = 130
      Height = 19
      Caption = 'Add an IP address'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
