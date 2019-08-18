object frmPreferences: TfrmPreferences
  Left = 395
  Top = 115
  Caption = 'Preferences'
  ClientHeight = 250
  ClientWidth = 331
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
    Left = 0
    Top = 42
    Width = 331
    Height = 163
    Align = alClient
    Caption = ' LOGid aliace table '
    TabOrder = 0
    object leLogId: TValueListEditor
      Left = 2
      Top = 15
      Width = 327
      Height = 146
      Align = alClient
      TabOrder = 0
      ColWidths = (
        150
        171)
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 331
    Height = 42
    ButtonHeight = 32
    ButtonWidth = 36
    Caption = 'ToolBar1'
    Images = frmMain.ButtonImages
    TabOrder = 1
    object btnAdd: TToolButton
      Left = 0
      Top = 0
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      EnableDropdown = True
      ImageIndex = 12
      OnClick = btnAddClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 205
    Width = 331
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel2: TPanel
      Left = 142
      Top = 0
      Width = 189
      Height = 45
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 8
        Top = 8
        Width = 81
        Height = 33
        DoubleBuffered = True
        Kind = bkOK
        ParentDoubleBuffered = False
        TabOrder = 0
      end
      object BitBtn2: TBitBtn
        Left = 96
        Top = 8
        Width = 81
        Height = 33
        DoubleBuffered = True
        Kind = bkCancel
        ParentDoubleBuffered = False
        TabOrder = 1
      end
    end
  end
end
