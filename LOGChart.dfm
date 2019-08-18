object frmLogChart: TfrmLogChart
  Left = 624
  Top = 75
  Caption = 'Log chart'
  ClientHeight = 630
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 83
    Width = 393
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 89
    ExplicitWidth = 23
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 393
    Height = 33
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Images = frmMain.ButtonImages
    TabOrder = 0
    object btnCopy: TToolButton
      Left = 0
      Top = 0
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      Caption = 'btnCopy'
      ImageIndex = 20
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCopyClick
    end
    object btnExport: TToolButton
      Left = 31
      Top = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1084#1077#1090#1072#1092#1072#1081#1083
      Caption = 'btnExport'
      Enabled = False
      ImageIndex = 21
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnExportClick
    end
    object btnExportToACAD: TToolButton
      Left = 62
      Top = 0
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1074' AutoCAD'
      Enabled = False
      ImageIndex = 22
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnExportToACADClick
    end
    object ToolButton1: TToolButton
      Left = 93
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      Style = tbsSeparator
    end
    object btnLOGstyle: TToolButton
      Tag = 26
      Left = 101
      Top = 0
      Hint = #1051#1086#1075#1072#1088#1080#1092#1084#1080#1095#1077#1089#1082#1080#1081' '#1084#1072#1089#1096#1090#1072#1073
      ImageIndex = 26
      ParentShowHint = False
      ShowHint = True
      OnClick = btnLOGstyleClick
    end
    object btnGrafPref: TToolButton
      Left = 132
      Top = 0
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1082#1086#1083#1086#1085#1082#1080
      Caption = 'btnGrafPref'
      ImageIndex = 10
      OnClick = btnGrafPrefClick
    end
    object btnToSeeLevel: TToolButton
      Tag = 23
      Left = 163
      Top = 0
      Hint = #1054#1090' '#1091#1088#1086#1074#1085#1103' '#1084#1086#1088#1103
      Caption = 'btnToSeeLevel'
      Enabled = False
      ImageIndex = 23
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnToSeaLevelClick
    end
    object btnAddLog: TToolButton
      Left = 194
      Top = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1088#1086#1090#1072#1078' '#1080#1079' '#1092#1072#1081#1083#1072
      Enabled = False
      ImageIndex = 27
      OnClick = btnAddLogClick
    end
  end
  object sbStatus: TStatusBar
    Left = 0
    Top = 608
    Width = 393
    Height = 22
    Panels = <
      item
        Width = 85
      end
      item
        Width = 185
      end
      item
        Width = 50
      end>
  end
  object sbHeader: TScrollBox
    Left = 0
    Top = 33
    Width = 393
    Height = 50
    HorzScrollBar.Smooth = True
    HorzScrollBar.Style = ssFlat
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Size = 16
    VertScrollBar.Style = ssFlat
    VertScrollBar.Tracking = True
    Align = alTop
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 32
  end
  object ScrollBox: TPainterBox
    Left = 0
    Top = 86
    Width = 393
    Height = 522
    HorzScrollBar.Style = ssFlat
    VertScrollBar.Smooth = True
    VertScrollBar.Size = 16
    VertScrollBar.Style = ssFlat
    VertScrollBar.Tracking = True
    Align = alClient
    TabOrder = 3
    DefColumnWidth = 310
    DepthColumn = pbDepth
    FixedColumnWidth = False
    Lock = True
    object pbDepth: TPainterRule
      Left = 0
      Top = 0
      Width = 41
      Height = 690
      Graf = rule
      FixedWidth = True
    end
    object pbChart: TPainter
      Tag = 100
      Left = 41
      Top = 0
      Width = 325
      Height = 690
      Cursor = crCross
      Color = clWhite
      ParentColor = False
      OnMouseMove = pbChartMouseMove
      Graf = grf
      FixedWidth = False
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'wmf'
    Filter = 
      'Windows MetafileWindows|*.wmf|Enhanced Metafile|*.emf|AutoCAD sc' +
      'ript|*.scr|Any Files|*.*'
    Left = 136
    Top = 40
  end
  object grf: TxGraf
    NumXMinorTicks = 10
    NumXMajorTicks = 10
    NumYMinorTicks = 10
    NumYMajorTicks = 10
    Ax = 1.000000000000000000
    Ay = 1.000000000000000000
    XPowShift = 0
    YPowShift = 0
    XAutoScale = True
    XGlobalScale = False
    YGlobalScale = True
    ScaleFactor = 2.000000000000000000
    XGridSwtch = True
    YGridSwtch = True
    XAxisEnabled = False
    YAxisEnabled = False
    HLabelSize = 40
    LeftMar = 0
    RightMar = 0
    TopMar = 5
    BottomMar = 0
    BkColour = clWhite
    AxColour = 10461087
    AyColour = 10461087
    Colour = clRed
    AxPenWidth = 1
    AyPenWidth = 1
    PenWidth = 0
    AxPenStyle = psDot
    AyPenStyle = psDot
    PenStyle = psDot
    XStep = 10.000000000000000000
    YStep = 10.000000000000000000
    Orientation = xgrfVERTICAL
    YAxisStyle = asLINE
    XAxisStyle = asLINE
    Ymax = 100.000000000000000000
    Xmax = 100.000000000000000000
    PaintBox = pbChart
    OwneredY = True
    OwnerY = rule
    Left = 152
    Top = 208
  end
  object rule: TxGraf
    NumXMinorTicks = 10
    NumXMajorTicks = 10
    NumYMinorTicks = 10
    NumYMajorTicks = 10
    Ax = 1.000000000000000000
    Ay = 1.000000000000000000
    XPowShift = 0
    YPowShift = 0
    XAutoScale = True
    XGlobalScale = False
    YGlobalScale = True
    ScaleFactor = 1.000000000000000000
    XGridSwtch = False
    YGridSwtch = False
    XAxisEnabled = False
    YAxisEnabled = True
    HLabelSize = 40
    LeftMar = 0
    RightMar = 0
    TopMar = 0
    BottomMar = 0
    BkColour = clWhite
    AxColour = 10461087
    AyColour = 10461087
    Colour = clBlack
    AxPenWidth = 1
    AyPenWidth = 1
    PenWidth = 1
    AxPenStyle = psDot
    AyPenStyle = psDot
    PenStyle = psDot
    XStep = 10.000000000000000000
    YStep = 10.000000000000000000
    Orientation = xgrfVERTICAL
    YAxisStyle = asLINE
    XAxisStyle = asLINE
    Ymax = 100.000000000000000000
    Xmax = 100.000000000000000000
    PaintBox = pbDepth
    OwneredY = False
    Left = 8
    Top = 208
  end
  object mnuSelectLog: TPopupMenu
    OnPopup = mnuSelectLogPopup
    Left = 216
    Top = 41
    object Select1: TMenuItem
      Caption = 'Select'
      OnClick = Select1Click
    end
    object Deselect1: TMenuItem
      Caption = 'Deselect'
      OnClick = Deselect1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
  end
  object OpenDialog1: TOpenDialog
    FileName = 'f:\_project\WELLS\std.las'
    InitialDir = 'E:\_project\wells'
    Left = 288
    Top = 41
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = frmMain.JvAppIniFileStorage1
    AppStoragePath = '%FORM_NAME%\'
    StoredValues = <>
    Left = 48
    Top = 40
  end
end
