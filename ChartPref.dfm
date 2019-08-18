object frmChartPref: TfrmChartPref
  Left = 267
  Top = 153
  Caption = 'Chart preferences'
  ClientHeight = 259
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 306
    Height = 210
    Caption = ' options '
    TabOrder = 0
    object Label1: TLabel
      Left = 176
      Top = 8
      Width = 20
      Height = 13
      Caption = 'start'
    end
    object Label2: TLabel
      Left = 176
      Top = 32
      Width = 20
      Height = 13
      Caption = 'stop'
    end
    object Label3: TLabel
      Left = 176
      Top = 56
      Width = 20
      Height = 13
      Caption = 'step'
    end
    object Label4: TLabel
      Left = 176
      Top = 80
      Width = 51
      Height = 13
      Caption = 'Tick count'
    end
    object Label8: TLabel
      Left = 8
      Top = 56
      Width = 23
      Height = 13
      Caption = 'Xmin'
    end
    object Label9: TLabel
      Left = 8
      Top = 80
      Width = 26
      Height = 13
      Caption = 'Xmax'
    end
    object Label10: TLabel
      Left = 8
      Top = 116
      Width = 63
      Height = 13
      Caption = 'Column width'
    end
    object chkGlobalScale: TCheckBox
      Left = 7
      Top = 21
      Width = 156
      Height = 14
      Caption = 'Common scale for all series'
      TabOrder = 0
      OnClick = chkGlobalScaleClick
      OnKeyUp = chkGlobalScaleKeyUp
    end
    object GroupBox2: TGroupBox
      Left = 176
      Top = 109
      Width = 113
      Height = 92
      Caption = ' depth scale '
      TabOrder = 1
      object Label5: TLabel
        Left = 7
        Top = 43
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Label6: TLabel
        Left = 72
        Top = 43
        Width = 8
        Height = 13
        Caption = 'm'
      end
      object Label7: TLabel
        Left = 52
        Top = 56
        Width = 6
        Height = 13
        Caption = '='
      end
      object cbDepthScale: TComboBox
        Left = 7
        Top = 20
        Width = 98
        Height = 21
        TabOrder = 0
        Text = '1:500'
        OnChange = cbDepthScaleChange
        Items.Strings = (
          '1:100'
          '1:200'
          '1:500'
          '1:1000'
          '1:5000'
          '1:10000'
          'Custom')
      end
      object edMMScale: TEdit
        Left = 7
        Top = 56
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '2'
        OnChange = edMMScaleChange
      end
      object edMScale: TEdit
        Left = 72
        Top = 56
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '1'
      end
    end
    object chkAutoScale: TCheckBox
      Left = 112
      Top = 56
      Width = 57
      Height = 17
      Caption = 'auto'
      TabOrder = 2
    end
    object edTickCount: TEdit
      Left = 232
      Top = 80
      Width = 56
      Height = 21
      Enabled = False
      TabOrder = 3
      Text = '0'
    end
    object edStrt: TJvValidateEdit
      Left = 232
      Top = 8
      Width = 56
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 4
      OnValueChanged = edStrtChange
    end
    object edStop: TJvValidateEdit
      Tag = 1
      Left = 232
      Top = 32
      Width = 56
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      EditText = '5000'
      MaxValue = 5000.000000000000000000
      TabOrder = 5
      OnValueChanged = edStrtChange
    end
    object edStep: TJvValidateEdit
      Tag = 2
      Left = 232
      Top = 56
      Width = 56
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      TabOrder = 6
      OnValueChanged = edStrtChange
    end
    object edXmin: TJvValidateEdit
      Left = 40
      Top = 55
      Width = 65
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloatGeneral
      EditText = '1'
      TabOrder = 7
    end
    object edXmax: TJvValidateEdit
      Left = 40
      Top = 80
      Width = 65
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfFloat
      EditText = '10'
      TabOrder = 8
    end
    object edColumnWidth: TJvValidateEdit
      Left = 40
      Top = 129
      Width = 65
      Height = 19
      Flat = True
      ParentFlat = False
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      EditText = '325'
      TabOrder = 9
    end
  end
  object btnCancel: TBitBtn
    Left = 247
    Top = 222
    Width = 66
    Height = 27
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Left = 176
    Top = 222
    Width = 67
    Height = 27
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnOkClick
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = frmMain.JvAppIniFileStorage1
    AppStoragePath = '%FORM_NAME%\'
    StoredValues = <>
    Left = 16
    Top = 176
  end
end
