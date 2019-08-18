unit FAlignLogByDepth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, ComCtrls, Utils, CLas;

type
  TfrmAlignLogByDepth = class(TForm)
    GroupBox1: TGroupBox;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edDepthFrom: TRxCalcEdit;
    Label1: TLabel;
    Label2: TLabel;
    edDepthTo: TRxCalcEdit;
    Label3: TLabel;
  private
    { Private declarations }
  public
    function Init( const start, stop : Double; var las : TLasFile; var list : TList ) : integer;
  end;

var
  frmAlignLogByDepth: TfrmAlignLogByDepth;

implementation

{$R *.dfm}
function TfrmAlignLogByDepth.Init( const start, stop : Double; var las : TLasFile; var list : TList ) : integer;
var
  i : integer;
  NullVal : Double;
  logs : TLogList;
begin
  for i := 0 to las.Logs.Count-1 do begin
    NullVal := las._NULL();

  end;
end;

end.
