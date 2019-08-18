unit ChartHeaderInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, xSeries, xGraf, Buttons, ExtCtrls, Mask, DrawComboBox,
  GrafHead, PainterBox, xColorBox;

type
  TfrmChartHeaderInfo = class(TForm)
    GroupBox1: TGroupBox;
    edLOGid: TEdit;
    Label1: TLabel;
    edUnit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnOK: TBitBtn;
    Label7: TLabel;
    btnCancel: TBitBtn;
    Label8: TLabel;
    chkLOGAxisStyle: TCheckBox;
    cbLineStyle: TLineStyleComboBox;
    cbLineWidth: TLineWidthComboBox;
    Label5: TLabel;
    chkAutoScale: TCheckBox;
    edMin: TEdit;
    edMax: TEdit;
    cbLineColour: TxColorBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    ColNo,
    SeriesNo : integer;
    Series   : TSeries;
    function Init( Sender : TLogLegendButton; PainterBox : TPainterBox ) : integer;
    function Finish( Sender : TLogLegendButton; PainterBox : TPainterBox ) : integer;
  end;

var
  frmChartHeaderInfo: TfrmChartHeaderInfo;

implementation
uses
  utils;

const
  STRT_CAPTION = 'STRT:';
  STOP_CAPTION = 'STOP:';
{$R *.DFM}

function TfrmChartHeaderInfo.Init(Sender : TLogLegendButton; PainterBox : TPainterBox) : integer;
begin
  ColNo := GetColumnNoFromTag(Sender.Tag);
  SeriesNo := GetSeriesNoFromTag(Sender.Tag);
  try
    series := PainterBox.Columns[ColNo].Graf.Series[SeriesNo];
    edLOGid.Text := series.name;
    edUnit.Text := series.aUnit;
    edMin.Text := FloatToStr(series.Xmin);
    edMax.Text := FloatToStr(series.Xmax);
    cbLineColour.Selected := series.Colour;
    cbLineStyle.LineStyle := series.PenStyle;
    cbLineWidth.LineWidth := series.PenWidth;
    chkAutoScale.Checked := series.XAutoScale;
  except
    edLOGid.Text := 'ERROR';
    edUnit.Text := 'ERROR';
    edMin.Text := '0.0';
    edMax.Text := '0.0';
    cbLineColour.Selected := 1;
    cbLineStyle.LineStyle := psSolid;
    cbLineWidth.LineWidth := 1;
    chkAutoScale.Checked := true;
  end;
  result := _OK_;
end;

function TfrmChartHeaderInfo.Finish( Sender : TLogLegendButton; PainterBox : TPainterBox ) : integer;
begin
  try
//Настраиваем каротажную кривую
    with series do begin
      Colour := cbLineColour.Selected;
      Xmin := StrToFloat(edMin.Text);
      Xmax := StrToFloat(edMax.Text);
      PenWidth := cbLineWidth.LineWidth;
      PenStyle := cbLineStyle.LineStyle;
      XAutoScale := chkAutoScale.Checked;
      if XAutoScale then
        FindMinMax();     //для автоскейла определяем заново мин/макс
    end;
//Настраиваем график в целом
    with PainterBox.Columns[ColNo] do begin
      Graf.InitXMinMax(StrToFloat(edMin.Text), StrToFloat(edMax.Text));
      if Graf.XGlobalScale then begin  //Для логарифм шкалы масштаб по X один на всех
        graf.Xmax := series.Xmax;
        graf.Xmin := series.Xmin;
      end;
      graf.ReScaleX(); //масштабирование по оси X
    end;
  except;
  end;
//Настраиваем кнопку
  with Sender do begin
    LineColour := series.Colour;
    PenStyle := series.PenStyle;
    PenWidth := series.PenWidth;
//изменяем надпись на кнопке
    MinValue := Format('%4.3g',[series.Xmin]);
    MaxValue := Format('%4.3g',[series.Xmax]);
    Invalidate();
  end;
  result := _OK_;
end;

procedure TfrmChartHeaderInfo.FormShow(Sender: TObject);
begin
  if not Assigned(series) then
    exit;
  try
    edLOGid.Text := series.name;
    edUnit.Text := series.aUnit;
    edMin.Text := FloatToStr(series.Xmin);
    edMax.Text := FloatToStr(series.Xmax);
    cbLineColour.Selected := series.Colour;
    cbLineStyle.LineStyle := series.PenStyle;
    cbLineWidth.LineWidth := series.PenWidth;
  except
    edLOGid.Text := 'ERROR';
    edUnit.Text := 'ERROR';
    edMin.Text := '0.0';
    edMax.Text := '0.0';
    cbLineColour.Selected := 1;
    cbLineStyle.LineStyle := psSolid;
    cbLineWidth.LineWidth := 1;
  end;
end;

procedure TfrmChartHeaderInfo.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

end.
