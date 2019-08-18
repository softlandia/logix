unit ChangeLOGid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BaseDlg, ImgList, Menus, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, Utils, Common, CLAS, AnsiStrings, Grids, ValEdit;

type
  TfrmChangeLogId = class(TfrmBaseDlg)
    ImageList1: TImageList;
    Selectall1: TMenuItem;
    Deselectall1: TMenuItem;
    Splitter1: TSplitter;
    veLogId: TValueListEditor;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Deselectall1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangeLogId: TfrmChangeLogId;

implementation
uses
  preferences;
{$R *.DFM}

procedure TfrmChangeLogId.BitBtn1Click(Sender: TObject);
var
  i           : integer;
  lasfilename : string;
  li          : TListItem;
  las         : TLASFile;
  cur         : TCursor;
  path        : string;
  well        : string;
  date        : string;
begin
  inherited;
  cur := Screen.Cursor;
  Screen.Cursor := crAppStart;
  Writeln(logfile, 'Start change LOGid');
  if strlstFile.Count = 0 then
    if SearchFiles() = _ERROR_ then
      exit;
  pbProgress.min := 0;
  pbProgress.max := strlstFile.Count -1;
  pbProgress.Position := pbProgress.min;
  las := TLASFile.Create();
  try
    for i := 0 to strlstFile.Count -1 do begin
      lasfilename := strlstFile[i];
      path := StripBackSlash(ExtractFilePath(lasfilename));
      well := ExtractFileName(path);
      li := lv.FindCaption( 0, lasfilename, true, true, true);
      Writeln(logfile, Format('Read las file: %s', [lasfilename]));
      try
        if las.ReadFromLas(lasfilename) = _OK_ then begin
          Writeln(logfile, Format('Change LOGid: %s', [lasfilename]));
          //замена поля WELL на имя каталога где лежит файл
          las.header.SetValue('WELL', well);
          //замена поля FLD
          las.header.SetValue('FLD', 'NEFTEGORSKOE');
          //замена в поле DATE символов "," на "-"
          date := las.header.GetValue('DATE');
          date := ReplaceStr(date, ',', '-');
          las.header.SetValue('DATE', date);
          //Замена идентификаторов на стандартные мнемоники
          las.ChangeLogId(preferences.frmPreferences.leLogId);
          Writeln(logfile, Format('Write las file: %s', [lasfilename]));
          las.WriteToLasRaw(lasfilename);
        end
        else
          Writeln(logfile, Format('Error, las file: %s skip', [lasfilename]));
      finally
        las.Clear();
      end;
      pbProgress.Position := pbProgress.Position + 1;
    end;
  finally
    las.Free;
    Screen.Cursor := cur;
  end;
end;

procedure TfrmChangeLogId.FormShow(Sender: TObject);
{var
  li  : TListItem;
  i   : integer;}
begin
  inherited;
  if Assigned(preferences.frmPreferences.leLogId.Strings) then
    try
      veLogId.Strings.AddStrings(preferences.frmPreferences.leLogId.Strings);
{     При использовании компонента ListView имеется возможность выбора отдельных элементов
      lvLOGid.AllocBy := strlstLOGid.Count + 1;
      for i := 0 to strlstLOGid.Count-1 do begin
        li := lvLOGid.Items.Add;
        li.Caption := strlstLOGid.Names[i];
        li.SubItems.Add(strlstLOGid.Values[li.Caption]);
        li.Checked := true;
      end;}
    except
    end;
end;

procedure TfrmChangeLogId.Selectall1Click(Sender: TObject);
var
  i   : integer;
begin
  inherited;
{  for i := 0 to lvLOGid.Items.Count-1 do begin
    lv.Items[i].Checked := true;
  end;}
end;

procedure TfrmChangeLogId.Deselectall1Click(Sender: TObject);
var
  i   : integer;
begin
  inherited;
{  for i := 0 to lvLOGid.Items.Count-1 do begin
    lv.Items[i].Checked := false;
  end;}
end;

procedure TfrmChangeLogId.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
