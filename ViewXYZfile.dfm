object frmViewXYZfile: TfrmViewXYZfile
  Left = 337
  Top = 115
  Width = 289
  Height = 381
  Caption = 'file: '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 296
    Width = 281
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOk: TBitBtn
      Left = 137
      Top = 7
      Width = 67
      Height = 26
      TabOrder = 0
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 208
      Top = 7
      Width = 66
      Height = 26
      TabOrder = 1
      Kind = bkCancel
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 39
      Width = 281
      Height = 19
      Panels = <
        item
          Width = 127
        end>
    end
    object Gauge: TProgressBar
      Left = 0
      Top = 13
      Width = 131
      Height = 13
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 296
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lvData: TListView
      Left = 0
      Top = 0
      Width = 281
      Height = 296
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = '0'
        end
        item
          AutoSize = True
          Caption = '1'
        end
        item
          AutoSize = True
          Caption = '2'
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
