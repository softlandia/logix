unit ViewSheet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Utils, cLas;

type
  TfrmViewSheet = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    lvData: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    las : TLASFile;
    function LoadData( var las : TLASFile ) : integer;
  end;

var
  frmViewSheet: TfrmViewSheet;

implementation

{$R *.dfm}

function  TfrmViewSheet.LoadData( var las : TLASFile ) : integer;
var
  j,
  i  : integer;
  lc : TListColumn;
  li : TListItem;
begin
  result := _ERROR_;
  if not Assigned(las) then
    exit;
  for i := 0 to las.Logs.Count-1 do begin
    lc := lvData.Columns.Add();
    lc.Caption := las.Logs.LOG(i).Id;
  end;
  for i := 0 to las.Logs.LOG(0).y.Count-1 do begin
    li := lvData.Items.Add();
    li.Caption := FloatToStr(las.Logs.LOG(0).y[i]);
    for j := 1 to las.Logs.Count-1 do begin
      li.SubItems.Add(FloatToStr(las.Logs.LOG(j).y[i]));
    end;
  end;
end;

procedure TfrmViewSheet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
