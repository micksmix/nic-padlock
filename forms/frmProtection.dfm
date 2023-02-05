object frmTrialProtector: TfrmTrialProtector
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmTrialProtector'
  ClientHeight = 81
  ClientWidth = 94
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mxprtctr1: TmxProtector
    CodeKey = 'Ignored'
    ProtectionTypes = [stDayTrial]
    Options = [poAutoInit, poCheckSytemTime, poPasswordOnce]
    RegistryRootKey = rkCurrentUser
    Expiration = 41248.535497685190000000
    MaxStartNumber = 0
    MaxDayNumber = 30
    Version = '1.32'
    OnExpiration = mxprtctr1Expiration
    OnDayTrial = mxprtctr1DayTrial
    OnInvalidSystemTime = mxprtctr1InvalidSystemTime
    OnGetRegistryPath = mxprtctr1GetRegistryPath
    Left = 32
    Top = 16
    UniqueCodeID = 
      '7A3735473230464C48273C394E3A2224532120395757252D345F2F242C5C2F19' +
      '17646510645B'
    UniqueID = 
      '21002501197415667070076E745E6B18796E106E6507697849006C716566031F' +
      '041C0B247022'
  end
end
