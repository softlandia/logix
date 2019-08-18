object frmReplace: TfrmReplace
  Left = 313
  Top = 400
  BorderStyle = bsDialog
  Caption = 'Search & replace'
  ClientHeight = 244
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblResult: TLabel
    Left = 7
    Top = 221
    Width = 163
    Height = 13
    AutoSize = False
    Caption = 'lblResult'
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 312
    Height = 202
    Caption = ' parameters '
    TabOrder = 0
    object edStrToSearch: TLabeledEdit
      Left = 13
      Top = 39
      Width = 118
      Height = 21
      EditLabel.Width = 74
      EditLabel.Height = 13
      EditLabel.Caption = 'Value to search'
      TabOrder = 0
    end
    object edStrToReplace: TLabeledEdit
      Left = 13
      Top = 169
      Width = 118
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Replace'
      TabOrder = 1
    end
    object GroupBox2: TGroupBox
      Left = 150
      Top = 13
      Width = 156
      Height = 105
      Caption = ' result '
      TabOrder = 2
      object lblInfo: TLabel
        Left = 7
        Top = 20
        Width = 143
        Height = 78
        AutoSize = False
        Caption = '**************'
        WordWrap = True
      end
    end
    object GroupBox3: TGroupBox
      Left = 13
      Top = 65
      Width = 131
      Height = 85
      Caption = ' selection criteria '
      TabOrder = 3
      object rbGreate: TRadioButton
        Left = 7
        Top = 20
        Width = 91
        Height = 13
        Caption = 'Greate'
        TabOrder = 0
      end
      object rbEqual: TRadioButton
        Left = 7
        Top = 39
        Width = 91
        Height = 14
        Caption = 'Equal'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object rbLess: TRadioButton
        Left = 7
        Top = 59
        Width = 91
        Height = 13
        Caption = 'Less'
        TabOrder = 2
      end
    end
  end
  object BitBtn2: TBitBtn
    Left = 328
    Top = 72
    Width = 65
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnReplace: TBitBtn
    Left = 328
    Top = 8
    Width = 65
    Height = 25
    Hint = #1047#1072#1084#1077#1085#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1089#1083#1086#1074#1080#1102
    Caption = 'Replace'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnReplaceClick
  end
  object BitBtn1: TBitBtn
    Left = 328
    Top = 40
    Width = 65
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
end
