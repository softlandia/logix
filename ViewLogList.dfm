object frmViewLogList: TfrmViewLogList
  Left = 634
  Top = 336
  Width = 502
  Height = 350
  Caption = 'LOG list'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 304
    Width = 494
    Height = 19
    Panels = <>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 494
    Height = 41
    Caption = 'ToolBar1'
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 494
    Height = 263
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object mmLogList: TMemo
      Left = 2
      Top = 2
      Width = 490
      Height = 259
      Align = alClient
      Lines.Strings = (
        'mmLogList')
      TabOrder = 0
    end
  end
  object Images: TImageList
    Height = 32
    Width = 32
    Left = 464
    Top = 8
  end
end
