unit TestChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, ToolWin, StdCtrls, Common, Utils, LasClass;

type
  TfrmTestChart = class(TForm)
    ToolBar1: TToolBar;
    sbStatus: TStatusBar;
    ScrollBox1: TScrollBox;
    pbBox: TPaintBox;
    Label1: TLabel;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure pbBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbBoxPaint(Sender: TObject);
  private
    ymin,
    ymax,
    xmin,
    xmax,
    ay, by,
    ax, bx : double;
  public
    xlog,                     //depth log
    ylog : TLOGDataSet;       //value log
    las  : TLASFile;
  end;

var
  frmTestChart: TfrmTestChart;

implementation

{$R *.DFM}

procedure TfrmTestChart.FormShow(Sender: TObject);
begin
//  Chart.SeriesList[0].Clear;
  Label1.Caption := xlog.LOGid;
  Label2.Caption := ylog.LOGid;
  ymin := ylog.y.FindMin;
  ymax := ylog.y.FindMax;

  xmin := xlog.y.FindMin;
  xmax := xlog.y.FindMax;

  pbBox.Height := Round(xmax);
  ax := (0.0 - pbBox.Height)/(xmin - xmax);
  bx := 0.0 - ax * xmin;
  ay := (0.0 - pbBox.Width)/(ymin - ymax);
  by := pbBox.Width - ay * ymax;
end;

procedure TfrmTestChart.pbBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  sbStatus.Panels[0].Text := IntToStr(x);
  sbStatus.Panels[1].Text := IntToStr(y);
end;

procedure TfrmTestChart.pbBoxPaint(Sender: TObject);
var
  i   : integer;
  point : TPoint;
  x, y   : integer;
begin
  point.x := 0;
  point.y := 0;
  with pbBox.Canvas do begin
    Pen.Color := clRed;
    Pen.Style := psSolid;
    Pen.Mode  := pmCopy;
    Pen.Width := 5;
    PenPos := point;
    for i := 0 to xlog.y.Count-1 do begin
      x := Round(ax*xlog.y[i]+bx);
      y := Round(ay*ylog.y[i]+by);
      LineTo( y, x);
    end;
  end;
end;

end.
