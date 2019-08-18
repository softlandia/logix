object frmCreateLAS: TfrmCreateLAS
  Left = 275
  Top = 169
  Caption = 'Create new LAS file'
  ClientHeight = 367
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 371
    Height = 325
    Caption = ' Well info '
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 299
      Width = 45
      Height = 13
      Caption = 'File name'
    end
    object btnSelectFile: TSpeedButton
      Left = 336
      Top = 296
      Width = 23
      Height = 22
      OnClick = btnSelectFileClick
    end
    object edCOMP: TLabeledEdit
      Left = 312
      Top = 26
      Width = 52
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Company'
      LabelPosition = lpLeft
      TabOrder = 10
    end
    object edWELLid: TLabeledEdit
      Left = 59
      Top = 26
      Width = 52
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'WELLid'
      LabelPosition = lpLeft
      TabOrder = 0
      OnExit = edWELLidExit
    end
    object edDate: TLabeledEdit
      Left = 59
      Top = 46
      Width = 52
      Height = 21
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Date'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object edAPI: TLabeledEdit
      Left = 59
      Top = 65
      Width = 52
      Height = 21
      EditLabel.Width = 17
      EditLabel.Height = 13
      EditLabel.Caption = 'API'
      LabelPosition = lpLeft
      TabOrder = 2
    end
    object edUWI: TLabeledEdit
      Left = 59
      Top = 85
      Width = 52
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'UWI'
      LabelPosition = lpLeft
      TabOrder = 3
    end
    object edWELLno: TLabeledEdit
      Left = 59
      Top = 104
      Width = 52
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Well no'
      LabelPosition = lpLeft
      TabOrder = 4
    end
    object edFLD: TLabeledEdit
      Left = 59
      Top = 124
      Width = 52
      Height = 21
      EditLabel.Width = 33
      EditLabel.Height = 13
      EditLabel.Caption = 'Field id'
      LabelPosition = lpLeft
      TabOrder = 5
    end
    object edSTRT: TLabeledEdit
      Left = 176
      Top = 26
      Width = 52
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'STRT'
      LabelPosition = lpLeft
      TabOrder = 6
    end
    object edSTOP: TLabeledEdit
      Left = 176
      Top = 46
      Width = 52
      Height = 21
      EditLabel.Width = 29
      EditLabel.Height = 13
      EditLabel.Caption = 'STOP'
      LabelPosition = lpLeft
      TabOrder = 7
    end
    object edNULL: TLabeledEdit
      Left = 176
      Top = 65
      Width = 52
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'NULL'
      LabelPosition = lpLeft
      TabOrder = 8
    end
    object edSTEP: TLabeledEdit
      Left = 176
      Top = 85
      Width = 52
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'STEP'
      LabelPosition = lpLeft
      TabOrder = 9
    end
    object GroupBox2: TGroupBox
      Left = 13
      Top = 150
      Width = 352
      Height = 137
      Caption = 'Data source '
      TabOrder = 14
      object lvDataFiles: TListView
        Left = 7
        Top = 13
        Width = 338
        Height = 118
        Columns = <
          item
            Caption = 'File name'
            Width = 223
          end
          item
            Caption = 'LOG id'
            Width = 52
          end
          item
            Caption = 'Unit'
            Width = 52
          end>
        FlatScrollBars = True
        RowSelect = True
        PopupMenu = lvMenu
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = Edit1Click
        OnKeyDown = lvDataFilesKeyUp
      end
    end
    object edCTRY: TLabeledEdit
      Left = 312
      Top = 46
      Width = 52
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Country'
      LabelPosition = lpLeft
      TabOrder = 11
      Text = 'Russia'
    end
    object edLOC: TLabeledEdit
      Left = 312
      Top = 65
      Width = 52
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'Location'
      LabelPosition = lpLeft
      TabOrder = 12
    end
    object edSRVC: TLabeledEdit
      Left = 312
      Top = 85
      Width = 52
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Service'
      LabelPosition = lpLeft
      TabOrder = 13
    end
    object edAlt: TLabeledEdit
      Left = 176
      Top = 117
      Width = 52
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'ALT'
      LabelPosition = lpLeft
      TabOrder = 15
    end
    object FilenameEdit1: TEdit
      Left = 56
      Top = 296
      Width = 281
      Height = 21
      TabOrder = 16
      Text = 'FilenameEdit1'
    end
  end
  object btnOk: TBitBtn
    Left = 241
    Top = 338
    Width = 65
    Height = 27
    TabOrder = 1
    OnClick = btnOkClick
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 312
    Top = 338
    Width = 66
    Height = 27
    TabOrder = 2
    Kind = bkCancel
  end
  object lvMenu: TPopupMenu
    Images = frmMain.ButtonImages
    Left = 8
    Top = 336
    object Addfile1: TMenuItem
      Caption = 'Add'
      ImageIndex = 28
      OnClick = Addfile1Click
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      ImageIndex = 31
      OnClick = Edit1Click
    end
    object Deletefile1: TMenuItem
      Caption = 'Delete'
      ImageIndex = 32
      OnClick = Deletefile1Click
    end
    object View1: TMenuItem
      Caption = 'View'
      ImageIndex = 2
      OnClick = View1Click
    end
    object Shortfilename1: TMenuItem
      Caption = 'Short filename'
    end
    object Fullfilename1: TMenuItem
      Caption = 'Full filename'
    end
  end
  object OpenDlg: TOpenDialog
    DefaultExt = 'xyz'
    Filter = 'XYZ files (*.xyz)|*.xyz|Any files (*.*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 72
    Top = 336
  end
  object FormStorage1: TFormStorage
    IniFileName = 'logix.ini'
    IniSection = 'frmCreateLas'
    StoredValues = <>
    Left = 104
    Top = 336
  end
end
