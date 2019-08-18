object frmAlignLogByDepth: TfrmAlignLogByDepth
  Left = 294
  Top = 297
  Width = 322
  Height = 236
  Caption = 'frmAlignLogByDepth'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 153
    Caption = ' depth '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 20
      Height = 13
      Caption = 'from'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 9
      Height = 13
      Caption = 'to'
    end
    object Label3: TLabel
      Left = 160
      Top = 16
      Width = 128
      Height = 104
      Caption = 
        #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1082#1072#1088#1086#1090#1072#1078' '#1074#1099#1088#1072#1074#1085#1080#1074#1072#1077#1090#1089#1103' '#1087#1086' '#1082#1086#1083#1086#1085#1082#1077' '#1075#1083#1091#1073#1080#1085#1099' '#1087#1077#1088#1074#1086#1075#1086' '#1092#1072 +
        #1081#1083#1072'.'#13#10#1042' '#1089#1083#1091#1095#1072#1077' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086#1089#1090#1080' '#1082#1072#1088#1086#1090#1072#1078' '#1086#1073#1088#1077#1079#1072#1077#1090#1089#1103' '#1080#1083#1080' '#1079#1072#1087#1086#1083#1085#1103#1077#1090#1089#1103' ' +
        #1079#1085#1072#1095#1077#1085#1080#1077#1084' NULL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edDepthFrom: TRxCalcEdit
      Left = 32
      Top = 32
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 0
    end
    object edDepthTo: TRxCalcEdit
      Left = 32
      Top = 64
      Width = 121
      Height = 21
      AutoSize = False
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 190
    Width = 314
    Height = 19
    Panels = <>
  end
  object BitBtn1: TBitBtn
    Left = 128
    Top = 152
    Width = 81
    Height = 33
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 216
    Top = 152
    Width = 81
    Height = 33
    TabOrder = 3
    Kind = bkCancel
  end
end
