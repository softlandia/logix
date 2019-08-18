object frmViewLAS: TfrmViewLAS
  Left = 253
  Top = 155
  Width = 599
  Height = 460
  Caption = 'View LAS file:'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline fraLASView: TfraLASView
    Left = 0
    Top = 29
    Width = 591
    Height = 385
    Align = alClient
    TabOrder = 0
    inherited lvLOGs: TListView
      Top = 249
      Width = 591
      Height = 136
      Columns = <
        item
          Caption = 'LOG'
          Width = 61
        end
        item
          Caption = 'unit'
          Width = 41
        end
        item
          Caption = 'min'
          Width = 61
        end
        item
          Caption = 'max'
          Width = 61
        end>
    end
    inherited lvHeader: TListView
      Width = 591
      Height = 249
      Columns = <
        item
          Caption = 'Field name'
          Width = 73
        end
        item
          Caption = 'Value'
          Width = 142
        end>
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 591
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 1
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 414
    Width = 591
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end
