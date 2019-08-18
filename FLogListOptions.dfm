object frmLogListOptions: TfrmLogListOptions
  Left = 232
  Top = 271
  Width = 320
  Height = 338
  Caption = 'Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 270
    Width = 312
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOK: TBitBtn
      Left = 175
      Top = 7
      Width = 65
      Height = 26
      TabOrder = 0
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 247
      Top = 7
      Width = 65
      Height = 26
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 312
    Height = 270
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lvParameters: TListView
      Left = 0
      Top = 0
      Width = 312
      Height = 270
      Align = alClient
      Checkboxes = True
      Color = 15269887
      Columns = <
        item
          Caption = 'Parameters'
          Width = 300
        end>
      FlatScrollBars = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
end
