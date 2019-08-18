object frmEditLOGid: TfrmEditLOGid
  Left = 362
  Top = 214
  BorderStyle = bsToolWindow
  Caption = 'Edit LOG parameters'
  ClientHeight = 105
  ClientWidth = 239
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 18
    Height = 13
    Caption = 'Log'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 17
    Height = 13
    Caption = 'unit'
  end
  object min: TLabel
    Left = 16
    Top = 56
    Width = 16
    Height = 13
    Caption = 'min'
  end
  object max: TLabel
    Left = 16
    Top = 80
    Width = 19
    Height = 13
    Caption = 'max'
  end
  object btnOK: TBitBtn
    Left = 169
    Top = 42
    Width = 66
    Height = 27
    TabOrder = 2
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 169
    Top = 75
    Width = 66
    Height = 26
    TabOrder = 3
    Kind = bkCancel
  end
  object edLOGid: TEdit
    Left = 48
    Top = 8
    Width = 98
    Height = 21
    TabOrder = 0
    Text = 'edLOGid'
  end
  object edUnit: TEdit
    Left = 48
    Top = 32
    Width = 98
    Height = 21
    TabOrder = 1
    Text = 'edUnit'
  end
  object edMin: TEdit
    Left = 48
    Top = 56
    Width = 97
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object edMax: TEdit
    Left = 48
    Top = 80
    Width = 97
    Height = 21
    TabOrder = 5
    Text = '0'
  end
end
