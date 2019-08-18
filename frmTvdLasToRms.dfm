inherited frmTvdLasRoRms: TfrmTvdLasRoRms
  Caption = 'Generate TVD LAS to Rms'
  ClientWidth = 759
  ExplicitWidth = 767
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    Width = 759
    ExplicitWidth = 759
    object Label2: TLabel [1]
      Left = 360
      Top = 7
      Width = 42
      Height = 13
      Caption = 'Wells file'
    end
    object edWellsFile: TEdit
      Left = 408
      Top = 7
      Width = 225
      Height = 21
      TabOrder = 2
    end
    object btnOpenWellsFile: TButton
      Left = 632
      Top = 8
      Width = 20
      Height = 20
      Caption = '...'
      TabOrder = 3
      OnClick = btnOpenWellsFileClick
    end
  end
  inherited Panel1: TPanel
    Width = 759
    ExplicitWidth = 759
    inherited lv: TListView
      Width = 471
      FlatScrollBars = True
      ExplicitWidth = 528
    end
    object lvWells: TListView
      Left = 472
      Top = 1
      Width = 286
      Height = 290
      Align = alRight
      Columns = <>
      FlatScrollBars = True
      GridLines = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  inherited Panel3: TPanel
    Width = 759
    ExplicitWidth = 759
  end
  inherited PopupMenu1: TPopupMenu
    Left = 24
  end
  inherited PopupMenuImage: TImageList
    Left = 104
  end
  object odWellsFile: TOpenDialog
    Filter = 'Prn files|*.prn|Text files|*.txt|All files|*.*'
    Left = 240
    Top = 56
  end
end
