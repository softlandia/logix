object frmChartHeaderInfo: TfrmChartHeaderInfo
  Left = 741
  Top = 280
  BorderStyle = bsDialog
  Caption = 'INFO'
  ClientHeight = 258
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 293
    Height = 215
    Caption = ' LOG parameters '
    TabOrder = 0
    object Label1: TLabel
      Left = 189
      Top = 20
      Width = 30
      Height = 13
      Caption = 'LOGid'
    end
    object Label2: TLabel
      Left = 189
      Top = 46
      Width = 19
      Height = 13
      Caption = 'Unit'
    end
    object Label3: TLabel
      Left = 14
      Top = 20
      Width = 16
      Height = 13
      Caption = 'min'
    end
    object Label4: TLabel
      Left = 14
      Top = 46
      Width = 19
      Height = 13
      Caption = 'max'
    end
    object Label7: TLabel
      Left = 33
      Top = 117
      Width = 24
      Height = 13
      Caption = 'Color'
    end
    object Label8: TLabel
      Left = 7
      Top = 169
      Width = 49
      Height = 13
      Caption = 'Thickness'
    end
    object Label5: TLabel
      Left = 33
      Top = 143
      Width = 23
      Height = 13
      Caption = 'Style'
    end
    object edLOGid: TEdit
      Left = 222
      Top = 20
      Width = 65
      Height = 21
      Hint = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1082#1072#1088#1086#1090#1072#1078#1072
      Color = clInfoBk
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'edLOGid'
      OnKeyUp = FormKeyUp
    end
    object edUnit: TEdit
      Left = 222
      Top = 46
      Width = 65
      Height = 21
      Hint = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      Color = clInfoBk
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'edUnit'
      OnKeyUp = FormKeyUp
    end
    object chkLOGAxisStyle: TCheckBox
      Left = 65
      Top = 195
      Width = 157
      Height = 14
      Caption = 'Logariphm axis'
      Enabled = False
      TabOrder = 2
      OnKeyUp = FormKeyUp
    end
    object cbLineStyle: TLineStyleComboBox
      Left = 65
      Top = 143
      Width = 144
      Hint = #1057#1090#1080#1083#1100' '#1083#1080#1085#1080#1080
      LineStyle = psSolid
      MaxLineStyle = psClear
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyUp = FormKeyUp
    end
    object cbLineWidth: TLineWidthComboBox
      Left = 65
      Top = 169
      Width = 144
      Hint = #1058#1086#1083#1097#1080#1085#1072' '#1083#1080#1085#1080#1080
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnKeyUp = FormKeyUp
    end
    object chkAutoScale: TCheckBox
      Left = 120
      Top = 20
      Width = 49
      Height = 17
      Caption = 'auto'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnKeyUp = FormKeyUp
    end
    object edMin: TEdit
      Left = 40
      Top = 24
      Width = 73
      Height = 21
      TabOrder = 6
      Text = '0.0'
    end
    object edMax: TEdit
      Left = 40
      Top = 48
      Width = 73
      Height = 21
      TabOrder = 7
      Text = '0.0'
    end
    object cbLineColour: TxColorBox
      Left = 63
      Top = 115
      Width = 145
      Height = 22
      TabOrder = 8
      OnKeyUp = FormKeyUp
    end
  end
  object btnOK: TBitBtn
    Left = 163
    Top = 228
    Width = 65
    Height = 26
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 234
    Top = 228
    Width = 66
    Height = 26
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
end
