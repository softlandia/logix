object frmViewSheet: TfrmViewSheet
  Left = 547
  Top = 408
  Caption = 'frmViewSheet'
  ClientHeight = 258
  ClientWidth = 538
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
    Top = 239
    Width = 538
    Height = 19
    Panels = <>
    ExplicitTop = 189
  end
  object ToolBar1: TToolBar
    Left = 509
    Top = 0
    Width = 29
    Height = 239
    Align = alRight
    Caption = 'ToolBar1'
    TabOrder = 1
    ExplicitHeight = 233
  end
  object lvData: TListView
    Left = 0
    Top = 0
    Width = 509
    Height = 239
    Align = alClient
    Columns = <>
    TabOrder = 2
    ViewStyle = vsReport
    ExplicitWidth = 414
    ExplicitHeight = 189
  end
end
