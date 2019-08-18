{$DEFINE DEBUG}
unit BaseDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask,
  Utils, CLas, Common, Menus, ImgList;

type
  TfrmBaseDlg = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    lblFileCount: TLabel;
    pbProgress: TProgressBar;
    lv: TListView;
    Label1: TLabel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    PopupMenu1: TPopupMenu;
    Icon1: TMenuItem;
    SmallIcon1: TMenuItem;
    List1: TMenuItem;
    Report1: TMenuItem;
    PopupMenuImage: TImageList;
    deFolder: TEdit;
    btnSelectFolder: TButton;
    procedure FormShow(Sender: TObject);
    procedure Icon1Click(Sender: TObject);
    procedure SmallIcon1Click(Sender: TObject);
    procedure List1Click(Sender: TObject);
    procedure Report1Click(Sender: TObject);
    procedure deFolderChange(Sender: TObject);
    procedure btnSelectFolderClick(Sender: TObject);
  private
  protected
  public
    function SearchFiles() : integer;
  end;


implementation

uses
  BrowseDir;

{$R *.DFM}

function  TfrmBaseDlg.SearchFiles() : integer;
begin
  Writeln(logfile, 'APIcode: Create files list');
  strlstFile.Clear();
  if FFiles(AddBackSlash(deFolder.Text), '*.las', strlstFile)<= 0 then
    result := _ERROR_
  else
    result := _OK_;
  lv.AllocBy := strlstFile.Count;
  CopyStrListToListView(strlstFile, lv);
  lv.Update;
end;

procedure TfrmBaseDlg.FormShow(Sender: TObject);
begin
  if strlstFile.Count > 0 then begin
//    deFolder.Text := '<<LIST>>';
    lv.AllocBy := strlstFile.Count;
    CopyStrListToListView(strlstFile, lv);
    lv.Update();
  end
  else
    deFolder.Text := ExtractFilePath(LastFolderPath);
end;

procedure TfrmBaseDlg.Icon1Click(Sender: TObject);
begin
  lv.ViewStyle := vsIcon;
end;

procedure TfrmBaseDlg.SmallIcon1Click(Sender: TObject);
begin
  lv.ViewStyle := vsSmallIcon;
end;

procedure TfrmBaseDlg.List1Click(Sender: TObject);
begin
  lv.ViewStyle := vsList;
end;

procedure TfrmBaseDlg.Report1Click(Sender: TObject);
begin
  lv.ViewStyle := vsReport;
end;

procedure TfrmBaseDlg.deFolderChange(Sender: TObject);
begin
  if deFolder.Text <> '' then
    SearchFiles();
end;

procedure TfrmBaseDlg.btnSelectFolderClick(Sender: TObject);
var
  path : string;
begin
  if BrowseDirectory(path, 'Выберите каталог', 0) then
    deFolder.Text := path;
  SearchFiles();
end;

end.
