unit FillAPI;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrmFillAPI = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    BitBtn1: TBitBtn;
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFillAPI: TfrmFillAPI;

implementation
uses
  Utils;
{$R *.DFM}
procedure TfrmFillAPI.btnOkClick(Sender: TObject);
var
  fn : string;
  strlstDir,
  strlstFile : TStringList;
begin
  fn := '*.las';
  strlstDir  := TStringList.Create;
  strlstFile := TStringList.Create;
  strlstDir.Assign( ListBox1.Items );
  FillFileList( fn, strlstDir, strlstFile );
  ListBox2.Items.Assign( strlstFile );
  strlstFile.Free;
  strlstDir.Free;
end;

end.
