object frmAddNewLOGaliace: TfrmAddNewLOGaliace
  Left = 291
  Top = 148
  Width = 223
  Height = 173
  Caption = 'Add new aliace'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TBitBtn
    Left = 72
    Top = 117
    Width = 65
    Height = 27
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 143
    Top = 117
    Width = 66
    Height = 27
    TabOrder = 1
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 202
    Height = 104
    Caption = ' input aliace and target LOGid '
    TabOrder = 2
    object Label1: TLabel
      Left = 20
      Top = 33
      Width = 32
      Height = 13
      Caption = 'source'
    end
    object Label2: TLabel
      Left = 20
      Top = 65
      Width = 27
      Height = 13
      Caption = 'target'
    end
    object edKey: TEdit
      Left = 59
      Top = 33
      Width = 98
      Height = 21
      TabOrder = 0
      Text = 'edKey'
    end
    object edValue: TEdit
      Left = 59
      Top = 65
      Width = 98
      Height = 21
      TabOrder = 1
      Text = 'edValue'
    end
  end
end
