unit SearchResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Common, ImgList;

type
  TfrmSearchResult = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    lvFiles: TListView;
    PopupMenu1: TPopupMenu;
    Icon1: TMenuItem;
    SmallIcon1: TMenuItem;
    List1: TMenuItem;
    Report1: TMenuItem;
    ImageList1: TImageList;
    Open1: TMenuItem;
    sbStatus: TStatusBar;
    deFolder: TEdit;
    SpeedButton1: TSpeedButton;
    procedure Icon1Click(Sender: TObject);
    procedure SmallIcon1Click(Sender: TObject);
    procedure List1Click(Sender: TObject);
    procedure Report1Click(Sender: TObject);
    procedure deFolderChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure lvFilesDblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmSearchResult: TfrmSearchResult;

implementation
uses
  Utils, ViewLAS;
{$R *.DFM}

procedure TfrmSearchResult.Icon1Click(Sender: TObject);
begin
  lvFiles.ViewStyle := vsIcon;
end;

procedure TfrmSearchResult.SmallIcon1Click(Sender: TObject);
begin
  lvFiles.ViewStyle := vsSmallIcon;
end;


procedure TfrmSearchResult.List1Click(Sender: TObject);
begin
  lvFiles.ViewStyle := vsList;
end;

procedure TfrmSearchResult.Report1Click(Sender: TObject);
begin
  lvFiles.ViewStyle := vsReport;
end;

procedure TfrmSearchResult.deFolderChange(Sender: TObject);
begin
  strlstFile.Clear;
  WorkFolderPath := deFolder.Text;
  try
    FFiles( AddBackSlash(deFolder.Text), '*.las', strlstFile);
    Utils.CopyStrListToListView( strlstFile, lvFiles );
    sbStatus.Panels[0].Text := Format('Found %u LAS files.',[strlstFile.Count]);
  except
    sbStatus.Panels[0].Text := 'LAS files not found...';
  end;
end;

procedure TfrmSearchResult.FormShow(Sender: TObject);
begin
  if ParamCount >= 2 then
    deFolder.Text := WorkFolderPath   //при изменении состояния вызывается событие OnChange -> функция deFolderChange
  else
    deFolder.Text := AddBackSlash(ExtractFilePath(ParamStr(0)));
end;

procedure TfrmSearchResult.Open1Click(Sender: TObject);
var
  li : TListItem;
begin
  li :=  lvFiles.ItemFocused;
  lf.Clear;
  if lf.Open( li.Caption ) = _OK_ then
    frmViewLAS.ShowModal;
end;

procedure TfrmSearchResult.lvFilesDblClick(Sender: TObject);
begin
  Open1click( Sender );
end;

procedure TfrmSearchResult.SpeedButton1Click(Sender: TObject);
begin
//deFolder.Text :=
end;

end.
