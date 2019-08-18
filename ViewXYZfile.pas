unit ViewXYZfile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Utils, cLAS, FloatList;

const
  msgLinesCount  = 'Loaded %u points.';
  msgFileNotOpen = 'File %s can not open.';

type
  TfrmViewXYZfile = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    lvData: TListView;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    StatusBar1: TStatusBar;
    Gauge: TProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
{  Имя входного файла }
    xyzFile : string;
{  Load to List View data from FloatList}
    function  LoadDataToListView( const d, v : TxFloatList ) : integer;
{  Initialize form: read .xyz file and load data to visual components }
    function  Init( const filename : string ) : integer;                    
  end;


implementation

{$R *.dfm}

{  Load to List View data from FloatList}
function  TfrmViewXYZfile.LoadDataToListView( const d, v : TxFloatList ) : integer;
var
  i : integer;
begin
  for i := 0 to d.Count-1 do begin
    with lvData.Items.Add() do begin
      Caption := IntToStr(i);
      SubItems.Add( FloatToStr(d[i]) );
      SubItems.Add( FloatToStr(v[i]) );
      Gauge.Position := Gauge.Position + 1;
    end;
  end;
  Gauge.Position := Gauge.Min;
  result := _OK_;
end;

{  Initialize form: read .xyz file and load data to visual components }
function  TfrmViewXYZfile.Init( const filename : string ) : integer;
var
  d,
  v : TxFloatList;
begin
  result := _OK_;
  xyzFile := filename;
  try
    d := TxFloatList.Create();
    v := TxFloatList.Create();
    if ReadXYZfile( xyzFile, d, v ) = _ERROR_ then begin
      MessageDlg( Format( msgFileNotOpen, [xyzFile]), mtError, [mbOk], 0);
      exit;
    end;
    StatusBar1.Panels[0].Text := Format( msgLinesCount, [d.Count]);
    Caption := Caption + xyzFile;
    Gauge.Position := 0;
    Gauge.Max := d.Count-1;
    if LoadDataToListView( d, v ) = _ERROR_ then
      exit;
  finally
    v.Free();
    d.Free();
  end;
end;

procedure TfrmViewXYZfile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
