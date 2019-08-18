unit AddLAS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ImgList, ComCtrls, ToolWin, Utils, Common, CLAS, LASView;

const
  defFormCaption = 'Add logs from %-s to %-s.';
  defPntCountCaption = 'Total read points: ';

type
  TfrmAddLAS = class(TForm)
    ToolBar1: TToolBar;
    sbStatus: TStatusBar;
    btnOpenFirst: TToolButton;
    btnOpenSecond: TToolButton;
    ToolButton3: TToolButton;
    btnAddLAS: TToolButton;
    OpenDlg: TOpenDialog;
    tblSaveDlg: TToolButton;
    ImageList1: TImageList;
    SaveDlg: TSaveDialog;
    ToolButton1: TToolButton;
    btnSaveLAS: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    fraLASView1: TfraLASView;
    fraLASView2: TfraLASView;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnOpenFirstClick(Sender: TObject);
    procedure btnOpenSecondClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
{ƒобавл€ет данные из одного файла в другой, добавл€€ их в конец существующих}
    procedure btnAddLASClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tblSaveDlgClick(Sender: TObject);
    procedure lvLOGs2DblClick(Sender: TObject);
    procedure lvLOGs1DblClick(Sender: TObject);
    procedure btnSaveLASClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvHeader1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvHeader2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvLOGs1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvLOGs2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    lf1,
    lf2         : TLASFile;
    FileNameAs  : string;
    lf_can_free : BOOL;
    las_changed : TCHANGEDFLAG;
    function  EditLOGparams( var li : TListItem ) : integer;
    function  InitListView( var lvHeader : TListView;
                            var lvLOGs   : TListView;
                            var lf       : TLASFile ) : integer;
  end;

var
  frmAddLAS: TfrmAddLAS;

implementation
uses
  EditLOGid;
{$R *.DFM}

function  TfrmAddLAS.InitListView( var lvHeader : TListView;
                                   var lvLOGs   : TListView;
                                   var lf       : TLASFile ) : integer;
var
  i     : integer;
  li    : TListItem;
begin
  try
    lvHeader.Items.Clear();
    for i := 0 to lf.header.count-1 do begin
      li := lvHeader.Items.Add();
      li.Caption := lf.header.strings[i];
      li.SubItems.Add(lf.header.asString(li.Caption));
    end;
    lvLOGs.Items.Clear();
    for i := 0 to lf.logs.count-1 do begin
      li := lvLOGs.Items.Add();
      li.Caption := Trim(lf.logs[i]);
      li.SubItems.Add(Trim(lf.logs.GetUnit(i)));
      li.SubItems.Add(FloatToStr(lf.logs.y(i).min));
      li.SubItems.Add(FloatToStr(lf.logs.y(i).max));
    end;
    result := _OK_;
  except
    result := _ERROR_;
  end;
end;

procedure TfrmAddLAS.FormShow(Sender: TObject);
begin
  lf_can_free := false;
  OpenDlg.InitialDir := LastFolderPath;
  FormResize(Sender);
  if lf.logs.Count > 0 then begin
    lf1 := lf;
    lf_can_free := false;
    InitListView( fraLASView1.lvHeader, fraLASView1.lvLOGs, lf1 );
    self.Caption := Format( defFormCaption, [lf1.FileName, '???']);
  end
  else
    lf1 := TLASFile.Create();
  lf2 := TLASFile.Create();
  btnAddLAS.Enabled := false;
end;

procedure TfrmAddLAS.FormResize(Sender: TObject);
begin
  fraLASView1.Width := self.ClientWidth div 2;
//  fraLASView1.lvHeader.Height := 2 * Panel1.Height div 3;
//  fraLASView2.lvHeader.Height := 2 * Panel2.Height div 3;
end;

procedure TfrmAddLAS.btnOpenFirstClick(Sender: TObject);
var
  cur : TCursor;
begin
  cur := Screen.Cursor;
  try
    if OpenDlg.Execute() then
      try
        Screen.Cursor := crHourGlass;
        lf1.Clear();
        if lf1.ReadFromLAS(OpenDlg.FileName) > 0 then
          InitListView(fraLASView1.lvHeader, fraLASView1.lvLOGs, lf1);
        self.Caption := Format( defFormCaption, [lf1.FileName, '???']);
        btnAddLAS.Enabled := (fraLASView2.lvLOGs.Items.Count > 0) and (fraLASView1.lvLOGs.Items.Count > 0);
      except
        lf1.Clear();
        btnAddLAS.Enabled := false;
      end;
  finally
    Screen.Cursor := cur;
  end;
