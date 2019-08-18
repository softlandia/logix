object frmTestChart: TfrmTestChart
  Left = 309
  Top = 188
  Width = 613
  Height = 396
  Caption = 'frmTestChart'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 605
    Height = 29
    ButtonHeight = 16
    Caption = 'ToolBar1'
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 2
      Width = 41
      Height = 16
      Caption = 'Label1'
    end
    object ToolButton1: TToolButton
      Left = 41
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 49
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 0
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 57
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 65
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object Label2: TLabel
      Left = 73
      Top = 2
      Width = 41
      Height = 16
      Caption = 'Label2'
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 336
    Width = 605
    Height = 20
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 29
    Width = 233
    Height = 307
    Align = alLeft
    TabOrder = 2
    object pbBox: TPaintBox
      Left = 0
      Top = 0
      Width = 213
      Height = 10000
      Align = alTop
      OnMouseDown = pbBoxMouseDown
      OnPaint = pbBoxPaint
    end
  end
end
