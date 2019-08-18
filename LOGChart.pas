unit LogChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Common, Utils, CLas, xGraf,
  xSeries, Buttons, GrafHead, ImgList,
  Painter, PainterControl, PainterBox, Menus, ToolWin, JvComponentBase,
  JvFormPlacement;

const
  defFormCaption      = 'well: "%s"';
  defLOGLegendHeight  = 41;   //высота по умолчанию кнопки заголовка каротажа
  defLOGLegendWidth   = 333;  //ширина по умолчанию кнопки заголовка каротажа
  defIncrInPage       = 14;   //количество шагов прокрутки в полном окне
  _HINT_LOG_AXIS_TYPE_= 'Логарифмический масштаб';
  _HINT_LIN_AXIS_TYPE_= 'Линейный масштаб';
  _HINT_GROUND_LEVEL_ = 'От уровня земли';
  _HINT_SEE_LEVEL_    = 'От уровня моря';

type
  TfrmLogChart = class(TForm)
    ToolBar1: TToolBar;
    sbStatus: TStatusBar;
    ToolButton1: TToolButton;
    sbHeader: TScrollBox;
    btnExport: TToolButton;
    btnGrafPref: TToolButton;
    SaveDialog1: TSaveDialog;
    btnCopy: TToolButton;
    btnExportToACAD: TToolButton;
    btnLOGstyle: TToolButton;
    grf: TxGraf;
    rule: TxGraf;
    ScrollBox: TPainterBox;
    pbDepth: TPainterRule;
    pbChart: TPainter;
    btnToSeeLevel: TToolButton;
    mnuSelectLog: TPopupMenu;
    Select1: TMenuItem;
    Deselect1: TMenuItem;
    btnAddLog: TToolButton;
    OpenDialog1: TOpenDialog;
    Remove1: TMenuItem;
    Splitter1: TSplitter;
    JvFormStorage1: TJvFormStorage;
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  ExportToWmf( const filename : string) : integer;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure LOGLegend1Click(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnGrafPrefClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopyClick(Sender: TObject);
    procedure btnExportToAcadClick(Sender: TObject);
    procedure btnLOGstyleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnToSeaLevelClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Select1Click(Sender: TObject);
    procedure Deselect1Click(Sender: TObject);
    procedure mnuSelectLogPopup(Sender: TObject);
    procedure pbChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnAddLogClick(Sender: TObject);
    procedure pbPaint(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
  private
    HeaderBtnTag : integer;
  public
    las         : TLasFile;
    UnlockPaint : boolean;
    retcode     : integer;
    function CreateChartHeader(Columns : TPaintersList; ColNum : integer) : integer;
    function ResizeChartHeader() : integer;
    function ResizeLOGButtons() : integer;
    function DoResize(NewWidth, NewHeight : integer) : integer;
    function Init(const _las : TLasFile) : integer;
    function CreateMetafile() : TMetafile;
  end;


implementation
uses
  ChartHeaderInfo, ChartPref, Main, Clipbrd, ChartExport, preferences;
{$R *.DFM}

procedure TfrmLogChart.FormCreate(Sender: TObject);
begin
  UnlockPaint := FALSE;
  Top    := 0;
  Height := Screen.DesktopHeight-1;
  grf.filename := 'grf';
  rule.filename := 'rule';
end;

procedure TfrmLogChart.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmLogChart.LOGLegend1Click(Sender: TObject);
begin
  with frmChartHeaderInfo do begin
    if Init((Sender as TLogLegendButton) , ScrollBox) = _ERROR_ then
      exit;
    if ShowModal() = mrOk then begin
      if Finish((Sender as TLogLegendButton), ScrollBox) = _ERROR_ then
        exit;
    end;
  end;
  ScrollBox.Invalidate();
end;

///<summary> Создание кнопок всех кривых для одного трека (колонки)
///</summary>
// ColNum - номер колонки 1-первая, 2-вторая и т.д.
// Tag колонки это её номер для раздачи номеров кнопкам этой колонки
// Новые кнопки начинаем от левого конца колонки
// Кнопоки вставляются в объект sbHeader
function  TfrmLogChart.CreateChartHeader(Columns : TPaintersList; ColNum : integer) : integer;
var
  i,
  prevRight,            //окончание предыдущей кнопки
  prevHeight,           //окончание предыдущей кнопки
  ButtonWidth : integer;  //полная ширина области для кнопок
  grafs : TxGraf;
  ser : TSeries;
begin
  result := _ERROR_;
  if ColNum <= 0 then
    exit;
  grafs := Columns[ColNum].Graf;
  ButtonWidth := Columns[ColNum].Width;
  if ColNum = 1 then
    prevRight  := Columns[ColNum-1].Right
  else
    prevRight  := Columns[ColNum-1].Right + _LOG_COLUMN_GAP_;
  prevHeight := 0;
//+debug
//  sbStatus.Panels[0].Text := 'Panel width: ' + IntToStr(ButtonWidth);
//  sbStatus.Panels[1].Text := 'Button width: ' + IntToStr(ButtonWidth);
//-debug
  for i := 0 to grafs.Series.Count-1 do begin
    ser := grafs.Series[i];
    with TLogLegendButton.Create(sbHeader) do begin
      Parent  := sbHeader;
      Tag     := Columns[ColNum].Tag+i;   //100, 101 - для первой; 200, 201 - для второй
      Top     := prevHeight;
      Left    := prevRight;
      Width   := ButtonWidth;
      Height  := defLOGLegendHeight;
//init event handlers
      OnClick := LOGLegend1Click;
      PopupMenu := mnuSelectLog;
//init additional params
      Caption := Format('%-s, %-s [%-4.3g, %-4.3g] ',[Trim(ser.name), Trim(ser.aUnit), ser.Xmin, ser.Xmax]);
      MinValue := Format('%4.3g',[ser.Xmin]);
      MaxValue := Format('%4.3g',[ser.Xmax]);
      LineColour := ser.Colour;
      PenStyle := ser.PenStyle;
      PenWidth := ser.PenWidth;
      prevHeight := prevHeight + Height;
    end;
  end;
  result := _OK_;
end;

///<summary>
///Изменение ширины кнопок заголовков каротажа
///</summary>
function  TfrmLogChart.ResizeChartHeader() : integer;
var
  i : integer;
begin
  if sbHeader.ControlCount = 0 then
    exit;
  for i := 0 to sbHeader.ControlCount-1 do begin
    (sbHeader.Controls[i] as TLogLegendButton).Width := ScrollBox.Columns[1].Width;
  end;
end;

function TfrmLogChart.ResizeLOGButtons() : integer;
var
  prevHeight : integer;  //полная ширина области для кнопок
  i : integer;
begin
  prevHeight := 0;
  for i := 0 to sbHeader.ControlCount-1 do begin
    with sbHeader.Controls[i] do begin
      Top     := prevHeight;
      Left    := pbChart.Left;                          //левая граница по началу графика
      Width   := grf.cRect.Right;                       //ширина по ширине графика
      Height  := defLOGLegendHeight;
      prevHeight := prevHeight + Height;
    end;
  end;
  result := _OK_;
end;

function  TfrmLogChart.DoResize(NewWidth, NewHeight : integer) : integer;
begin
//  ResizeLOGButtons();
  result := _OK_;
end;

procedure TfrmLogChart.FormResize(Sender: TObject);
begin
  ResizeChartHeader();
{-  DoResize(Width+1, Height);
  ScrollBox.Update(); -}
end;

function  TfrmLogChart.Init(const _las : TLasFile) : integer;
begin
// Не перерисовывать форму - флаг проверяется в функции FormCanResize
  UnlockPaint := false;
  ScrollBox.Lock := true;

  result := _ERROR_;
  if (not Assigned(_las)) then begin
    retcode := _ERR_INPUT_PARAMETERS_;
    Close();
    exit;
  end;
  las := _las;
  if not las.DataPresent() then begin
    retcode := _ERR_NO_LOG_SELECT_;
    Close();
    exit;
  end;
  Caption := Format(defFormCaption, [ExtractFileName(las.FileName)]);
// Загрузка данных из объекта las в график
  grf.LoadData(frmPreferences.leLOGid, stdLOG, las);
  grf.ScaleFactor := svScaleValue500;
  rule.LoadData(grf);
  ScrollBox.SetColumnHeight();
  ScrollBox.Rescale();
  UnlockPaint := true;
  ScrollBox.Lock := false;
  result := _OK_;
end;

procedure TfrmLogChart.pb1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  sbStatus.Panels[0].Text := IntToStr(pbChart.BoundsRect.Left) + ' x ' +IntToStr(pbChart.BoundsRect.Top);
//  sbStatus.Panels[1].Text := IntToStr(pbChart.BoundsRect.Right) + ' x ' +IntToStr(pbChart.BoundsRect.Bottom);
end;

procedure TfrmLogChart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmLogChart.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  if ((NewWidth <> Width) or (NewHeight <> Height)) and UnlockPaint then
    Resize := true
  else
    Resize := false;
end;

procedure TfrmLogChart.btnExportClick(Sender: TObject);
begin
  if SaveDialog1.Execute() then
    ExportToWmf( SaveDialog1.FileName );
end;

procedure TfrmLogChart.btnGrafPrefClick(Sender: TObject);
var
  res : integer;
begin
  with frmChartPref do begin
    if Init(ScrollBox) = _OK_ then
      if ShowModal() = mrOk then begin
        Finish(ScrollBox);
      end;
  end;
  sbStatus.Panels[2].Text := IntToStr(res);
  sbHeader.Invalidate();
  ScrollBox.SetColumnHeight();
  ScrollBox.Invalidate();
end;

//Закрытие формы по клавише ESC, обновление экрана по F5  ComponentName
procedure TfrmLogChart.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close();
  if Key = VK_F5 then
    pbChart.Update();
end;

procedure TfrmLogChart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with ScrollBox.VertScrollBar do begin
    if Key = VK_DOWN then
      Position := Position + Increment;
    if Key = VK_UP then
      Position := Position - Increment;
    if Key = VK_NEXT then
      Position := Position + defIncrInPage * Increment;
    if Key = VK_PRIOR then
      Position := Position - defIncrInPage * Increment;
  end;
end;

function TfrmLogChart.ExportToWmf( const filename : string) : integer;
var
  AMetafile: TMetafile;
begin
  AMetafile := CreateMetafile();
  try
    AMetafile.SaveToFile(filename);
  finally
    AMetafile.Free();
  end;
  result := _OK_;
end;

function TfrmLogChart.CreateMetafile() : TMetafile;
begin
  result := ScrollBox.CreateMetafile();
//  FormResize(self);
  sbHeader.Invalidate();
  ScrollBox.SetColumnHeight();
  ScrollBox.Invalidate();
//  Refresh();
end;

procedure TfrmLogChart.btnCopyClick(Sender: TObject);
var
  Clipboard  : TClipboard;
  ClipFormat : WORD;
  ClipData   : THandle;
  ClipPalette: HPALETTE;
  Metafile   : TMetafile;
begin
  Clipboard := TClipboard.Create;
  Metafile := CreateMetafile();
//  Metafile.SaveToFile('x:\tmp\pic.emf');
  Metafile.SaveToClipboardFormat(ClipFormat, ClipData, ClipPalette);
  ClipBoard.SetAsHandle(ClipFormat, ClipData);
  Metafile.Free();
  Clipboard.Free();
end;

procedure TfrmLogChart.btnExportToAcadClick(Sender: TObject);
var
  b : boolean;
  vrect,
  rrect : TRect;
begin
  rrect := grf.rRect;
  vrect := grf.vRect;
  with TfrmChartExport.Create(self) do begin
    if Init(ScrollBox) = _OK_ then
      Show();
  end;
  grf.rRect := rrect;
  grf.vRect := vrect;
  ScrollBox.Rescale();
//Готовим обновление всей формы
  ScrollBox.Invalidate();
end;

procedure TfrmLogChart.btnLOGstyleClick(Sender: TObject);
begin
  with (Sender as TToolButton) do begin
    case Tag of
      26: begin
            grf.XAxisStyle := asLOG;
            Tag := 25;
            Hint := _HINT_LIN_AXIS_TYPE_;
          end;
      25: begin
            grf.XAxisStyle := asLINE;
            Tag := 26;
            Hint := _HINT_LOG_AXIS_TYPE_;
          end;
      else
        Tag := 25;
    end;
    ImageIndex := Tag;
  end;
  grf.RestoreXMinMax();
  grf.Invalidate();
end;

procedure TfrmLogChart.FormShow(Sender: TObject);
begin
// Создаем кнопки для кривых - при показе формы для первой колонки (всегда существующей)
  CreateChartHeader(ScrollBox.Columns, 1);
end;

procedure TfrmLogChart.pbPaint(Sender: TObject);
var
  i : integer;
  d : extended;
  f, i1, i2 : int64;
begin
{  if UnlockPaint then begin
    QueryPerformanceFrequency(f);
    QueryPerformanceCounter(i1);
    QueryPerformanceCounter(i2);
    d := (i2 - i1) / (f);
    sbStatus.Panels[0].Text := Format('%-10.6f',[d]);
    writeln(logfile, 'Paint stop: ', sbStatus.Panels[0].Text);
  end;}
end;

procedure TfrmLogChart.btnToSeaLevelClick(Sender: TObject);
begin
  with (Sender as TToolButton) do begin
    case Tag of
      24: begin  //к устью скважины
            ScrollBox.BaseLine := las._RKB;
            Tag := 23;
            Hint := _HINT_SEE_LEVEL_;
            writeln(logfile, 'Align to SL: ');
          end;
      23: begin //к уровню моря
            ScrollBox.BaseLine := 0;
            Tag := 24;
            Hint := _HINT_GROUND_LEVEL_;
            writeln(logfile, 'Align to KB: ');
          end;
    end;
    ImageIndex := Tag;
  end;
end;

procedure TfrmLogChart.FormPaint(Sender: TObject);
begin
//  sbStatus.Panels[0].Text := 'grf.w: ' + IntToStr(grf.cRect.Right - grf.cRect.Left);
//  sbStatus.Panels[1].Text := 'r, c:' + IntToStr(pbDepth.Width) +', ' + IntToStr(pbChart.Width);
//  sbStatus.Panels[2].Text := 'scr.w-b: ' + IntToStr(ScrollBox.Width - ScrollBox.VertScrollBar.Size);
//  sbStatus.Panels[1].Text := las._API;
end;

procedure TfrmLogChart.mnuSelectLogPopup(Sender: TObject);
var
  btn : TControl;
begin
  btn := sbHeader.ControlAtPos(sbHeader.ScreenToClient(mnuSelectLog.PopupPoint), true, true);
//Запоминаем номер кнопки на которой вызвали контекстное меню
  if Assigned(btn) then
    HeaderBtnTag := btn.Tag;
end;

//Sender это колонка на которой происходит перемещение курсора.
procedure TfrmLogChart.pbChartMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  SelectedButtonTag,
  i,
  ColNo,
  SerNo : integer;
  Ax, Bx,
  Ay, By,
  nx, ny  : double;
  log_name: string;
  ser     : TSeries;
  painter : TPainter;
begin
  SelectedButtonTag := -1;
//Номер колонки на которой происходит перемещение мышки
  ColNo := GetColumnNoFromTag((Sender as TPainter).Tag);
//Ищем и сохраняем Tag кнопки выбранной кривой, но только в данной колонке
  for i := 0 to sbHeader.ControlCount-1 do begin
    if (GetColumnNoFromTag((sbHeader.Controls[i] as TLogLegendButton).Tag) = ColNo) and
       (sbHeader.Controls[i] as TLogLegendButton).Selected then begin
      SelectedButtonTag := (sbHeader.Controls[i] as TLogLegendButton).Tag;
      break;
    end;
  end;
  painter := (Sender as TPainter);
  if SelectedButtonTag < 0 then begin
    Ax := painter.Graf.Ax;
    Bx := painter.Graf.Bx;
    Ay := painter.Graf.Ay;
    By := painter.Graf.By;
    log_name := Format('Column #%-2u',[ColNo]);
  end else begin
//Номер колонки определяется по Sender'у  //ColNo := GetColumnNoFromTag(SelectedButtonTag);
    SerNo := GetSeriesNoFromTag(SelectedButtonTag);
    if (ColNo < 0) or (ColNo >= ScrollBox.Columns.Count) or
       (SerNo < 0) or (SerNo >= ScrollBox.Columns[ColNo].Graf.Series.Count) then exit;
    ser := ScrollBox.Columns[ColNo].Graf.Series[SerNo];
    log_name := ser.name;
    Ax := ser.Ax;
    Bx := ser.Bx;
    Ay := ser.Ay;
    By := ser.By;
  end;
  sbStatus.Panels[0].Text := IntToStr(x) + 'x' + IntToStr(y);
  try
    nx := ( x - Bx ) / Ax;
    ny := ( y - By ) / Ay;
  except
    nx := 0;
    ny := 0;
  end;
  sbStatus.Panels[1].Text := Format('%-s: %-4.2fx%-3.1f',[log_name,-ny,nx]);
end;

procedure TfrmLogChart.btnAddLogClick(Sender: TObject);
var
  p : TPainter;
  l : TLasFile;
begin
  l := TLasFile.Create();
  try
    if not OpenDialog1.Execute() then
      exit;
    l.Open(OpenDialog1.FileName);
    l.SelectAllLogs();
//Не перерисовывать форму - флаг проверяется в функции FormCanResize
    UnlockPaint := false;
    ScrollBox.Lock := true;

    Caption := Format(defFormCaption, [ExtractFileName(l.FileName)]);
    p := ScrollBox.AddColumn(nil);
    if not Assigned(p) then begin
      MessageDlg('Can not add new column.', mtWarning, [mbOk], 0 );
      exit;
    end;
    p.Color := clWhite;
    p.OnMouseMove := pbChartMouseMove;
    p.Graf.LoadData(frmPreferences.leLOGid, stdLOG, l );
    p.Graf.filename := ExtractFileName(l.FileName);
    with ScrollBox do begin
      Lock := false;
      AlignDepth();
      Resize();
      Rescale();
    end;
    CreateChartHeader(ScrollBox.Columns, ScrollBox.Columns.Count-1);
  finally
    UnlockPaint := true;
    pbPaint(self);
    Invalidate();
    l.Free();
  end;
end;

procedure TfrmLogChart.Select1Click(Sender: TObject);
var
  i,
  ColNo : integer;
  a     : TComponent;
begin
//HeaderBtnTag содержит tag той кнопки на которой вызвали контекстное меню
  ColNo := GetColumnNoFromTag(HeaderBtnTag);
  for i := 0 to sbHeader.ControlCount-1 do begin
    if GetColumnNoFromTag((sbHeader.Controls[i] as TLogLegendButton).Tag) = ColNo then
      (sbHeader.Controls[i] as TLogLegendButton).Selected := false;
  end;
  a := ComponentByTag(HeaderBtnTag, TComponent(sbHeader));
  if Assigned(a) then begin
    (a as TLogLegendButton).Selected := true;
    (a as TLogLegendButton).Invalidate();
  end;
end;

procedure TfrmLogChart.Deselect1Click(Sender: TObject);
var
  a : TComponent;
begin
//HeaderBtnTag содержит tag той кнопки на которой вызвали контекстное меню
  a := ComponentByTag(HeaderBtnTag, TComponent(sbHeader));
  if assigned(a) then begin
    (a as TLogLegendButton).Selected := false;
    (a as TLogLegendButton).Invalidate();
  end;
end;

procedure TfrmLogChart.Remove1Click(Sender: TObject);
//Удаляем каротаж из колонки
var
  a : TComponent;
  LogId : string;
begin
//HeaderBtnTag содержит tag той кнопки на которой вызвали контекстное меню
  a := ComponentByTag(HeaderBtnTag, TComponent(sbHeader));
  if assigned(a) then begin
//    LogId := (a as TLogLegend).
//    (a as TLogLegend).Selected := false;
//    (a as TLogLegend).Invalidate();
  end;
end;

end.



