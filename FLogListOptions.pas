unit FLogListOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Utils, CLas;

type
  TfrmLogListOptions = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    lvParameters: TListView;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    filename : string;
    las : TLasFile;
  end;

var
  frmLogListOptions: TfrmLogListOptions;

implementation

{$R *.dfm}

procedure TfrmLogListOptions.FormShow(Sender: TObject);
var
  i  : integer;
  li : TListItem;
begin
  lvParameters.Clear();
  las := TLasFile.Create();
  if las.ReadFromLasHeader(filename) = _OK_ then begin
    for i := 0 to las.Header.Count-1 do begin
      li := lvParameters.Items.Add();
      li.Caption := las.Header.asString(i);
    end;
  end;
end;

procedure TfrmLogListOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  las.Free();
  Action := caFree;
end;

end.
