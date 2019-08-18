unit CreateLas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Utils, CLas,
  ImgList, Menus, ComCtrls, Floatlist;

type
  TfrmCreateLAS = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edWELLid: TLabeledEdit;
    edLOC: TLabeledEdit;
    edSRVC: TLabeledEdit;
    edDate: TLabeledEdit;
    edAPI: TLabeledEdit;
    edUWI: TLabeledEdit;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    edWELLno: TLabeledEdit;
    edFLD: TLabeledEdit;
    edSTRT: TLabeledEdit;
    edSTOP: TLabeledEdit;
    edNULL: TLabeledEdit;
    edCOMP: TLabeledEdit;
    edCTRY: TLabeledEdit;
    edSTEP: TLabeledEdit;
    GroupBox2: TGroupBox;
    lvDataFiles: TListView;
    lvMenu: TPopupMenu;
    Addfile1: TMenuItem;
    Deletefile1: TMenuItem;
    Edit1: TMenuItem;
    OpenDlg: TOpenDialog;
    Shortfilename1: TMenuItem;
    Fullfilename1: TMenuItem;
    View1: TMenuItem;
    edAlt: TLabeledEdit;
    FilenameEdit1: TEdit;
    btnSelectFile: TSpeedButton;
    procedure edWELLidExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure Addfile1Click(Sender: TObject);
    procedure Deletefile1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure View1Click(Sender: TObject);
    procedure lvDataFilesKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectFileClick(Sender: TObject);
  private
  public
    las : TLASFile;
    function  EditLOGparams( var li : TListItem ) : integer;
  end;

var
  frmCreateLAS: TfrmCreateLAS;

implementation
{$R *.dfm}
uses
  EditLOGid, ViewXYZfile, Wells, Main;

procedure TfrmCreateLAS.edWELLidExit(Sender: TObject);
begin
  if edWELLid.Text = '' then
    exit;
  edAPI.Text := edWELLid.Text;
  edUWI.Text := edWELLid.Text;
  edFLD.Text := GetFLD( edWELLid.Text );
  edWELLno.Text := IntToStr(GetWELLno( edWELLid.Text ));
end;

procedure TfrmCreateLAS.FormCreate(Sender: TObject);
begin
  edDate.Text := DateToStr(Now());
end;

procedure TfrmCreateLAS.btnOkClick(Sender: TObject);

  function AddOneLog( const filename, _LOGid, _Unit : string; lasfile : TLASFile ) : TLOGDataSet;
  var
    d, v,
    y : TxFloatList;
  begin
    try
      d := TxFloatList.Create();
      v := TxFloatList.Create();
//—читываем .xyz файл, глубину в d, значени€ в v
      if ReadXYZfile( filename, d, v ) = _ERROR_ then begin
        result := nil;
        exit;
      end;
      y := TxFloatList.Create;
//»нтерполируем не регул€рные данные d, v в регул€рный по глубине список y
      NormalizeXYZ( lasfile._STRT, lasfile._STOP, lasfile._STEP,   //нач. конечна€ глубина и шаг
                    lasfile._NULL,                                 //пустое значение
                    d, v,                                          //√лубина/значение считанные из XYZ файла
                    y);                                            //–езультирующий список
      if y.Count <> lasfile.logs.log(0).y.count then begin
        result := nil;
        exit;
      end;
      result := lasfile.AddLog( _LOGid, _Unit, y );
    finally
      y.Free();
      v.Free();
      d.Free();
    end;
  end;

var
  li  : TListItem;
  i   : integer;
begin
  if Length(FilenameEdit1.Text) = 0 then
    exit;
  las := TLASFile.Create();
  try
    with las, header do begin
      CreateNew();
      FileName := FilenameEdit1.Text;
      SetValue('STRT', edSTRT.Text);
      SetValue('STOP', edSTOP.Text);
      SetValue('STEP', edSTEP.Text);
      SetValue('NULL', edNULL.Text);
      SetValue('COMP', edCOMP.Text);
      SetValue('WELL', edWELLno.Text);
      SetValue('FLD',  edFLD.Text);
      SetValue('LOC',  edLOC.Text);
      SetValue('CTRY', edCTRY.Text);
      SetValue('SRVC', edSRVC.Text);
      SetValue('DATE', edDate.Text);
      SetValue('API',  edAPI.Text);
      SetValue('UWI',  edUWI.Text);
      SetValue('ALT',  edAlt.Text);
      SetupDepthLog();
    end;
//«аполнение секции ~CURVE и данных из файлов
    for i := 0 to lvDataFiles.Items.Count-1 do begin
      li := lvDataFiles.Items[i];
//li.Caption - им€ файла, li.SubItems[0] - LOGid, li.SubItems[1] - ед измерени€
      if AddOneLog( li.Caption, li.SubItems[0], li.SubItems[1], las ) = nil then
        exit;
    end;
    Cursor := crHourGlass;
    las.WriteToLAS(FilenameEdit1.Text);
    Cursor := crDefault;
  finally
    las.Free();
  end;
end;

procedure TfrmCreateLAS.Addfile1Click(Sender: TObject);
var
  li : TListItem;
begin
  if OpenDlg.Execute then begin
    li := lvDataFiles.Items.Add;
    li.Caption := OpenDlg.FileName;
    li.SubItems.Add('N/A');
    li.SubItems.Add('N/A');
  end;
end;

procedure TfrmCreateLAS.Deletefile1Click(Sender: TObject);
begin
  lvDataFiles.Items.Delete( lvDataFiles.ItemIndex );
end;

function  TfrmCreateLAS.EditLOGparams( var li : TListItem ) : integer;
begin
  try
    with frmEditLOGid do begin
      edLOGid.Text := li.SubItems[0];
      edUnit.Text  := 'N/A';
      edMin.Text  := '0.0';
      edMax.Text  := '0.0';
      if ShowModal = mrOK then begin
//        li.Caption     := ;
        li.SubItems[0] := edLOGid.Text;
        li.SubItems[1] := edUnit.Text;
//        li.SubItems[2] := FloatToStr(edMax.Value);
        result := _OK_;   
      end
      else
        result := _ERROR_;
    end;
  except
    result := _ERROR_;
  end;
end;

procedure TfrmCreateLAS.Edit1Click(Sender: TObject);
var
  li : TListItem;
begin
  li := lvDataFiles.ItemFocused;
  EditLOGparams(li);
end;

procedure TfrmCreateLAS.View1Click(Sender: TObject);
begin
  with TfrmViewXYZfile.Create(Application) do begin
    xyzFile := lvDataFiles.ItemFocused.Caption;
    Show();
    Init(lvDataFiles.ItemFocused.Caption);
  end;
end;

procedure TfrmCreateLAS.lvDataFilesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Edit1Click(Sender);
end;

procedure TfrmCreateLAS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCreateLAS.btnSelectFileClick(Sender: TObject);
begin
  if OpenDlg.Execute() then
    FilenameEdit1.Text := OpenDlg.FileName;
end;

end.
