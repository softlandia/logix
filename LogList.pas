////////////////////////////////////////////////////////////////////////////////
//Построение списка исследований по скважинам для списка las файлов
//ver   1.0.1
//date  11.04.2001
//autor softland@zmail.ru
////////////////////////////////////////////////////////////////////////////////
unit LogList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  APIcode, ImgList, Menus, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, Utils, Common, BaseDlg;

type
  TfrmLogList = class(TfrmBaseDlg)
    chkViewLogList: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogList: TfrmLogList;

implementation
uses
  CLas;
{$R *.DFM}

procedure TfrmLogList.BitBtn1Click(Sender: TObject);
var
  hl : TextFile;
  lf : TLASFile;
  j,
  i  : integer;
  lasfilename : string;
  sLastError  : string;
begin
  inherited;
  if deFolder.Text <> 'deFolder' then begin
    if SearchFiles() = _ERROR_ then exit;
  end else begin
    exit;
  end;
  pbProgress.min := 0;
  pbProgress.max := strlstFile.Count -1;
  pbProgress.Position := pbProgress.min;
  AssignFile(hl, LogListFileName);
  try
    Rewrite(hl);
  except
    Writeln(logfile, Format('Can''t create file: %s', [LogListFileName]));
    Exit;
  end;
  Writeln(hl, Format('FILE%sAPI%sLOGid%smin%smax',[#9,#9,#9,#9]));
  lf := TLASFile.Create();
  try
    for i := 0 to strlstFile.Count -1 do begin
      lasfilename := strlstFile[i];
      Writeln(logfile, Format('Reading header of the file: %s', [lasfilename]));
      if lf.ReadFromLas(lasfilename, false) = _OK_ then begin
        for j := 0 to lf.logs.Count -1 do begin
          Writeln(hl, Format('%-s%s%-s%s%-s%s%-9.3f%s%-9.3f',[Trim(lf.FileName), #9,
                                                              Trim(lf._API), #9,
                                                              Trim(lf.logs[j]), #9,
                                                              lf._STRT,#9,
                                                              lf._STOP]));
        end;
  {$IFDEF DEBUG}
        Writeln(logfile, Format('Write header of file: %s', [lasfilename]));
  {$ENDIF}
      end
      else
        Writeln(logfile, Format('Error, las file: %s skip', [lasfilename]));
      pbProgress.Position := pbProgress.Position + 1;
      lf.Clear();
    end;
  finally
    lf.Free();
    CloseFile(hl);
  end;
  if chkViewLogList.Checked then begin
    if ShellExec(Application.Handle, LogListFileName) = 0 then begin
      sLastError := MessageOnShellExecuteError(LogListFileName);
      MessageDlg(sLastError, mtError, [mbOK], 0);
    end;
  end;
end;

end.
