object Form11: TForm11
  Left = 0
  Top = 0
  Caption = #1050#1091#1088#1089#1086#1074#1072#1103' '#1088#1072#1073#1086#1090#1072' '#1074#1072#1088#1080#1072#1085#1090' 25'
  ClientHeight = 429
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 111
    Width = 269
    Height = 19
    Caption = #1042#1099#1073#1077#1088#1077#1090#1077' '#1082#1072#1090#1072#1083#1086#1075' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 520
    Top = 23
    Width = 187
    Height = 46
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = SpeedButton1Click
  end
  object Label2: TLabel
    Left = 24
    Top = 16
    Width = 189
    Height = 19
    Caption = #1042#1099#1073#1077#1088#1077#1090#1077' '#1076#1080#1089#1082'-'#1086#1088#1080#1075#1080#1085#1072#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 49
    Width = 167
    Height = 19
    Caption = #1042#1099#1073#1077#1088#1077#1090#1077' '#1076#1080#1089#1082'-'#1082#1086#1087#1080#1102':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 320
    Top = 111
    Width = 411
    Height = 19
    Caption = #1042#1099#1073#1077#1088#1077#1090#1077' '#1075#1088#1091#1087#1087#1091' '#1092#1072#1081#1083#1086#1074' '#1074#1085#1091#1090#1088#1080' '#1082#1072#1090#1072#1083#1086#1075#1072' '#1076#1083#1103' '#1072#1085#1072#1083#1080#1079#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DriveComboBox1: TDriveComboBox
    Left = 240
    Top = 18
    Width = 145
    Height = 19
    TabOrder = 0
    OnChange = DriveComboBox1Change
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 40
    Top = 136
    Width = 217
    Height = 193
    TabOrder = 1
    OnChange = DirectoryListBox1Change
  end
  object FileListBox1: TFileListBox
    Left = 376
    Top = 136
    Width = 257
    Height = 201
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 226
    Top = 356
    Width = 287
    Height = 65
    Caption = #1055#1077#1088#1077#1081#1090#1080' '#1074' '#1084#1077#1085#1102' "'#1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1080' '#1072#1085#1072#1083#1080#1079'"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button1Click
  end
  object DriveComboBox2: TDriveComboBox
    Left = 240
    Top = 50
    Width = 145
    Height = 19
    TabOrder = 4
  end
  object BitBtn7: TBitBtn
    Left = 24
    Top = 366
    Width = 113
    Height = 45
    Hint = #1057#1087#1088#1072#1074#1082#1072
    Caption = 'Help'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333CCCCC33
      33333FFFF77777FFFFFFCCCCCC808CCCCCC3777777F7F777777F008888070888
      8003777777777777777F0F0770F7F0770F0373F33337F333337370FFFFF7FFFF
      F07337F33337F33337F370FFFB99FBFFF07337F33377F33337F330FFBF99BFBF
      F033373F337733333733370BFBF7FBFB0733337F333FF3337F33370FBF98BFBF
      0733337F3377FF337F333B0BFB990BFB03333373FF777FFF73333FB000B99000
      B33333377737777733333BFBFBFB99FBF33333333FF377F333333FBF99BF99BF
      B333333377F377F3333333FB99FB99FB3333333377FF77333333333FB9999FB3
      333333333777733333333333FBFBFB3333333333333333333333}
    NumGlyphs = 2
    TabOrder = 5
    OnClick = BitBtn7Click
  end
  object BitBtn2: TBitBtn
    Left = 597
    Top = 369
    Width = 134
    Height = 40
    Caption = #1042#1099#1093#1086#1076
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 6
    OnClick = BitBtn2Click
  end
end
