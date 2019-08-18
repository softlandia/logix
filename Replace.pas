unit Replace;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cLAS, Utils, Menus;

type
  TfrmReplace = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn2: TBitBtn;
    edStrToSearch: TLabeledEdit;
    edStrToReplace: TLabeledEdit;
    GroupBox2: TGroupBox;
    lblInfo: TLabel;
    btnReplace: TBitBtn;
    lblResult: TLabel;
    GroupBox3: TGroupBox;
    rbGreate: TRadioButton;
    rbEqual: TRadioButton;
    rbLess: TRadioButton;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    lf : TLASFile;
  end;

var
  frmReplace: TfrmReplace;

implementation

uses
  floatlist;

{$R *.dfm}

procedure TfrmReplace.FormCreate(Sender: TObject);
begin
  lblResult.Caption := '';
end;

procedure TfrmReplace.btnReplaceClick(Sender: TObject);
var
  j   : integer;
  vs,
  vr  : double;
  y   : TxFloatList;
begin
  y := lf.SelectedLOG.y;
  j := 0;
  if Pos('All', edStrToSearch.Text ) > 0 then
    j := y.ReplaceNegativeToNULL()
  else begin
    try
      vs := StrToFloat( edStrToSearch.Text );
    except
      lblResult.Caption := 'Invalid search float number.';
      exit;
    end;
    try
      vr := StrToFloat( edStrToReplace.Text);
    except
      lblResult.Caption := 'Invalid replace float number.';
      exit;
    end;
    if rbEqual.Checked then
      j := y.ReplaceValToVal( vs, vr, _EPSILON_ )
    else if rbLess.Checked then
      j := y.ReplaceLessToVal( vs, vr, _EPSILON_ )
    else if rbGreate.Checked then
      j := y.ReplaceGreateToVal( vs, vr, _EPSILON_ )
  end;                                              // if
  if j > 0 then begin
    lf.Changed := TRUE;
    lf.SelectedLOG.y.FindMax();
    lf.SelectedLOG.y.FindMin();
    lblResult.Caption := Format('Replaced: %u numbers.',[j]);
  end;
end;

procedure TfrmReplace.FormShow(Sender: TObject);
var
  l : TLOGDataSet;
begin
  l := lf.SelectedLOG;
{  with pSearchMenu do begin
    Items.Clear();
    Items.Add( TMenuItem.Create(self));
    Items[0].Caption := FloatToStr(l.y.Max);
    Items[0].OnClick := pSearchMenuClick;
    Items.Add( TMenuItem.Create(self));
    Items[1].Caption := FloatToStr(l.y.Min);
    Items[1].OnClick := pSearchMenuClick;
    Items.Add( TMenuItem.Create(self));
    Items[2].Caption := 'All negative values.';
    Items[2].OnClick := pSearchMenuClick;
  end;
  with pReplaceMenu do begin
    Items.Clear();
    Items.Add( TMenuItem.Create(self));
    Items[0].Caption := FloatToStr(lf._NULL);
    Items[0].OnClick := pReplaceMenuClick;
  end;}
  edStrToReplace.Text := FloatToStr(lf._NULL);
  lblInfo.Caption := Format('LOG: %s,'+CRLF+'Min: %8.3f,'+CRLF+'Max: %8.3f.',[l.Id, l.y.Min, l.y.Max]);
end;

end.