end;

procedure TfrmAddLAS.btnOpenSecondClick(Sender: TObject);
var
  cur : TCursor;
begin
  cur := Screen.Cursor;
  try
    if OpenDlg.Execute() then
      try
        Screen.Cursor := crHourGlass;
        lf2.Clear;
        if lf2.ReadFromLAS( OpenDlg.FileName ) > 0 then
          InitListView( fraLASView2.lvHeader, fraLASView2.lvLOGs, lf2 );
        self.Caption := Format( defFormCaption, [lf1.FileName, lf2.FileName]);
        btnAddLAS.Enabled := (fraLASView2.lvLOGs.Items.Count > 0) and (fraLASView1.lvLOGs.Items.Count > 0);
      except
        lf2.Clear;
        btnAddLAS.Enabled := false;
      end;
  finally
    Screen.Cursor := cur;
  end;
end;

procedure TfrmAddLAS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  lf2.Free;
  if lf_can_free then
    lf1.Free;
end;


{ƒобавление осуществл€етс€ по пор€дковому номеру каротажа}
procedure TfrmAddLAS.btnAddLASClick(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to lf1.logs.Count-1 do begin
    lf1.AddLogData( i, lf2.logs.LOG(i) );
  end;
  if FileNameAs = '' then
    FileNameAs := lf1.FileName;
  with lf1 do begin
    WriteToLas( FileNameAs );
    header.SetValueAsFloat('STRT', logs.y(0).FindMin );
    header.SetValueAsFloat('STOP', logs.y(0).FindMax );
  end;
  InitListView( fraLASView1.lvHeader, fraLASView1.lvLOGs, lf1 );
end;

procedure TfrmAddLAS.FormCreate(Sender: TObject);
begin
  FileNameAs :=  '';
  las_changed := [cfNONE];
end;

procedure TfrmAddLAS.tblSaveDlgClick(Sender: TObject);
begin
  if SaveDlg.Execute then
    FileNameAs := SaveDlg.filename;
end;

function  TfrmAddLas.EditLOGparams( var li : TListItem ) : integer;
begin
  try
    with frmEditLOGid do begin
      edLOGid.Text := li.Caption;
      edUnit.Text  := li.SubItems[0];
      edMin.Text   := PutDecimalSeparator(li.SubItems[1]);
      edMax.Text   := PutDecimalSeparator(li.SubItems[2]);
      if ShowModal = mrOK then begin
        li.Caption     := edLOGid.Text;
        li.SubItems[0] := edUnit.Text;
        li.SubItems[1] := edMin.Text;
        li.SubItems[2] := edMax.Text;
        result := _OK_;
      end
      else
        result := _ERROR_;
    end;
  except
    result := _ERROR_;
  end;
end;

procedure TfrmAddLAS.lvLOGs2DblClick(Sender: TObject);
var
  li : TListItem;
begin
  li := fraLASView2.lvLOGs.ItemFocused;
  btnSaveLAS.Enabled := (EditLOGparams(li) = _OK_);
  las_changed := las_changed + [cfSECOND];
end;

procedure TfrmAddLAS.lvLOGs1DblClick(Sender: TObject);
var
  li : TListItem;
begin
  li := fraLASView1.lvLOGs.ItemFocused;
  btnSaveLAS.Enabled := (EditLOGparams(li) = _OK_);
  las_changed := las_changed + [cfFirst];
end;

procedure TfrmAddLAS.btnSaveLASClick(Sender: TObject);
begin
  if cfFIRST in las_changed then begin
      lf1.SaveParameters( fraLASView1.lvHeader, fraLASView1.lvLOGs );
      lf1.WriteToLAS( lf1.FileName );
      las_changed := las_changed - [cfFIRST];
    end
  else
  if cfSECOND in las_changed then begin
      lf2.SaveParameters( fraLASView2.lvHeader, fraLASView2.lvLOGs );
      lf2.WriteToLAS( lf2.FileName );
      las_changed := las_changed - [cfSECOND];
  end;
  btnSaveLAS.Enabled := false;
end;

procedure TfrmAddLAS.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 83) and btnSaveLAS.Enabled then
    btnSaveLASClick(Sender);
end;

procedure TfrmAddLAS.lvHeader1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmAddLAS.lvHeader2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmAddLAS.lvLOGs1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

procedure TfrmAddLAS.lvLOGs2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyUp(sender, key, Shift);
end;

end.
