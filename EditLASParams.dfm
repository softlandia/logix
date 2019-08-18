object frmEditLASParams: TfrmEditLASParams
  Left = 523
  Top = 269
  Width = 293
  Height = 118
  Caption = 'Edit LAS parameter'
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
    Left = 7
    Top = 7
    Width = 22
    Height = 13
    Caption = 'Field'
  end
  object Label2: TLabel
    Left = 7
    Top = 46
    Width = 27
    Height = 13
    Caption = 'Value'
  end
  object edFieldName: TEdit
    Left = 7
    Top = 20
    Width = 150
    Height = 24
    Color = 15269887
    TabOrder = 1
    Text = 'edFieldName'
  end
  object BitBtn1: TBitBtn
    Left = 163
    Top = 20
    Width = 65
    Height = 26
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 163
    Top = 52
    Width = 65
    Height = 27
    TabOrder = 3
    Kind = bkCancel
  end
  object edFieldValue: TEdit
    Left = 7
    Top = 59
    Width = 150
    Height = 24
    Color = 15269887
    TabOrder = 0
    Text = 'edFieldValue'
  end
end
