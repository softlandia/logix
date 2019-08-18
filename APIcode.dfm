inherited frmAPIcode: TfrmAPIcode
  Left = 370
  Top = 254
  Caption = 'Change API code'
  ClientWidth = 488
  OldCreateOrder = True
  ExplicitWidth = 496
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 488
    ExplicitWidth = 488
  end
  inherited Panel1: TPanel
    Width = 488
    ExplicitWidth = 488
    inherited lv: TListView
      Width = 486
      FlatScrollBars = True
      ViewStyle = vsReport
      ExplicitWidth = 486
    end
  end
  inherited Panel3: TPanel
    Width = 488
    ExplicitWidth = 488
    inherited btnOK: TBitBtn
      Left = 345
      OnClick = BitBtn1Click
      ExplicitLeft = 345
    end
    inherited btnCancel: TBitBtn
      Left = 410
      ExplicitLeft = 410
    end
  end
end
