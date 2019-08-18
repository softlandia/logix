unit APIcode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDlg, ImgList, Menus, StdCtrls, Buttons, ComCtrls, Mask,
  ExtCtrls;

type
  TfrmAPIcode = class(TfrmBaseDlg)
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAPIcode: TfrmAPIcode;

implementation
uses
  CLas, Utils, Common;
{$R *.DFM}

procedure TfrmAPIcode.BitBtn1Click(Sender: TObject);
var
  lf : TLASFile;
  i  : integer;
  filecount : string;
  lasfilename : shortstring;
begin
  inherited;
  if deFolder.Text <> 'deFolder' then
    if SearchFiles() = _ERROR_ then exit;
  pbProgress.Visible := true;
  pbProgress.min := 0;
  pbProgress.max := strlstFile.Count;
  pbProgress.Position := pbProgress.min;
  filecount := lblFileCount.Caption;
  strlstAPI.Sort();
  lf := TLASFile.Create();
  try
    for i := 0 to strlstFile.Count -1 do begin
      lasfilename := strlstFile[i];
      Writeln(logfile, Format('Read las file: %s', [lasfilename]));
      try
        if lf.ReadFromLas(lasfilename) = _OK_ then begin
          if lf.FillAPI( strlstAPI ) = _OK_ then begin
            Writeln(logfile, Format('Change API: %s', [lasfilename]));
            Application.ProcessMessages();
            lf.WriteToLAS(lasfilename);
            Application.ProcessMessages();
            Writeln(logfile, Format('Write las file: %s', [lasfilename]));
          end;
        end
        else
          Writeln(logfile, Format('     las file: %s skip', [lasfilename]));
      except
        Writeln(logfile, Format('     las file: %s ERROR', [lasfilename]));
      end;
      lf.Clear();
      pbProgress.Position := pbProgress.Position + 1;
      lblFilecount.Caption := lasfilename;
      lblFileCount.Refresh();
    end;
  finally
    lf.Free;
    Writeln(logfile, Format('Error on file: %s skip', [lasfilename]));
  end;
  pbProgress.Visible := false;
end;

end.
