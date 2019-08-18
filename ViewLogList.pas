unit ViewLogList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, ToolWin, ComCtrls, StdCtrls, Utils;

type
  TfrmViewLogList = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    Images: TImageList;
    Panel1: TPanel;
    mmLogList: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    function Init( filename : string ) : integer;
  end;

var
  frmViewLogList: TfrmViewLogList;

implementation

{$R *.dfm}

function TfrmViewLogList.Init( filename : string ) : integer;
begin
  if not FileExists(filename) then begin
    result := _ERROR_;
    exit;
  end;
  Caption := filename;
  mmLogList.Lines.LoadFromFile(filename);
  result := _OK_;
end;

procedure TfrmViewLogList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
