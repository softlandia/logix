unit ChartPref;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Utils, PainterBox, JvExStdCtrls, JvEdit,
  JvValidateEdit, xGraf, JvComponentBase, JvFormPlacement;

type
  TfrmChartPref = class(TForm)
    GroupBox1: TGroupBox;
    btnCancel: TBitBtn;
    chkGlobalScale: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnOk: TBitBtn;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    cbDepthScale: TComboBox;
    edMMScale: TEdit;
    Label5: TLabel;
    edMScale: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    chkAutoScale: TCheckBox;
    edTickCount: TEdit;
    edStrt: TJvValidateEdit;
    edStop: TJvValidateEdit;
    edStep: TJvValidateEdit;
    edXmin: TJvValidateEdit;
    edXmax: TJvValidateEdit;
    edColumnWidth: TJvValidateEdit;
    Label10: TLabel;
    JvFormStorage1: TJvFormStorage;
    procedure FormCreate(Sender: TObject);
    procedure edStrtChange(Sender: TObject);
    procedure cbDepthScaleChange(Sender: TObject);
    procedure edMMScaleChange(Sender: TObject);
    procedure chkGlobalScaleClick(Sender: TObject);
    procedure chkGlobalScaleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    procedure SetTextControlByScale(scale: Double);
    { Private declarations }
  public
    DepthScaleFactor : double;
    function  Init(const PainterBox : TPainterBox) : integer;
    function  Finish(const PainterBox : TPainterBox) : integer;
    function  SetScaleFactor(scale : double) : integer;
  end;

var
  frmChartPref: TfrmChartPref;

implementation
{$R *.DFM}
uses
  main;

//Create form and load default settings
procedure TfrmChartPref.FormCreate(Sender: TObject);
begin
end;

//Save default settings
function  TfrmChartPref.Init(const PainterBox : TPainterBox ) : integer;
begin
  result := _ERROR_;
  if PainterBox.Columns.Count <= 1 then
    exit;
  with PainterBox.Columns[1].Graf do begin
    chkGlobalScale.Checked := XGlobalScale;
    chkAutoScale.Checked := XAutoScale;
    edXmin.Enabled := chkGlobalScale.Checked;
    edXMax.Enabled := chkGlobalScale.Checked;
    edXmin.Value := Xmin;
    edXmax.Value := Xmax;
    edColumnWidth.Value := PainterBox.Columns[1].Width;
  end;
  with PainterBox.DepthColumn.Graf do begin
    edStrt.Value := Round(-Ymax);
    edStop.Value := Round(-Ymin);
    edStep.Value := Round(abs(Ymax - Ymin)/numYMajorTicks);
    edTickCount.Text := FloatToStr(numYMajorTicks);
    SetScaleFactor(ScaleFactor);
  end;
  result := _OK_;
end;

function  TfrmChartPref.Finish(const PainterBox : TPainterBox ) : integer;
var
  i : integer;
begin
  with PainterBox do begin
    for i := 0 to Columns.Count-1 do begin
      Columns[i].Graf.XGlobalScale := chkGlobalScale.Checked;
      Columns[i].Graf.XAutoScale := chkAutoScale.Checked;
      if not chkAutoScale.Checked then begin
        Columns[i].Graf.Xmin := StrToFloat(edXmin.Text);
        Columns[i].Graf.Xmax := StrToFloat(edXmax.Text);
        Columns[i].Graf.RescaleX();
      end;
      if i > 0 then begin
          Columns[i].Width := edColumnWidth.Value;
          with Columns[i] do begin
//            graf.ScaleFactor := ScaleFactor;
//            graf.Ymax := Strt;
//            graf.Ymin := Stop;
//            graf.numYMajorTicks := Round((Strt-Stop)/DepthLabelStep);
            graf.rRect.Right := graf.rRect.Left + Columns[i].Width;
            graf.Resize(graf.rRect);
            graf.RescaleX();
            graf.RescaleY();
          end;
      end;
    end;
//    PainterBox.Columns[1].Width := edColumnWidth.Value;
    SetColumnHeight(DepthScaleFactor, -edStrt.Value, -edStop.Value, edStep.Value);
  end;
  result := _OK_;
end;

procedure TfrmChartPref.edStrtChange(Sender: TObject);
begin
  if edStep.Value <> 0 then
    edTickCount.Text := IntToStr(Round((edStop.Value - edStrt.Value)/edStep.Value));
end;

function  TfrmChartPref.SetScaleFactor(scale : double) : integer;
begin
  DepthScaleFactor := scale;
  SetTextControlByScale(scale);
  if scale = svScaleValue100 then
    cbDepthScale.ItemIndex := 0
  else if scale = svScaleValue200 then
    cbDepthScale.ItemIndex := 1
  else if scale = svScaleValue500 then
    cbDepthScale.ItemIndex := 2
  else if scale = svScaleValue1000 then
    cbDepthScale.ItemIndex := 3
  else if scale = svScaleValue5000 then
    cbDepthScale.ItemIndex := 4
  else if scale = svScaleValue10000 then
    cbDepthScale.ItemIndex := 5;
  result := _OK_;
end;

procedure TfrmChartPref.SetTextControlByScale(scale: Double);
begin
  edMMScale.Text := Format('%-4.1f', [scale]);
  edMScale.Text := '1';
end;

procedure TfrmChartPref.btnOkClick(Sender: TObject);
begin
  if edStrt.Value > edStop.Value then
    ModalResult := mrCancel;
end;

procedure TfrmChartPref.cbDepthScaleChange(Sender: TObject);
begin
  SetTextControlByScale(ScaleValueArray[TScaleIndex(cbDepthScale.ItemIndex)]);
end;

procedure TfrmChartPref.edMMScaleChange(Sender: TObject);
var
  mmScale,
  mScale   : double;
begin
  try
    mmScale := StrToFloat(edMMScale.Text);
  except
    MessageDlg( 'No valid float point number: '+edMMScale.Text, mtError, [mbOK], 0 );
    cbDepthScale.ItemIndex := 1;
    exit;
  end;
  try
    mScale := StrToFloat(edMScale.Text);
  except
    MessageDlg( 'No valid float point number: '+edMScale.Text, mtError, [mbOK], 0 );
    cbDepthScale.ItemIndex := 1;
    exit;
  end;
  DepthScaleFactor := mmScale / mScale;
end;

procedure TfrmChartPref.chkGlobalScaleClick(Sender: TObject);
begin
  edXmin.Enabled := chkGlobalScale.Checked;
  edXMax.Enabled := chkGlobalScale.Checked;
end;

procedure TfrmChartPref.chkGlobalScaleKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  edXmin.Enabled := chkGlobalScale.Checked;
  edXMax.Enabled := chkGlobalScale.Checked;
end;

end.
