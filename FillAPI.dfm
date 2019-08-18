object frmFillAPI: TfrmFillAPI
  Left = 233
  Top = 128
  Width = 452
  Height = 401
  Caption = 'frmFillAPI'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object ListBox1: TListBox
    Left = 16
    Top = 16
    Width = 305
    Height = 145
    ItemHeight = 16
    Items.Strings = (
      'x:\prj\well\BEZ-1\'
      'x:\prj\well\OLN-1\')
    TabOrder = 0
  end
  object ListBox2: TListBox
    Left = 16
    Top = 176
    Width = 305
    Height = 161
    ItemHeight = 16
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 336
    Top = 16
    Width = 81
    Height = 33
    Caption = 'BitBtn1'
    TabOrder = 2
    OnClick = btnOkClick
  end
end
