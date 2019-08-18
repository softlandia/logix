unit frmTvdLasToRms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDlg, ImgList, Menus, Buttons, ComCtrls, StdCtrls, ExtCtrls, Utils;

type
  TfrmTvdLasRoRms = class(TfrmBaseDlg)
    lvWells: TListView;
    edWellsFile: TEdit;
    Label2: TLabel;
    btnOpenWellsFile: TButton;
    odWellsFile: TOpenDialog;
    procedure btnOpenWellsFileClick(Sender: TObject);
  private

    function LoadPrnFile(const filename : string) : integer;
  public
    { Public declarations }
  end;

var
  frmTvdLasRoRms: TfrmTvdLasRoRms;

implementation

{$R *.dfm}

function TfrmTvdLasRoRms.LoadPrnFile(const filename : string) : integer;
var
  f   : TextFile;
  i,
  n   : integer;
  well,
  val,
  s   : string;
  item :  TListItem;
  col  :  TListColumn;
begin
  AssignFile(f, FileName);
  try
    Reset(f);
    try
      readln(f, n);
    except
      Writeln(logfile, 'file: "' + filename + '" line 1 error format, not integer number');
    end;
    lvWells.Items.Clear();
    for i :=  0 to n-1 do begin
      readln(f, s);
      col := lvWells.Columns.Add();
      col.Caption := s;
    end;
    while not eof(f) do begin
      item := lvWells.Items.Add();
      readln(f, s);
      i := pos(' ', s);
      well := copy(s, 1, i-1);
      item.Caption := well;         //idWell
      delete(s, 1, i);
      s := trim(s);
      i := pos(' ', s);
      val := copy(s, 1, i-1);
      item.SubItems.Add(val);       //KB
      delete(s, 1, i);
      s := trim(s);
      i := pos(' ', s);
      val := copy(s, 1, i-1);
      item.SubItems.Add(val);       //TD
      delete(s, 1, i);
      s := trim(s);
      i := pos(' ', s);
      val := copy(s, 1, i-1);
      item.SubItems.Add(val);       //X
      delete(s, 1, i);
      val := trim(s);
      item.SubItems.Add(val);       //Y
    end;
  finally
    CloseFile(f);
    Writeln(logfile, 'wells file: '+ filename + ' successfully loaded');
  end;
end;

procedure TfrmTvdLasRoRms.btnOpenWellsFileClick(Sender: TObject);
begin
  if odWellsFile.Execute() then begin
    edWellsFile.Text := odWellsFile.FileName;
    LoadPrnFile(edWellsFile.Text);
  end;
end;

end.
