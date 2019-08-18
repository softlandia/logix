unit ChartExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, Utils, xGraf, cLAS, xSeries,
  StdCtrls, Types, PainterBox, ToolWin;

type
  TfrmChartExport = class(TForm)
    ToolBar1: TToolBar;
    btnExportToScript: TToolButton;
    ImageList1: TImageList;
    SaveDlg: TSaveDialog;
    GroupBox1: TGroupBox;
    VScale: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    chkLog: TCheckBox;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    cbLegendStyle: TComboBox;
    Label12: TLabel;
    chkForcedXScale: TCheckBox;
    edLeft: TEdit;
    edBottom: TEdit;
    edRight: TEdit;
    edTop: TEdit;
    edColDistance: TEdit;
    edBaseLine: TEdit;
    edUnitValue: TEdit;
    edTextScale: TEdit;
    edMin: TEdit;
    edMax: TEdit;
    edStep: TEdit;
    procedure btnExportToScriptClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    PaintBox : TPainterBox;
    function Init(var _PaintBox : TPainterBox) : integer;
  end;

var
  frmChartExport: TfrmChartExport;

implementation
uses
  AScript;
{$R *.dfm}

procedure TfrmChartExport.btnExportToScriptClick(Sender: TObject);
var
  f    : TextFile;
  ColDistance,
  j,
  i    : integer;
  ser  : TSeries;
  r,                      //прямоугольник для рисования одной колонки
  rect : TRect;
  graf     : TxGraf;
  fileext,
  filepath,
  colname,
  filenamestd,
  base_filename,
  filename : string;
  _OwneredY: boolean;
begin
  Cursor := crHourGlass;
  try
    ColDistance := StrToInt(edColDistance.Text);
    if SaveDlg.Execute() then begin
      for j := 1 to PaintBox.Columns.Count-1 do begin
  //название колонки
        colname := PaintBox.Columns[j].Graf.filename;
        filepath:= ExtractFilePath(SaveDlg.FileName);
        base_filename := ExtractFileNameEx(SaveDlg.FileName, false);
        fileext := ExtractFileExt(SaveDlg.FileName);
        filenamestd := filepath + base_filename + '.' + colname;
  //текущая колонка
        graf := PaintBox.Columns[j].Graf;
  //настройка размеров
        graf.rRect := Types.Rect(Round(StrToFloat(edLeft.Text) + (j-1) * ColDistance),                 StrToInt(edTop.Text),
                                 Round(StrToFloat(edLeft.Text) + StrToFloat(edRight.Text) + (j-1) * ColDistance), StrToInt(edBottom.Text));
        graf.vRect := graf.rRect;

  //запоминаем состояние
        with graf do begin
          _OwneredY := OwneredY;
          OwneredY := false;
          if chkForcedXScale.Checked then begin
{            RescaleY();
  //По оси Х использовать указанный пользователем масштаб
            Xmin := edMin.Value;
            Xmax := edMax.Value;
            RescaleX();}
          end else
            AutoScale();
    //восстанавливаем состояние
          OwneredY := _OwneredY;
        end;

  //plot depth axis
        filename:= filenamestd + fileext;
        graf.DrawYAxisToFile( filename );
  //plot value axis
        if chkLOG.Checked then
          graf.DrawXAxisToFile( filenamestd + '.xGrid.scr', asLOG, StrToFloat(edMin.Text), StrToFloat(edMax.Text),
                                StrToFloat(edStep.Text), 'iLabel' )
        else
          graf.DrawXAxisToFile( filenamestd + '.xGrid.scr', asLINE, 0, 0, 0, 'iLabel' );
  //legend rect
        rect.Bottom := graf.rRect.Top;
        rect.Top := rect.Bottom + 50;
        rect.Left := graf.rRect.Left;
        rect.Right := graf.rRect.Right;
  //plot legends
        for i := 0 to graf.Series.Count-1 do begin
          ser := graf.Series[i];
          filename := filenamestd + '.' + ser.name + '.lgnd' + '.scr';
          AssignFile( f, filename );
          try
            rewrite( f );
            case cbLegendStyle.ItemIndex of
  //            0: AS_LOGlegend( f, ser.name, FloatToStr( ser.Xmin ), FloatToStr( ser.Xmax ), edTextScale.Value, 1, rect );
              1: AS_LogLegendByBase(f, ser.name, ser.aUnit, StrToFloat(edBaseLine.Text), graf.Xmax, ser.ax, ser.bx, rect.Top, rect.Bottom, StrToFloat(edTextScale.Text));
              2: AS_LogLegendForSP(f, ser.name, ser.aUnit, rect.Left, StrToFloat(edUnitValue.Text), ser.ax, rect.Top, rect.Bottom, StrToFloat(edTextScale.Text));
            else
                 AS_Loglegend(f, ser.name, FloatToStr(ser.Xmin), FloatToStr(ser.Xmax), StrToFloat(edTextScale.Text), 1, rect);
            end;
          finally
            CloseFile( f );
          end;
          filename := filenamestd + '.' + ser.name + '.scr';
  //plot chart
          graf.DrawToFile( filename, ser, graf.rRect.Bottom, graf.rRect.Top );
        end;
      end;
    end;
  finally
    Cursor := crDefault;
  end;
end;

function TfrmChartExport.Init(var _PaintBox : TPainterBox) : integer;
var
  graf : TxGraf;
begin
  result := _ERROR_;
  if not Assigned(_PaintBox) then
    exit;
  PaintBox := _PaintBox;
  graf := PaintBox.Columns[1].Graf;
  edTop.Text := FloatToStr(PaintBox.DepthColumn.Graf.Ymax);
  edBottom.Text := FloatToStr(PaintBox.DepthColumn.Graf.Ymin);
  if graf.XAxisStyle = asLog then begin
//Для логарифмич масштаба устанавливаем значения на форме
    chkLog.Checked := true;
    edMin.Text := FloatToStr(graf.Xmin);
    edMax.Text := FloatToStr(graf.Xmax);
  end;
  result := _OK_;
end;

procedure TfrmChartExport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
