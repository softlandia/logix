object fraLASView: TfraLASView
  Left = 0
  Top = 0
  Width = 561
  Height = 394
  TabOrder = 0
  OnResize = FrameResize
  object lvLOGs: TListView
    Left = 0
    Top = 153
    Width = 561
    Height = 241
    Align = alClient
    Color = 15269887
    Columns = <
      item
        Caption = 'LOG'
        Width = 75
      end
      item
        Caption = 'unit'
      end
      item
        Caption = 'min'
        Width = 75
      end
      item
        Caption = 'max'
        Width = 75
      end>
    FlatScrollBars = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvLOGsDblClick
  end
  object lvHeader: TListView
    Left = 0
    Top = 0
    Width = 561
    Height = 153
    Align = alTop
    Color = 15269887
    Columns = <
      item
        Caption = 'Field name'
        Width = 90
      end
      item
        Caption = 'Value'
        Width = 175
      end>
    FlatScrollBars = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = lvHeaderDblClick
  end
end
